<?php

$koneksi = mysqli_connect("localhost", "root", "", "pariwisata_new");

if($koneksi){

	// echo "Database berhasil konek";
	
} else {
	echo "gagal Connect";
}

?>