<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Organisation Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header a { color: white; text-decoration: none; margin-left: 15px; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #333; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .event-card { background: white; padding: 20px; margin-bottom: 15px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .event-card h3 { margin-top: 0; color: #333; }
        .event-card p { color: #666; margin: 5px 0; font-size: 14px; }
        .btn { display: inline-block; padding: 8px 20px; background-color: #333; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; font-size: 14px; }
        .btn:hover { background-color: #555; }
        .btn-danger { background-color: #c0392b; }
        .btn-danger:hover { background-color: #e74c3c; }
        .btn-edit { background-color: #2980b9; margin-right: 10px; }
        .btn-edit:hover { background-color: #3498db; }
        .no-data { text-align: center; color: #999; padding: 40px; }
        .seat-info { display: inline-block; background: #eee; padding: 4px 10px; border-radius: 3px; font-size: 13px; margin-top: 5px; }
        .seat-info .booked { color: #c0392b; font-weight: bold; }
        .seat-info .available { color: #27ae60; font-weight: bold; }

        /* Edit form styles */
        .edit-form { margin-top: 15px; padding-top: 15px; border-top: 1px solid #eee; display: none; }
        .edit-form .form-group { margin-bottom: 10px; }
        .edit-form label { display: block; margin-bottom: 3px; color: #555; font-size: 13px; }
        .edit-form input, .edit-form textarea { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 13px; }
        .edit-form textarea { resize: vertical; height: 60px; }
        .edit-form .form-actions { margin-top: 10px; }
        .btn-save { background-color: #27ae60; margin-right: 10px; }
        .btn-save:hover { background-color: #2ecc71; }
        .btn-cancel { background-color: #999; }
        .btn-cancel:hover { background-color: #bbb; }
        .msg { font-size: 13px; margin-top: 8px; }
        .msg.success { color: green; }
        .msg.error { color: red; }
    </style>
</head>
<body>
    <div class="header">
        <span>Organisation: <b id="orgName"></b></span>
        <div>
            <a href="/" id="logoutBtn">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="top-bar">
            <h2>Your Events</h2>
            <a href="/create-event" class="btn">+ Create Event</a>
        </div>
        <div id="eventsList"></div>
    </div>

    <script>
        const orgId = sessionStorage.getItem('orgId');
        const orgName = sessionStorage.getItem('orgName');
        if (!orgId) {
            window.location.href = '/org-login';
        }
        document.getElementById('orgName').textContent = orgName;

        document.getElementById('logoutBtn').addEventListener('click', function() {
            sessionStorage.clear();
        });

        function loadEvents() {
            fetch('/api/event-by-organisation/' + orgId)
                .then(response => response.json())
                .then(events => {
                    const container = document.getElementById('eventsList');
                    container.innerHTML = '';
                    if (events.length === 0) {
                        container.innerHTML = '<div class="no-data">No events created yet. Click "Create Event" to get started.</div>';
                        return;
                    }
                    events.forEach(event => {
                        const date = new Date(event.eventDateTime);
                        const dateStr = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});

                        const totalSeats = event.seats ? event.seats.length : 0;
                        const bookedSeats = event.seats ? event.seats.filter(s => s.status === 'BOOKED').length : 0;
                        const availableSeats = totalSeats - bookedSeats;

                        // format datetime for input field
                        const dtVal = event.eventDateTime ? event.eventDateTime.substring(0, 16) : '';

                        const card = document.createElement('div');
                        card.className = 'event-card';
                        card.innerHTML =
                            '<h3>' + event.title + '</h3>' +
                            '<p><b>Description:</b> ' + (event.description || 'N/A') + '</p>' +
                            '<p><b>Venue:</b> ' + event.venue + '</p>' +
                            '<p><b>Date & Time:</b> ' + dateStr + '</p>' +
                            '<p><b>Price per Seat:</b> Rs. ' + event.pricePerSeat + '</p>' +
                            '<div class="seat-info">' +
                                'Total: ' + totalSeats +
                                ' | <span class="booked">Booked: ' + bookedSeats + '</span>' +
                                ' | <span class="available">Available: ' + availableSeats + '</span>' +
                            '</div>' +
                            '<br>' +
                            '<button class="btn btn-edit" onclick="toggleEdit(' + event.id + ')">Edit</button>' +
                            '<button class="btn btn-danger" onclick="deleteEvent(' + event.id + ')">Delete</button>' +

                            '<div class="edit-form" id="editForm-' + event.id + '">' +
                                '<div class="form-group">' +
                                    '<label>Title</label>' +
                                    '<input type="text" id="editTitle-' + event.id + '" value="' + (event.title || '') + '">' +
                                '</div>' +
                                '<div class="form-group">' +
                                    '<label>Description</label>' +
                                    '<textarea id="editDesc-' + event.id + '">' + (event.description || '') + '</textarea>' +
                                '</div>' +
                                '<div class="form-group">' +
                                    '<label>Venue</label>' +
                                    '<input type="text" id="editVenue-' + event.id + '" value="' + (event.venue || '') + '">' +
                                '</div>' +
                                '<div class="form-group">' +
                                    '<label>Date & Time</label>' +
                                    '<input type="datetime-local" id="editDate-' + event.id + '" value="' + dtVal + '">' +
                                '</div>' +
                                '<div class="form-group">' +
                                    '<label>Price per Seat (Rs.)</label>' +
                                    '<input type="number" id="editPrice-' + event.id + '" value="' + event.pricePerSeat + '" step="0.01">' +
                                '</div>' +
                                '<div class="form-actions">' +
                                    '<button class="btn btn-save" onclick="saveEvent(' + event.id + ')">Save</button>' +
                                    '<button class="btn btn-cancel" onclick="toggleEdit(' + event.id + ')">Cancel</button>' +
                                '</div>' +
                                '<div class="msg" id="editMsg-' + event.id + '"></div>' +
                            '</div>';
                        container.appendChild(card);
                    });
                })
                .catch(err => {
                    document.getElementById('eventsList').innerHTML = '<div class="no-data">Error loading events.</div>';
                });
        }

        function toggleEdit(eventId) {
            const form = document.getElementById('editForm-' + eventId);
            if (form.style.display === 'block') {
                form.style.display = 'none';
            } else {
                form.style.display = 'block';
            }
        }

        function saveEvent(eventId) {
            const data = {
                id: eventId,
                title: document.getElementById('editTitle-' + eventId).value,
                description: document.getElementById('editDesc-' + eventId).value,
                venue: document.getElementById('editVenue-' + eventId).value,
                eventDateTime: document.getElementById('editDate-' + eventId).value,
                pricePerSeat: parseFloat(document.getElementById('editPrice-' + eventId).value),
                organisation: { id: parseInt(orgId) }
            };

            const msgEl = document.getElementById('editMsg-' + eventId);

            fetch('/api/event', {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) throw new Error('Update failed');
                msgEl.className = 'msg success';
                msgEl.textContent = 'Event updated successfully!';
                setTimeout(() => loadEvents(), 1000);
            })
            .catch(err => {
                msgEl.className = 'msg error';
                msgEl.textContent = 'Failed to update event.';
            });
        }

        function deleteEvent(id) {
            if (confirm('Are you sure you want to delete this event?')) {
                fetch('/api/event/' + id, { method: 'DELETE' })
                    .then(() => loadEvents())
                    .catch(err => alert('Failed to delete event.'));
            }
        }

        loadEvents();
    </script>
</body>
</html>
