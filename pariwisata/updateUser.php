<?php

header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

if($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    
    // Memeriksa keberadaan data POST yang diperlukan
    if(isset($_POST['id_user']) && isset($_POST['username']) && isset($_POST['fullname']) && isset($_POST['jenis_kelamin']) && isset($_POST['no_hp'])&& isset($_POST['alamat']) &&  isset($_POST['email'])) {
        $id_user = $_POST['id_user'];
        $username = $_POST['username'];
        $fullname = $_POST['fullname'];
        $jenis_kelamin = $_POST['jenis_kelamin']; 
        $no_hp = $_POST['no_hp'];
        $alamat = $_POST['alamat'];
        $email = $_POST['email'];

        $sql = "UPDATE users SET username = '$username', fullname = '$fullname', jenis_kelamin = '$jenis_kelamin', no_hp = '$no_hp', alamat = '$alamat', email = '$email' WHERE id_user = $id_user";
        $isSuccess = $koneksi->query($sql);

        if ($isSuccess) {
            $cek = "SELECT * FROM users WHERE id_user = $id_user";
            $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
            $response['is_success'] = true;
            $response['value'] = 1;
            $response['message'] = "User Berhasil di Edit";
            $response['username'] = $result['username'];
            $response['fullname'] = $result['fullname'];
            $response['jenis_kelamin'] = $result['jenis_kelamin']; 
            $response['email'] = $result['email']; 
            $response['no_hp'] = $result['no_hp']; 
            $response['email'] = $result['email']; 
            $response['alamat'] = $result['alamat']; 
            $response['id_user'] = $result['id_user'];
        } else {
            $response['is_success'] = false;
            $response['value'] = 0;
            $response['message'] = "Gagal Edit User: " . $koneksi->error; // Menampilkan pesan kesalahan
        }
    } else {
        // Jika salah satu data POST tidak lengkap
        $response['is_success'] = false;
        $response['value'] = 0;
        $response['message'] = "Data yang diperlukan tidak lengkap";
    }

    echo json_encode($response);
}

?>
