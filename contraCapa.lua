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
        backgroundColor = { 0.075, 0.22, 0.1 }, 
        horizontalScrollDisabled = true,
    })
    sceneGroup:insert(scrollView) 

   
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
end

scene:addEventListener("create", scene)

return scene
