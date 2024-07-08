<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($_GET['id_kategori'])) {
        $id_kategori = $_GET['id_kategori'];

        // Memastikan koneksi berhasil
        if ($koneksi->connect_error) {
            $response['isSuccess'] = false;
            $response['message'] = "Connection failed: " . $koneksi->connect_error;
        } else {
            // Query untuk mendapatkan data pariwisata berdasarkan kategori
            $sql = "SELECT pariwisata.id_pariwisata, pariwisata.id_kategori, pariwisata.nama_pariwisata, pariwisata.harga, pariwisata.lokasi, pariwisata.keterangan, pariwisata.gambar 
                    FROM pariwisata
                    JOIN kategori ON pariwisata.id_kategori = kategori.id_kategori
                    WHERE pariwisata.id_kategori = ?";

            $stmt = $koneksi->prepare($sql);
            if ($stmt === false) {
                $response['isSuccess'] = false;
                $response['message'] = "Failed to prepare statement: " . $koneksi->error;
            } else {
                $stmt->bind_param("i", $id_kategori);
                if ($stmt->execute()) {
                    $result = $stmt->get_result();

                    if ($result->num_rows > 0) {
                        $response['isSuccess'] = true;
                        $response['data'] = array();

                        while ($row = $result->fetch_assoc()) {
                            $data = array(
                                'id_kategori' => $row['id_kategori'],
                                'id_pariwisata' => $row['id_pariwisata'],
                                'nama_pariwisata' => $row['nama_pariwisata'],
                                'harga' => $row['harga'],
                                'lokasi' => $row['lokasi'],
                                'keterangan' => $row['keterangan'],
                                'gambar' => $row['gambar'],
                            );
                            array_push($response['data'], $data);
                        }
                    } else {
                        $response['isSuccess'] = false;
                        $response['message'] = "No products found in this category";
                    }
                } else {
                    $response['isSuccess'] = false;
                    $response['message'] = "Failed to execute statement: " . $stmt->error;
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

$koneksi->close();
?>
