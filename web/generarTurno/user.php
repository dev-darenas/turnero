<?php

include_once 'db.php';

class User extends DB {

    public function userExists($cedula) {

        $query = $this->connect()->prepare("Select * from Cliente where cedula = :cedula");

        $query->execute(['cedula' => $cedula]);

        if ($query->rowCount()) {
            
            if($cedula=="0"){
                return false;
            } else{
                return true;
            }
                       
        } else {
            return false;
        }
    }

}
?>

