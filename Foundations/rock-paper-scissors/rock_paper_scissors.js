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

    let output = `<strong>Round ${round}</strong><br>`;
    output += `You chose: ${humanChoice} | Computer chose: ${computerChoice}<br>`;

    if (humanChoice === computerChoice) {
        output += "It's a tie!<br>";
    } else if (
        (humanChoice === "rock" && computerChoice === "scissors") ||
        (humanChoice === "paper" && computerChoice === "rock") ||
        (humanChoice === "scissors" && computerChoice === "paper")
    ) {
        output += "You won this round!<br>";
        humanScore++;
    } else {
        output += "You lost this round.<br>";
        computerScore++;
    }

    output += `Current Score: You - ${humanScore} | Computer - ${computerScore}<br><br>`;

    round++;

    if (round > 5) {
        output += `<strong>Game Over!</strong><br>`;
        if (humanScore > computerScore) {
            output += `You won the game! Final Score: ${humanScore} - ${computerScore}`;
        } else if (humanScore < computerScore) {
            output += `You lost the game! Final Score: ${humanScore} - ${computerScore}`;
        } else {
            output += `It's a tie! Final Score: ${humanScore} - ${computerScore}`;
        }

        // Remove event listeners after 5 rounds
        rock.removeEventListener("click", handleRock);
        paper.removeEventListener("click", handlePaper);
        scissors.removeEventListener("click", handleScissors);
    }

    writeToDiv(output);
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
    writeToDiv("Welcome to Rock, Paper, Scissors! Best of 5 rounds.<br><br>");

    rock.addEventListener("click", handleRock);
    paper.addEventListener("click", handlePaper);
    scissors.addEventListener("click", handleScissors);
}

function writeToDiv(content) {
    document.querySelector("#content").innerHTML += content + "<br>";
}

playGame();
