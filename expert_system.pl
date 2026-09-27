:- consult('knowledge_base.pl').

:- dynamic known_fact/1.

clear_facts :-
    retractall(known_fact(_)).

add_fact(Fact) :-
    assertz(known_fact(Fact)).

has_fact(Fact) :-
    known_fact(Fact).

diagnose(Problem, Diagnosis, Explanation) :-
    rule(Problem, Condition, Diagnosis, Explanation),
    known_fact(Condition).

get_recommendation(Diagnosis, Recommendation) :-
    recommendation(Diagnosis, Recommendation).

% Questions

question(player_not_moving,
    'Is the player completely unable to move?').

question(player_moves_slowly,
    'Does the player move too slowly?').

question(player_moves_too_fast,
    'Does the player move too fast?').

question(player_moves_in_wrong_direction,
    'Does the player move in the wrong direction?').

question(player_cannot_jump,
    'Can the player not jump when expected?').

question(movement_works_animation_doesnt,
    'Does the player move correctly while its animation does not change?').

question(player_moves_without_input,
    'Does the player move without receiving input?').

question(player_cannot_stop,
    'Does the player continue moving when you try to stop?').

question(player_cannot_change_direction,
    'Can the player not change direction correctly?').

question(player_falls_when_jumping,
    'Does the player fall or fail to remain airborne during a jump?').

question(player_jump_too_high,
    'Does the player jump higher than expected?').

question(player_jump_too_low,
    'Does the player jump lower than expected?').

question(player_movement_is_jittery,
    'Does the player movement appear jittery or unstable?').

question(player_movement_is_inconsistent,
    'Does the movement behave differently or inconsistently between attempts?').


% Diagnostic Questions

question(movement_script_attached,
    'Is a movement script attached to the player?').

question(movement_script_enabled,
    'Is the movement script enabled?').

question(input_action_assigned,
    'Is a valid movement Input Action assigned?').

question(input_binding_exists,
    'Does the movement Input Action have a valid binding?').

question(movement_speed_configured,
    'Is the movement speed configured correctly?').

question(jump_input_assigned,
    'Is a valid jump input assigned?').

question(ground_detection_present,
    'Is a valid ground detection mechanism present?').

question(collider_present,
    'Does the object have a Collider component?').

question(collider_enabled,
    'Is the Collider component enabled?').

question(layer_collision_enabled,
    'Is collision enabled between the relevant layers?').

question(constraints_configured,
    'Are the Rigidbody constraints configured correctly?').

question(animator_present,
    'Does the GameObject have an Animator component?').

question(controller_assigned,
    'Is an Animator Controller assigned?').

question(transition_exists,
    'Does the required animation transition exist?').

question(parameter_exists,
    'Does the required Animator parameter exist?').

question(parameter_updated,
    'Is the Animator parameter being updated correctly?').

question(loop_time,
    'Is Loop Time enabled for the animation clip?').

question(canvas_present,
    'Does the UI have a Canvas?').

question(canvas_enabled,
    'Is the Canvas enabled?').

question(button_interactable,
    'Is the button interactable?').

question(button_event_assigned,
    'Is the required button event assigned?').

question(health_bar_reference_assigned,
    'Is the health bar reference assigned?').

question(scene_in_build_settings,
    'Is the scene included in the build settings?').

question(script_attached,
    'Is the required script attached?').

question(script_enabled,
    'Is the script enabled?').

question(game_object_active,
    'Is the GameObject active?').

question(object_destroyed_check,
    'Is the object being destroyed during runtime?').


% Question-Problem mapping

problem_question(player_not_moving, movement_script_attached).
problem_question(player_not_moving, movement_script_enabled).
problem_question(player_not_moving, input_action_assigned).
problem_question(player_not_moving, input_binding_exists).

problem_question(player_moves_slowly, movement_speed_configured).

problem_question(player_cannot_jump, jump_input_assigned).
problem_question(player_cannot_jump, ground_detection_present).

problem_question(falls_through_floor, collider_present).
problem_question(falls_through_floor, collider_enabled).

problem_question(object_does_not_collide, collider_present).
problem_question(object_does_not_collide, layer_collision_enabled).

problem_question(trigger_not_activating, collider_present).

problem_question(rigidbody_behaves_strangely, constraints_configured).

problem_question(animation_not_playing, animator_present).
problem_question(animation_not_playing, controller_assigned).

problem_question(stuck_in_idle, transition_exists).

problem_question(animation_not_transitioning, parameter_exists).
problem_question(animation_not_transitioning, parameter_updated).

problem_question(animation_plays_once, loop_time).

problem_question(ui_not_visible, canvas_present).
problem_question(ui_not_visible, canvas_enabled).

problem_question(button_not_responding, button_interactable).
problem_question(button_not_responding, button_event_assigned).

problem_question(health_bar_not_updating, health_bar_reference_assigned).

problem_question(scene_not_loading, scene_in_build_settings).

problem_question(script_not_executing, script_attached).
problem_question(script_not_executing, script_enabled).

problem_question(game_object_does_not_respond, game_object_active).

problem_question(object_disappears, object_destroyed_check).

%User answer to facts mapping

answer_fact(movement_script_attached, yes, movement_script_attached).
answer_fact(movement_script_attached, no, movement_script_missing).

answer_fact(movement_script_enabled, yes, movement_script_enabled).
answer_fact(movement_script_enabled, no, movement_script_disabled).

answer_fact(input_action_assigned, yes, input_action_assigned).
answer_fact(input_action_assigned, no, input_action_missing).

answer_fact(input_binding_exists, yes, input_binding_exists).
answer_fact(input_binding_exists, no, input_binding_missing).

answer_fact(movement_speed_configured, yes, movement_speed_configured).
answer_fact(movement_speed_configured, no, movement_speed_too_low).

answer_fact(jump_input_assigned, yes, jump_input_assigned).
answer_fact(jump_input_assigned, no, jump_input_missing).

answer_fact(ground_detection_present, yes, ground_detection_present).
answer_fact(ground_detection_present, no, ground_detection_missing).

answer_fact(collider_present, yes, collider_present).
answer_fact(collider_present, no, collider_missing).

answer_fact(collider_enabled, yes, collider_enabled).
answer_fact(collider_enabled, no, collider_disabled).

answer_fact(layer_collision_enabled, yes, layer_collision_enabled).
answer_fact(layer_collision_enabled, no, layer_collision_disabled).

answer_fact(constraints_configured, yes, constraints_configured).
answer_fact(constraints_configured, no, constraints_restrict_movement).

answer_fact(animator_present, yes, animator_present).
answer_fact(animator_present, no, animator_missing).

answer_fact(controller_assigned, yes, controller_assigned).
answer_fact(controller_assigned, no, controller_missing).

answer_fact(transition_exists, yes, transition_exists).
answer_fact(transition_exists, no, transition_missing).

answer_fact(parameter_exists, yes, parameter_exists).
answer_fact(parameter_exists, no, parameter_missing).

answer_fact(parameter_updated, yes, script_updates_animator).
answer_fact(parameter_updated, no, parameter_not_updated).

answer_fact(loop_time, yes, loop_time_enabled).
answer_fact(loop_time, no, loop_time_disabled).

answer_fact(canvas_present, yes, canvas_present).
answer_fact(canvas_present, no, canvas_missing).

answer_fact(canvas_enabled, yes, canvas_enabled).
answer_fact(canvas_enabled, no, canvas_disabled).

answer_fact(button_interactable, yes, button_interactable).
answer_fact(button_interactable, no, button_not_interactable).

answer_fact(button_event_assigned, yes, button_event_assigned).
answer_fact(button_event_assigned, no, button_event_missing).

answer_fact(health_bar_reference_assigned, yes, health_bar_reference_assigned).
answer_fact(health_bar_reference_assigned, no, health_bar_reference_missing).

answer_fact(scene_in_build_settings, yes, scene_in_build_settings).
answer_fact(scene_in_build_settings, no, scene_missing_from_build_settings).

answer_fact(script_attached, yes, script_attached).
answer_fact(script_attached, no, script_missing).

answer_fact(script_enabled, yes, script_enabled).
answer_fact(script_enabled, no, script_disabled).

answer_fact(game_object_active, yes, game_object_active).
answer_fact(game_object_active, no, game_object_inactive).

answer_fact(object_destroyed_check, yes, object_destroyed).
answer_fact(object_destroyed_check, no, object_not_destroyed).

%Recommended solutions

recommendation(movement_script_missing,
    'Attach the required movement script to the player GameObject.').

recommendation(movement_script_disabled,
    'Enable the movement script on the player GameObject.').

recommendation(input_action_missing,
    'Create or assign the required movement Input Action.').

recommendation(input_binding_missing,
    'Add a valid keyboard, controller, or other input binding to the Input Action.').

recommendation(movement_speed_too_low,
    'Increase the configured movement speed to an appropriate value.').

recommendation(jump_input_missing,
    'Assign a valid input action or key for jumping.').

recommendation(ground_detection_missing,
    'Add a valid ground detection method so the system can determine whether the player is grounded.').

recommendation(missing_collider,
    'Add the required Collider component to the object.').

recommendation(collider_disabled,
    'Enable the Collider component.').

recommendation(layer_collision_disabled,
    'Enable collision between the relevant physics layers.').

recommendation(constraints_restrict_movement,
    'Check the Rigidbody constraints and remove restrictions that should not apply.').

recommendation(animator_missing,
    'Add an Animator component to the GameObject.').

recommendation(controller_missing,
    'Assign the correct Animator Controller.').

recommendation(transition_missing,
    'Create the required transition between the Animator states.').

recommendation(parameter_missing,
    'Create and configure the Animator parameter required by the transition.').

recommendation(parameter_not_updated,
    'Update the Animator parameter from the relevant gameplay or movement script.').

recommendation(loop_time_disabled,
    'Enable Loop Time if the animation is expected to repeat.').

recommendation(canvas_missing,
    'Create or assign a Canvas for the UI elements.').

recommendation(canvas_disabled,
    'Enable the Canvas.').

recommendation(button_not_interactable,
    'Enable the button so that it can receive interaction.').

recommendation(button_event_missing,
    'Assign the required method to the button event.').

recommendation(health_bar_reference_missing,
    'Assign the correct health bar reference in the relevant script.').

recommendation(scene_missing_from_build_settings,
    'Add the required scene to the project build configuration.').

recommendation(scene_manager_not_imported,
    'Check the scene management API reference and ensure the required namespace or API is correctly used.').

recommendation(script_missing,
    'Attach the required script to the GameObject.').

recommendation(script_disabled,
    'Enable the script component.').

recommendation(game_object_inactive,
    'Set the GameObject to active.').

recommendation(object_destroyed,
    'Check where the object is destroyed and verify that the destruction occurs only when intended.').

%Forward chaining

forward_chain :-
    forward_step,
    !,
    forward_chain.
forward_chain.

forward_step :-
    rule(_, Condition, Diagnosis, _),
    known_fact(Condition),
    \+ known_fact(Diagnosis),
    assertz(known_fact(Diagnosis)).

%Backward chaining

backward_chain(Problem, Diagnosis, Explanation) :-
    rule(Problem, Condition, Diagnosis, Explanation),
    known_fact(Condition).

%Solving

solve(Problem, Diagnosis, Explanation) :-
    backward_chain(Problem, Diagnosis, Explanation).

% Consultation

ask_question(Fact) :-
    question(Fact, Text),
    format('~w (yes/no): ', [Text]),
    read(Answer),
    process_answer(Fact, Answer).

process_answer(Fact, yes) :-
    answer_fact(Fact, yes, DerivedFact),
    add_fact(DerivedFact).

process_answer(Fact, no) :-
    answer_fact(Fact, no, DerivedFact),
    add_fact(DerivedFact).

ask_questions([]).

ask_questions([Fact|Rest]) :-
    ask_question(Fact),
    ask_questions(Rest).

consult_problem(Problem) :-
    clear_facts,
    format('~n=Unity Troubleshooting Expert System=~n~n'),
    format('Problem: ~w~n~n', [Problem]),
    findall(Fact, problem_question(Problem, Fact), Questions),
    ask_questions(Questions),
    forward_chain,
    show_diagnoses(Problem).

show_diagnoses(Problem) :-
    findall(
        Diagnosis-Explanation,
        diagnose(Problem, Diagnosis, Explanation),
        Results
    ),
    show_results(Results).

show_results([]).

show_results([Diagnosis-Explanation|Rest]) :-
    nl,
    format('Diagnosis: ~w~n', [Diagnosis]),
    format('Reason: ~w~n', [Explanation]),
    (
        get_recommendation(Diagnosis, Recommendation)
        ->
        format('Recommendation: ~w~n', [Recommendation])
        ;
        true
    ),
    show_results(Rest).