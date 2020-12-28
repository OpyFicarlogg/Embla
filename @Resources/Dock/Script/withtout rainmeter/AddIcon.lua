

function AddParam(number, action, img, inputFile)

  appAction=("\r\nappAction%d=\"%s\"\n"):format(number,action)
  appImg = ("appImg%d=%s"):format(number,img)
  
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


AddParam(7,"test","img.png",[[D:\User\Documents\Rainmeter\Skins\Embla\@Resources\Dock\DockSettings.ini]])