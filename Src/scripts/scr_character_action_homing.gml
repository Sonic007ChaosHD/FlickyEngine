/// scr_character_action_homing()
 // Script to handle Sonics homing attack.
 
    // Create Homing Table.
       if(HomingTable == 0){
          HomingTable  = ds_list_create()
          // List all objects that can be targeted.
             ds_list_add(HomingTable, par_enemy);
             ds_list_add(HomingTable, obj_monitor);
             ds_list_add(HomingTable, par_spring);
             ds_list_add(HomingTable, par_spring_diagonal);          
       }
        
    // Create Target while Jumping.       
       if(Ground == false){
       
             if(instance_exists(obj_homing_target) == false){
          
                for(i=0; i!=ds_list_size(HomingTable); i++){
                    TableContent = ds_list_find_value(HomingTable, i)
                    if(distance_to_object(TableContent) < 128){
                       if(instance_number(obj_homing_target) < 1){
                          LockOn        = instance_create(TableContent.x, TableContent.y, obj_homing_target)
                          LockOn.Scale  = 0;
                          LockOn.Target = TableContent;         
                       }                           
                    }                      
                }
             }
                                 
       }else{
       
       // Destroy Target:
          if(instance_exists(obj_homing_target)){
             with(obj_homing_target){
                  instance_destroy();
             }
           }     
             
       }
       
    // Destroy Target if too far away:
       if(instance_exists(obj_homing_target)){
          if(distance_to_object(obj_homing_target) > 80){
             with(obj_homing_target){
                  instance_destroy()
             }
          }
       }
       
    // Perform Homing attack.
       if(!HomingUsed && instance_exists(obj_homing_target)){
          if(KeyAction_Pressed){
             HomingUsed = true;
          }
       }
       
       if(HomingUsed){
          if(instance_exists(obj_homing_target) && distance_to_object(obj_homing_target) > 0){
             HDir = point_direction(x, y, obj_homing_target.x, obj_homing_target.y);   
             Action = ActionJump;
             XSpeed = lengthdir_x(8, HDir);
             YSpeed = lengthdir_y(8, HDir);             
          }
       }

       
