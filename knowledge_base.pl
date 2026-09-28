
% Player Movement Rules

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

rule(player_moves_too_fast, movement_speed_too_high,
     movement_speed_too_high,
     'The configured movement speed is too high.').

rule(player_moves_without_input, input_action_stuck,
     input_action_stuck,
     'The movement input is being continuously detected when it should not be.').

rule(player_cannot_stop, movement_input_not_released,
     movement_input_not_released,
     'The movement input is not being released correctly.').

rule(player_cannot_change_direction, direction_input_incorrect,
     direction_input_incorrect,
     'The direction input is not being interpreted correctly.').

rule(player_jump_too_high, jump_force_too_high,
     jump_force_too_high,
     'The configured jump force is too high.').

rule(player_jump_too_low, jump_force_too_low,
     jump_force_too_low,
     'The configured jump force is too low.').

rule(player_movement_is_jittery, physics_update_mismatch,
     physics_update_mismatch,
     'Movement is being updated in a way that can cause unstable or jittery physics behaviour.').


% Physics & Collision Rules

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

rule(object_passes_through_wall, collider_missing,
     missing_collider,
     'A required Collider component is missing.').

rule(object_is_stuck, constraints_restrict_movement,
     constraints_restrict_movement,
     'Rigidbody constraints are restricting the object movement.').

rule(object_bounces_unexpectedly, physics_material_present,
     unexpected_physics_material,
     'A Physics Material may be causing unexpected bouncing behaviour.').

rule(object_does_not_fall, gravity_disabled,
     gravity_disabled,
     'Gravity is disabled for the Rigidbody.').

rule(object_collides_with_wrong_object, layer_collision_disabled,
     layer_configuration_problem,
     'The configured physics layers do not match the intended collision behaviour.').


% Animation Rules

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

rule(wrong_animation_playing, wrong_controller_assigned,
     wrong_controller,
     'The wrong Animator Controller is assigned.').

rule(animation_loops_unexpectedly, loop_time_enabled,
     unexpected_looping,
     'Loop Time is enabled even though the animation is expected to play only once.').

rule(animation_is_too_fast, animation_speed_incorrect,
     animation_speed_too_high,
     'The animation playback speed is higher than expected.').

rule(animation_is_too_slow, animation_speed_incorrect,
     animation_speed_too_low,
     'The animation playback speed is lower than expected.').

rule(animation_transition_delayed, has_exit_time,
     exit_time_delays_transition,
     'Exit Time is delaying the animation transition.').

rule(character_animation_does_not_match_movement, script_does_not_update_animator,
     animator_not_updated,
     'The gameplay script is not updating the Animator according to the character movement.').

rule(animation_parameter_has_no_effect, parameter_value_incorrect,
     animator_parameter_value_problem,
     'The Animator parameter value does not match the expected transition condition.').


% UI Rules

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

rule(text_not_visible, text_component_disabled,
     text_component_disabled,
     'The UI text component is disabled.').

rule(ui_appears_but_is_invisible, text_component_disabled,
     text_component_disabled,
     'A required UI component is disabled.').

rule(health_bar_not_updating, health_value_not_updated,
     health_value_not_updated,
     'The health value is not being updated correctly.').

rule(ui_not_scaling_correctly, wrong_canvas_render_mode,
     canvas_scaling_problem,
     'The Canvas configuration may not be appropriate for the intended UI scaling behaviour.').

rule(ui_overlaps_other_ui, ui_layout_problem,
     ui_layout_problem,
     'The UI elements have a layout or positioning conflict.').


% Scene / Game Logic Rules

rule(scene_not_loading, scene_missing_from_build_settings,
     scene_missing_from_build_settings,
     'The scene is not included in the build settings.').

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

rule(scene_transition_failed, scene_name_incorrect,
     incorrect_scene_name,
     'The scene name or scene reference used for the transition is incorrect.').

rule(object_disappears_after_scene_change, object_not_marked_dont_destroy_on_load,
     object_not_persistent,
     'The object is destroyed when the scene changes because it is not configured to persist.').

rule(object_exists_in_editor_but_not_runtime, game_object_inactive,
     game_object_inactive,
     'The GameObject is inactive at runtime.').

rule(prefab_instance_does_not_update, prefab_overrides_present,
     prefab_override_problem,
     'Prefab instance overrides may be preventing the expected prefab changes from appearing.').

rule(script_works_in_editor_not_build, script_has_compile_error,
     script_compile_error,
     'The script has a compile error that prevents it from running correctly.').

rule(game_object_does_not_respond, required_component_missing,
     required_component_missing,
     'A component required by the GameObject behaviour is missing.').

rule(event_does_not_trigger, script_missing,
     script_missing,
     'The script required to handle the event is missing.').