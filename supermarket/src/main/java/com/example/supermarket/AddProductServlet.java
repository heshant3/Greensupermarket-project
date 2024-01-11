package com.example.supermarket;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.StorageClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.*;
import java.nio.file.Paths;
import java.sql.*;
import java.sql.DriverManager;
import java.util.Random;
import static java.lang.System.out;

@WebServlet(name = "addProduct", value = "/addProduct")
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        System.out.println(name);
        String category =  request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));
        String imageUrl = request.getParameter("image");
        String JDBC_URL = "jdbc:mysql://localhost:3306/supermarket";
        String JDBC_USER = "root";
        String JDBC_PASSWORD = "";
        String INSERT_SQL = "INSERT INTO products (name, description, quantity, price, image_url, id,category) VALUES (?, ?, ?, ?, ?,?,?)";
        Part image = request.getPart("image");
        Random random = new Random();
        int randomNumber = 9999 + random.nextInt(90000);
        String randomnumber = Integer.toString(randomNumber);


        FileInputStream serviceAccount = new FileInputStream(getServletContext().getRealPath("/uploads/serviceAccountKey.json"));

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setStorageBucket("supermarket-39e8c.appspot.com")
                .build();

        if (FirebaseApp.getApps().isEmpty()) {
            out.println("emty");
            FirebaseApp.initializeApp(options);
        }
        Bucket bucket = StorageClient.getInstance().bucket();


        InputStream inputStream = null;


        String imageFileName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
        inputStream = image.getInputStream();
        String relativePath = "/uploads/" + randomnumber + imageFileName;
        File outputFile = new File(getServletContext().getRealPath(relativePath));
        OutputStream outputStream = new FileOutputStream(outputFile);
        byte[] buffer = new byte[4096];
        int byteRead;
        try {
            while ((byteRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, byteRead);
            }
        } catch (IOException e) {
            out.println(e);
        } finally {
            inputStream.close();
            outputStream.close();
        }
        String relativeFilePath = "/uploads/" + randomnumber + imageFileName;
        File file = new File(getServletContext().getRealPath(relativeFilePath));
         inputStream = new FileInputStream(file);

        Blob blob = bucket.create(randomnumber+imageFileName, inputStream, "image/jpeg");

        String url = blob.getMediaLink();
        out.println(url);
        String imgUrl = "https://firebasestorage.googleapis.com/v0/b/supermarket-39e8c.appspot.com/o/"+randomnumber+imageFileName+"?alt=media&token";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            PreparedStatement statement = connection.prepareStatement(INSERT_SQL);
            statement.setString(1, name);
            statement.setString(2, description);
            statement.setInt(3, quantity);
            statement.setDouble(4, price);
            statement.setString(5, imgUrl);
            statement.setString(6, randomnumber);
            statement.setString(7, category);

            int result = statement.executeUpdate();

            if (result > 0) {
                response.sendRedirect("add_product.jsp?success=true");
            } else {
                response.sendRedirect("add_product.jsp?success=false");
            }

            statement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}