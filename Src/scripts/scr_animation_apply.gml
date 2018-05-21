///scr_animation_apply()
// Checks the current state of the character and applies the correct animation:

  // Frame counter, simply count frames when an animation is being played. Really useful for a lot of things!
  
     switch(Animation){
            case "IDLE":     { if(FramesCount < 288) {FramesCount += 1}; break; }
            case "IDLE_2":   { FramesCount = 288;  break; }
            case "LOOK_UP":  { if(FramesCount < 120) {FramesCount += 1}; break; }    
            case "CROUCH":   { if(FramesCount < 120) {FramesCount += 1}; break; }                     
            case "SKID":     { FramesCount +=  1;  break; }
            case "SKIDTURN": { FramesCount +=  1;  break; }
            default:         { FramesCount =   0;  break; }
     }
                
  /*** Sonic the Hedgehog and Tails:  ***/
  if((CharacterID == CharacterSonic || CharacterID == CharacterTails) && CharacterState = CharacterNormal){
   
     // When the character is in his normal state:
        if(Action = ActionNormal && Ground){
          
           // Idle Animation:
              if(XSpeed == 0 && Animation != "IDLE" && FramesCount != 288){
                 Animation = "IDLE";
              }
                   
           // Idle Animation 2:
              if(XSpeed == 0 && Animation != "IDLE_2" && FramesCount >= 288){
                 Animation = "IDLE_2";
              }
                        
           // Jog Animation:
              if(abs(XSpeed) != 0 && abs(XSpeed) < 5.50 && Animation != "WALK"){
                 Animation = "WALK";
              }
          
           // Run Animation:
              if(XSpeed != 0 && PeeloutFlag == 0 && Animation != "RUN" && abs(XSpeed) >= 5.50){
                 Animation = "RUN";
              }  
              
           // Peelout:
              if(XSpeed != 0 && PeeloutFlag == 1 && abs(XSpeed) >= 7){
                 Animation = "PEELOUT";
              }           
                         
           // Goal:
              if(GoalState = 1 && Ground && Animation != "GOAL"){
                 Animation = "GOAL";
              }else if(GoalState = 1 && !Ground && Animation = "GOAL"){
                 Animation = "ROLL";
              }
           
           // Goal: (Finish)
              if(GoalState = 2 && Animation = "IDLE"){
                 GoalState = 0;
              }
           
        }else{
          
           // Jump Animation:
              if(Action = ActionJump && DropDashFlag != 2 && Animation != "ROLL"){
                 Animation = "ROLL";
              }
              if(Action = ActionJump && DropDashFlag == 2 && Animation != "DROPDASH"){
                 Animation = "DROPDASH";
              }              
              
          
           // Hurt Animation:
              if(Action = ActionHurt or Action = ActionFly && Animation != "HURT"){
                 Animation = "HURT";
              }    
                        
           // Spring Animation:
              if(Action = ActionSpring && YSpeed < 0 && Animation != "SPRING"){
                 Animation = "SPRING";
              }
              if(Action = ActionSpring && YSpeed > 0 && Animation != "WALK"){
                 Animation = "WALK";
              }
                             
           // Crouch Animation:
              if(Ground && Action = ActionCrouch && Animation != "CROUCH"){
                 Animation = "CROUCH";
              }              
                             
           // Push Animation:
              if(Ground && Action = ActionPush && Animation != "PUSH"){
                 Animation = "PUSH";
              }              
                    
           // Lookup Animation:
              if(Ground && Action = ActionLookup && Animation != "LOOK_UP"){
                 Animation = "LOOK_UP";
              }
                        
           // Spindash Animation:
              if(Action = ActionSpindash && Animation != "SPINDASH"){
                 Animation = "SPINDASH";
              }
          
           // Roll Animation:
              if(Action = ActionRolling && Animation != "ROLL"){
                 Animation = "ROLL";   
              }    
              
           // Hanging:
              if(Action = ActionHang && Animation != "HANG"){
                 Animation = "HANG";
              }
           
           // Rotations:
              if(Rotation_Animation != 0){
                 if(Rotation_Animation == 1){
                    Animation = "ROTATION_1";
                 }
              }
           
           // Peelout (getting ready) animation:
              if(Action = ActionPeelout && PeeloutTimer > 0 && PeeloutTimer < 3 && Animation != "WALK"){
                 Animation = "WALK";
              }
              if(Action = ActionPeelout && PeeloutTimer > 3 && PeeloutTimer < 6 && Animation != "RUN"){
                 Animation = "RUN";
              }
              if(Action = ActionPeelout && PeeloutTimer >= 6 && Animation != "PEELOUT"){
                 Animation = "PEELOUT";
              }                         
           
           // Transforming Animation:
              if(Action = ActionTransform && Animation != "TRANSFORM"){
                 Animation = "TRANSFORM" 
              }
                           
           // Breath Animation:
              if(Action = ActionBreath && Animation != "BREATH"){
                 Animation = "BREATH";
              }
                                         
           // Die Animation:
              if(Action = ActionDie && Animation != "DIE"){
                 Animation = "DIE";
              }
              
           // Tail Animation:
              if(Action = ActionFly     && !Underwater && Animation != "FLY"){
                 Animation = "FLY";
              }
              if(Action = ActionFly     &&  Underwater && Animation != "SWIM"){
                 Animation = "SWIM";
              }
              if(Action = ActionFlydrop && !Underwater && Animation != "FLY_EXHAUSTED"){
                 Animation = "FLY_EXHAUSTED";
              }
              if(Action = ActionFlydrop &&  Underwater && Animation != "SWIM_EXHAUSTED"){
                 Animation = "SWIM_EXHAUSTED";
              }
                                                                         
        }
        
        // Edge Wobbling:
  
            if(Ground && XSpeed == 0 && YSpeed == 0 && Angle == 0 && (Action == ActionNormal or Animation = "CROUCH" or Animation = "LOOK_UP") 
            && !scr_character_collision_bottom_object(x, y, Angle, spr_mask_big, par_collision_collapse_tiles)){
               if(AnimationDirection == 1){
                  if(scr_character_collision_left_edge(x, y, 8) && !scr_character_collision_right_edge(x, y, 350)){       
                     if(Animation != "EDGEWOBBLE_1") {Animation = "EDGEWOBBLE_1"; AllowLookUp = 0; AllowLookDown = 0;}
                     if(Action != ActionNormal) {Action = ActionNormal}
                  }else
                  if(!scr_character_collision_left_edge(x, y, 8) && scr_character_collision_right_edge(x, y, 350)){             
                     if(Animation != "EDGEWOBBLE_2") {Animation = "EDGEWOBBLE_2"; AllowLookUp = 0; AllowLookDown = 0;}     
                     if(Action != ActionNormal) {Action = ActionNormal}                                                                           
                  }                                      
               }
               if(AnimationDirection == -1){
                  if(scr_character_collision_left_edge(x, y, 8) && !scr_character_collision_right_edge(x, y, 350)){                    
                     if(Animation != "EDGEWOBBLE_2") {Animation = "EDGEWOBBLE_2"; AllowLookUp = 0; AllowLookDown = 0;} 
                     if(Action != ActionNormal) {Action = ActionNormal}                                                       
                  }else
                  if(!scr_character_collision_left_edge(x, y, 8) && scr_character_collision_right_edge(x, y, 350)){                   
                     if(Animation != "EDGEWOBBLE_1") {Animation = "EDGEWOBBLE_1"; AllowLookUp = 0; AllowLookDown = 0;} 
                     if(Action != ActionNormal) {Action = ActionNormal}                                                  
                  }   
               }                                      
            }else{
               // Check if we disabled looking up/down.
                  if(AllowLookUp == 0){
                     AllowLookUp  = 1; 
                  }
                  if(AllowLookDown == 0){
                     AllowLookDown  = 1; 
                  }                  
            }
 
  }
                
  /*** Super Sonic the Hedgehog:  ***/
  if(CharacterID == CharacterSonic && (CharacterState = CharacterSuper or CharacterState = CharacterHyper)){
   
     // When the character is in his normal state:
        if(Action = ActionNormal && Ground){
          
           // Idle Animation:
              if(XSpeed == 0 && Animation != "IDLE"){
                 Animation = "IDLE";
              }
  
           // Jog Animation:
              if(abs(XSpeed) != 0 && abs(XSpeed) < 6 && Animation != "WALK"){
                 Animation = "WALK";
              }
          
           // Run Animation:
              if(XSpeed != 0 && PeeloutFlag == 0 && Animation != "RUN" && abs(XSpeed) >= 6){
                 Animation = "RUN";
              }  
              
           // Peelout:
              if(XSpeed != 0 && PeeloutFlag == 1 && abs(XSpeed) >= 7){
                 Animation = "RUN"
              }           
                         
        }else{
          
           // Jump Animation:
              if(Action = ActionJump && Animation != "ROLL"){
                 Animation = "ROLL";
              }     
              if(Action = ActionJump && DropDashFlag == 2 && Animation != "DROPDASH"){
                 Animation = "DROPDASH";
              }  
                                       
           // Spring Animation:
              if(Action = ActionSpring && YSpeed < 0 && Animation != "SPRING"){
                 Animation = "SPRING";
              }
              if(Action = ActionSpring && YSpeed > 0 && Animation != "WALK"){
                 Animation = "WALK";
              }
                             
           // Crouch Animation:
              if(Ground && Action = ActionCrouch && Animation != "CROUCH"){
                 Animation = "CROUCH";
              }              
                             
           // Push Animation:
              if(Ground && Action = ActionPush && Animation != "PUSH"){
                 Animation = "PUSH";
              }              
                    
           // Lookup Animation:
              if(Ground && Action = ActionLookup && Animation != "LOOK_UP"){
                 Animation = "LOOK_UP";
              }
                        
           // Spindash Animation:
              if(Action = ActionSpindash && Animation != "SPINDASH"){
                 Animation = "SPINDASH";
              }
          
           // Roll Animation:
              if(Action = ActionRolling && Animation != "ROLL"){
                 Animation = "ROLL";   
              }    
              
           // Peelout (getting ready) animation:
              if(Action = ActionPeelout && PeeloutTimer > 0 && PeeloutTimer < 3 && Animation != "WALK"){
                 Animation = "WALK";
              }
              if(Action = ActionPeelout && PeeloutTimer > 3 && Animation != "RUN"){
                 Animation = "RUN";
              }
                           
           // Breath Animation:
              if(Action = ActionBreath && Animation != "BREATH"){
                 Animation = "BREATH";
              }
                                             
        }
        
        // Edge Wobbling:
  
            if(Ground && XSpeed == 0 && YSpeed == 0 && Angle == 0 && (Action == ActionNormal or Animation = "CROUCH" or Animation = "LOOK_UP") 
            && !scr_character_collision_bottom_object(x, y, Angle, spr_mask_big, par_collision_collapse_tiles)){
               if(AnimationDirection == 1){
                  if(scr_character_collision_left_edge(x, y, 8) && !scr_character_collision_right_edge(x, y, 350)){       
                     if(Animation != "EDGEWOBBLE_1") {Animation = "EDGEWOBBLE_1"; AllowLookUp = 0; AllowLookDown = 0;}
                     if(Action != ActionNormal) {Action = ActionNormal}
                  }else
                  if(!scr_character_collision_left_edge(x, y, 8) && scr_character_collision_right_edge(x, y, 350)){             
                     if(Animation != "EDGEWOBBLE_1") {Animation = "EDGEWOBBLE_1"; AllowLookUp = 0; AllowLookDown = 0;}     
                     if(Action != ActionNormal) {Action = ActionNormal}                                                                           
                  }                                      
               }
               if(AnimationDirection == -1){
                  if(scr_character_collision_left_edge(x, y, 8) && !scr_character_collision_right_edge(x, y, 350)){                    
                     if(Animation != "EDGEWOBBLE_1") {Animation = "EDGEWOBBLE_1"; AllowLookUp = 0; AllowLookDown = 0;} 
                     if(Action != ActionNormal) {Action = ActionNormal}                                                       
                  }else
                  if(!scr_character_collision_left_edge(x, y, 8) && scr_character_collision_right_edge(x, y, 350)){                   
                     if(Animation != "EDGEWOBBLE_1") {Animation = "EDGEWOBBLE_1"; AllowLookUp = 0; AllowLookDown = 0;} 
                     if(Action != ActionNormal) {Action = ActionNormal}                                                  
                  }   
               }                                      
            }else{
               // Check if we disabled looking up/down.
                  if(AllowLookUp == 0){
                     AllowLookUp  = 1; 
                  }
                  if(AllowLookDown == 0){
                     AllowLookDown  = 1; 
                  }                  
            }
 
  }

  /*** Amy Rose:  ***/
  if((CharacterID == CharacterAmy)){
   
          
     // Exit if using hammer:
     if(AmyHammerAttack = 0){  
     
     // When the character is in his normal state:
        if(Action = ActionNormal && Ground){
           
           // Idle Animation: 
              if(XSpeed == 0 && Animation != "IDLE" && FramesCount != 288){
                 Animation = "IDLE";
              }
                   
           // Idle Animation 2:
              if(XSpeed == 0 && Animation != "IDLE_2" && FramesCount >= 288){
                 Animation = "IDLE_2";
              }
                        
           // Jog Animation:
              if(abs(XSpeed) != 0 && abs(XSpeed) < 5.50 && Animation != "WALK"){
                 Animation = "WALK";
              }
          
           // Run Animation:
              if(XSpeed != 0 && PeeloutFlag == 0 && Animation != "RUN" && abs(XSpeed) >= 5.50){
                 Animation = "RUN";
              }  
 
           // Goal:
              if(GoalState = 1 && Ground && Animation != "GOAL"){
                 Animation = "GOAL";
              }else if(GoalState = 1 && !Ground && Animation = "GOAL"){
                 Animation = "ROLL";
              }
           
           // Goal: (Finish)
              if(GoalState = 2 && Animation = "IDLE"){
                 GoalState = 0;
              }
                        
        }else{
          
           // Jump Animation:
              if(Action = ActionJump && AmyRollJump = false && Animation != "JUMP"){
                 Animation = "JUMP";
              }
              if(Action = ActionJump && AmyRollJump = true && Animation != "ROLL"){
                 Animation = "ROLL";
              }      
                                         
           // Run Charge:
              if(Action = ActionSpindash && Animation != "RUN"){
                 Animation = "RUN";
              }
          
           // Hurt Animation:
              if(Action = ActionHurt or Action = ActionFly && Animation != "HURT"){
                 Animation = "HURT";
              }    
                        
           // Spring Animation:
              if(Action = ActionSpring && YSpeed < 0 && Animation != "SPRING"){
                 Animation = "SPRING";
              }
              if(Action = ActionSpring && YSpeed > 0 && Animation != "WALK"){
                 Animation = "WALK";
              }
                             
           // Crouch Animation:
              if(Ground && Action = ActionCrouch && Animation != "CROUCH"){
                 Animation = "CROUCH";
              }              
                             
           // Push Animation:
              if(Ground && Action = ActionPush && Animation != "PUSH"){
                 Animation = "PUSH";
              }              
                    
           // Lookup Animation:
              if(Ground && Action = ActionLookup && Animation != "LOOK_UP"){
                 Animation = "LOOK_UP";
              }

           // Roll Animation:
              if(Action = ActionRolling && Animation != "ROLL"){
                 Animation = "ROLL";   
              }
              
           // Transforming Animation:
              if(Action = ActionTransform && Animation != "TRANSFORM"){
                 Animation = "TRANSFORM" 
              }
                           
           // Breath Animation:
              if(Action = ActionBreath && Animation != "BREATH"){
                 Animation = "BREATH";
              }
                                         
           // Die Animation:
              if(Action = ActionDie && Animation != "DIE"){
                 Animation = "DIE";
              }
                                                      
        }
        
        }else{ // Hammer attacks!
        
           // Hammer Punch Animation:
              if(AmyHammerAttack = 1){
                 Animation = "HAMMER_PUNCH";
              }           
        
           // Hammer Spin Animation:
              if(AmyHammerAttack = 2){
                 Animation = "HAMMER_SPIN";
              }     
              
           // Hammer Jump:
              if(AmyHammerAttack = 3 && Animation != "JUMP"){
                 Animation = "HAMMER_AIR";
              }
                      
        }
        
        // Edge Wobbling:
  
            if(Ground && XSpeed == 0 && YSpeed == 0 && Angle == 0 && (Action == ActionNormal or Animation = "CROUCH" or Animation = "LOOK_UP") 
            && !scr_character_collision_bottom_object(x, y, Angle, spr_mask_big, par_collision_collapse_tiles)){
               if(AnimationDirection == 1){
                  if(scr_character_collision_left_edge(x, y, 8) && !scr_character_collision_right_edge(x, y, 350)){       
                     if(Animation != "EDGEWOBBLE") {Animation = "EDGEWOBBLE"; AllowLookUp = 0; AllowLookDown = 0;}
                     if(Action != ActionNormal) {Action = ActionNormal}
                  }else
                  if(!scr_character_collision_left_edge(x, y, 8) && scr_character_collision_right_edge(x, y, 350)){             
                     if(Animation != "EDGEWOBBLE") {Animation = "EDGEWOBBLE"; AllowLookUp = 0; AllowLookDown = 0;}     
                     if(Action != ActionNormal) {Action = ActionNormal}                                                                           
                  }                                      
               }
               if(AnimationDirection == -1){
                  if(scr_character_collision_left_edge(x, y, 8) && !scr_character_collision_right_edge(x, y, 350)){                    
                     if(Animation != "EDGEWOBBLE") {Animation = "EDGEWOBBLE"; AllowLookUp = 0; AllowLookDown = 0;} 
                     if(Action != ActionNormal) {Action = ActionNormal}                                                       
                  }else
                  if(!scr_character_collision_left_edge(x, y, 8) && scr_character_collision_right_edge(x, y, 350)){                   
                     if(Animation != "EDGEWOBBLE") {Animation = "EDGEWOBBLE"; AllowLookUp = 0; AllowLookDown = 0;} 
                     if(Action != ActionNormal) {Action = ActionNormal}                                                  
                  }   
               }                                      
            }else{
               // Check if we disabled looking up/down.
                  if(AllowLookUp == 0){
                     AllowLookUp  = 1; 
                  }
                  if(AllowLookDown == 0){
                     AllowLookDown  = 1; 
                  }                  
            }
 
  }  


