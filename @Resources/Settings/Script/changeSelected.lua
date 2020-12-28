
function Initialize()
  
  texts={"TextDock","TextAction","TextBar","TextRecycle","TextBattery","TextPing","TextCpu","TextRam","TextDrive","TextClock"}
  selected = tonumber(SKIN:GetVariable('selected'))
  
  SKIN:Bang('!SetOptionGroup Options MeterStyle "StyleText"')
  SKIN:Bang('!SetOption '..texts[selected]..' MeterStyle "StyleTextSelect"')
  
  SKIN:Bang('!Update')
end
