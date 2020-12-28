--local inspect = require('inspect')

function Initialize()
  position = SKIN:GetVariable('pos')
  settingFile= SELF:GetOption('settingsFile')

-- Ajout d'un check si position est OK 
  if position ~= "" and position ~= nil then
      MeterBackGroundChange(position,settingFile)
      MeterBarChange(position,settingFile)
      IconPosStyleChange(position,settingFile)

      SKIN:Bang('!Update')
  end
end



function MeterBackGroundChange(pos,settingFile)
  option1 = "(#*IconSize*#+#*Spacing*#)"
  option2 = "(#*NbIcons*#*(#*Spacing*#+#*IconSize*#))"
  
  bgH=""
  bgW=""
  -- Modifier MeterBackGround H et W 
  if(pos == "top" or pos == "bottom") then 
    bgH=option1
    bgW=option2
      -- Up/Down H=(#IconSize#+#Spacing#) W=(#*NbIcons*#*(#*Spacing*#+#*IconSize*#))
  elseif(pos == "left" or pos == "right") then
    bgH=option2
    bgW=option1
      -- Left/Right H=(#NbIcons#*(#Spacing#+#IconSize#))  W=(#IconSize#+#Spacing#)
  end
  
  SKIN:Bang(('!WriteKeyValue Variables bgH  "%s" "%s"'):format(bgH,settingFile))
  SKIN:Bang(('!WriteKeyValue Variables bgW  "%s" "%s"'):format(bgW,settingFile))
  
end



function MeterBarChange(pos,settingFile)
  option1 = "(#*IconSize*#+#*Spacing*#)"
  option2 = "(#*NbIcons*#*(#*Spacing*#+#*IconSize*#))"
  
  barH="3"
  barW="3"
  barX="0"
  barY="0"
  
    -- Modifier MeterBar H et W
  if(pos == "top")  then
    barW=option2   
  -- Up    W=(#NbIcons#*(#Spacing#+#IconSize#)) H=3  X=0  Y=0  
  elseif(pos == "bottom") then 
    barW=option2
    barY=option1
  -- Down    W=(#NbIcons#*(#Spacing#+#IconSize#)) H=3  X=0  Y=(#IconSize#+#Spacing#)
  elseif(pos == "left") then 
    barH=option2
  -- Left  W=3   H=(#NbIcons#*(#Spacing#+#IconSize#))  X=0  Y=0
  elseif(pos == "right") then
    barH=option2
    barX=option1
  -- Right  W=3   H=(#NbIcons#*(#Spacing#+#IconSize#))  X=(#IconSize#+#Spacing#)  Y=0
  end
  
  SKIN:Bang(('!WriteKeyValue Variables barH  "%s" "%s"'):format(barH,settingFile))
  SKIN:Bang(('!WriteKeyValue Variables barW  "%s" "%s"'):format(barW,settingFile))
  SKIN:Bang(('!WriteKeyValue Variables barX  "%s" "%s"'):format(barX,settingFile))
  SKIN:Bang(('!WriteKeyValue Variables barY  "%s" "%s"'):format(barY,settingFile))
  
end

function IconPosStyleChange(pos,settingFile)
  value = "(#*Spacing*#+#*IconSize*#)r"
  
  iconPosX="0r"
  iconPosY="0r"
  
  
   -- Modifier [IconPosStyle] X et Y 
  if(pos == "top" or pos == "bottom") then 
    iconPosX=value
        -- Up/down X=(#Spacing#+#IconSize#)r Y=0r
  elseif(pos == "left" or pos == "right") then 
    iconPosY=value
      -- Left/right X=0r Y=(#Spacing#+#IconSize#)r
  end
  
  SKIN:Bang(('!WriteKeyValue Variables iconPosX  "%s" "%s"'):format(iconPosX,settingFile))
  SKIN:Bang(('!WriteKeyValue Variables iconPosY  "%s" "%s"'):format(iconPosY,settingFile))
  
end

  
 

  

