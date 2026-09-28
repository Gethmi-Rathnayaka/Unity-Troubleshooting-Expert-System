:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_files)).

:- consult('expert_system.pl').

:- dynamic current_problem/1.
:- dynamic remaining_questions/1.

:- http_handler(root(.), serve_static, [prefix]).

serve_static(Request) :-
    working_directory(ProjectDir, ProjectDir),
    http_reply_from_files(ProjectDir, [], Request).

:- http_handler(root(api/start), start_handler, []).
:- http_handler(root(api/question), question_handler, []).
:- http_handler(root(api/answer), answer_handler, []).
:- http_handler(root(api/reset), reset_handler, []).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

start_handler(Request) :-
    cors_enable,

    http_parameters(Request,
        [ problem(Problem, [atom])
        ]),

    clear_facts,

    retractall(current_problem(_)),
    retractall(remaining_questions(_)),

    assertz(current_problem(Problem)),

    findall(
        Fact,
        problem_question(Problem, Fact),
        Questions
    ),

    assertz(remaining_questions(Questions)),

    Questions = [FirstQuestion|Rest],

    retractall(remaining_questions(_)),
    assertz(remaining_questions(Rest)),

    question(FirstQuestion, Text),

    reply_json_dict(_{
        status: question,
        problem: Problem,
        question: FirstQuestion,
        text: Text,
        remaining: Rest
    }).

question_handler(Request) :-
    cors_enable,

    http_parameters(Request,
        [ fact(Fact, [atom])
        ]),

    question(Fact, Text),

    reply_json_dict(_{
        question: Fact,
        text: Text
    }).

answer_handler(Request) :-
    cors_enable,

    http_read_json_dict(Request, Data),

    atom_string(Fact, Data.fact),
    atom_string(Answer, Data.answer),

    process_answer(Fact, Answer),

    remaining_questions(Questions),

    handle_next_step(Questions).


handle_next_step([NextQuestion|Rest]) :-

    retractall(remaining_questions(_)),
    assertz(remaining_questions(Rest)),

    question(NextQuestion, Text),

    reply_json_dict(_{
        status: question,
        question: NextQuestion,
        text: Text
    }).


handle_next_step([]) :-

    current_problem(Problem),

    forward_chain,

    findall(
        Result,
        diagnosis_result(Problem, Result),
        Results
    ),

    reply_json_dict(_{
        status: complete,
        results: Results
    }).


diagnosis_result(Problem, Result) :-

    diagnose(
        Problem,
        Diagnosis,
        Explanation
    ),

    (
        get_recommendation(
            Diagnosis,
            Recommendation
        )
        ->
        true
        ;
        Recommendation = ''
    ),

    Result = _{
        diagnosis: Diagnosis,
        explanation: Explanation,
        recommendation: Recommendation
    }.


reset_handler(_Request) :-

    cors_enable,

    clear_facts,

    retractall(current_problem(_)),
    retractall(remaining_questions(_)),

    reply_json_dict(_{
        success: true
    }).