<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header a { color: white; text-decoration: none; margin-left: 15px; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #333; }
        .event-card { background: white; padding: 20px; margin-bottom: 15px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .event-card h3 { margin-top: 0; color: #333; }
        .event-card p { color: #666; margin: 5px 0; font-size: 14px; }
        .btn { display: inline-block; padding: 8px 20px; background-color: #333; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; font-size: 14px; }
        .btn:hover { background-color: #555; }
        .no-data { text-align: center; color: #999; padding: 40px; }
    </style>
</head>
<body>
    <div class="header">
        <span>Welcome, <b id="userName"></b></span>
        <div>
            <a href="/my-bookings">My Bookings</a>
            <a href="/" id="logoutBtn">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Available Events</h2>
        <div id="eventsList"></div>
    </div>

    <script>
        // check login
        const userId = sessionStorage.getItem('userId');
        const userName = sessionStorage.getItem('userName');
        if (!userId) {
            window.location.href = '/user-login';
        }
        document.getElementById('userName').textContent = userName;

        document.getElementById('logoutBtn').addEventListener('click', function() {
            sessionStorage.clear();
        });

        // load events
        fetch('/api/events')
            .then(response => response.json())
            .then(events => {
                const container = document.getElementById('eventsList');
                if (events.length === 0) {
                    container.innerHTML = '<div class="no-data">No events available right now.</div>';
                    return;
                }
                events.forEach(event => {
                    const date = new Date(event.eventDateTime);
                    const dateStr = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
                    const card = document.createElement('div');
                    card.className = 'event-card';
                    card.innerHTML =
                        '<h3>' + event.title + '</h3>' +
                        '<p><b>Description:</b> ' + (event.description || 'N/A') + '</p>' +
                        '<p><b>Venue:</b> ' + event.venue + '</p>' +
                        '<p><b>Date & Time:</b> ' + dateStr + '</p>' +
                        '<p><b>Price per Seat:</b> Rs. ' + event.pricePerSeat + '</p>' +
                        '<br>' +
                        '<a href="/book-event?eventId=' + event.id + '" class="btn">Book Now</a>';
                    container.appendChild(card);
                });
            })
            .catch(err => {
                document.getElementById('eventsList').innerHTML = '<div class="no-data">Error loading events.</div>';
            });
    </script>
</body>
</html>
