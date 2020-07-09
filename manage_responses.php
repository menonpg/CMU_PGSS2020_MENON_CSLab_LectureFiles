<?php
if(isset($_POST['submit'])){

      if(!empty($red) || !empty($green) || !empty($blue)){

      $cvsData = $red . "," . $green . "," . $blue  . "\n"; // Add newline

      $fp = fopen("formdata.csv","a"); // $fp is now the file pointer to file $filename

          if($fp)
          {
              fwrite($fp,$cvsData); // Write information to the file
              fclose($fp); // Close the file
          }
      }

    }
}

?> 
