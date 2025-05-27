<?php
header('Content-Type: application/json');

// Database configuration
$host = 'localhost';
$dbname = 'babay_db';
$username = 'root';
$password = '';

// Connect to database
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'ERROR',
        'message' => 'Database connection error',
    ]);
    exit;
}

// Get the JWT token from the request header
$headers = getallheaders();
$token = isset($headers['Token']) ? $headers['Token'] : null;

if (!$token) {
    http_response_code(401);
    echo json_encode([
        'status' => 'ERROR',
        'message' => 'Authentication token required',
    ]);
    exit;
}

// Verify token and get user_id (this is a simplified example)
// In a real application, you would properly validate the JWT token
try {
    // Decode JWT token to get user_id
    // This is a placeholder - replace with your actual JWT verification logic
    $user_id = verifyToken($token);
    
    if (!$user_id) {
        throw new Exception('Invalid token');
    }
} catch (Exception $e) {
    http_response_code(401);
    echo json_encode([
        'status' => 'ERROR',
        'message' => 'Authentication failed: ' . $e->getMessage(),
    ]);
    exit;
}

// Handle GET request to fetch profile data
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        $stmt = $pdo->prepare("SELECT id, name, last_name, email, personal_photo, personal_phone, 
                                personal_birthday, DATE_FORMAT(personal_birthday, '%Y-%m-%d') as personal_birthday_date, 
                                personal_gender FROM users WHERE id = ?");
        $stmt->execute([$user_id]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user) {
            echo json_encode([
                'status' => 'OK',
                'data' => $user
            ]);
        } else {
            http_response_code(404);
            echo json_encode([
                'status' => 'ERROR',
                'message' => 'User not found'
            ]);
        }
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode([
            'status' => 'ERROR',
            'message' => 'Database error: ' . $e->getMessage()
        ]);
    }
    exit;
}

// Handle POST request to update profile
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get and validate input data
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        // Try to get data from POST
        $input = $_POST;
    }
    
    // Validation
    $errors = [];
    
    // Name validation (at least 3 characters)
    $name = isset($input['name']) ? trim($input['name']) : '';
    if (empty($name) || strlen($name) < 3) {
        $errors[] = 'Name must be at least 3 characters';
    }
    
    // Last name validation
    $last_name = isset($input['last_name']) ? trim($input['last_name']) : '';
    if (empty($last_name)) {
        $errors[] = 'Last name is required';
    }
    
    // Email validation
    $email = isset($input['email']) ? trim($input['email']) : '';
    if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Valid email is required';
    }
    
    // Phone validation (at least 9 digits)
    $phone = isset($input['personal_phone']) ? trim($input['personal_phone']) : '';
    if (empty($phone) || strlen(preg_replace('/[^0-9]/', '', $phone)) < 9) {
        $errors[] = 'Phone number must have at least 9 digits';
    }
    
    // Birthday validation (optional)
    $birthday = isset($input['personal_birthday']) ? trim($input['personal_birthday']) : null;
    if (!empty($birthday) && !strtotime($birthday)) {
        $errors[] = 'Invalid birthday format';
    }
    
    // Gender validation (must be M or F)
    $gender = isset($input['personal_gender']) ? trim($input['personal_gender']) : '';
    if (empty($gender) || !in_array($gender, ['M', 'F'])) {
        $errors[] = 'Gender must be M or F';
    }
    
    // If there are validation errors, return them
    if (!empty($errors)) {
        http_response_code(400);
        echo json_encode([
            'status' => 'ERROR',
            'message' => 'Validation failed',
            'errors' => $errors
        ]);
        exit;
    }
    
    // Update user profile in database
    try {
        $stmt = $pdo->prepare("UPDATE users SET 
                               name = ?, 
                               last_name = ?, 
                               email = ?, 
                               personal_phone = ?, 
                               personal_birthday = ?, 
                               personal_gender = ? 
                               WHERE id = ?");
        
        $result = $stmt->execute([
            $name,
            $last_name,
            $email,
            $phone,
            $birthday,
            $gender,
            $user_id
        ]);
        
        if ($result) {
            echo json_encode([
                'status' => 'OK',
                'message' => 'Profile updated successfully'
            ]);
        } else {
            http_response_code(500);
            echo json_encode([
                'status' => 'ERROR',
                'message' => 'Failed to update profile'
            ]);
        }
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode([
            'status' => 'ERROR',
            'message' => 'Database error: ' . $e->getMessage()
        ]);
    }
    exit;
}

// If the request method is not supported
http_response_code(405);
echo json_encode([
    'status' => 'ERROR',
    'message' => 'Method not allowed'
]);

// Function to verify JWT token (placeholder - implement your actual verification)
function verifyToken($token) {
    // This is a simplified example
    // In a real application, you would properly decode and verify the JWT token
    // For now, we'll assume the token is valid and extract the user_id
    
    // Example: decode JWT and extract user_id
    // $decoded = JWT::decode($token, $key, ['HS256']);
    // return $decoded->user_id;
    
    // For testing purposes, we'll just return a user ID
    // Replace this with your actual JWT verification logic
    return 1; // Return user_id 1 for testing
}
?>
