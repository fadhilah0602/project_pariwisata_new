<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa parameter id_pariwisata tersedia
    if (isset($_POST['id_pariwisata'])) {
        $id_pariwisata = $_POST['id_pariwisata'];

        $sql = "DELETE FROM pariwisata WHERE id_pariwisata='$id_pariwisata'";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menghapus data pariwisata";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menghapus data pariwisata: " . $koneksi->error;
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
