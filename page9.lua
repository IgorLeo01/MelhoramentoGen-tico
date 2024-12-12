local composer = require("composer")
local widget = require("widget")
local physics = require("physics")  
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
        backgroundColor = {0.86, 0.85, 0.85},
        horizontalScrollDisabled = true
    })
    sceneGroup:insert(scrollView)

    local pageNumber = display.newText({
        text = "9",
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
        text = "Benefícios e Controvérsias do Melhoramento Genético",
        x = 331,
        y = 175,
        width = 620,
        font = "Inter",
        fontSize = 26,
        align = "left"
    })
    title:setFillColor(0, 0, 0)
    scrollView:insert(title)

    local description = display.newText({
        text = "    O melhoramento genético tem sido amplamente utilizado para melhorar a produtividade de plantas e animais, além de ser aplicado em medicina e outras áreas. No entanto, como qualquer tecnologia, há uma série de discussões e debates sobre seus impactos. Vamos explorar os principais benefícios e controvérsias dessa prática. Vire a tela do dispositivo para os lados para destacar o texto de benefícios e controvérsias.",
        x = 341,
        y = 290,
        width = 641,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    description:setFillColor(0, 0, 0)
    scrollView:insert(description)

    local benefitsTitle = display.newText({
        text = "Benefícios:",
        x = 78,
        y = 400,
        font = "Inter",
        fontSize = 24,
        align = "left"
    })
    benefitsTitle:setFillColor(0, 0, 0)
    scrollView:insert(benefitsTitle)

    local AumentoDaProdutividadeTitle = display.newText({
        text = "Aumento da produtividade agrícola:",
        x = 152,
        y = 430,
        width = 290,
        font = "Inter",
        fontSize = 17,
        align = "left"
    })
    AumentoDaProdutividadeTitle:setFillColor(0, 0, 0)
    --AumentoDaProdutividadeTitle.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(AumentoDaProdutividadeTitle)

    local benefitsDescription = display.newText({
        text = " Exemplo: Plantas geneticamente modificadas para resistir a pragas e doenças reduzem a necessidade de pesticidas e aumentam o rendimento agrícola.",
        x = 150,
        y = 512,
        width = 250,
        font = "Inter",
        fontSize = 17,
        align = "left"
    })
    benefitsDescription:setFillColor(0, 0, 0)
    --benefitsDescription.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(benefitsDescription)

    local controversiesTitle = display.newText({
        text = "Controvérsias:",
        x = 391,
        y = 388,
        font = "Inter",
        fontSize = 24,
        align = "left"
    })
    controversiesTitle:setFillColor(0, 0, 0)
    scrollView:insert(controversiesTitle)

    local ImpactosAmbientaisTitle = display.newText({
        text = "Impactos ambientais:",
        x = 408,
        y = 420,
        font = "Inter-Bold",
        fontSize = 17,
        align = "left"
    })
    ImpactosAmbientaisTitle:setFillColor(0, 0, 0)
    --ImpactosAmbientaisTitle.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(ImpactosAmbientaisTitle)

    local controversiesDescription = display.newText({
        text = " Exemplo: Existe o temor de que organismos geneticamente modificados possam afetar o ecossistema, especialmente se essas mudanças genéticas forem transferidas para outras espécies por meio de polinização cruzada ou reprodução.",
        x = 454,
        y = 528,
        width = 250,
        font = "Inter",
        fontSize = 17,
        align = "left"
    })
    controversiesDescription:setFillColor(0, 0, 0)
    --controversiesDescription.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(controversiesDescription)

    local nutritionTitle = display.newText({
        text = "Melhoria nutricional:",
        x = 100,
        y = 606,
        font = "Inter-Bold",
        fontSize = 17,
        align = "left"
    })
    nutritionTitle:setFillColor(0, 0, 0)
    --nutritionTitle.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(nutritionTitle)

    local nutritionDescription = display.newText({
        text = "  Exemplo: Cientistas podem alterar as características de certos alimentos para torná-los mais nutritivos, como o 'arroz dourado', que foi modificado para conter mais vitamina A.",
        x = 140,
        y = 700,
        width = 234,
        font = "Inter",
        fontSize = 17,
        align = "left"
    })
    nutritionDescription:setFillColor(0, 0, 0)
    --nutritionDescription.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(nutritionDescription)

    local ethicsTitle = display.newText({
        text = "Ética no melhoramento genético humano:",
        x = 490,
        y = 645,
        font = "Inter-Bold",
        fontSize = 17,
        align = "left"
    })
    ethicsTitle:setFillColor(0, 0, 0)
    --ethicsTitle.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(ethicsTitle)

    local ethicsDescription = display.newText({
        text = "    Exemplo: A possibilidade de modificar geneticamente embriões humanos levanta questões éticas sobre o impacto na diversidade genética e a criação de 'bebês projetados' com características específicas.",
        x = 444,
        y = 744,
        width = 234,
        font = "Inter",
        fontSize = 17,
        align = "left"
    })
    ethicsDescription:setFillColor(0, 0, 0)
    --ethicsDescription.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(ethicsDescription)

    local diseaseResistanceTitle = display.newText({
        text = "Resistência a doenças:",
        x = 120,
        y = 803,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    diseaseResistanceTitle:setFillColor(0, 0, 0)
    --diseaseResistanceTitle.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(diseaseResistanceTitle)

    local diseaseResistanceDescription = display.newText({
        text = "    Exemplo: Animais podem ser geneticamente modificados para serem menos suscetíveis a certas doenças, diminuindo a necessidade de medicamentos e aumentando o bem-estar animal.",
        x = 140,
        y = 905,
        width = 234,
        font = "Inter",
        fontSize = 17,
        align = "left"
    })
    diseaseResistanceDescription:setFillColor(0, 0, 0)
    --diseaseResistanceDescription.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(diseaseResistanceDescription)

    local publicResistanceTitle = display.newText({
        text = "Resistência pública:",
        x = 421,
        y = 856,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    publicResistanceTitle:setFillColor(0, 0, 0)
    --publicResistanceTitle.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(publicResistanceTitle)

    local publicResistanceDescription = display.newText({
        text = "    Exemplo: Em muitas partes do mundo, há uma resistência significativa ao consumo de organismos geneticamente modificados, devido a preocupações sobre segurança alimentar.",
        x = 434,
        y = 946,
        width = 234,
        font = "Inter",
        fontSize = 17,
        align = "left"
    })
    publicResistanceDescription:setFillColor(0, 0, 0)
    --publicResistanceDescription.isVisible = false -- Não consegui fazer com que a flag mudasse usando o Shake do solar2d
    scrollView:insert(publicResistanceDescription)

    local line = display.newRect(display.contentCenterX - 90, 700, 2, 500) 
    line:setFillColor(0, 0, 0) 
    scrollView:insert(line)

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
            composer.gotoScene("page8") 
        end
    })
    scrollView:insert(backButton)

    local leftTextVisible = false
    local rightTextVisible = false

    local function onShake(event)
        local totalAcceleration = math.sqrt((event.xGravity * event.xGravity) + (event.yGravity * event.yGravity))
        local shakeThreshold = 5  

        if totalAcceleration > shakeThreshold then
            if not leftTextVisible then
                AumentoDaProdutividadeTitle.isVisible = true
                benefitsDescription.isVisible = true
                leftTextVisible = true
            else
                AumentoDaProdutividadeTitle.isVisible = false
                benefitsDescription.isVisible = false
                leftTextVisible = false
            end

            if not rightTextVisible then
                ImpactosAmbientaisTitle.isVisible = true
                controversiesDescription.isVisible = true
                rightTextVisible = true
            else
                ImpactosAmbientaisTitle.isVisible = false
                controversiesDescription.isVisible = false
                rightTextVisible = false
            end
        end
    end

    Runtime:addEventListener("accelerometer", onShake)


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
            composer.gotoScene("page10") 
        end
    })
    scrollView:insert(nextButton)
    narration = audio.loadStream("audio/Página9.wav")

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
