var grid = document.getElementById("grid");

// Update element width based on its height
function updateWidth() {
    console.log(window.innerWidth);
    var threshold = 1000  ; // Replace with your desired max height in pixels

    if (window.innerWidth > threshold) {
        grid.style.width = "50%"; // Replace with your desired width
    } else {
        grid.style.width = "95%"; // Default width
    }
}

// Listen for changes in height
window.addEventListener("resize", updateWidth);

// Initial width update
updateWidth();