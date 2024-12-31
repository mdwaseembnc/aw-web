<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Insert and Display Records</title>
</head>
<body>
    <h2>Enter Name and Age</h2>
    <form action="6.php" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>
        <label for="age">Age:</label>
        <input type="number" id="age" name="age" required><br><br>
        <input type="submit" value="Submit">
    </form>

    <?php
    // Database credentials
    $servername = "localhost";
    $username = "root";
    $password = ""; // Default password for XAMPP MySQL is empty
    $dbname = "test"; // Replace with your database name

    // Create a connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Insert data if form is submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Get data from form
        $name = $_POST['name'];
        $age = $_POST['age'];

        // Prepare and bind
        $stmt = $conn->prepare("INSERT INTO info (name, age) VALUES (?, ?)"); // Replace with your table name
        $stmt->bind_param("si", $name, $age);

        // Execute the query
        if ($stmt->execute()) {
            echo "<p>New record inserted successfully!</p>";
        } else {
            echo "<p>Error: " . $stmt->error . "</p>";
        }

        // Close the statement
        $stmt->close();
    }

    // Fetch and display all records from the table
    $sql = "SELECT * FROM info"; // Replace with your table name
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<h2>Current Records</h2>";
        echo "<table border='1'><tr><th>Name</th><th>Age</th></tr>";
        while ($row = $result->fetch_assoc()) {
            echo "</td><td>" . $row["name"] . "</td><td>" . $row["age"] . "</td></tr>";
        }
        echo "</table>";
    } else {
        echo "<p>No records found.</p>";
    }

    // Close the database connection
    $conn->close();
    ?>
</body>
</html>
