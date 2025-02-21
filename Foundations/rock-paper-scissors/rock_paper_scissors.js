let humanScore = 0;
let computerScore = 0; 
let round = 1;

const rock = document.querySelector("#rock");
const paper = document.querySelector("#paper");
const scissors = document.querySelector("#scissors");

function computerSelection() {
    let choice = Math.floor(Math.random() * 3);
    return choice === 0 ? "rock" : choice === 1 ? "paper" : "scissors";
}

function playRound(humanChoice, computerChoice) {
    if (round > 5) return; // Prevent playing more than 5 rounds

    console.log(`Round ${round}`);
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
    
    round++;

    if (round > 5) {
        console.log("\nGame Over!");
        if (humanScore > computerScore) {
            console.log(`You won the game! Final Score: ${humanScore} - ${computerScore}`);
        } else if (humanScore < computerScore) {
            console.log(`You lost the game! Final Score: ${humanScore} - ${computerScore}`);
        } else {
            console.log(`It's a tie! Final Score: ${humanScore} - ${computerScore}`);
        }

        rock.removeEventListener("click", handleRock);
        paper.removeEventListener("click", handlePaper);
        scissors.removeEventListener("click", handleScissors);
    }
}

function handleRock() {
    playRound("rock", computerSelection());
}

function handlePaper() {
    playRound("paper", computerSelection());
}

function handleScissors() {
    playRound("scissors", computerSelection());
}

function playGame() {
    console.log("Welcome to Rock, Paper, Scissors! Best of 5 rounds.");

    rock.addEventListener("click", handleRock);
    paper.addEventListener("click", handlePaper);
    scissors.addEventListener("click", handleScissors);
}

playGame();
