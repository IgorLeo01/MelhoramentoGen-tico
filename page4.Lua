local composer = require("composer")
local widget = require("widget")

local scene = composer.newScene()

local soundOn = true

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
        text = "4",
        x = 26,
        y = 61,
        font = native.systemFontBold,
        fontSize = 16,
        align = "center"
    })
    pageNumber:setFillColor(0, 0, 0)
    scrollView:insert(pageNumber)

    local soundIcon = display.newRect(display.contentWidth - 60, 60, 40, 40)
    soundIcon.fill = {
        type = "image",
        filename = "images/ComponentSound.png"
    }
    sceneGroup:insert(soundIcon)

    local function toggleSound()
        soundOn = not soundOn
        if soundOn then
            print("Som ativado!")
            soundIcon.fill = {
                type = "image",
                filename = "images/ComponentSound.png"
            }
        else
            print("Som desativado!")
            soundIcon.fill = {
                type = "image",
                filename = "images/ComponentSoundMute.png"
            }
        end
    end

    soundIcon:addEventListener("tap", toggleSound)

    local topLeafIcon = display.newImageRect("images/FolhaSuperior.png", 136, 165)
    topLeafIcon.x = 530 + (136 / 2) 
    topLeafIcon.y = 1 + (165 / 2) 
    scrollView:insert(topLeafIcon)

    local title = display.newText({
        text = "Cruzamento",
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
        text = "    Cruzamento Dihíbrido:  é um tipo de cruzamento genético que envolve o estudo simultâneo de duas características diferentes, em contraste com o cruzamento monohíbrido, que examina apenas uma característica. No cruzamento dihíbrido, ambos os progenitores diferem em duas características, e os descendentes resultantes têm combinações variadas dessas duas características, com base nas leis de segregação e assortimento independente de Gregor Mendel Temos como exemplo cruzar plantas que diferem em cor e altura para observar como as combinações se expressam na próxima geração.",
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
        y = 570,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph2:setFillColor(0, 0, 0)
    scrollView:insert(paragraph2)

    local subtitle = display.newText({
        text = "Hibridização",
        x = display.contentCenterX,
        y = 690,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    subtitle:setFillColor(0, 0, 0)
    scrollView:insert(subtitle)

    local paragraph3 = display.newText({
        text = "    Agora falaremos da Hibridização, que vai um passo além do cruzamento tradicional, permitindo a união de indivíduos de diferentes espécies ou variedades. Esse processo é crucial para obter híbridos que possuem características exclusivas, resultantes da combinação de espécies distintas.",
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
        text = "    Tipos de Hibridização:\n\nHibridização Intraespecífica: Ocorre fazendo a junção entre duas variedades da mesma espécie, temos como exemplo hibridização entre diferentes variedades de arroz para aumentar a tolerância à seca.",
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
        y = 1200,
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
            composer.gotoScene("page3") 
        end
    })
    scrollView:insert(backButton)

    
    local nextButton = widget.newButton({
        label = "Próximo",
        width = 88,
        height = 32,
        x = 408 + (88 / 2),
        y = 1200,
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
            composer.gotoScene("page5") 
        end
    })
    scrollView:insert(nextButton)
end

scene:addEventListener("create", scene)

return scene
