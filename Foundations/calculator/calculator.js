function add(a, b){
    return a + b;
}
function subtract(a, b){
    return a - b;
}
function multiply(a, b){
    return a * b;
}
function divide(a, b){
    if (b == 0){
        return "Error: divide by zero"
    }
    return a / b;
}
function operate(operation, a, b){
    return operation(a, b);
}
console.log(operate(add, 5, 4));

const display = document.querySelector("#display");

document.getElementById("btn1").addEventListener("click", () => handleClick("1"));
document.getElementById("btn2").addEventListener("click", () => handleClick("2"));
document.getElementById("btn3").addEventListener("click", () => handleClick("3"));
document.getElementById("btn0").addEventListener("click", () => handleClick("0"));
document.getElementById("btn4").addEventListener("click", () => handleClick("4"));
document.getElementById("btn5").addEventListener("click", () => handleClick("5"));
document.getElementById("btn6").addEventListener("click", () => handleClick("6"));
document.getElementById("btnDot").addEventListener("click", () => handleClick("."));
document.getElementById("btn7").addEventListener("click", () => handleClick("7"));
document.getElementById("btn8").addEventListener("click", () => handleClick("8"));
document.getElementById("btn9").addEventListener("click", () => handleClick("9"));
document.getElementById("btnNeg").addEventListener("click", () => handleClick("(-)"));

let calculation = "";
function handleClick(buttonValue) {
    console.log(`Button ${buttonValue} clicked!`);
    
    calculation += buttonValue;
    display.innerHTML = calculation;
}
