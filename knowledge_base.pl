
% PLAYER MOVEMENT RULES

rule(player_not_moving, movement_script_missing,
     movement_script_missing,
     'The movement script is not attached to the player.').

rule(player_not_moving, movement_script_disabled,
     movement_script_disabled,
     'The movement script is attached but disabled.').

rule(player_not_moving, input_action_missing,
     input_action_missing,
     'The required movement input action is missing.').

rule(player_not_moving, input_binding_missing,
     input_binding_missing,
     'The movement input action does not have a valid binding.').

rule(player_moves_slowly, movement_speed_too_low,
     movement_speed_too_low,
     'The configured movement speed is too low.').

rule(player_cannot_jump, jump_input_missing,
     jump_input_missing,
     'The jump input has not been assigned.').

rule(player_cannot_jump, ground_detection_missing,
     ground_detection_missing,
     'The player has no valid ground detection mechanism.').


% PHYSICS RULES

rule(falls_through_floor, collider_missing,
     missing_collider,
     'A required Collider component is missing.').

rule(falls_through_floor, collider_disabled,
     collider_disabled,
     'The Collider component is disabled.').

rule(object_does_not_collide, collider_missing,
     missing_collider,
     'The object does not have a Collider component.').

rule(object_does_not_collide, layer_collision_disabled,
     layer_collision_disabled,
     'Collision between the relevant layers is disabled.').

rule(trigger_not_activating, collider_missing,
     missing_collider,
     'The required Collider component is missing.').

rule(rigidbody_behaves_strangely, constraints_restrict_movement,
     constraints_restrict_movement,
     'Rigidbody constraints are restricting the movement.').


% ANIMATION RULES

rule(animation_not_playing, animator_missing,
     animator_missing,
     'The GameObject does not have an Animator component.').

rule(animation_not_playing, controller_missing,
     controller_missing,
     'No Animator Controller is assigned.').

rule(stuck_in_idle, transition_missing,
     transition_missing,
     'The required animation transition is missing.').

rule(animation_not_transitioning, parameter_missing,
     parameter_missing,
     'The required Animator parameter is missing.').

rule(animation_not_transitioning, parameter_not_updated,
     parameter_not_updated,
     'The Animator parameter is not being updated correctly.').

rule(animation_plays_once, loop_time_disabled,
     loop_time_disabled,
     'Loop Time is disabled for the animation clip.').


% UI RULES

rule(ui_not_visible, canvas_missing,
     canvas_missing,
     'The UI does not have a Canvas.').

rule(ui_not_visible, canvas_disabled,
     canvas_disabled,
     'The Canvas is disabled.').

rule(button_not_responding, button_not_interactable,
     button_not_interactable,
     'The button is not interactable.').

rule(button_not_responding, button_event_missing,
     button_event_missing,
     'The required button event is not assigned.').

rule(health_bar_not_updating, health_bar_reference_missing,
     health_bar_reference_missing,
     'The health bar reference is missing.').


% SCENE / GAME LOGIC

rule(scene_not_loading, scene_missing_from_build_settings,
     scene_missing_from_build_settings,
     'The scene is not included in the build settings.').

rule(scene_transition_failed, scene_manager_not_imported,
     scene_manager_not_imported,
     'The required scene management functionality is not correctly referenced.').

rule(script_not_executing, script_missing,
     script_missing,
     'The required script is not attached.').

rule(script_not_executing, script_disabled,
     script_disabled,
     'The script is disabled.').

rule(game_object_does_not_respond, game_object_inactive,
     game_object_inactive,
     'The GameObject is inactive.').

rule(object_disappears, object_destroyed,
     object_destroyed,
     'The object was destroyed during runtime.').