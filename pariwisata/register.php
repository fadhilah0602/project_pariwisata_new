<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'koneksi.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    // Validasi input
    if (!empty($_POST['username']) && !empty($_POST['fullname']) && !empty($_POST['jenis_kelamin']) && !empty($_POST['no_hp']) && !empty($_POST['alamat']) && !empty($_POST['email']) && !empty($_POST['password'])) {
        
        $username = mysqli_real_escape_string($koneksi, $_POST['username']);
        $fullname = mysqli_real_escape_string($koneksi, $_POST['fullname']);
        $jenis_kelamin = mysqli_real_escape_string($koneksi, $_POST['jenis_kelamin']);
        $no_hp = mysqli_real_escape_string($koneksi, $_POST['no_hp']);
        $alamat = mysqli_real_escape_string($koneksi, $_POST['alamat']);
        $email = mysqli_real_escape_string($koneksi, $_POST['email']);
        $password = password_hash($_POST['password'], PASSWORD_BCRYPT);
        $role = 'customers';

        // Menggunakan prepared statements untuk memeriksa username atau email yang sudah ada
        $stmt = $koneksi->prepare("SELECT * FROM users WHERE username = ? OR email = ?");
        $stmt->bind_param("ss", $username, $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $response['value'] = 2;
            $response['message'] = "Username atau email telah digunakan";
        } else {
            // Menggunakan prepared statements untuk insert data
            $stmt = $koneksi->prepare("INSERT INTO users (username, fullname, jenis_kelamin, no_hp, alamat, role, email, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssssssss", $username, $fullname, $jenis_kelamin, $no_hp, $alamat, $role, $email, $password);

            if ($stmt->execute()) {
                $response['value'] = 1;
                $response['username'] = $username;
                $response['fullname'] = $fullname;
                $response['jenis_kelamin'] = $jenis_kelamin;
                $response['no_hp'] = $no_hp;
                $response['alamat'] = $alamat;
                $response['role'] = $role;
                $response['email'] = $email;
                $response['password'] = $password;
                $response['message'] = "Registrasi Berhasil";
            } else {
                $response['value'] = 0;
                $response['message'] = "Gagal Registrasi: " . $stmt->error;
            }
        }
        $stmt->close();
    } else {
        $response['value'] = 0;
        $response['message'] = "Semua field harus diisi";
    }

    echo json_encode($response);
}

$koneksi->close();

?>
