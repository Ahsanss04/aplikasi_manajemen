<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

$koneksi = new mysqli("localhost", "root", "", "gudangcv");

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->username) && !empty($data->password)) {
    $username = $data->username;
    $password = $data->password;

    $stmt = $koneksi->prepare("SELECT * FROM user WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $hasil = $stmt->get_result();

    if ($hasil->num_rows > 0) {
        $user = $hasil->fetch_assoc();

        if (password_verify($password, $user['password'])) {
            echo json_encode([
                "success" => true,
                "message" => "Login berhasil",
                "data" => [
                    "id_user" => $user['id_user'],
                    "username" => $user['username'],
                    "level" => $user['level']
                ]
            ]);
        } else {
            echo json_encode(["success" => false, "message" => "Password salah"]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "User tidak ditemukan"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Data tidak lengkap"]);
}
?>
