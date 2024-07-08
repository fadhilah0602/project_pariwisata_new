 <?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include 'koneksi.php';

$response = array();

// Periksa metode permintaan
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Periksa apakah parameter lengkap
    if ( isset($_POST['nama_kategori'])) {
        $nama_kategori = $_POST['nama_kategori']; // Set status default

        // Gunakan prepared statements untuk menghindari SQL Injection
        $stmt = $koneksi->prepare("INSERT INTO kategori (nama_kategori) VALUES (?)");
        $stmt->bind_param("s",$nama_kategori);

        if ($stmt->execute()) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menambahkan Kategori";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan kategori: " . $stmt->error;
        }

        $stmt->close();
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);

$koneksi->close();
?> 
