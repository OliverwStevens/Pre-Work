let size = 16;
const btn = document.querySelector("button");

btn.onclick = () => {
    let newSize = parseInt(prompt("What size do you want?", size), 10);

    if (isNaN(newSize) || newSize <= 0) {
        newSize = size;
    }

    if (newSize > 100) {
        newSize = 100;
    }

    size = newSize; 
    createGrid(size); 
};

function createGrid(size) {
    container.innerHTML = "";


    for (let y = 0; y < size; y++) {
        let row = document.createElement("div");
        row.classList.add("row");

        for (let x = 0; x < size; x++) {
            let cell = document.createElement("div");
            cell.classList.add("square");
            cell.textContent = " ";
            row.appendChild(cell);
        }

        container.appendChild(row);
    }
}

createGrid(size);
