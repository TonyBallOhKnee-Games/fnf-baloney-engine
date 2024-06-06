--Botplay Changer lua v1.5
--I Coded all of this
--If you want to use it! Credit me! (Credit thingy: "BlixerTheGamer")
--Botplay list code by XpsxExp (from his Purin PE Port with extras) 

--Settings--
--Change to whatever you want!
botTxt = 'Subscribe to TonyBallOhKnee' -- This Will Show up saying "Botplay" or smth...
withFont = false -- If haves font
withColor = true -- If haves color
withRandomMessages = false -- If have messages (Like Hypno Lullaby)
editBorder = false -- To customize border
font = 'vcr.ttf' -- The font
colorTxt = 'FFFFFFFF' -- The color
borderSize = 1 -- The size of the border
borderColor = 'FFFFFFFF' -- The color but as a border
botPlayTexts = {'Saku Tits', 'No Leaking!', 'Press 7', 'Lmao'} --You can add your Own messages here

function onCreatePost()
	if withRandomMessages == true then
	setTextString('botplayTxt', botTxt..'\n'..botPlayTexts[getRandomInt(1, #botPlayTexts)])
	else setTextString('botplayTxt', botTxt) end
	if withFont == true then setTextFont('botplayTxt', font) end
	if withColor == true then setTextColor('botplayTxt', '#00FF00') end
	if editBorder == true then setTextBorder('botplayTxt', borderSize, borderColor) end
end