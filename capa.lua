local composer = require("composer")
local widget = require("widget")
local audio = require("audio") 

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    
    scrollView = widget.newScrollView({
        top = 0,
        left = 0,
        width = display.contentWidth,
        height = display.contentHeight, 
        scrollWidth = display.contentWidth,
        scrollHeight = 1500, 
        backgroundColor = { 0.075, 0.22, 0.1 }, 
        horizontalScrollDisabled = true, 
    })
    sceneGroup:insert(scrollView) 
    

    
    local title = display.newText({
        text = "Melhoramento Genético",
        x = 112 + (545 / 2), 
        y = 113 + (58 / 2),
        width = 545,
        font = "Inter", 
        fontSize = 48,
        align = "center",
    })
    title:setFillColor(1, 1, 1) 
    scrollView:insert(title) 

   
    local centerImage = display.newImageRect("images/5104778-removebg-preview 1.png", 500, 500)
    if centerImage then
        centerImage.x = 134 + (500 / 2) 
        centerImage.y = 202 + (500 / 2) 
        scrollView:insert(centerImage) 
    else
        print("Erro: Imagem central não encontrada!")
    end

    
    local authorText = display.newText({
        text = "Autor: Igor Leonardo Moura da Silva",
        x = 30 + (708 / 2), 
        y = 855 + (44 / 2),
        width = 708,
        font = "Inter",
        fontSize = 36,
        align = "center",
    })
    authorText:setFillColor(1, 1, 1) 
    scrollView:insert(authorText) 

   
    local dateText = display.newText({
        text = "2024.2",
        x = 332 + (105 / 2), 
        y = 930 + (29 / 2), 
        width = 105,
        font = "Inter",
        fontSize = 24,
        align = "center",
    })
    dateText:setFillColor(1, 1, 1) 
    scrollView:insert(dateText) 

    local nextButton = widget.newButton({
        label = "Próximo",
        width = 120, 
        height = 40,
        x = display.contentCenterX + 200, 
        y = 1200, 
        shape = "rect",
        font = "Inter",
        fontSize = 18,
        labelColor = { default = { 0, 0, 0 }, over = { 1, 1, 1 } },
        fillColor = { default = { 0.9, 0.9, 0.9 }, over = { 0.7, 0.7, 0.7 } },
        onRelease = function()
            composer.gotoScene("page2") 
        end,
    })
    scrollView:insert(nextButton) 

   
    local soundOn = true
    local soundIcon

    
    local function toggleSound()
        soundOn = not soundOn
        if soundOn then
            print("Som ativado!")
            audio.resume()
            soundIcon.fill = { type = "image", filename = "images/ComponentSound.png" }
        else
            print("Som desativado!")
            audio.pause()
            soundIcon.fill = { type = "image", filename = "images/ComponentSoundMute.png" } 
        end
    end

    
    soundIcon = display.newRect(display.contentWidth - 60, 60, 40, 40)
    soundIcon.fill = { type = "image", filename = "images/ComponentSound.png" } 
    soundIcon:addEventListener("tap", toggleSound) 
    sceneGroup:insert(soundIcon) 
end

scene:addEventListener("create", scene)
return scene
