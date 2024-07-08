<?php

header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');
    
include 'koneksi.php';

function kirimResponse($sukses, $status, $pesan, $data = null) {
    $response = [
        'sukses' => $sukses,
        'status' => $status,
        'pesan' => $pesan
    ];

    if ($data !== null) {
        $response['data'] = $data;
    }

    echo json_encode($response);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $result = loginUser($koneksi, $email, $password);
    echo $result;
}

function loginUser($koneksi, $email, $password) {
    $query = $koneksi->prepare("SELECT * FROM users WHERE email = ?");
    $query->bind_param("s", $email);
    $query->execute();
    $result = $query->get_result();

    if ($result->num_rows === 1) {
        $row = $result->fetch_assoc();
        if (password_verify($password, $row['password'])) {

            return json_encode([
                'sukses' => true,
                'status' => 200,
                'pesan' => 'Login berhasil',
                'data' => $row
            ]);
        } else {
            return json_encode([
                'sukses' => false,
                'status' => 401,
                'pesan' => 'Login gagal, email atau password salah',
                'data' => null
            ]);
        }
    } else {
        return json_encode([
            'sukses' => false,
            'status' => 401,
            'pesan' => 'Login gagal, email atau password salah',
            'data' => null
        ]);
    }
}
?>




