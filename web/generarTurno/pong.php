<?php

include_once 'user.php';
include_once 'turno.php';

$user = new User();
$turno = new Turno();

if (isset($_GET['cedula']) && isset($_GET['comunicacion']) && isset($_GET['tipocomunicacion']) && isset($_GET['tiposervicio']) && isset($_GET['prioridad'])) {

    $cedulaForm = $_GET['cedula'];

    if ($user->userExists($cedulaForm)) {
        $array = array("client" => true);
    } else {
        $array = array("client" => false);
    }
    $comunicacionForm = $_GET['comunicacion'];
    $tipocomunicacionForm = $_GET['tipocomunicacion'];
    $tiposervicioForm = $_GET['tiposervicio'];
    $prioridadForm = $_GET['prioridad'];

    $array["turn"] =& $turno->generateTurn($cedulaForm,$comunicacionForm,$tipocomunicacionForm, $tiposervicioForm, $prioridadForm);



    $array2 = array($array);
    $array3["turno"]=$array2;
    print_r(json_encode($array3));
} else {
    echo 'Error, faltan datos de envio';
}
?>



