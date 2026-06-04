<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Event</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 15px 30px; }
        .header a { color: white; text-decoration: none; }
        .container { max-width: 600px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #333; }
        .event-info { background: white; padding: 20px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .event-info h3 { margin-top: 0; }
        .event-info p { color: #666; margin: 5px 0; font-size: 14px; }
        .seats-section { background: white; padding: 20px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .seats-grid { display: flex; flex-wrap: wrap; gap: 8px; margin: 15px 0; }
        .seat { width: 45px; height: 45px; display: flex; align-items: center; justify-content: center; border: 2px solid #333; border-radius: 4px; cursor: pointer; font-size: 12px; font-weight: bold; }
        .seat.available { background-color: #e8f5e9; color: #2e7d32; }
        .seat.booked { background-color: #ffebee; color: #c62828; cursor: not-allowed; }
        .seat.selected { background-color: #333; color: white; }
        .legend { display: flex; gap: 20px; margin: 10px 0; font-size: 13px; }
        .legend span { display: flex; align-items: center; gap: 5px; }
        .legend-box { width: 16px; height: 16px; border: 1px solid #999; border-radius: 3px; }
        .form-group { margin: 15px 0; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        .btn { padding: 12px 30px; background-color: #333; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn:hover { background-color: #555; }
        .btn:disabled { background-color: #999; cursor: not-allowed; }
        .total { font-size: 18px; font-weight: bold; color: #333; margin: 10px 0; }
        .error { color: red; font-size: 13px; margin-top: 10px; display: none; }
        .success { color: green; font-size: 13px; margin-top: 10px; display: none; }
    </style>
</head>
<body>
    <div class="header">
        <a href="/user-dashboard">← Back to Dashboard</a> | <b>Book Event</b>
    </div>

    <div class="container">
        <div class="event-info" id="eventInfo">
            <p>Loading event details...</p>
        </div>

        <div class="seats-section">
            <h3>Select Seats</h3>
            <div class="legend">
                <span><div class="legend-box" style="background:#e8f5e9"></div> Available</span>
                <span><div class="legend-box" style="background:#ffebee"></div> Booked</span>
                <span><div class="legend-box" style="background:#333"></div> Selected</span>
            </div>
            <div class="seats-grid" id="seatsGrid"></div>

            <div class="total" id="totalAmount">Total: Rs. 0</div>

            <button class="btn" id="bookBtn" disabled onclick="bookSeats()">Confirm Booking</button>
            <div class="error" id="error"></div>
            <div class="success" id="success"></div>
        </div>
    </div>

    <script>
        const userId = sessionStorage.getItem('userId');
        if (!userId) {
            window.location.href = '/user-login';
        }

        const urlParams = new URLSearchParams(window.location.search);
        const eventId = urlParams.get('eventId');
        let eventData = null;
        let selectedSeats = [];

        if (!eventId) {
            window.location.href = '/user-dashboard';
        }

        // Load event details
        fetch('/api/event/' + eventId)
            .then(response => response.json())
            .then(event => {
                eventData = event;
                const date = new Date(event.eventDateTime);
                const dateStr = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
                document.getElementById('eventInfo').innerHTML =
                    '<h3>' + event.title + '</h3>' +
                    '<p><b>Venue:</b> ' + event.venue + '</p>' +
                    '<p><b>Date & Time:</b> ' + dateStr + '</p>' +
                    '<p><b>Price per Seat:</b> Rs. ' + event.pricePerSeat + '</p>';
                loadSeats();
            });

        function loadSeats() {
            fetch('/api/seats-by-event/' + eventId)
                .then(response => response.json())
                .then(seats => {
                    const grid = document.getElementById('seatsGrid');
                    grid.innerHTML = '';
                    if (seats.length === 0) {
                        grid.innerHTML = '<p style="color:#999">No seats available for this event.</p>';
                        return;
                    }
                    seats.forEach(seat => {
                        const div = document.createElement('div');
                        div.className = 'seat ' + (seat.status === 'BOOKED' ? 'booked' : 'available');
                        div.textContent = seat.seatNumber;
                        div.dataset.seatId = seat.id;
                        if (seat.status !== 'BOOKED') {
                            div.onclick = function() { toggleSeat(this, seat.id); };
                        }
                        grid.appendChild(div);
                    });
                });
        }

        function toggleSeat(el, seatId) {
            if (el.classList.contains('selected')) {
                el.classList.remove('selected');
                el.classList.add('available');
                selectedSeats = selectedSeats.filter(id => id !== seatId);
            } else {
                el.classList.remove('available');
                el.classList.add('selected');
                selectedSeats.push(seatId);
            }
            const total = selectedSeats.length * eventData.pricePerSeat;
            document.getElementById('totalAmount').textContent = 'Total: Rs. ' + total;
            document.getElementById('bookBtn').disabled = selectedSeats.length === 0;
        }

        function bookSeats() {
            const total = selectedSeats.length * eventData.pricePerSeat;

            const data = {
                bookingTime: new Date().toISOString().slice(0, 19),
                totalAmount: total,
                userId: parseInt(userId),
                eventId: parseInt(eventId),
                numberOfSeats: selectedSeats.length
            };

            fetch('/api/booking', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) throw new Error('Booking failed');
                document.getElementById('success').style.display = 'block';
                document.getElementById('success').textContent = 'Booking successful! ' + selectedSeats.length + ' seat(s) booked. Redirecting...';
                document.getElementById('error').style.display = 'none';
                document.getElementById('bookBtn').disabled = true;
                setTimeout(() => { window.location.href = '/my-bookings'; }, 2000);
            })
            .catch(err => {
                document.getElementById('error').style.display = 'block';
                document.getElementById('error').textContent = 'Booking failed. Please try again.';
                document.getElementById('success').style.display = 'none';
            });
        }
    </script>
</body>
</html>
