<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    if ( isset($_POST['nama_kategori']) && isset($_POST['id_kategori'])) {
        $id_kategori = $_POST['id_kategori'];
        $nama_kategori = $_POST['nama_kategori'];

        $sql = "UPDATE kategori SET nama_kategori='$nama_kategori' WHERE id_kategori='$id_kategori'";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil mengedit data kategori";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal mengedit data kategori: " . $koneksi->error;
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
