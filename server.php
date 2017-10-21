<?php 

	$server = "localhost";
	$username = "root";
	$password = "";
	$database = "restoran_db";

	//mysqli_connect($server, $username, $password, $database);
	$mysqli = new mysqli($server, $username, $password, $database);
	//mysql_select_db($database) or die ("<h1> Koneksi ke database Error : </h1>" . mysql_error());


	@$operasi = $_GET['operasi'];

	switch ($operasi) {
		case "view" :
			$result = mysqli_query($mysqli, "SELECT * FROM makanan") or die(mysql_error());
			$data_array = array();
			while ($data = mysqli_fetch_assoc($result)){
				$data_array[] = $data;
			}
			echo json_encode($data_array);

			break;

		case "insert" :
			
			
			break;

		case "get_makanan_by_id" :
			@$id = $_GET['id'];

			$result = mysqli_query($mysqli, "SELECT * FROM makanan WHERE id_makanan = '$id'");
			$data_array = array();
			//$data_array = mysqli_fetch_assoc($result);

			while ($data = mysqli_fetch_assoc($result)){
				$data_array[] = $data;
			}
			echo json_encode($data_array);

			
			break;

		case "update" :
			
			
			break;

		case "delete" :
			@$id = $_GET['id'];
			$query = mysqli_query($mysqli, "DELETE FROM makanan WHERE id_makanan = '$id'");

			if ($query) {
            	echo "Delete Data Berhasil";
        	} else {
            	echo mysqli_error($mysqli);
        	}

			break;
		
		default:
			break;
	}

?>