<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$response = array('isSuccess' => false, 'message' => 'Unknown error occurred');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['id_pariwisata']) && isset($_POST['id_kategori']) && isset($_POST['nama_pariwisata']) && isset($_POST['harga']) && isset($_POST['lokasi']) && isset($_POST['keterangan'])) {
        $id_pariwisata = $_POST['id_pariwisata'];
        $id_kategori = $_POST['id_kategori'];
        $nama_pariwisata = $_POST['nama_pariwisata'];
        $harga = $_POST['harga'];
        $lokasi = $_POST['lokasi'];
        $keterangan = $_POST['keterangan'];
        $gambarPath = isset($_FILES['gambar']['name']) ? $_FILES['gambar']['name'] : '';

        // Handle file upload
        if (!empty($gambarPath)) {
            $targetDir = "gambar/";
            $targetFilePath = $targetDir . basename($_FILES["gambar"]["name"]);
            $fileType = strtolower(pathinfo($targetFilePath,PATHINFO_EXTENSION));
            // Allow certain file formats
            $allowTypes = array('jpg','png','jpeg');
            if(in_array($fileType, $allowTypes)){
                // Upload file to server
                if(move_uploaded_file($_FILES["gambar"]["tmp_name"], $targetFilePath)){
                    $gambar = $targetFilePath; // Update foto path to use in SQL
                } else {
                    $response['message'] = "Sorry, there was an error uploading your file.";
                    echo json_encode($response);
                    exit;
                }
            } else {
                $response['message'] = "Sorry, only JPG, JPEG, & PNG files are allowed.";
                echo json_encode($response);
                exit;
            }
        } else {
            // Use existing foto path if new foto is not uploaded
            $sql = "SELECT gambar FROM pariwisata WHERE id_pariwisata = '$id_pariwisata'";
            $result = $koneksi->query($sql);
            if($result->num_rows > 0){
                $row = $result->fetch_assoc();
                $gambar = $row['gambar'];
            } else {
                $response['message'] = "No record found to update.";
                echo json_encode($response);
                exit;
            }
        }

        $sql = "UPDATE pariwisata SET id_kategori='$id_kategori', gambar='$gambar', nama_pariwisata='$nama_pariwisata', harga='$harga', lokasi='$lokasi', keterangan='$keterangan' WHERE id_pariwisata='$id_pariwisata'";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil mengedit data pariwisata";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal mengedit data pariwisata: " . $koneksi->error;
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
?>
