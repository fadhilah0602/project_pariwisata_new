<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($_GET['id_user'])) {
        $id_user = $_GET['id_user'];

        // Memastikan koneksi berhasil
        if ($koneksi->connect_error) {
            $response['isSuccess'] = false;
            $response['message'] = "Connection failed: " . $koneksi->connect_error;
        } else {
            // Query untuk mendapatkan data pesanan
            $sql = "SELECT id_pesanan,pariwisata.nama_pariwisata, pesanan.jumlah, pariwisata.harga, pesanan.total, pariwisata.gambar
                    FROM pesanan 
                    JOIN pariwisata ON pesanan.id_pariwisata = pariwisata.id_pariwisata
                    WHERE pesanan.id_user = ?";

            $stmt = $koneksi->prepare($sql);
            if ($stmt === false) {
                $response['isSuccess'] = false;
                $response['message'] = "Failed to prepare statement: " . $koneksi->error;
            } else {
                $stmt->bind_param("i", $id_user);
                $stmt->execute();
                $result = $stmt->get_result();

                if ($result->num_rows > 0) {
                    $response['isSuccess'] = true;
                    $response['data'] = array();

                    while ($row = $result->fetch_assoc()) {
                        $data = array(
                            'id_pesanan' => $row['id_pesanan'],
                            'nama_pariwisata' => $row['nama_pariwisata'],
                            'jumlah' => $row['jumlah'],
                            'harga' => $row['harga'],
                            'gambar' => $row['gambar'],
                            'total' => $row['total']
                        );
                        array_push($response['data'], $data);
                    }
                } else {
                    $response['isSuccess'] = false;
                    $response['message'] = "Pesanan kosong";
                }
                $stmt->close();
            }
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Required fields are missing";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Only GET method is allowed";
}

echo json_encode($response);
?>
