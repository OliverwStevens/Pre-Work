const display = document.querySelector("#display");

document.getElementById("btn0").addEventListener("click", () => handleClick("0"));
document.getElementById("btn1").addEventListener("click", () => handleClick("1"));
document.getElementById("btn2").addEventListener("click", () => handleClick("2"));
document.getElementById("btn3").addEventListener("click", () => handleClick("3"));
document.getElementById("btn4").addEventListener("click", () => handleClick("4"));
document.getElementById("btn5").addEventListener("click", () => handleClick("5"));
document.getElementById("btn6").addEventListener("click", () => handleClick("6"));
document.getElementById("btn7").addEventListener("click", () => handleClick("7"));
document.getElementById("btn8").addEventListener("click", () => handleClick("8"));
document.getElementById("btn9").addEventListener("click", () => handleClick("9"));
document.getElementById("btnDot").addEventListener("click", () => handleClick("."));

let currentInput = "";
let firstOperand = null;
let operator = null;
let waitingForSecondOperand = false;

const MAX_DECIMALS = 6;

function handleClick(buttonValue) {
    console.log(`Button ${buttonValue} clicked!`);

    if (waitingForSecondOperand) {
        currentInput = buttonValue;
        waitingForSecondOperand = false;
    } else {
        if (buttonValue === "." && currentInput.includes(".")) return;
        
        currentInput = currentInput === "0" && buttonValue !== "." ? buttonValue : currentInput + buttonValue;
    }
    
    display.innerHTML = currentInput;
}

function add(a, b) {
    return a + b;
}
function subtract(a, b) {
    return a - b;
}
function multiply(a, b) {
    return a * b;
}
function divide(a, b) {
    return b === 0 ? "Error: divide by zero" : a / b;
}

function formatNumber(num) {
    if (typeof num === 'string' && num.includes('Error')) {
        return num;
    }
    
    const value = typeof num === 'string' ? parseFloat(num) : num;
    
    if (Number.isInteger(value)) {
        return value.toString();
    }
    
    const decimalStr = value.toString();
    const decimalParts = decimalStr.split('.');
    
    if (decimalParts.length === 2 && decimalParts[1].length > MAX_DECIMALS) {
        return value.toFixed(MAX_DECIMALS);
    }
    
    return decimalStr;
}

function handleOperator(op) {
    console.log(`Operator ${op} clicked`);
    
    const inputValue = parseFloat(currentInput);
    
    if (firstOperand === null) {
        firstOperand = inputValue;
    } 
    else if (operator !== null) {
        const result = calculate();
        firstOperand = parseFloat(result);
        display.innerHTML = result;
    }
    
    operator = op;
    waitingForSecondOperand = true;
}

function calculate() {
    if (operator === null || firstOperand === null || currentInput === "") {
        return currentInput;
    }
    
    const secondOperand = parseFloat(currentInput);
    let result;
    
    switch (operator) {
        case "+":
            result = add(firstOperand, secondOperand);
            break;
        case "-":
            result = subtract(firstOperand, secondOperand);
            break;
        case "*":
            result = multiply(firstOperand, secondOperand);
            break;
        case "/":
            result = divide(firstOperand, secondOperand);
            break;
        default:
            return currentInput;
    }
    
    return formatNumber(result);
}

function calculateResult() {
    console.log("Enter button clicked");
    
    if (operator === null || firstOperand === null) {
        return;
    }
    
    const result = calculate();
    currentInput = result;
    display.innerHTML = result;
    
    firstOperand = null;
    operator = null;
    waitingForSecondOperand = false;
}

document.getElementById("btnNeg").addEventListener("click", () => {
    console.log("Negation button clicked");
    
    if (currentInput !== "" && currentInput !== "0") {
        currentInput = (parseFloat(currentInput) * -1).toString();
        display.innerHTML = currentInput;
    }
});

document.getElementById("add").addEventListener("click", () => handleOperator("+"));
document.getElementById("subtract").addEventListener("click", () => handleOperator("-"));
document.getElementById("multiply").addEventListener("click", () => handleOperator("*"));
document.getElementById("divide").addEventListener("click", () => handleOperator("/"));

document.getElementById("clear").addEventListener("click", () => {
    console.log("Clear button clicked");
    currentInput = "";
    firstOperand = null;
    operator = null;
    waitingForSecondOperand = false;
    display.innerHTML = "0";
});

document.getElementById("enter").addEventListener("click", calculateResult);