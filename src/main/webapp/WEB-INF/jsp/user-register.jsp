<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 15px 30px; }
        .header a { color: white; text-decoration: none; }
        .container { max-width: 400px; margin: 60px auto; background: white; padding: 30px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 14px; }
        .btn { width: 100%; padding: 12px; background-color: #333; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn:hover { background-color: #555; }
        .error { color: red; font-size: 13px; margin-top: 10px; display: none; }
        .success { color: green; font-size: 13px; margin-top: 10px; display: none; }
        .link { text-align: center; margin-top: 15px; font-size: 14px; }
        .link a { color: #333; }
    </style>
</head>
<body>
    <div class="header">
        <a href="/">← Back</a> | <b>User Registration</b>
    </div>

    <div class="container">
        <h2>Register as User</h2>
        <form id="registerForm">
            <div class="form-group">
                <label>Name</label>
                <input type="text" id="name" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" id="email" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" id="password" required>
            </div>
            <button type="submit" class="btn">Register</button>
            <div class="error" id="error"></div>
            <div class="success" id="success"></div>
        </form>
        <div class="link">
            Already have an account? <a href="/user-login">Login here</a>
        </div>
    </div>

    <script>
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();

            fetch('/api/user', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    name: document.getElementById('name').value,
                    email: document.getElementById('email').value,
                    password: document.getElementById('password').value
                })
            })
            .then(response => {
                if (!response.ok) throw new Error('Registration failed');
                document.getElementById('success').style.display = 'block';
                document.getElementById('success').textContent = 'Registration successful! Redirecting...';
                document.getElementById('error').style.display = 'none';
                setTimeout(() => { window.location.href = '/user-login'; }, 1500);
            })
            .catch(err => {
                document.getElementById('error').style.display = 'block';
                document.getElementById('error').textContent = 'Registration failed. Email may already exist.';
                document.getElementById('success').style.display = 'none';
            });
        });
    </script>
</body>
</html>
