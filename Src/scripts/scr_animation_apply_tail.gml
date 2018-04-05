/// scr_animation_apply_tail()
//  Script to apply the correct tail sprite for Miles.

    // Default:
    if(CharacterID == CharacterTails){
       switch(Animation){
              case "IDLE":
              case "IDLE_2":
              case "LOOK_UP":
              case "CROUCH":
              case "SKID":
              case "SKIDTURN":
              case "PUSH":
              case "EDGEWOBBLE_1":
              case "EDGEWOBBLE_2":{
                    TailSprite    = spr_miles_tail_1;
                    if(Animation == "EDGEWOBBLE_1" || Animation == "EDGEWOBBLE_2"){
                       TailX      = AnimationDirection*8
                    }else{
                       TailX         = 0;
                    }
                    TailY         = 0;
                    TailDirection = AnimationDirection; 
                    TailSpeed     = 0.14;
                    break;
              }
              case "WALK":{
                    TailSprite    = spr_miles_tail_2;
                    TailX         = AnimationDirection*5;
                    TailY         = 4;
                    TailDirection = AnimationDirection; 
                    TailSpeed     = 0.24; 
                    break;                  
              }
              case "ROLL":
              case "SPINDASH":{
                    TailSprite = spr_miles_tail_2;
                    TailAngle  = 0;
                    
                    if(Action != ActionSpindash){
                       TailX      = 0;
                       TailY      = 0;
                       TailSpeed  = 0.24;                       
                    }else{
                       TailY      = 6;
                       TailX      = AnimationDirection*4; 
                       TailSpeed  = 0.48;
                    }
                    
                    if(Action == ActionJump){
                       TailDirection = 1;
                    }else{
                       TailDirection = AnimationDirection;
                    }
                                        
                    break;
              }
              case "FLY":
              case "FLY_EXHAUSTED":{
                    TailSprite    = spr_miles_tail_3;
                    TailX         = 0;
                    TailY         = 0;
                    TailDirection = AnimationDirection;     
                    TailSpeed     = 0.25;     
                    break;          
              }
              case "RUN":{
                    if(abs(XSpeed) < 8){
                       TailSprite    = spr_miles_tail_4;
                       TailX         = 0;
                       TailY         = 0;
                       TailDirection = AnimationDirection;
                    }else{
                       TailSprite    = spr_miles_tail_5;
                       TailX         = 0;
                       TailY         = 0;
                       TailDirection = AnimationDirection;                 
                    }
                    break;
              }
       }       
    }else{
     TailSprite    = noone;
     TailX         = 0;
     TailY         = 0;
     TailDirection = AnimationDirection;
    }  
