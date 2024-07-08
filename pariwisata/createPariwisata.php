<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Check if all parameters are available
    if (isset($_POST['id_kategori']) && isset ($_POST['nama_pariwisata']) && isset($_FILES['gambar']) && isset($_POST['harga']) && isset($_POST['lokasi'])  && isset($_POST['keterangan'])) {
        $nama_pariwisata = $_POST['nama_pariwisata'];
        $harga = $_POST['harga'];
        $lokasi = $_POST['lokasi'];
        $id_kategori = $_POST['id_kategori'];
        $keterangan = $_POST['keterangan'];

        // Handling file upload
        $file = $_FILES['gambar'];
        $filename = $file['name'];
        $filetmp = $file['tmp_name'];
        $fileError = $file['error'];
        $fileSize = $file['size'];
        $fileExt = explode('.', $filename);
        $fileActualExt = strtolower(end($fileExt));
        
        $allowed = array('jpg', 'jpeg', 'png', 'gif');

        if (in_array($fileActualExt, $allowed)) {
            if ($fileError === 0) {
                if ($fileSize < 5000000) { // restrict file size to 5MB
                    $fileNameNew = uniqid('', true).".".$fileActualExt;
                    $fileDestination = 'gambar/'.$fileNameNew;
                    move_uploaded_file($filetmp, $fileDestination);
                    $gambar = $fileDestination;

                    // Insert into database
                    $sql = "INSERT INTO pariwisata (nama_pariwisata, gambar, harga, lokasi, id_kategori, keterangan) VALUES (?, ?, ?, ?, ?, ?)";
                    $stmt = $koneksi->prepare($sql);
                    if ($stmt === false) {
                        $response['isSuccess'] = false;
                        $response['message'] = "Failed to prepare statement: " . $koneksi->error;
                    } else {
                        $stmt->bind_param("ssssss", $nama_pariwisata, $gambar, $harga, $lokasi, $id_kategori, $keterangan);
                        if ($stmt->execute()) {
                            $response['isSuccess'] = true;
                            $response['message'] = "Berhasil menambahkan pariwisata";
                        } else {
                            $response['isSuccess'] = false;
                            $response['message'] = "Gagal menambahkan pariwisata: " . $stmt->error;
                        }
                        $stmt->close();
                    }
                } else {
                    $response['isSuccess'] = false;
                    $response['message'] = "File is too large";
                }
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "There was an error uploading your file";
            }
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "You cannot upload files of this type";
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Required fields are missing";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Only POST method is allowed";
}

echo json_encode($response);
?>
