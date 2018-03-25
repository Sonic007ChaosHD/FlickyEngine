/// scr_camera_set_target(object, x offset, y offset, duration)
//  object      -- Instance ID of an object the camera should move to. The camera will move to the x/y origin of the object.
//  x offset    -- Horizontal offset based on the x/y origin point of the object.
//  y offset    -- Vertical offset based on the x/y origin point of the object.
//  duration    -- The time (in frames) it takes to get from the current object to the target object.
//  Returns boolean.

    if (!instance_exists(obj_camera)) { return false; } // No camera.
    
    with (obj_camera)
    {
        T_Timer     = 0; 
        T_ID        = argument0;
        T_Offset_X  = argument1;
        T_Offset_Y  = argument2;
        T_Duration  = argument3;
    }
    
    return true;
