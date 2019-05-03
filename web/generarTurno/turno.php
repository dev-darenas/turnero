<?php

include_once 'db.php';

class Turno extends DB {

    public function &generateTurn($cedula, $comunicacion, $tipocomunicacion, $tiposervicio, $prioridad) {

        $verify = $this->connect()->prepare("select * from Cliente where cedula = $cedula");
        $verify->execute();
        if ($verify->rowCount()) {

            switch ($prioridad) {
                case "isPregnant":
                    $prioridadForm = "A";
                    break;
                case "isMayor":
                    $prioridadForm = "B";
                    break;
                case "isDisability":
                    $prioridadForm = "C";
                    break;               
                default :
                    $prioridadForm = "D";
                    break;
            }
            
            $query = $this->connect()->prepare("select * from Turno where prioridad like '%$prioridadForm%' order by id desc");

            $query->execute();

            if ($query->rowCount() || $query->execute()) {

                $row = $query->fetch();

                $num_turnoForm = (integer) $row['num_turno'] + 1;

                $query2 = $this->connect()->prepare("Insert into Turno (id_cliente,num_turno,tipo_servicio,prioridad,id_historico_modulo,fecha_creacion,fecha_llamado,fecha_terminado,estado) values ((Select id from Cliente where cedula = :cedula),:num_turno,:tipo_servicio,:prioridad,0, NOW() , null , null ,1)");


                $query2->execute(['num_turno' => $num_turnoForm, 'prioridad' => $prioridadForm, 'cedula' => $cedula, 'tipo_servicio' => $tiposervicio]);
                $num_turnoForm = $num_turnoForm . $prioridadForm;
                return $num_turnoForm;
            } else {
                $num_turnoForm = "error, turno no generado";
                return $num_turnoForm;
            }
        } else {
            $num_turnoForm = "Error, cedula no encontrada";
            return $num_turnoForm;
        }
    }

}
?>

