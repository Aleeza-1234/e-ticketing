<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Event Ticketing System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .header {
            background-color: #333;
            color: white;
            padding: 15px 30px;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 80px auto;
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
        }
        p {
            color: #666;
            margin-bottom: 40px;
        }
        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }
        .btn {
            display: inline-block;
            padding: 12px 40px;
            background-color: #333;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            width: 200px;
            text-align: center;
        }
        .btn:hover {
            background-color: #555;
        }
        .btn-outline {
            background-color: white;
            color: #333;
            border: 2px solid #333;
        }
        .btn-outline:hover {
            background-color: #333;
            color: white;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Event Ticketing System</h2>
    </div>

    <div class="container">
        <h1>Welcome</h1>
        <p>Book tickets for events or manage your events as an organisation.</p>

        <div class="btn-group">
            <a href="/user-login" class="btn">User Login</a>
            <a href="/org-login" class="btn btn-outline">Organisation Login</a>
        </div>
    </div>
</body>
</html>
