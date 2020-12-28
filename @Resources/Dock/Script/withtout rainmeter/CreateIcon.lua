




function CreateIconFile(number,inputFile)

  Icon=""
  num=1
  
  while num <= number do
    -- Création d'un icon 
    Header=("[MeterIcon%d]\n"):format(num)
    Meter= "Meter=Image\n"..
    "MeterStyle=IconStyle | "..(num==1 and "FirstIconPosStyle" or "IconPosStyle").."\n"
    Image=("ImageName=#@#Dock\\Icons\\#appImg%d#\n"):format(num)
    Action=("LeftMouseUpAction=[#appAction%d#]\n"):format(num)
    Icon = Icon ..  Header .. Meter .. Image .. Action .. "\r\n"
    -- Increment
    num= num+1
  end

  WriteFile(inputFile,Icon)

  return true;
end

function WriteFile(FilePath, Contents)
	-- HANDLE RELATIVE PATH OPTIONS.
	--FilePath = SKIN:MakePathAbsolute(FilePath)

	-- OPEN FILE.
	local File = io.open(FilePath, 'w')

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('WriteFile: unable to open file at ' .. FilePath)
		return
	end

	-- WRITE CONTENTS AND CLOSE FILE
	File:write(Contents)
	File:close()

	return true
end

CreateIconFile(5,[[D:\User\Documents\Rainmeter\Skins\Embla\@Resources\Dock\Icons.ini]])
