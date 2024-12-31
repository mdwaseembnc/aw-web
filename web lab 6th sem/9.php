<?php
// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Database configuration
    $servername = "localhost";
    $username = "root";      // Default XAMPP MySQL username
    $password = "";          // Default XAMPP MySQL password (leave blank)
    $dbname = "library_db";  // Name of the database you created

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Retrieve the title from the form input
    $search_title = $_POST['title'];

    // Prepare and execute SQL query to search for the title
    $stmt = $conn->prepare("SELECT accession_number, title, authors, edition, publication FROM books WHERE title LIKE ?");
    $search_param = "%" . $search_title . "%";
    $stmt->bind_param("s", $search_param);
    $stmt->execute();
    $result = $stmt->get_result();

    // Display results if any books are found
    if ($result->num_rows > 0) {
        echo "<h1>Search Results</h1>";
        echo "<table border='1'>
                <tr>
                    <th>Accession Number</th>
                    <th>Title</th>
                    <th>Authors</th>
                    <th>Edition</th>
                    <th>Publication</th>
                </tr>";
        
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>" . htmlspecialchars($row['accession_number']) . "</td>
                    <td>" . htmlspecialchars($row['title']) . "</td>
                    <td>" . htmlspecialchars($row['authors']) . "</td>
                    <td>" . htmlspecialchars($row['edition']) . "</td>
                    <td>" . htmlspecialchars($row['publication']) . "</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No books found with the title '" . htmlspecialchars($search_title) . "'</p>";
    }

    // Close the connection
    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Search Book by Title</title>
</head>
<body>
    <h1>Search for a Book</h1>
    <form method="post" action="">
        <label for="title">Enter Book Title:</label><br>
        <input type="text" id="title" name="title" required><br><br>
        <input type="submit" value="Search">
    </form>
</body>
</html>