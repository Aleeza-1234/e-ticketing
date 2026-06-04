<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 15px 30px; }
        .header a { color: white; text-decoration: none; }
        .container { max-width: 400px; margin: 60px auto; background: white; padding: 30px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input[type="email"], input[type="password"], input[type="text"] {
            width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 14px;
        }
        .btn { width: 100%; padding: 12px; background-color: #333; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn:hover { background-color: #555; }
        .error { color: red; font-size: 13px; margin-top: 10px; display: none; }
        .link { text-align: center; margin-top: 15px; font-size: 14px; }
        .link a { color: #333; }
    </style>
</head>
<body>
    <div class="header">
        <a href="/">← Back</a> | <b>User Login</b>
    </div>

    <div class="container">
        <h2>User Login</h2>
        <form id="loginForm">
            <div class="form-group">
                <label>Email</label>
                <input type="email" id="email" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" id="password" required>
            </div>
            <button type="submit" class="btn">Login</button>
            <div class="error" id="error"></div>
        </form>
        <div class="link">
            Don't have an account? <a href="/user-register">Register here</a>
        </div>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;

            fetch('/api/user/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email: email, password: password })
            })
            .then(response => {
                if (!response.ok) throw new Error('Invalid credentials');
                return response.json();
            })
            .then(data => {
                sessionStorage.setItem('userId', data.id);
                sessionStorage.setItem('userName', data.name);
                sessionStorage.setItem('userType', 'user');
                window.location.href = '/user-dashboard';
            })
            .catch(err => {
                document.getElementById('error').style.display = 'block';
                document.getElementById('error').textContent = 'Login failed. Check your credentials.';
            });
        });
    </script>
</body>
</html>
