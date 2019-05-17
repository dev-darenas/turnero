package lib;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import java.io.File;

//https://peter.sh/experiments/chromium-command-line-switches/ pagina de comandos 
public class Bot {

    private WebDriver driver;
    private String numero, mensaje, perfil;

    File file = new File("chromedriver.exe"); 

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }

       
    public void iniciar() {       



        System.setProperty("webdriver.chrome.driver", file.getAbsolutePath());
//        System.setProperty("webdriver.chrome.driver", "c:/" + file.getPath);
        ChromeOptions options = new ChromeOptions();
        options.addArguments("user-data-dir=Chrome/" + getPerfil());
        System.out.println(getPerfil());
        options.setBinary("/Chrome/chrome.exe");
    }

    public void conectarCuenta() {



        System.setProperty("webdriver.chrome.driver", file.getAbsolutePath());
//        System.setProperty("webdriver.chrome.driver", "c:/" + file.getPath());
        ChromeOptions options = new ChromeOptions();
        options.addArguments("user-data-dir=Chrome/" + getPerfil());
        driver = new ChromeDriver(options);

        driver.navigate().to("https://web.whatsapp.com/");

    }

    public void mandarAlerta() {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("user-data-dir=Chrome/" + getPerfil());
        System.out.println("Mandar Alerta");
        options.addArguments("--window-size=780,640"); //tamaño 
        options.addArguments("--window-position=-2000,-2000"); // mandar fuera de pantalla

        driver = new ChromeDriver(options);
        driver.navigate().to("https://wa.me/57" + getNumero() + "?text=" + getMensaje());
        driver.findElement(By.id("action-button")).click();

        try {
            Thread.sleep(8000);
            Thread.sleep(8000);
        } catch (InterruptedException e) {
        }

        driver.findElement(By.xpath("//*[@id=\"main\"]/footer/div[1]/div[3]/button/span")).click();

    }

    public void cerrarVentana() {

        driver.close();
    }


    public static void main(String[] arg) {

        Bot b = new Bot();
        b.iniciar();
        b.mandarAlerta();
//          b.conectarCuenta();
//        b.cerrarVentana();
    }

}
