<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (isset($_POST['id_user']) && isset($_POST['id_pariwisata']) && isset($_POST['jumlah'])) {
        $id_user = $_POST['id_user'];
        $id_pariwisata = $_POST['id_pariwisata'];
        $jumlah = $_POST['jumlah'];

        // Mendapatkan harga pariwisata dari tabel pariwisata
        $sql = "SELECT harga FROM pariwisata WHERE id_pariwisata = ?";
        $stmt = $koneksi->prepare($sql);
        if ($stmt === false) {
            $response['isSuccess'] = false;
            $response['message'] = "Failed to prepare statement: " . $koneksi->error;
        } else {
            $stmt->bind_param("s", $id_pariwisata);
            $stmt->execute();
            $stmt->bind_result($harga);
            $stmt->fetch();
            $stmt->close();

            if ($harga !== null) {
                $total = $harga * $jumlah;

                // Insert into database
                $sql = "INSERT INTO pesanan (id_user, id_pariwisata, jumlah, total) VALUES (?, ?, ?, ?)";
                $stmt = $koneksi->prepare($sql);
                if ($stmt === false) {
                    $response['isSuccess'] = false;
                    $response['message'] = "Failed to prepare statement: " . $koneksi->error;
                } else {
                    $stmt->bind_param("sssd", $id_user, $id_pariwisata, $jumlah, $total); // Bind four parameters
                    if ($stmt->execute()) {
                        $response['isSuccess'] = true;
                        $response['message'] = "Berhasil menambahkan data";
                    } else {
                        $response['isSuccess'] = false;
                        $response['message'] = "Gagal menambahkan data: " . $stmt->error;
                    }
                    $stmt->close();
                }
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "Pariwisata tidak ditemukan";
            }
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
