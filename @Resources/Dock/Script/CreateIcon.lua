

function Initialize()
  --refresh 
  settingFile= SELF:GetOption('settingsFile')
  refresh = tonumber(SKIN:GetVariable('refresh'))
  
 
  dockFile=SELF:GetOption('dockFile')
  dockFolder=SELF:GetOption('dockFolder')
   
  nbIcons = tonumber(SKIN:GetVariable('NbIcons'))
  destFolder= SELF:GetOption('destFolder')
  destFolderOptions= SELF:GetOption('destFolderOptions')
  --call methodes 
	CreateIconFile(nbIcons,destFolder)
  CreateOptionsFile(nbIcons,destFolderOptions)
  
  if(refresh == 1) then
    SKIN:Bang('!Refresh')
    SKIN:Bang('!WriteKeyValue Variables refresh  "0" "'..settingFile..'"')
  end
  SKIN:Bang('!Refresh "'..dockFolder..'" "!'..dockFile..'"')
end


function CreateIconFile(number,destFolder)

  Icon=""
  num=1
  
  while num <= number do
    -- Création d'un icon 
    Header=("[MeterIcon%d]\n"):format(num)
    Meter= "Meter=Image\n"..
    "MeterStyle=IconStyle | "..(num==1 and "FirstIconPosStyle" or "IconPosStyle").."\n"
    Image=("ImageName=#@#Dock\\Icons\\#appImg%d#\n"):format(num)
    Action=("LeftMouseUpAction=[\"#appAction%d#\"]\n"):format(num)
    Icon = Icon ..  Header .. Meter .. Image .. Action .. "\r\n"
    -- Increment
    num= num+1
  end

  WriteFile(destFolder,"Icons.ini",Icon)

  return true;
end





function CreateOptionsFile(number,destFolder)

  Icon=""
  num=1
  
  while num <= number do
    shape= ('[MeterShape%d]\n'):format(num)..
    'Meter=Shape\n'..
    'MeterStyle=ShapeStyle\n'..
    ('X=([MeterIcon%d:X]-2)\n'):format(num)..
    ('Y=([MeterIcon%d:Y]+#IconSize#)\n'):format(num)..
    ('LeftMouseUpAction=[!WriteKeyValue Variables oldIcon "%d" "#@#Dock\\#settingsFile#"][!CommandMeasure "MeterInput%d" "ExecuteBatch 1-2"]'):format(num,num).."\r\n"


    value =('[MeterValue%d]\n'):format(num)..
    'Meter=String\n'..
    'MeterStyle=ValueStyle\n'..
    ('X=([MeterIcon%d:X]+3)\n'):format(num)..
    ('Y=([MeterIcon%d:Y]+#IconSize#+5)\n'):format(num)..
    ('Text=%d'):format(num)..
    "\r\n"

    input = ('[MeterInput%d]\n'):format(num)..
    'Measure=Plugin\n'..
    'Group=Options\n'..
    'Plugin=InputText\n'..
    'StringAlign=center\n'..
    'FontSize=10\n'..
    'SolidColor=0,0,0,255\n'..
    'FontColor=220,220,220\n'..
    'W=18\n'..
    'H=16\n'..
    'AntiAlias=1\n'..
    'FocusDismiss=1\n'..
    ('X=([MeterIcon%d:X])\n'):format(num)..
    ('Y=([MeterIcon%d:Y]+#IconSize#+3)\n'):format(num)..
    'Command1=[!WriteKeyValue Variables selectedIcon "$UserInput$" "#@#Dock\\#settingsFile#"]\n'..
    'Command2=[!UpdateMeasure MeasurePosition][!Refresh]\n'..
    ('DefaultValue=%d'):format(num)..
    "\r\n"


    delete= ('[MeterDelete%d]\n'):format(num)..
    'Meter=Image\n'..
    'MeterStyle=DeleteStyle\n'..
    ('X=([MeterIcon%d:X]+(#IconSize#/2))\n'):format(num)..
    ('Y=([MeterIcon%d:Y]+#IconSize#+2)\n'):format(num)..
    ('LeftMouseUpAction=[!WriteKeyValue Variables deleteIcon "%d" "#@#Dock\\#settingsFile#"][!ShowMeterGroup Delete]'):format(num)..
    "\r\n"
    
    
    Icon = Icon ..  shape .. value .. input .. delete 
    -- Increment
    num= num+1
  end

  WriteFile(destFolder,"IconOptions.ini",Icon)

  return true;
end


function WriteFile(FilePath,fileName, Contents)
	-- HANDLE RELATIVE PATH OPTIONS.
	--FilePath = SKIN:MakePathAbsolute(FilePath)

	-- OPEN FILE.
  
	local File = io.open(FilePath..[[\]]..fileName, 'w')

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('WriteFile: unable to open file at ' .. FilePath..[[\]]..fileName)
		return
	end

	-- WRITE CONTENTS AND CLOSE FILE
	File:write(Contents)
	File:close()

	return true
end


--CreateIconFile(5,[[D:\User\Documents\Rainmeter\Skins\Embla\@Resources\Dock\Icons.ini]])
