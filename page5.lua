local composer = require("composer")
local widget = require("widget")
local audio = require("audio")

local scene = composer.newScene()

local soundOn = true
local dolphinInside = false
local whaleInside = false
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
        text = "5",
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
        text = "Hibridização Avançada",
        x = display.contentCenterX,
        y = 180,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    title:setFillColor(0, 0, 0)
    scrollView:insert(title)

    local square = display.newImageRect("images/Quadrado.png", 200, 200)
    square.x = display.contentCenterX
    square.y = 800
    scrollView:insert(square)

    local dolphin = display.newImageRect("images/Dolphin.png", 200, 200)
    dolphin.x = display.contentCenterX - 150
    dolphin.y = 600
    scrollView:insert(dolphin)

    local whale = display.newImageRect("images/Baleia.png", 200, 200)
    whale.x = display.contentCenterX + 150
    whale.y = 600
    scrollView:insert(whale)

    local arrowLeft = display.newImageRect("images/ArrowLeft.png", 150, 150)
    arrowLeft.x = dolphin.x + 15
    arrowLeft.y = dolphin.y + 100
    scrollView:insert(arrowLeft)

    local arrowRight = display.newImageRect("images/ArrowRight.png", 150, 150)
    arrowRight.x = whale.x - 15
    arrowRight.y = whale.y + 100
    scrollView:insert(arrowRight)

    local function checkInside()
        if dolphinInside and whaleInside then
            local wholphin = display.newImageRect("images/Wholphin.png", 200, 200)
            wholphin.x = square.x
            wholphin.y = square.y
            scrollView:insert(wholphin)

            local successMessage = display.newText({
                text = "Você criou um Wholphin!",
                x = display.contentCenterX,
                y = square.y + 150,
                font = "Inter",
                fontSize = 22,
                align = "center"
            })
            successMessage:setFillColor(0, 0, 0)
            scrollView:insert(successMessage)

            display.remove(dolphin)
            display.remove(whale)
            dolphin = nil
            whale = nil
        end
    end

    local function dragImage(event)
        local image = event.target
        if event.phase == "began" then
            display.currentStage:setFocus(image)
            image.isFocus = true
            image.offsetX = event.x - image.x
            image.offsetY = event.y - image.y
        elseif event.phase == "moved" and image.isFocus then
            image.x = event.x - image.offsetX
            image.y = event.y - image.offsetY
        elseif event.phase == "ended" or event.phase == "cancelled" then
            if image.isFocus then
                display.currentStage:setFocus(nil)
                image.isFocus = false

                if image == dolphin and math.abs(image.x - square.x) < 100 and math.abs(image.y - square.y) < 100 then
                    dolphinInside = true
                    image.x = square.x - 50
                    image.y = square.y - 50
                elseif image == whale and math.abs(image.x - square.x) < 100 and math.abs(image.y - square.y) < 100 then
                    whaleInside = true
                    image.x = square.x + 50
                    image.y = square.y + 50
                end

                checkInside()
            end
        end
        return true
    end

    dolphin:addEventListener("touch", dragImage)
    whale:addEventListener("touch", dragImage)

   
    local paragraph1 = display.newText({
        text = "    Hibridização Interespecífica: ocorre ao realizar a junção de duas espécies diferentes, como é o exemplo do cruzamento de uma vaca com um búfalo para gerar o 'Beefalo', uma combinação de carne de alta qualidade com maior adaptabilidade ambiental.",
        x = display.contentCenterX,
        y = 304,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph1:setFillColor(0, 0, 0)
    scrollView:insert(paragraph1)

    local paragraph2 = display.newText({
        text = "    A hibridização permite a criação de organismos com características que não seriam possíveis através de cruzamentos dentro da mesma espécie. Exemplo: Junção entre golfinhos e falsas-orcas, dão origem a uma espécie chamada Wholphin. Vamos ver isso na prática, junte as duas espécies arrastando-as para dentro do quadrado e veja o que acontece.",
        x = display.contentCenterX,
        y = 450,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph2:setFillColor(0, 0, 0)
    scrollView:insert(paragraph2)

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
            composer.gotoScene("page4")
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
            composer.gotoScene("page6")
        end
    })
    scrollView:insert(nextButton)


    narration = audio.loadStream("audio/Página5.wav")


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
