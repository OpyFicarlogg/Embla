
--local inspect = require('inspect')
function Initialize()
  nbIcons = tonumber(SKIN:GetVariable('NbIcons'))
  deleteIcon = tonumber(SKIN:GetVariable('deleteIcon'))
  settingsFile= SELF:GetOption('settingsFile')
  
  
  if deleteIcon ~= 0 then  
    print(deleteIcon)
    DeleteIcon(deleteIcon,settingsFile)
    SKIN:Bang('!WriteKeyValue Variables nbIcons  "'..(nbIcons-1)..'" "'..settingsFile..'"')
    SKIN:Bang('!WriteKeyValue Variables deleteIcon  "0" "'..settingsFile..'"')
    SKIN:Bang('!WriteKeyValue Variables refresh  "1" "'..settingsFile..'"')
    SKIN:Bang('!Refresh')
  end
	
end

function DeleteIcon(value, inputFile)

    local file = io.open(inputFile, 'r')
    local fileContent = {}
    local skipNextLine=false
    for line in file:lines() do
        if not line:match('^appAction'..value..'=(.+)') and not line:match('^appImg'..value..'=(.+)') then
          if not skipNextLine then 
            table.insert (fileContent, line)
          else
            skipNextLine =false;
          end
        else
            skipNextLine = true
        end
        
        
    end
    io.close(file)

  
    --print(inspect(fileContent))
    -- recalc param
    local i=value
    for index, val in pairs(fileContent) do
        if(val:match('^appAction'..(i+1)..'=(.+)')) then 
          fileContent[index] = val:gsub("^appAction"..(i+1), "appAction"..i)
        end
        if(val:match('^appImg'..(i+1)..'=(.+)')) then
          fileContent[index] = val:gsub("^appImg"..(i+1), "appImg"..i)
          i=i+1
        end

    end

    file = io.open(inputFile, 'w')
    for index, value in ipairs(fileContent) do
        file:write(value..'\n')
    end
    io.close(file)
end


--DeleteIcon(3,[[D:\User\Documents\Rainmeter\Skins\Embla\@Resources\Dock\DockSettings.ini]])