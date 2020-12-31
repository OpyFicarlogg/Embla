function Initialize()
  nbIcons = tonumber(SKIN:GetVariable('NbIcons'))
  settingsFile= SELF:GetOption('settingsFile')
  image=SKIN:GetVariable('addImage')
  action=SKIN:GetVariable('addAction')
  
  --image = SKIN:GetMeter('MeterValueAddImg'):GetOption('Text')
  --action = SKIN:GetMeter('MeterValueAddAction'):GetOption('Text')
  
  --image= SELF:GetOption('newImage')
  --action= SELF:GetOption('newAction')
  
  -- test "action name" et "image name"

  if(image ~="" and image ~=nil and image ~="Image Name") and (action ~="" and action ~=nil and action ~="Action value") then
    nbIcons = nbIcons+1    
    AddParam(nbIcons,action,image,settingsFile)
    SKIN:Bang('!WriteKeyValue Variables NbIcons  "'..nbIcons..'" "'..settingsFile..'"')
    SKIN:Bang('!WriteKeyValue Variables refresh  "1" "'..settingsFile..'"')
    SKIN:Bang('!Refresh')
  end
  SKIN:Bang('!WriteKeyValue Variables addImage  "" "'..settingsFile..'"')
  SKIN:Bang('!WriteKeyValue Variables addAction  "" "'..settingsFile..'"')
	
end

function AddParam(number, action, img, inputFile)

  
  
  appAction=("appAction%d=\"%s\"\n"):format(number,action)
  appImg = ("appImg%d=%s\r"):format(number,img)
  
  param= appAction..appImg
  AppendFile(inputFile,param)

  return true;
end

function AppendFile(FilePath, Contents)
	-- HANDLE RELATIVE PATH OPTIONS.
	--FilePath = SKIN:MakePathAbsolute(FilePath)

	-- OPEN FILE.
	local File = io.open(FilePath, 'a')

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('WriteFile: unable to open file at ' .. FilePath)
		return
	end

	-- WRITE CONTENTS AND CLOSE FILE
	File:write(Contents)
	File:close()
end


--AddParam(7,"test","img.png",[[D:\User\Documents\Rainmeter\Skins\Embla\@Resources\Dock\DockSettings.ini]])