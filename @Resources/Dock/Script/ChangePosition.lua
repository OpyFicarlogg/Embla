--local inspect = require('inspect')

function Initialize()
  settingFile= SELF:GetOption('settingsFile')
  oldNum=tonumber(SKIN:GetVariable('oldIcon'))
  newNum=tonumber(SKIN:GetVariable('selectedIcon'))
  nbIcons=tonumber(SKIN:GetVariable('NbIcons'))

  if oldNum ~= 0 and newNum ~= 0 then
      print(oldNum.." "..newNum)
    if(oldNum<=nbIcons) and (newNum<=nbIcons) then
      ChangePosition(newNum,oldNum,settingFile)
      SKIN:Bang('!WriteKeyValue Variables oldIcon  "0" "'..settingFile..'"')
      SKIN:Bang('!WriteKeyValue Variables selectedIcon  "0" "'..settingFile..'"')
      SKIN:Bang('!WriteKeyValue Variables refresh  "1" "'..settingFile..'"')
      SKIN:Bang('!Refresh')
    end
  end
end


function ChangePosition(appNum, appNumOld, inputFile)
  --Get all variables
  iniConf = GetIniVar(inputFile)

  appAction=""
  appActionLine=""

  appActionOld=""
  appActionOldLine=""

  appImg=""
  appImgLine=""

  appImgOld=""
  appImgOldLine=""

  appReplace={}

  for key, value in pairs(iniConf) do
    
      -- get appAction
      if(value:match('^(appAction'..appNum..')=(.+)')) then  --Récupérerla valeur de appAction pour App
         appActionOld='appAction'..appNumOld..'='..value:match('=(.+)')
         appActionLine=key
      end
      
      if(value:match('^(appAction'..appNumOld..')=(.+)')) then  --Récupérerla valeur de appAction pour App
        appAction='appAction'..appNum..'='..value:match('=(.+)')
         appActionOldLine=key
      end
      
      -- get appLine
      if(value:match('^(appImg'..appNum..')=(.+)')) then  --Récupérerla valeur de appAction pour App
         appImgOld='appImg'..appNumOld..'='..value:match('=(.+)')
         appImgLine=key
      end
      
      if(value:match('^(appImg'..appNumOld..')=(.+)')) then  --Récupérerla valeur de appAction pour App
        appImg='appImg'..appNum..'='..value:match('=(.+)')
        appImgOldLine=key
      end
      
  end

  appReplace[appActionLine]=appAction
  appReplace[appActionOldLine]=appActionOld
  appReplace[appImgLine]=appImg
  appReplace[appImgOldLine]=appImgOld
  
  
  SwitchValues(appReplace, inputFile)

end


-- Récupère toutes les variables 
function GetIniVar(inputFile)
	local file = assert(io.open(inputFile, 'r'), 'Unable to open ' .. inputFile)
	local tbl={}
	local num = 0
	for line in file:lines() do
		num = num + 1
    if line:match('^([^=]+)=(.+)') then
      tbl[num]=line
    end
	end
	file:close()
	return tbl
end


function SwitchValues(values, inputFile)

    local file = io.open(inputFile, 'r')
    local fileContent = {}
    for line in file:lines() do
        table.insert (fileContent, line)
    end
    io.close(file)

    for editLine, value in pairs(values) do
        fileContent[editLine] = value
    end
    

    file = io.open(inputFile, 'w')
    for index, value in ipairs(fileContent) do
        file:write(value..'\n')
    end
    io.close(file)
end



--ChangePosition(1,2,[[D:\User\Documents\Rainmeter\Skins\Embla\@Resources\Dock\DockSettings.ini]])





