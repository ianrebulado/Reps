document.addEventListener('DOMContentLoaded', function() {
  var form = document.getElementById('exercise-form');
  form.addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent the default form submission
    var formData = new FormData(form);
    var xhr = new XMLHttpRequest();
    xhr.open(form.method, form.action, true);
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    xhr.responseType = 'json';
    xhr.onload = function() {
      if (xhr.status === 200) {
        // Handle the JSON response
        if (xhr.response.success) {
          form.reset(); // Clear the form fields
          // Display the flash message if present
          if (xhr.response.flash && xhr.response.flash.notice) {
            // Create a new element to display the flash message
            var flashElement = document.createElement('div');
            flashElement.classList.add('flash-notice');
            flashElement.textContent = xhr.response.flash.notice;
            // Append the flash message element to the page
            document.body.appendChild(flashElement);
            // Remove the flash message after a certain time
            setTimeout(function() {
              flashElement.remove();
            }, 5000); // Remove after 5 seconds (adjust as needed)
          }
        } else {
          // Handle other response scenarios
        }
      } else {
        // Handle non-200 status codes
      }
    };
    xhr.send(formData);
  });
});
