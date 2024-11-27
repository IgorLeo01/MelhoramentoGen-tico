local composer = require("composer")
local widget = require("widget")

local scene = composer.newScene()

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
        text = "6",
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
            soundIcon.fill = {
                type = "image",
                filename = "images/ComponentSound.png"
            }
        else
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
        text = "Engenharia Genética e CRISPR",
        x = display.contentCenterX - 80,
        y = 123,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    title:setFillColor(0, 0, 0)
    scrollView:insert(title)

   
    local paragraph1 = display.newText({
        text = "    A engenharia genética é uma área da ciência que envolve a modificação direta dos genes de um organismo, permitindo que cientistas alterem suas características genéticas de maneira precisa e controlada. Essa manipulação pode ser feita para melhorar determinadas características, como aumentar a resistência a doenças ou alterar o crescimento de uma planta. Na agricultura, por exemplo, isso pode significar a criação de plantas que produzem maiores quantidades de alimento, ou até mesmo que resistam a pragas e climas adversos.",
        x = display.contentCenterX,
        y = 300,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph1:setFillColor(0, 0, 0)
    scrollView:insert(paragraph1)

    
    local paragraph2 = display.newText({
        text = "    normalmente envolve a inserção, remoção ou substituição de segmentos específicos de DNA dentro do genoma de um organismo. O DNA (ácido desoxirribonucleico) é a molécula que contém as informações genéticas que determinam as características de um organismo. Ao alterar partes específicas do DNA, os cientistas podem influenciar diretamente como essas características se expressam.",
        x = display.contentCenterX,
        y = 510,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph2:setFillColor(0, 0, 0)
    scrollView:insert(paragraph2)

    
    local paragraph3 = display.newText({
        text = "    Um exemplo prático disso é na agricultura, uma planta geneticamente modificada pode ser criada para ser mais resistente a pragas. Ao inserir genes que conferem resistência a certos insetos, a planta pode crescer sem a necessidade de pesticidas químicos.",
        x = display.contentCenterX,
        y = 650,
        width = 690,
        font = "Inter",
        fontSize = 20,
        align = "left"
    })
    paragraph3:setFillColor(0, 0, 0)
    scrollView:insert(paragraph3)

    
    local subtitle = display.newText({
        text = "CRISPR: A Revolução da Engenharia Genética",
        x = display.contentCenterX,
        y = 750,
        width = 754,
        font = "Inter",
        fontSize = 32,
        align = "center"
    })
    subtitle:setFillColor(0, 0, 0)
    scrollView:insert(subtitle)

    
    local paragraph4 = display.newText({
        text = "    Uma das maiores inovações em engenharia genética nos últimos anos foi o desenvolvimento da técnica chamada CRISPR-Cas9. Essa ferramenta revolucionou a biotecnologia ao permitir que cientistas editem o DNA de forma extremamente precisa e eficiente. O CRISPR funciona como uma espécie de tesoura molecular, que pode cortar o DNA em pontos específicos, permitindo que genes sejam removidos, adicionados ou alterados",
        x = display.contentCenterX,
        y = 890,
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
            composer.gotoScene("page5")
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
            composer.gotoScene("page7")
        end
    })
    scrollView:insert(nextButton)
end

scene:addEventListener("create", scene)

return scene
