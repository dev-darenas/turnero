<?php

include_once 'turno.php';

$turno = new Turno();

if (isset($_GET['cedula']) && !isset($_GET['celular']) && !isset($_GET['correo']) && !isset($_GET['tiposervicio']) && !isset($_GET['prioridad']) && !isset($_GET['notificacion_whatsapp']) && !isset($_GET['notificacion_email']) && !isset($_GET['notificacion_sms'])) {

    $cedulaForm = $_GET['cedula'];

    $array["estado"] = & $turno->verificarCedula($cedulaForm);
    $array2 = array($array);
    $array3["cliente"] = $array2;
    print_r(json_encode($array3));
}

if (isset($_GET['cedula']) && isset($_GET['celular']) && isset($_GET['correo']) && isset($_GET['tiposervicio']) && isset($_GET['prioridad']) && isset($_GET['notificacion_whatsapp']) && isset($_GET['notificacion_email']) && isset($_GET['notificacion_sms'])) {

    $cedulaForm = $_GET['cedula'];
    $celularForm = $_GET['celular'];
    $correoForm = $_GET['correo'];
    $tiposervicioForm = $_GET['tiposervicio'];
    $prioridadForm = $_GET['prioridad'];
    $notwhatsappForm = $_GET["notificacion_whatsapp"];
    $notemailForm = $_GET["notificacion_email"];
    $notsmsForm = $_GET["notificacion_sms"];

    $array["turn"] = & $turno->generateTurn($cedulaForm, $celularForm, $correoForm, $tiposervicioForm, $prioridadForm, $notwhatsappForm, $notemailForm, $notsmsForm);

    $array2 = array($array);
    $array3["turno"] = $array2;
    print_r(json_encode($array3));
}
?>



