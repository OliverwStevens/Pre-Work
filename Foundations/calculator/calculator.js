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
console.log("hello");
console.log(operate(add, 5, 4));