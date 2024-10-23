// Replace these with your actual API Gateway URLs
const apiUrl = '${api_url}';
const getApiUrl = `${apiUrl}/items/`;
const postApiUrl = `${apiUrl}/items`;

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('add-item-form');
    const itemDataDiv = document.getElementById('item-data');
    const apiResponseDiv = document.getElementById('api-response');

    // Function to make GET request
    function getItem(itemId) {
        fetch(getApiUrl + itemId)
            .then(response => response.json())
            .then(data => {
                itemDataDiv.textContent = JSON.stringify(data, null, 2);
            })
            .catch(error => {
                console.error('Error:', error);
                itemDataDiv.textContent = 'Error fetching item data';
            });
    }

    // Function to make POST request
    function addItem(item) {
        fetch(postApiUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(item)
        })
            .then(response => response.json())
            .then(data => {
                apiResponseDiv.textContent = JSON.stringify(data, null, 2);
                // After successfully adding an item, fetch and display it
                if (data.id) {
                    getItem(data.id);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                apiResponseDiv.textContent = 'Error adding item';
            });
    }

    // Event listener for form submission
    form.addEventListener('submit', (e) => {
        e.preventDefault();
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        addItem({ name, email });
    });
});
