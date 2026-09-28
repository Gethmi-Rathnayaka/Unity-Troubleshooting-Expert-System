
const problems = {

    movement: [
        {
            id: "player_not_moving",
            title: "My player does not move",
            description: "The character stays still when I try to move."
        },
        {
            id: "player_moves_slowly",
            title: "My player moves too slowly",
            description: "The character moves, but the speed is lower than expected."
        },
        {
            id: "player_cannot_jump",
            title: "My player cannot jump",
            description: "The jump input does not make the character jump."
        }
    ],

    physics: [
        {
            id: "falls_through_floor",
            title: "My object falls through the floor",
            description: "The object passes through the floor instead of standing on it."
        },
        {
            id: "object_does_not_collide",
            title: "My objects do not collide",
            description: "Objects pass through each other when they should collide."
        },
        {
            id: "trigger_not_activating",
            title: "My trigger does not activate",
            description: "A trigger zone does not respond when an object enters it."
        },
        {
            id: "rigidbody_behaves_strangely",
            title: "My Rigidbody behaves strangely",
            description: "The physics behaviour is not what I expected."
        }
    ],

    animation: [
        {
            id: "animation_not_playing",
            title: "My animation does not play",
            description: "The character or object stays in its default state."
        },
        {
            id: "stuck_in_idle",
            title: "My character is stuck in one animation",
            description: "The character stays in the same animation state."
        },
        {
            id: "animation_not_transitioning",
            title: "My animations do not transition",
            description: "The Animator does not move between animation states."
        },
        {
            id: "animation_plays_once",
            title: "My animation only plays once",
            description: "The animation stops after playing a single time."
        }
    ],

    ui: [
        {
            id: "ui_not_visible",
            title: "My UI does not appear",
            description: "The Canvas or interface is not visible in the game."
        },
        {
            id: "button_not_responding",
            title: "My button does not respond",
            description: "Clicking the button does nothing."
        },
        {
            id: "health_bar_not_updating",
            title: "My health bar does not update",
            description: "The health bar remains unchanged when health changes."
        }
    ],

    scene: [
        {
            id: "scene_not_loading",
            title: "My scene does not load",
            description: "The game cannot load the scene I selected."
        },
        {
            id: "script_not_executing",
            title: "My script does not execute",
            description: "A script is attached but its behaviour does not run."
        },
        {
            id: "game_object_does_not_respond",
            title: "My GameObject does not respond",
            description: "The GameObject does not behave as expected."
        },
        {
            id: "object_disappears",
            title: "My object disappears",
            description: "An object disappears unexpectedly during gameplay."
        }
    ]
};


const categoryNames = {
    movement: "Player Movement",
    physics: "Physics & Collision",
    animation: "Animation",
    ui: "UI",
    scene: "Scene / Game Logic"
};


let currentCategory = null;
let currentProblem = null;
let currentQuestionFact = null;
let questionNumber = 0;
let totalQuestions = 0;


const startScreen = document.getElementById("start-screen");
const problemScreen = document.getElementById("problem-screen");
const diagnosisScreen = document.getElementById("diagnosis-screen");
const resultScreen = document.getElementById("result-screen");

const problemTitle = document.getElementById("problem-title");
const problemList = document.getElementById("problem-list");

const diagnosisProblem = document.getElementById("diagnosis-problem");
const questionText = document.getElementById("question-text");
const progressText = document.getElementById("progress-text");

const yesButton = document.getElementById("yes-button");
const noButton = document.getElementById("no-button");

const resultSummary = document.getElementById("result-summary");
const diagnosisResults = document.getElementById("diagnosis-results");


function showScreen(screen) {

    startScreen.classList.add("hidden");
    problemScreen.classList.add("hidden");
    diagnosisScreen.classList.add("hidden");
    resultScreen.classList.add("hidden");

    screen.classList.remove("hidden");
}


document.querySelectorAll(".category-card").forEach(button => {

    button.addEventListener("click", () => {

        currentCategory = button.dataset.category;

        showProblemList(currentCategory);
    });
});

function showProblemList(category) {

    problemTitle.textContent = categoryNames[category];

    problemList.innerHTML = "";

    problems[category].forEach(problem => {

        const button = document.createElement("button");

        button.className = "problem-card";

        button.innerHTML = `
            <span class="problem-content">
                <strong>${problem.title}</strong>
                <small>${problem.description}</small>
            </span>

            <span class="arrow">→</span>
        `;

        button.addEventListener("click", () => {
            startConsultation(problem);
        });

        problemList.appendChild(button);
    });

    showScreen(problemScreen);
}


async function startConsultation(problem) {

    currentProblem = problem;
    questionNumber = 1;

    diagnosisProblem.textContent = problem.title;
    questionText.textContent = "Loading question...";
    progressText.textContent = "Question 1";

    showScreen(diagnosisScreen);

    try {

        const response = await fetch(
            `/api/start?problem=${encodeURIComponent(problem.id)}`
        );

        if (!response.ok) {
            throw new Error("Unable to start consultation.");
        }

        const data = await response.json();

        totalQuestions =
            1 + (data.remaining ? data.remaining.length : 0);

        displayQuestion(data);

    } catch (error) {

        console.error(error);

        questionText.textContent =
            "Unable to connect to the Prolog expert system.";

        progressText.textContent =
            "Make sure the Prolog server is running.";
    }
}


function displayQuestion(data) {

    currentQuestionFact = data.question;

    questionText.textContent = data.text;

    progressText.textContent =
        `Question ${questionNumber} of ${totalQuestions}`;

    yesButton.disabled = false;
    noButton.disabled = false;
}


yesButton.addEventListener("click", () => {
    submitAnswer("yes");
});

noButton.addEventListener("click", () => {
    submitAnswer("no");
});


async function submitAnswer(answer) {

    yesButton.disabled = true;
    noButton.disabled = true;

    try {

        const response = await fetch("/api/answer", {

            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify({
                fact: currentQuestionFact,
                answer: answer
            })
        });

        if (!response.ok) {
            throw new Error("Unable to submit answer.");
        }

        const data = await response.json();

        if (data.status === "question") {

            questionNumber++;

            displayQuestion(data);

        } else if (data.status === "complete") {

            showResults(data.results);

        } else {

            throw new Error("Unknown server response.");
        }

    } catch (error) {

        console.error(error);

        questionText.textContent =
            "Something went wrong while communicating with Prolog.";

        yesButton.disabled = false;
        noButton.disabled = false;
    }
}


function showResults(results) {

    diagnosisResults.innerHTML = "";

    if (!results || results.length === 0) {

        resultSummary.textContent =
            "No specific cause was identified.";

        const noResult = document.createElement("div");

        noResult.className = "diagnosis-card";

        noResult.innerHTML = `
            <h3>No specific cause identified</h3>

            <p>
                The available rules did not identify a matching diagnosis.
            </p>

            <p>
                Review the relevant Unity components and settings manually.
            </p>
        `;

        diagnosisResults.appendChild(noResult);

        showScreen(resultScreen);

        return;
    }

    resultSummary.textContent =
        `${results.length} possible cause${results.length === 1 ? "" : "s"} identified.`;

    results.forEach((result, index) => {

        const card = document.createElement("div");

        card.className = "diagnosis-card";

        const diagnosis = document.createElement("h3");
        diagnosis.textContent =
            `${index + 1}. ${formatDiagnosis(result.diagnosis)}`;

        const explanationTitle = document.createElement("strong");
        explanationTitle.textContent = "Reason";

        const explanation = document.createElement("p");
        explanation.textContent = result.explanation;

        const recommendationTitle = document.createElement("strong");
        recommendationTitle.textContent = "Recommendation";

        const recommendation = document.createElement("p");
        recommendation.textContent =
            result.recommendation ||
            "No recommendation available.";

        card.appendChild(diagnosis);
        card.appendChild(explanationTitle);
        card.appendChild(explanation);
        card.appendChild(recommendationTitle);
        card.appendChild(recommendation);

        diagnosisResults.appendChild(card);
    });

    showScreen(resultScreen);
}


function formatDiagnosis(diagnosis) {

    return diagnosis
        .replaceAll("_", " ")
        .replace(/\b\w/g, letter => letter.toUpperCase());
}


document
    .getElementById("back-to-categories")
    .addEventListener("click", () => {

        showScreen(startScreen);
    });


document
    .getElementById("restart-button")
    .addEventListener("click", async () => {

        try {

            await fetch("/api/reset", {
                method: "POST"
            });

        } catch (error) {

            console.error(error);
        }

        currentCategory = null;
        currentProblem = null;
        currentQuestionFact = null;
        questionNumber = 0;
        totalQuestions = 0;

        showScreen(startScreen);
    });