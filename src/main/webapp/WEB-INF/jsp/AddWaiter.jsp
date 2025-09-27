<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="th">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>เพิ่มพนักงาน</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #1c1c1c;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
            color: #f0f0f0;
        }

        .form-container {
            background-color: #2c2c2c;
            border-radius: 16px;
            padding: 45px 35px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.6);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
            color: #e0e0e0;
        }

        .form-label {
            color: #ddd;
            margin-bottom: 0.4rem;
            display: block;
            font-weight: 500;
        }

        .form-control,
        .form-control-select {
            background-color: #3c3c3c;
            border: none;
            border-radius: 10px;
            color: #fff;
            padding: 12px 15px;
            margin-bottom: 1.3rem;
            transition: 0.3s ease-in-out;
            box-shadow: inset 0 0 0 transparent;
        }

        .form-control:focus {
            background-color: #4a4a4a;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
            outline: none;
        }

        .btn-primary {
            background-color: #9d4edd;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 500;
            padding: 12px;
            width: 100%;
            transition: 0.3s;
        }

        .btn-primary:hover {
            background-color: #7b2cbf;
            transform: scale(1.02);
        }

        .form-links {
            text-align: center;
            margin-top: 25px;
        }

        .form-links a {
            color: #bbb;
            text-decoration: none;
            font-weight: 500;
        }

        .form-links a:hover {
            color: #fff;
            text-decoration: underline;
        }

        .success-message {
            font-size: 1.1rem;
            color: #28a745;
            text-align: center;
            font-weight: bold;
            margin-top: 15px;
        }

        hr {
            border-color: #555;
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .form-label i {
            margin-right: 6px;
            color: #aaa;
        }

        @media (max-width: 576px) {
            .form-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>

<body>

    <div class="form-container">
        <h2><i class="fas fa-user-plus"></i> เพิ่มพนักงานเสิร์ฟ</h2>

        <div class="result-message">
            <div class="success-message">${add_result}</div>
        </div>

        <form action="Add_Waiter" method="post">
            <div class="mb-3">
                <label for="empusername" class="form-label"><i class="fas fa-user"></i>ชื่อผู้ใช้งาน</label>
                <input type="text" class="form-control" id="empusername" name="empusername" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label"><i class="fas fa-lock"></i>รหัสผ่าน</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <div class="mb-3">
                <label for="empname" class="form-label"><i class="fas fa-id-card"></i>ชื่อ - นามสกุล</label>
                <input type="text" class="form-control" id="empname" name="empname" required>
            </div>

            <div class="mb-3">
                <label for="age" class="form-label"><i class="fas fa-calendar"></i>อายุ</label>
                <input type="number" class="form-control" id="age" name="age" required>
            </div>

            <div class="mb-3">
                <label for="position" class="form-label"><i class="fas fa-briefcase"></i>ตำแหน่ง</label>
                <select class="form-control form-control-select" id="position" name="position">
                    <option>พนักงานเสิร์ฟ</option>
                    <option>แคชเชียร์</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="url" class="form-label"><i class="fas fa-image"></i>URL รูปภาพ</label>
                <input type="url" class="form-control" id="url" name="url" required>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i> เพิ่มพนักงาน
            </button>
        </form>

        <hr>

        <div class="form-links">
            <a href="backmain"><i class="fas fa-arrow-left"></i> กลับหน้าหลัก</a>
        </div>
    </div>

</body>

</html>
