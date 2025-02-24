const container = document.querySelector("#container");

function createGrid(size) {
    container.innerHTML = ""; // Clear previous grid


    for (let y = 0; y < size; y++) {
        let row = document.createElement("div");
        row.classList.add("row");

        for (let x = 0; x < size; x++) {
            let cell = document.createElement("div");
            cell.classList.add("square");
            cell.textContent = "hi";
            row.appendChild(cell);
        }

        container.appendChild(row);
    }
}

// Example: Change this number to test different sizes
let size = 16; // 16 cells (4x4), try changing to 25 (5x5) or 36 (6x6)
createGrid(size);
