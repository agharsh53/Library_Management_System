// Get all links in the navbar
const links = document.querySelectorAll('.toolbar a');

// Loop through the links and add an "active" class to the current page
links.forEach(link => {
    // Check if the link's href matches the current page URL
    if (window.location.href.includes(link.getAttribute('href'))) {
        link.classList.add('active');
    }
});
