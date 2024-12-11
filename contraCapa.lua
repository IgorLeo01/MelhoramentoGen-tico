local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()
local audio = require("audio") 

local soundOn = true
local narration
local narrationTimer
local soundIcon

local function playNarrationWithDelay()
    if soundOn then
        audio.play(narration)
        narrationTimer = timer.performWithDelay(3000, playNarrationWithDelay) 
    end
end

function scene:create(event)
    local sceneGroup = self.view

    local scrollView = widget.newScrollView({
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

    local titulo = display.newText({
        text = "Melhoramento Genético",
        x = 112 + (545 / 2), 
        y = 113 + (58 / 2), 
        width = 545,
        font = "Inter", 
        fontSize = 48,
        align = "center", 
    })
    titulo:setFillColor(1, 1, 1) 
    scrollView:insert(titulo) 

    
    local imagemContraCapa = display.newImageRect("images/ContraCapa.png", 612, 408)
    imagemContraCapa.x = 75 + (612 / 2) 
    imagemContraCapa.y = 260 + (408 / 2) 
    scrollView:insert(imagemContraCapa) 

    local autor = display.newText({
        text = "Autor: Igor Leonardo Moura da Silva",
        x = 20 + (708 / 2), 
        y = 736 + (44 / 2), 
        width = 708,
        font = "Inter",
        fontSize = 36,
        align = "center", 
    })
    autor:setFillColor(1, 1, 1)
    scrollView:insert(autor) 

   
    local orientador = display.newText({
        text = "Orientador: Prof. Ewerton Mendonça",
        x = 20 + (708 / 2), 
        y = 850 + (44 / 2),
        width = 708,
        font = "Inter",
        fontSize = 36,
        align = "center", 
    })
    orientador:setFillColor(1, 1, 1) 
    scrollView:insert(orientador) 

    local disciplina = display.newText({
        text = "Disciplina: Computação Gráfica e Sistemas Multimídia",
        x = 5 + (708 / 2), 
        y = 950 + (88 / 2), 
        width = 600,
        font = "Inter",
        fontSize = 36,
        align = "center", 
    })
    disciplina:setFillColor(1, 1, 1) 
    scrollView:insert(disciplina)

    local backButton = widget.newButton({
        label = "Voltar",
        width = 74,
        height = 32,
        x = display.contentCenterX - 100, 
        y = 1200, 
        shape = "rect",
        font = "Inter",
        fontSize = 18,
        labelColor = { default = { 0, 0, 0 }, over = { 1, 1, 1 } },
        fillColor = { default = { 0.9, 0.9, 0.9 }, over = { 0.7, 0.7, 0.7 } },
        onRelease = function()
            composer.gotoScene("page9") 
        end,
    })
    scrollView:insert(backButton) 

   
    local nextButton = widget.newButton({
        label = "Voltar ao Inicio",
        width = 134,
        height = 32,
        x = display.contentCenterX + 100, 
        y = 1200, 
        shape = "rect",
        font = "Inter",
        fontSize = 18,
        labelColor = { default = { 0, 0, 0 }, over = { 1, 1, 1 } },
        fillColor = { default = { 0.9, 0.9, 0.9 }, over = { 0.7, 0.7, 0.7 } },
        onRelease = function()
            composer.gotoScene("capa") 
        end,
    })
    scrollView:insert(nextButton) 
    narration = audio.loadStream("audio/ContraCapa.wav")

    local function toggleSound()
        soundOn = not soundOn
        if soundOn then
            soundIcon.fill = { type = "image", filename = "images/ComponentSound.png" }
            print("Som ativado!")
            playNarrationWithDelay()
        else
            soundIcon.fill = { type = "image", filename = "images/ComponentSoundMute.png" }
            print("Som desativado!")
            if narrationTimer then
                timer.cancel(narrationTimer)
            end
            audio.stop()
        end
    end
    
    soundIcon = display.newRect(display.contentWidth - 60, 110, 40, 40)
    soundIcon.fill = { type = "image", filename = "images/ComponentSound.png" } 
    soundIcon:setFillColor(1, 1, 1)
    soundIcon:addEventListener("tap", toggleSound) 
    sceneGroup:insert(soundIcon) 
end

function scene:show(event)
    if event.phase == "did" then
        audio.stop()  
        
        if soundOn then
            audio.rewind(narration) 
            playNarrationWithDelay()
        end
    end
end


function scene:hide(event)
    if event.phase == "will" then
        if narrationTimer then
            timer.cancel(narrationTimer)
        end
        audio.stop()
    end
end

function scene:destroy(event)
    if narration then
        audio.dispose(narration)
        narration = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
return scene
