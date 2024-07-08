<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa parameter id tersedia
    if (!empty($_POST['id_pesanan'])) {
        $id_pesanan = $_POST['id_pesanan'];

        $sql = "DELETE FROM pesanan WHERE id_pesanan='$id_pesanan'";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menghapus data pesanan";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menghapus data pesanan: " . $koneksi->error;
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