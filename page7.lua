local composer = require("composer")
local widget = require("widget")
local audio = require("audio")

local scene = composer.newScene()

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
        backgroundColor = {0.86, 0.85, 0.85},
        horizontalScrollDisabled = true
    })
    sceneGroup:insert(scrollView)

    local pageNumber = display.newText({
        text = "7",
        x = 26,
        y = 61,
        font = "Inter",
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
        text = "CRISPR: A Revolução da Engenharia Genética",
        x = display.contentCenterX,
        y = 204,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    title:setFillColor(0, 0, 0)
    scrollView:insert(title)

    local paragraph1 = display.newText({
        text = "    A técnica CRISPR utiliza uma proteína chamada Cas9, que atua como uma tesoura capaz de cortar o DNA. Para garantir que o corte seja feito no lugar correto, os cientistas utilizam uma sequência de RNA guia, que se liga ao local exato onde a modificação deve ocorrer no genoma. Uma vez que o DNA é cortado, a célula do organismo tenta reparar o corte, e é nesse momento que os cientistas podem introduzir a alteração genética desejada.",
        x = display.contentCenterX,
        y = 315,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph1:setFillColor(0, 0, 0)
    scrollView:insert(paragraph1)

    local subtitle = display.newText({
        text = "Aplicações da Engenharia Genética e CRISPR",
        x = display.contentCenterX,
        y = 430,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    subtitle:setFillColor(0, 0, 0)
    scrollView:insert(subtitle)

    local paragraph2 = display.newText({
        text = "    As aplicações da engenharia genética e da técnica CRISPR são vastas e se estendem a diversas áreas, incluindo: \n\nMedicina: No tratamento de doenças genéticas, como a fibrose cística, a anemia falciforme e a distrofia muscular, onde genes defeituosos podem ser substituídos por genes saudáveis.\n\nAgricultura: No desenvolvimento de culturas mais nutritivas, resistentes a pragas e mais produtivas.\n\nZootecnia: No aprimoramento genético de animais para aumentar a produção de carne, leite e ovos, ou para desenvolver resistência a doenças.",
        x = display.contentCenterX,
        y = 610,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph2:setFillColor(0, 0, 0)
    scrollView:insert(paragraph2)

    local example = display.newText({
        text = "Exemplo prático: Se um gene em um organismo estiver causando uma doença, como uma mutação que leva a uma condição hereditária, os cientistas podem usar CRISPR para remover o gene defeituoso e substituí-lo por uma versão saudável, potencialmente curando a doença no processo.",
        x = display.contentCenterX,
        y = 930,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    example:setFillColor(0, 0, 0)
    scrollView:insert(example)

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
            composer.gotoScene("page6")
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
            composer.gotoScene("page8")
        end
    })
    scrollView:insert(nextButton)
    narration = audio.loadStream("audio/Página7.wav")

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

    function scene:destroy(event)
        if narration then
            audio.dispose(narration)
            narration = nil
        end
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
