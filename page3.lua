local composer = require("composer")
local widget = require("widget")
local audio = require("audio") 

local scene = composer.newScene()

local narration
local narrationTimer
local soundOn = true
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
        backgroundColor = {0.86, 0.85, 0.85}, 
        horizontalScrollDisabled = true
    })
    sceneGroup:insert(scrollView)

    local pageNumber = display.newText({
        text = "3",
        x = 26,
        y = 61,
        font = native.systemFontBold,
        fontSize = 16,
        align = "center"
    })
    pageNumber:setFillColor(0, 0, 0)
    scrollView:insert(pageNumber)

    local topLeafIcon = display.newImageRect("images/FolhaSuperior.png", 136, 165)
    topLeafIcon.x = 530 + (136 / 2) 
    topLeafIcon.y = 1 + (165 / 2) 
    scrollView:insert(topLeafIcon)

    local title = display.newText({
        text = "Técnicas de Melhoramento Genético:\nCruzamentos e Hibridização",
        x = display.contentCenterX,
        y = 223,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    title:setFillColor(0, 0, 0)
    scrollView:insert(title)

    local paragraph1 = display.newText({
        text = "    Cruzamento e Hibridização são dois métodos tradicionais no melhoramento genético usados para criar novas gerações de organismos com características aprimoradas. Essas técnicas são fundamentais em áreas como agricultura, zootecnia, e silvicultura, permitindo o desenvolvimento de novas variedades e raças com características desejáveis, como maior resistência a pragas, produtividade, e adaptação a diferentes condições ambientais.",
        x = display.contentCenterX,
        y = 404,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph1:setFillColor(0, 0, 0)
    scrollView:insert(paragraph1)

    local paragraph2 = display.newText({
        text = "    Essas técnicas permitem que as características vantajosas de dois organismos sejam passadas para seus descendentes, promovendo a diversidade genética dentro de uma espécie. Isso ajuda na criação de novas variedades que são melhor adaptadas a desafios ambientais ou comerciais.",
        x = display.contentCenterX,
        y = 550,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph2:setFillColor(0, 0, 0)
    scrollView:insert(paragraph2)

    local subtitle = display.newText({
        text = "Cruzamento",
        x = display.contentCenterX,
        y = 730,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    subtitle:setFillColor(0, 0, 0)
    scrollView:insert(subtitle)

    local paragraph3 = display.newText({
        text = "    O cruzamento é o processo de reprodução entre dois indivíduos da mesma espécie, com o objetivo de misturar os genes de ambos e gerar descendentes com características aprimoradas ou combinadas. Esse método é amplamente utilizado na criação de plantas e animais para otimizar traços específicos.",
        x = display.contentCenterX,
        y = 823,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph3:setFillColor(0, 0, 0)
    scrollView:insert(paragraph3)

    local paragraph4 = display.newText({
        text = "    Tipos de Cruzamento:\n\nCruzamento Monohíbrido: A cruza entre dois organismos que diferem em apenas uma característica (como cor de flor). Temos como exemplo, cruzar uma planta com flores vermelhas com outra de flores brancas para ver qual cor prevalece nos descendentes.",
        x = display.contentCenterX,
        y = 955,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph4:setFillColor(0, 0, 0)
    scrollView:insert(paragraph4)

   
    local bottomLeafIcon = display.newImageRect("images/FolhaInferior.png", 136, 165)
    bottomLeafIcon.x = -11 + (136 / 2) 
    bottomLeafIcon.y = 1100 + (165 / 2) 
    scrollView:insert(bottomLeafIcon)

    local backButton = widget.newButton({
        label = "Voltar",
        width = 74,
        height = 32,
        x = 296 + (74 / 2),
        y = 1100,
        shape = "rect",
        font = "Inter",
        fontSize = 18,
        labelColor = {
            default = {0, 0, 0},
            over = {1, 1, 1}
        },
        fillColor = {
            default = {0.9, 0.9, 0.9},
            over = {0.7, 0.7, 0.7}
        },
        onRelease = function()
            composer.gotoScene("page2") 
        end
    })
    scrollView:insert(backButton)

    local nextButton = widget.newButton({
        label = "Próximo",
        width = 88,
        height = 32,
        x = 408 + (88 / 2),
        y = 1100,
        shape = "rect",
        font = "Inter",
        fontSize = 18,
        labelColor = {
            default = {0, 0, 0},
            over = {1, 1, 1}
        },
        fillColor = {
            default = {0.9, 0.9, 0.9},
            over = {0.7, 0.7, 0.7}
        },
        onRelease = function()
            composer.gotoScene("page4") 
        end
    })
    scrollView:insert(nextButton)
    narration = audio.loadStream("audio/Página3.wav")

    local function toggleSound()
        soundOn = not soundOn
        if soundOn then
            print("Som ativado!")
            playNarrationWithDelay()
            --audio.resume()--
            soundIcon.fill = { type = "image", filename = "images/ComponentSound.png" }
        else
            print("Som desativado!")
            timer.cancel(narrationTimer) 
            audio.stop()
            soundIcon.fill = { type = "image", filename = "images/ComponentSoundMute.png" } 
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
