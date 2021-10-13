import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

//This is my first time using HTTP requests in Java, used to using Javascript and Python
//Everything is written and compiled using Visual Studio Code
public class http {

    public static void main(String[] args) throws IOException {

        //I'm using Java 11 documentation for HttpURLConnection
        //https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/net/HttpURLConnection.html
        String stringURL = "https://mhcd-dev.azure-api.net/echo/resource";


        //I decided to use a string formatted to resemble JSON. Initially I tried using
        //a map to create a key, value object, but it would not format correctly when
        //turned into a string.
        String payload = "{\"MyObject\":444}";

        HttpURLConnection connection;

        
        try {

            URL url = new URL(stringURL);

            //openConnection() returns URLconnection object so it needs to be cast to be compatible
            connection = (HttpURLConnection) url.openConnection();

            //This needs to be set to true if sending data
            connection.setDoOutput(true);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("User-Agent", "Java client");
            connection.setRequestProperty("Content-Type", "application/json");

            try (DataOutputStream data = new DataOutputStream(connection.getOutputStream())) {

                //The output stream expects the data to be in bytes
                data.write(payload.getBytes());
            }
            
            System.out.println(connection.getResponseCode());

            connection.disconnect();

        }
        catch(Exception e) {
            System.out.println("Connection failed.");
        }

    }
}