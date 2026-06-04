<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 15px 30px; }
        .header a { color: white; text-decoration: none; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-radius: 5px; overflow: hidden; }
        th { background-color: #333; color: white; padding: 12px 15px; text-align: left; font-size: 14px; }
        td { padding: 12px 15px; border-bottom: 1px solid #eee; font-size: 14px; color: #555; }
        tr:last-child td { border-bottom: none; }
        .no-data { text-align: center; color: #999; padding: 40px; }
    </style>
</head>
<body>
    <div class="header">
        <a href="/user-dashboard">← Back to Dashboard</a> | <b>My Bookings</b>
    </div>

    <div class="container">
        <h2>My Bookings</h2>
        <div id="bookingsContainer"></div>
    </div>

    <script>
        const userId = sessionStorage.getItem('userId');
        if (!userId) {
            window.location.href = '/user-login';
        }

        // Load all bookings and filter by user
        fetch('/api/bookings')
            .then(response => response.json())
            .then(bookings => {
                const userBookings = bookings.filter(b => b.user && b.user.id == userId);
                const container = document.getElementById('bookingsContainer');

                if (userBookings.length === 0) {
                    container.innerHTML = '<div class="no-data">You have no bookings yet.</div>';
                    return;
                }

                let html = '<table>';
                html += '<tr><th>Booking ID</th><th>Event</th><th>Venue</th><th>Booking Time</th><th>Total Amount</th></tr>';

                userBookings.forEach(booking => {
                    const date = new Date(booking.bookingTime);
                    const dateStr = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
                    html += '<tr>';
                    html += '<td>' + booking.id + '</td>';
                    html += '<td>' + (booking.event ? booking.event.title : 'N/A') + '</td>';
                    html += '<td>' + (booking.event ? booking.event.venue : 'N/A') + '</td>';
                    html += '<td>' + dateStr + '</td>';
                    html += '<td>Rs. ' + booking.totalAmount + '</td>';
                    html += '</tr>';
                });

                html += '</table>';
                container.innerHTML = html;
            })
            .catch(err => {
                document.getElementById('bookingsContainer').innerHTML = '<div class="no-data">Error loading bookings.</div>';
            });
    </script>
</body>
</html>
