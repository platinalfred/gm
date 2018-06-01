<?php 
session_start();
unset($_SESSION['admin']);
unset($_SESSION['logged']);
unset($_SESSION['firstname']);
header("location:index.php");
?>
	<!--script>
		window.location.href = "index.php";
	</script-->