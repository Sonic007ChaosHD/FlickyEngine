/// scr_character_handle_enemies()
//  Script to handle enemies:

    // Destroy a enemy:
       if(Action = ActionJump || Action = ActionRolling || Action = ActionSpindash || (Invincibility > 1 && YSpeed > 0.0)
       ||(CharacterState != CharacterNormal) || (Shield != ShieldDefault && ShieldAttack) || Animation = "ROLL" || HomingUsed == true) 
       or (Action == ActionFly && YSpeed < 0){ 
          
          EnemyHandle = scr_character_collision_object(x, y, par_enemy);
          if(EnemyHandle){
          
             // Rebound:
                if((ShieldAttack) || (Action = ActionJump && YSpeed >= 0) || (YSpeed >= 0 && Action = ActionRolling || Action != ActionHurt && Invincibility != 0 && YSpeed > 0 ) || (Animation = "ROLL" && YSpeed > 0) || HomingUsed == true) 
                {
                   if(Action != ActionFly){
                      if(KeyAction){
                         if(HomingUsed == true){
                            HomingUsed  = false;
                            XSpeed      = 0;
                         }
                         YSpeed  *= -1; 
                         Ground  = false;
                         JumpHeightMod = false;                   
                      }else{                
                         if(HomingUsed == true){
                            HomingUsed  = false;                         
                            XSpeed      = 0;
                         }                      
                         YSpeed  = max(-4, YSpeed*-1); 
                         Ground  = false;     
                         JumpHeightMod = false;                                   
                      }         
                   }         
                }
             
             // Destroy the enemy:
                with(EnemyHandle){
                     instance_destroy();
                }
                
          }                              
       }
       

       
