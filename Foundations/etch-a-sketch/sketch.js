let size = 16;
const btn = document.querySelector("button");
let isMouseDown = true;
let cellInteractions = new Map();

btn.onclick = () => {
    let newSize = parseInt(prompt("What size do you want?", size), 10);

    if (isNaN(newSize) || newSize <= 0) {
        newSize = size;
    }

    if (newSize > 100) {
        newSize = 100;
    }

    size = newSize;
    cellInteractions.clear();
    createGrid(size);
};

function createGrid(size) {
    const container = document.getElementById('container');
    container.innerHTML = "";

    for (let y = 0; y < size; y++) {
        let row = document.createElement("div");
        row.classList.add("row");

        for (let x = 0; x < size; x++) {
            let cell = document.createElement("div");
            cell.classList.add("square");
            cell.dataset.position = `${x},${y}`;
            
            cell.addEventListener('mouseover', handleHover);
            
            row.appendChild(cell);
        }

        container.appendChild(row);
    }
}

function handleHover(e) {
    colorCell(e.target);
}
  
function colorCell(cell) {
    const position = cell.dataset.position;
    let count = cellInteractions.get(position) || 0;
    
    if (count === 0) {
        cell.style.backgroundColor = getRandomColor();
    } else if (count < 10) {
        const darkenAmount = count * 0.1;
        cell.style.filter = `brightness(${1 - darkenAmount})`;
    } else {
        cell.style.backgroundColor = 'black';
        cell.style.filter = 'none';
    }
    
    cellInteractions.set(position, count + 1);
}

function getRandomColor() {
    return `hsl(${Math.random() * 360}, 70%, 60%)`;
}

createGrid(size);