<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Event</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 15px 30px; }
        .header a { color: white; text-decoration: none; }
        .container { max-width: 500px; margin: 40px auto; background: white; padding: 30px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 14px; }
        textarea { resize: vertical; height: 80px; }
        .btn { width: 100%; padding: 12px; background-color: #333; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn:hover { background-color: #555; }
        .error { color: red; font-size: 13px; margin-top: 10px; display: none; }
        .success { color: green; font-size: 13px; margin-top: 10px; display: none; }
    </style>
</head>
<body>
    <div class="header">
        <a href="/org-dashboard">← Back to Dashboard</a> | <b>Create Event</b>
    </div>

    <div class="container">
        <h2>Create New Event</h2>
        <form id="eventForm">
            <div class="form-group">
                <label>Event Title</label>
                <input type="text" id="title" required>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea id="description"></textarea>
            </div>
            <div class="form-group">
                <label>Venue</label>
                <input type="text" id="venue" required>
            </div>
            <div class="form-group">
                <label>Date & Time</label>
                <input type="datetime-local" id="eventDateTime" required>
            </div>
            <div class="form-group">
                <label>Price per Seat (Rs.)</label>
                <input type="number" id="pricePerSeat" min="0" step="0.01" required>
            </div>
            <div class="form-group">
                <label>Number of Seats</label>
                <input type="number" id="numberOfSeats" min="1" required>
            </div>
            <button type="submit" class="btn">Create Event</button>
            <div class="error" id="error"></div>
            <div class="success" id="success"></div>
        </form>
    </div>

    <script>
        const orgId = sessionStorage.getItem('orgId');
        if (!orgId) {
            window.location.href = '/org-login';
        }

        document.getElementById('eventForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const data = {
                title: document.getElementById('title').value,
                description: document.getElementById('description').value,
                venue: document.getElementById('venue').value,
                eventDateTime: document.getElementById('eventDateTime').value,
                pricePerSeat: parseFloat(document.getElementById('pricePerSeat').value),
                organisationId: parseInt(orgId),
                numberOfSeats: parseInt(document.getElementById('numberOfSeats').value)
            };

            fetch('/api/event', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) throw new Error('Failed to create event');
                document.getElementById('success').style.display = 'block';
                document.getElementById('success').textContent = 'Event created successfully! Redirecting...';
                document.getElementById('error').style.display = 'none';
                setTimeout(() => { window.location.href = '/org-dashboard'; }, 1500);
            })
            .catch(err => {
                document.getElementById('error').style.display = 'block';
                document.getElementById('error').textContent = 'Failed to create event. Please try again.';
                document.getElementById('success').style.display = 'none';
            });
        });
    </script>
</body>
</html>
