<?php 

	$server = "localhost";
	$username = "root";
	$password = "";
	$database = "restoran_db";

	$mysqli = new mysqli($server, $username, $password, $database);


	@$operasi = $_GET['operasi'];

	switch ($operasi) {
		case "view" :
			$result = mysqli_query($mysqli, "SELECT * FROM makanan") or die(mysql_error());
			$data_array = array();
			while ($data = mysqli_fetch_assoc($result)){
				$data_array[] = $data;
			}
			echo json_encode($data_array);

			mysqli_close($mysqli);

			break;

		case "insert" :
			$json_string = file_get_contents('php://input');
			
			$params = array();
			$params = json_decode($json_string,true);
			//rint(count($params));

			for ($i=0; $i < count($params); $i++) { 
				$query = "insert into makanan values('".$params[$i]['id_makanan']."','".$params[$i]['nama']."','".$params[$i]['deskripsi']."','".$params[$i]['harga_beli']."','".$params[$i]['harga_jual']."') ";

				if ($result = mysqli_query($mysqli,$query)){
					print("Seccess!");
				}
					
			}

			mysqli_close($mysqli);
			break;

		case "get_makanan_by_id" :
			@$id = $_GET['id'];

			$result = mysqli_query($mysqli, "SELECT * FROM makanan WHERE id_makanan = '$id'");
			$data_array = array();

			while ($data = mysqli_fetch_assoc($result)){
				$data_array[] = $data;
			}
			echo json_encode($data_array);

			mysqli_close($mysqli);
			
			break;

		case "update" :
			@$id = $_GET['id'];


			$json_string = file_get_contents('php://input');
			
			$params = array();
			$params = json_decode($json_string,true);

			$query = "UPDATE makanan SET nama = '".$params['nama']."' , deskripsi =  '".$params['deskripsi']."' , harga_beli = 
			'".$params['harga_beli']."' , harga_jual =  '".$params['harga_jual']."' WHERE id_makanan = '$id'";


			if ($result = mysqli_query($mysqli,$query)){
				print("Seccess Update!");
			} else {
				echo mysqli_error($mysqli);
			}
			
			mysqli_close($mysqli);
			break;

		case "delete" :
			@$id = $_GET['id'];
			$query = mysqli_query($mysqli, "DELETE FROM makanan WHERE id_makanan = '$id'");

			if ($query) {
            	echo "Delete Data Berhasil";
        	} else {
            	echo mysqli_error($mysqli);
        	}

        	mysqli_close($mysqli);
			break;
		
		default:
			break;
	}


?>