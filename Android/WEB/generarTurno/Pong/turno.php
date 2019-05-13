<?php

include_once 'db.php';

class Turno extends DB {

    public function &verificarCedula($cedula) {

        $verify = $this->connect()->prepare("select * from Cliente where cedula = :cedula");
        $verify->execute(['cedula' => $cedula]);
        if ($verify->rowCount()) {
            $num_turnoForm = true;
            return $num_turnoForm;
        } else {
            $num_turnoForm = false;
            return $num_turnoForm;
        }
    }

    public function &generateTurn($cedula, $celular, $correo, $tiposervicio, $prioridad, $whatsapp, $email, $sms) {

        $verify = $this->connect()->prepare("select * from Cliente where cedula = $cedula");
        $verify->execute();
        if ($verify->rowCount()) {
            $prioridad = $prioridad + 1;
        } else {

            if ($whatsapp === 1 && $celular === null || $sms === 1 && $celular === null) {
                $num_turnoForm = "No ingresaste tu celular";
                return $num_turnoForm;
            } else if ($email === 1 && $correo === null) {
                $num_turnoForm = "No ingresaste tu correo";
                return $num_turnoForm;
            } else {
                $insert = $this->connect()->prepare("Insert into Cliente (cedula,email,celular) values (:cedula,:email,:celular)");
                $insert->execute(['cedula' => $cedula, 'email' => $email, 'celular' => $celular]);
            }
        }

        if ($prioridad === 3) {
            $letra = "A";
        } else if ($prioridad === 2) {
            $letra = "B";
        } else if ($prioridad === 1) {
            $letra = "C";
        } else {
            $letra = "D";
        }

        $query = $this->connect()->prepare("select * from Turno where num_turno like '%$letra' order by id desc");
        $query->execute();

        if ($query->rowCount() || $query->execute()) {

            $row = $query->fetch();

            $resultado = intval(preg_replace('/[^0-9]+/', '', $row['num_turno']), 10);
  

            $num_turnoForm = (integer) $resultado + 1;
        
            $num_turnoForm = $num_turnoForm . $letra;
            

            
            $insert = $this->connect()->prepare("Insert into Turno (id_cliente,num_turno,tipo_servicio,prioridad,id_historico_modulo,fecha_creacion,fecha_llamado,fecha_terminado,estado) values ((Select id from Cliente where cedula = :cedula),:num_turno,:tipo_servicio,:prioridad,0, NOW() , null , null ,1)");
            $insert->execute(['num_turno' => $num_turnoForm, 'prioridad' => $prioridad, 'cedula' => $cedula, 'tipo_servicio' => $tiposervicio]);
            return $num_turnoForm;
            } else {
            $num_turnoForm = "error, turno no generado";
            return $num_turnoForm;
        }
    }

}
?>

