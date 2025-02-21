
let humanScore = 0;
let computerScore = 0; 
function computerSelection() {
    let choice = Math.floor(Math.random() * 3);
    return choice === 0 ? "rock" : choice === 1 ? "paper" : "scissors";
}

 
let humanSelection = function(){
    return (prompt("Rock, paper, or scissors?")).toLowerCase();
}

function playRound(humanChoice, computerChoice) {
    console.log(`You chose: ${humanChoice} | Computer chose: ${computerChoice}`);

    if (humanChoice === computerChoice) {
        console.log("It's a tie!");
    } else if (
        (humanChoice === "rock" && computerChoice === "scissors") ||
        (humanChoice === "paper" && computerChoice === "rock") ||
        (humanChoice === "scissors" && computerChoice === "paper")
    ) {
        console.log("You won this round!");
        humanScore++;
    } else {
        console.log("You lost this round.");
        computerScore++;
    }

    console.log(`Current Score: You - ${humanScore} | Computer - ${computerScore}`);
}


//const humanSelection = getHumanChoice();
//const computerSelection = getComputerChoice();

//playRound(humanSelection, computerSelection); 

function playGame() {
    console.log("Welcome to Rock, Paper, Scissors! Best of 5 rounds.");

    for (let i = 0; i < 5; i++) {
        console.log(`\nRound ${i + 1}`);
        playRound(humanSelection(), computerSelection());
    }

    console.log("\nGame Over!");
    if (humanScore > computerScore) {
        console.log(`You won the game! Final Score: ${humanScore} - ${computerScore}`);
    } else if (humanScore < computerScore) {
        console.log(`You lost the game! Final Score: ${humanScore} - ${computerScore}`);
    } else {
        console.log(`It's a tie! Final Score: ${humanScore} - ${computerScore}`);
    }
}

playGame();