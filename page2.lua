local composer = require("composer")
local widget = require("widget")
local audio = require("audio") 

local scene = composer.newScene()
local scrollView, watermelonModified, watermelonRevealed
local narration
local narrationTimer
local soundOn = true
local soundIcon

local function playNarrationWithDelay()
    if soundOn then
        audio.play(narration)
        narrationTimer = timer.performWithDelay(5000, playNarrationWithDelay) 
    end
end

local function createBlurredWatermelon()
    if watermelonModified then
        display.remove(watermelonModified)
    end
    watermelonModified = display.newImageRect("images/melanciaBlur.png", 213, 213)
    watermelonModified.x = 477 + (213 / 2)
    watermelonModified.y = 760 + (213 / 2)
    scrollView:insert(watermelonModified)

    watermelonModified:addEventListener("tap", function()
        if watermelonRevealed then
            display.remove(watermelonRevealed)
        end
        watermelonRevealed = display.newImageRect("images/melanciaRevealed.png", 213, 213)
        watermelonRevealed.x = watermelonModified.x
        watermelonRevealed.y = watermelonModified.y
        scrollView:insert(watermelonRevealed)
        display.remove(watermelonModified)
        watermelonModified = nil
    end)
end

function scene:create(event)
    local sceneGroup = self.view

    scrollView = widget.newScrollView({
        top = 0,
        left = 0,
        width = display.contentWidth,
        height = display.contentHeight, 
        scrollWidth = display.contentWidth,
        scrollHeight = 1500, 
        backgroundColor = {0.86, 0.85, 0.85}, 
        horizontalScrollDisabled = true, 
    })
    sceneGroup:insert(scrollView) 

    local pageNumber = display.newText({
        text = "2",
        x = 26,
        y = 61,
        font = native.systemFontBold,
        fontSize = 16,
        align = "center",
    })
    pageNumber:setFillColor(0, 0, 0)
    scrollView:insert(pageNumber)

    local leafIcon = display.newImageRect("images/FolhaBackground.png", 136, 165)
    leafIcon.x = 77 + (136 / 2)
    leafIcon.y = 8 + (165 / 2)
    scrollView:insert(leafIcon)



    local title = display.newText({
        text = "Introdução ao melhoramento genético",
        x = display.contentCenterX,
        y = 240,
        width = 608,
        font = native.systemFontBold,
        fontSize = 32,
        align = "center",
    })
    title:setFillColor(0, 0, 0)
    scrollView:insert(title)

    local paragraph1 = display.newText({
        text = "   O melhoramento genético é uma prática que visa aprimorar as características de organismos, sejam eles plantas, animais ou microorganismos, por meio da seleção e manipulação de seus genes. Essa técnica tem sido utilizada em diversas áreas, como agricultura, zootecnia e medicina, com o objetivo de aumentar a produtividade, melhorar a qualidade das espécies e otimizar recursos.",
        x = display.contentCenterX,
        y = 380,
        width = 700,
        font = native.systemFont,
        fontSize = 20,
        align = "left",
    })
    paragraph1:setFillColor(0, 0, 0)
    scrollView:insert(paragraph1)

    local paragraph2 = display.newText({
        text = "    Essa prática abrange uma variedade de métodos e abordagens projetadas para modificar as características hereditárias de uma população de organismos. As mudanças podem ocorrer de maneira natural, por meio da seleção artificial, ou de forma mais precisa, utilizando técnicas de biotecnologia e engenharia genética.",
        x = display.contentCenterX,
        y = 580,
        width = 700,
        font = native.systemFont,
        fontSize = 20,
        align = "left",
    })
    paragraph2:setFillColor(0, 0, 0)
    scrollView:insert(paragraph2)


    local paragraph3 = display.newText({
        text = " Exemplo: Uma prática frequente no setor agrícola é a modificação de sementes de plantas que resultam em frutos sem sementes, representando uma das aplicações do melhoramento genético. Podemos ver isso exemplificado abaixo se clicarmos na melancia borrada:",
        x = display.contentCenterX,
        y = 710,
        width = 700,
        font = native.systemFont,
        fontSize = 20,
        align = "left",
    })
    paragraph3:setFillColor(0, 0, 0)
    scrollView:insert(paragraph3)
    

    local watermelonOriginal = display.newImageRect("images/MelanciaCaroco.png", 213, 213)
    watermelonOriginal.x = 38 + (213 / 2)
    watermelonOriginal.y = 760 + (213 / 2)
    scrollView:insert(watermelonOriginal)

    local arrowImage = display.newImageRect("images/Arrow12.png", 150, 50) 
    arrowImage.x = display.contentCenterX
    arrowImage.y = 760 + (213 / 2) 
    scrollView:insert(arrowImage)

    createBlurredWatermelon()

    local bottomImage = display.newImageRect("images/GreenImage.png", 322, 322)
    bottomImage.x = 523 + (322 / 2)
    bottomImage.y = 1050 
    scrollView:insert(bottomImage)

    local backButton = widget.newButton({
        label = "Voltar",
        width = 74,
        height = 32,
        x = 296 + (74 / 2),
        y = 1000, 
        shape = "rect",
        font = native.systemFont,
        fontSize = 18,
        labelColor = { default = { 0, 0, 0 }, over = { 1, 1, 1 } },
        fillColor = { default = { 0.9, 0.9, 0.9 }, over = { 0.7, 0.7, 0.7 } },
        onRelease = function()
            composer.gotoScene("capa")
        end,
    })
    scrollView:insert(backButton)

local nextButton = widget.newButton({
    label = "Próximo",
    width = 88,
    height = 32,
    x = 408 + (88 / 2),
    y = 1000, 
    shape = "rect",
    font = native.systemFont,
    fontSize = 18,
    labelColor = { default = { 0, 0, 0 }, over = { 1, 1, 1 } },
    fillColor = { default = { 0.9, 0.9, 0.9 }, over = { 0.7, 0.7, 0.7 } },
    onRelease = function()
        composer.gotoScene("page3") 
    end,
})
scrollView:insert(nextButton)
narration = audio.loadStream("audio/Página2.wav")

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
