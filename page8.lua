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
        text = "8",
        x = 26,
        y = 61,
        font = "Inter",
        fontSize = 16,
        align = "center"
    })
    pageNumber:setFillColor(0, 0, 0)
    scrollView:insert(pageNumber)

    local dna = display.newImageRect("images/DNA.png", 600, 900) 
    dna.x = display.contentCenterX - 150
    dna.y = display.contentCenterY
    scrollView:insert(dna)

    local instructions = display.newText({
        text = "Com a técnica de CRISPR é possível cortar e conectar outros pedaços dos genes ao DNA, tente conectá-los colidindo os pedaços para a fita de DNA nos locais indicados para encaixá-los.",
        x = display.contentCenterX + 150,
        y = display.contentCenterY - 230,
        width = 350,
        font = "Inter",
        fontSize = 30,
        align = "center"
    })
    instructions:setFillColor(0, 0, 0)
    scrollView:insert(instructions)

    local slots = {{
        x = dna.x + 25,
        y = dna.y - 43,
        width = 90,
        height = 6,
        color = {19 / 255, 56 / 255, 26 / 255},
        rotation = 5 
    }, {
        x = dna.x + 30,
        y = dna.y + 13,
        width = 90,
        height = 6,
        color = {253 / 255, 193 / 255, 58 / 255},
        rotation = -6 
    }, {
        x = dna.x - 30,
        y = dna.y + 44,
        width = 90,
        height = 8,
        color = {155 / 255, 224 / 255, 200 / 255},
        rotation = -9 
    }}

    local dnaPieces = {}

    local function shineEffect(piece)
        transition.to(piece, {
            time = 200, 
            xScale = 1.2, 
            yScale = 1.2,
            alpha = 0.8,  
            onComplete = function()
                transition.to(piece, {
                    time = 200,
                    xScale = 1,
                    yScale = 1,
                    alpha = 1
                })
            end
        })
    end

    for i, slot in ipairs(slots) do
        
        local slotRect = display.newRect(slot.x, slot.y, slot.width, slot.height)
        slotRect:setFillColor(slot.color[1], slot.color[2], slot.color[3])
        slotRect.alpha = 0.2
        slotRect.rotation = slot.rotation
        scrollView:insert(slotRect)

        
        local piece = display.newRect(display.contentCenterX + 150, 
        display.contentCenterY - 50 + (i * 50), 
        slot.width, slot.height)
        piece:setFillColor(slot.color[1], slot.color[2], slot.color[3])
        piece.rotation = slot.rotation
        scrollView:insert(piece)

        dnaPieces[#dnaPieces + 1] = {
            piece = piece,
            slot = slotRect
        }

        local function dragPiece(event)
            local target = event.target
            if event.phase == "began" then
                display.currentStage:setFocus(target)
                target.isFocus = true
                target.offsetX = event.x - target.x
                target.offsetY = event.y - target.y
            elseif event.phase == "moved" and target.isFocus then
                target.x = event.x - target.offsetX
                target.y = event.y - target.offsetY
            elseif event.phase == "ended" or event.phase == "cancelled" then
                if target.isFocus then
                    display.currentStage:setFocus(nil)
                    target.isFocus = false

                    if math.abs(target.x - slotRect.x) < 15 and math.abs(target.y - slotRect.y) < 15 then
                        target.x = slotRect.x
                        target.y = slotRect.y
                        target.isLocked = true
                        shineEffect(target)
                    end
                end
            end
            return true
        end

        piece:addEventListener("touch", dragPiece)
    end

    local arrowInferior = display.newImageRect("images/ArrowInferior.png", 100, 100) 
    arrowInferior.x = slots[1].x + 200 
    arrowInferior.y = slots[1].y + 170 
    arrowInferior.rotation = -10 
    scrollView:insert(arrowInferior)

    local arrowSuperior = display.newImageRect("images/ArrowSuperior.png", 100, 100) 
    arrowSuperior.x = slots[2].x + 200 
    arrowSuperior.y = slots[2].y - 60 
    arrowSuperior.rotation = 15 
    scrollView:insert(arrowSuperior)

    local backButton = widget.newButton({
        label = "Voltar",
        width = 74,
        height = 32,
        x = 296 + (74 / 2),
        y = 950,
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
    scrollView:insert(backButton)

    local nextButton = widget.newButton({
        label = "Próximo",
        width = 88,
        height = 32,
        x = 408 + (88 / 2),
        y = 950,
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
            composer.gotoScene("page9") 
        end
    })
    scrollView:insert(nextButton)
    narration = audio.loadStream("audio/pagina8.wav")

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
