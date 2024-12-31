<?php
// Database configuration
$servername = "localhost";
$username = "root";
$password = "";  // Default XAMPP MySQL password
$dbname = "library_db";  // Name of the database you created

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve form data
    $accession_number = $_POST['accession_number'];
    $title = $_POST['title'];
    $authors = $_POST['authors'];
    $edition = $_POST['edition'];
    $publication = $_POST['publication'];

    // Prepare and bind the SQL statement
    $stmt = $conn->prepare("INSERT INTO books (accession_number, title, authors, edition, publication) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("issss", $accession_number, $title, $authors, $edition, $publication);

    // Execute the statement
    if ($stmt->execute()) {
        echo "<p>New book added successfully.</p>";
    } else {
        echo "<p>Error: " . $stmt->error . "</p>";
    }

    // Close the statement
    $stmt->close();
}

// SQL query to select all records from the 'books' table
$sql = "SELECT * FROM books";
$result = $conn->query($sql);

// HTML structure to display results
echo "<!DOCTYPE html>
<html>
<head>
    <title>Add and View Books</title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 18px;
            text-align: left;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Add New Book</h1>
    <form method='post' action=''>
        <label for='accession_number'>Accession Number:</label><br>
        <input type='number' id='accession_number' name='accession_number' required><br><br>

        <label for='title'>Title:</label><br>
        <input type='text' id='title' name='title' required><br><br>

        <label for='authors'>Authors:</label><br>
        <input type='text' id='authors' name='authors' required><br><br>

        <label for='edition'>Edition:</label><br>
        <input type='text' id='edition' name='edition' required><br><br>

        <label for='publication'>Publication:</label><br>
        <input type='text' id='publication' name='publication' required><br><br>

        <input type='submit' value='Add Book'>
    </form>";

if ($result->num_rows > 0) {
    // Display the list of books in a table
    echo "<h2>List of Books</h2>
          <table>
            <tr>
                <th>Accession Number</th>
                <th>Title</th>
                <th>Authors</th>
                <th>Edition</th>
                <th>Publication</th>
            </tr>";
    
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>" . $row["accession_number"] . "</td>
                <td>" . $row["title"] . "</td>
                <td>" . $row["authors"] . "</td>
                <td>" . $row["edition"] . "</td>
                <td>" . $row["publication"] . "</td>
              </tr>";
    }
    echo "</table>";
} else {
    echo "<p>No books found.</p>";
}

$conn->close();

echo "</body>
</html>";
?>
