:- consult('expert_system.pl').

% UNITY Game Development Troubleshooting Expert System

start :-
    clear_facts,
    nl,
    writeln(' Unity Game Development Troubleshooting ES'),
    writeln('=============================================='),
    nl,
    writeln('Select a problem category:'),
    nl,
    writeln('1. Player Movement'),
    writeln('2. Physics & Collision'),
    writeln('3. Animation'),
    writeln('4. UI'),
    writeln('5. Scene / Game Logic'),
    nl,
    write('Enter your choice: '),
    read(Choice),
    category_choice(Choice, Category),
    category_menu(Category).

% Category selection

category_choice(1, movement).
category_choice(2, physics).
category_choice(3, animation).
category_choice(4, ui).
category_choice(5, scene).

% Category Menus

category_menu(movement) :-
    nl,
    writeln('--- Player Movement ---'),
    writeln('1. My player does not move'),
    writeln('2. My player moves too slowly'),
    writeln('3. My player cannot jump'),
    nl,
    write('Enter your choice: '),
    read(Choice),
    movement_choice(Choice, Problem),
    consult_problem(Problem).

category_menu(physics) :-
    nl,
    writeln('--- Physics & Collision ---'),
    writeln('1. My object falls through the floor'),
    writeln('2. My objects do not collide'),
    writeln('3. My trigger does not activate'),
    writeln('4. My physics object behaves strangely'),
    nl,
    write('Enter your choice: '),
    read(Choice),
    physics_choice(Choice, Problem),
    consult_problem(Problem).

category_menu(animation) :-
    nl,
    writeln('--- Animation ---'),
    writeln('1. My animation does not play'),
    writeln('2. My character is stuck in one animation'),
    writeln('3. My animations do not transition'),
    writeln('4. My animation only plays once'),
    nl,
    write('Enter your choice: '),
    read(Choice),
    animation_choice(Choice, Problem),
    consult_problem(Problem).

category_menu(ui) :-
    nl,
    writeln('--- UI ---'),
    writeln('1. My UI does not appear'),
    writeln('2. My button does not respond'),
    writeln('3. My health bar does not update'),
    nl,
    write('Enter your choice: '),
    read(Choice),
    ui_choice(Choice, Problem),
    consult_problem(Problem).

category_menu(scene) :-
    nl,
    writeln('--- Scene / Game Logic ---'),
    writeln('1. My scene does not load'),
    writeln('2. My script does not execute'),
    writeln('3. My GameObject does not respond'),
    writeln('4. My object disappears'),
    nl,
    write('Enter your choice: '),
    read(Choice),
    scene_choice(Choice, Problem),
    consult_problem(Problem).

% Problem Mappings

movement_choice(1, player_not_moving).
movement_choice(2, player_moves_slowly).
movement_choice(3, player_cannot_jump).

physics_choice(1, falls_through_floor).
physics_choice(2, object_does_not_collide).
physics_choice(3, trigger_not_activating).
physics_choice(4, rigidbody_behaves_strangely).

animation_choice(1, animation_not_playing).
animation_choice(2, stuck_in_idle).
animation_choice(3, animation_not_transitioning).
animation_choice(4, animation_plays_once).

ui_choice(1, ui_not_visible).
ui_choice(2, button_not_responding).
ui_choice(3, health_bar_not_updating).

scene_choice(1, scene_not_loading).
scene_choice(2, script_not_executing).
scene_choice(3, game_object_does_not_respond).
scene_choice(4, object_disappears).