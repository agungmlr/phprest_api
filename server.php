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
			$json_string = file_get_contents('php://input');
			
			$params = array();
			$params = json_decode($json_string,true);
			//rint(count($params));

			for ($i=0; $i < count($params); $i++) { 
				$query = "insert into makanan values('".$params[$i]['id_makanan']."','".$params[$i]['nama']."','".$params[$i]['desc']."','".$params[$i]['harga_beli']."','".$params[$i]['harga_jual']."') ";

				if ($result = mysqli_query($mysqli,$query)){
					print("Seccess!");
				}
					
			}
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

	class makanan{
		public $id;
		public $nama;
		public $desc;
		public $harga_beli;
		public $harga_jual;

		function __construct($id, $nama, $desc, $harga_beli, $harga_jual){
			$this->id = $id;
			$this->nama = $nama;
			$this->desc = $desc;
			$this->harga_beli = $harga_beli;
			$this->harga_jual = $harga_jual;
		}
	}

?>