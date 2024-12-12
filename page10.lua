local composer = require("composer")
local widget = require("widget")
local audio = require("audio")
local scene = composer.newScene()
system.activate("multitouch")

local soundOn = true
local narration
local parabenAudio
local narrationTimer
local soundIcon
local wheatImage
local targetCircle
local genes = {}
local feedbackText
local insects = {}
local protectionCircle
local savedGenes = {}
local savedProtectionCircle
local savedInsects = {}

local function saveState()
    for i, gene in ipairs(genes) do
        if gene.isPlaced then
            table.insert(savedGenes, {
                x = gene.x,
                y = gene.y
            })
        end
    end

    if protectionCircle then
        savedProtectionCircle = {
            x = protectionCircle.x,
            y = protectionCircle.y,
            radius = protectionCircle.radius or 0  
        }
    end

    for i, insect in ipairs(insects) do
        table.insert(savedInsects, {
            x = insect.x,
            y = insect.y
        })
    end
end

local function restoreState()
    for i, gene in ipairs(savedGenes) do
        local restoredGene = display.newImageRect("images/gene.png", 10, 10)
        restoredGene.x = gene.x
        restoredGene.y = gene.y
        scrollView:insert(restoredGene)

        restoredGene.isPlaced = true
    end

    if savedProtectionCircle and savedProtectionCircle.radius then
        protectionCircle = display.newCircle(savedProtectionCircle.x, savedProtectionCircle.y, savedProtectionCircle.radius)
        protectionCircle:setStrokeColor(0, 1, 0)
        protectionCircle.strokeWidth = 5
        protectionCircle:setFillColor(0, 1, 0, 0.1)
        scrollView:insert(protectionCircle)
    end

    for i, insect in ipairs(savedInsects) do
        local restoredInsect = display.newImageRect("images/inseto.png", 40, 40)
        restoredInsect.x = insect.x
        restoredInsect.y = insect.y
        scrollView:insert(restoredInsect)
        table.insert(insects, restoredInsect)
    end
end

local function playNarrationWithDelay()
    if soundOn then
        audio.play(narration)
        narrationTimer = timer.performWithDelay(3000, playNarrationWithDelay)
    end
end

local function checkCompletion()
    local allPlaced = true
    for _, gene in ipairs(genes) do
        if not gene.isPlaced then
            allPlaced = false
            break
        end
    end

    if allPlaced then
        protectionCircle = display.newCircle(wheatImage.x, wheatImage.y, 200)
        protectionCircle:setStrokeColor(0, 1, 0)
        protectionCircle.strokeWidth = 5
        protectionCircle:setFillColor(0, 1, 0, 0.1)

        for _, insect in ipairs(insects) do
            local angle = math.atan2(insect.y - wheatImage.y, insect.x - wheatImage.x)
            local distance = math.random(150, 300)
            transition.to(insect, {
                x = wheatImage.x + math.cos(angle) * distance,
                y = wheatImage.y + math.sin(angle) * distance,
                time = 1000,
                transition = easing.outQuad
            })
        end

        feedbackText.text =
            "Parabéns! Você criou um organismo geneticamente melhorado e\nagora está protegido contra pragas."

        if soundOn then
            audio.play(narration, { onComplete = function()
                audio.play(parabenAudio)
            end })
        end
    end
end

local function createInsectsAroundPlant(scrollView)
    local minX = wheatImage.x - 300
    local maxX = wheatImage.x + 300
    local minY = wheatImage.y - 300
    local maxY = wheatImage.y + 300

    for i = 1, 5 do
        local insect = display.newImageRect("images/inseto.png", 40, 40)

        local insectX, insectY
        repeat
            insectX = math.random(minX, maxX)
            insectY = math.random(minY, maxY)
        until (math.sqrt((insectX - wheatImage.x) ^ 2 + (insectY - wheatImage.y) ^ 2) > 200)

        insect.x = insectX
        insect.y = insectY
        scrollView:insert(insect)
        table.insert(insects, insect)

        local function moveInsect()
            local randomX = math.random(-50, 50)
            local randomY = math.random(-50, 50)
            transition.to(insect, {
                x = insect.x + randomX,
                y = insect.y + randomY,
                time = math.random(1000, 2000),
                onComplete = moveInsect
            })
        end
        moveInsect()

        local function restrictInsectMovement()
            local distance = math.sqrt((insect.x - wheatImage.x) ^ 2 + (insect.y - wheatImage.y) ^ 2)
            if distance < 200 then
                local angle = math.atan2(insect.y - wheatImage.y, insect.x - wheatImage.x)
                local newX = wheatImage.x + math.cos(angle) * 200
                local newY = wheatImage.y + math.sin(angle) * 200
                transition.to(insect, {
                    x = newX,
                    y = newY,
                    time = 500,
                    transition = easing.outQuad
                })
            end
        end

        timer.performWithDelay(100, restrictInsectMovement, 0)
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

    -- Texto e elementos da interface
    local pageNumber = display.newText({
        text = "10",
        x = 26,
        y = 61,
        font = "Inter",
        fontSize = 16,
        align = "center"
    })
    pageNumber:setFillColor(0, 0, 0)
    scrollView:insert(pageNumber)

    local title = display.newText({
        text = "Conclusão",
        x = display.contentCenterX,
        y = 120,
        font = "Inter",
        fontSize = 24,
        align = "center"
    })
    title:setFillColor(0, 0, 0)
    scrollView:insert(title)

    local interactionText = display.newText({
        text = "Concluindo, entendemos que, com o melhoramento genético, é possível criar plantas mais fortes e adaptáveis, otimizando características como resistência a doenças, aumento da produtividade e tolerância a condições climáticas adversas. Agora, é sua vez de aplicar esses conceitos!",
        x = display.contentCenterX,
        y = 260,
        width = 600,
        font = "Inter",
        fontSize = 18,
        align = "center"
    })
    interactionText:setFillColor(0, 0, 0)
    scrollView:insert(interactionText)

    local description = display.newText({
        text = "Use o gesto de pinça para ampliar a área e arraste os ícones de genes melhorados para dentro do Trigo, O objetivo é melhorar o trigo através de melhoramento genético e criar um organismo mais resistente a pragas!",
        x = display.contentCenterX,
        y = 450,
        width = 600,
        font = "Inter",
        fontSize = 18,
        align = "center"
    })
    description:setFillColor(0, 0, 0)
    scrollView:insert(description)

    wheatImage = display.newImageRect("images/trigo.png", 400, 400)
    wheatImage.x = display.contentCenterX
    wheatImage.y = 700
    scrollView:insert(wheatImage)

    targetCircle = display.newCircle(wheatImage.x, wheatImage.y + 50, 30)
    targetCircle:setFillColor(0, 1, 0, 0.3)
    scrollView:insert(targetCircle)

    createInsectsAroundPlant(scrollView)

    local function pinchListener(event)
        if event.numTaps then
            return false
        end

        if event.phase == "began" then
            wheatImage.initialScaleX = wheatImage.xScale
            wheatImage.initialScaleY = wheatImage.yScale
        elseif event.phase == "moved" and event.scale then
            wheatImage.xScale = wheatImage.initialScaleX * event.scale
            wheatImage.yScale = wheatImage.initialScaleY * event.scale
        end
        return true
    end
    wheatImage:addEventListener("touch", pinchListener)

    local genePositions = {{
        x = targetCircle.x - 60,
        y = targetCircle.y - 60
    }, {
        x = targetCircle.x + 60,
        y = targetCircle.y - 60
    }, {
        x = targetCircle.x,
        y = targetCircle.y + 80
    }}

    for i, pos in ipairs(genePositions) do
        local gene = display.newImageRect("images/gene.png", 10, 10)
        gene.x = pos.x
        gene.y = pos.y
        scrollView:insert(gene)

        local function dragGene(event)
            if event.phase == "began" then
                display.currentStage:setFocus(gene)
                gene.isFocus = true
                gene.offsetX = event.x - gene.x
                gene.offsetY = event.y - gene.y
            elseif event.phase == "moved" and gene.isFocus then
                gene.x = event.x - gene.offsetX
                gene.y = event.y - gene.offsetY
            elseif event.phase == "ended" or event.phase == "cancelled" then
                if gene.isFocus then
                    display.currentStage:setFocus(nil)
                    gene.isFocus = false

                    if math.abs(gene.x - targetCircle.x) < 20 and math.abs(gene.y - targetCircle.y) < 20 then
                        gene.x = targetCircle.x
                        gene.y = targetCircle.y
                        gene.isPlaced = true
                        checkCompletion()
                    end
                end
            end
            return true
        end

        gene:addEventListener("touch", dragGene)
        genes[#genes + 1] = gene
    end

    feedbackText = display.newText({
        text = "",
        x = display.contentCenterX,
        y = 915,
        font = "Inter",
        fontSize = 20,
        align = "center"
    })
    feedbackText:setFillColor(0, 0, 0)
    scrollView:insert(feedbackText)

    local backButton = widget.newButton({
        label = "Voltar",
        width = 74,
        height = 32,
        x = 296 + (74 / 2),
        y = 1000,
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
    scrollView:insert(backButton)

    local nextButton = widget.newButton({
        label = "Próximo",
        width = 88,
        height = 32,
        x = 408 + (88 / 2),
        y = 1000,
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
            composer.gotoScene("contraCapa")
        end
    })
    scrollView:insert(nextButton)

    local function toggleSound()
        soundOn = not soundOn
        if soundOn then
            soundIcon.fill = {
                type = "image",
                filename = "images/ComponentSound.png"
            }
            playNarrationWithDelay()
        else
            soundIcon.fill = {
                type = "image",
                filename = "images/ComponentSoundMute.png"
            }
            if narrationTimer then
                timer.cancel(narrationTimer)
            end
            audio.stop()
        end
    end

    soundIcon = display.newRect(display.contentWidth - 60, 110, 40, 40)
    soundIcon.fill = {
        type = "image",
        filename = "images/ComponentSound.png"
    }
    soundIcon:addEventListener("tap", toggleSound)
    sceneGroup:insert(soundIcon)

    narration = audio.loadStream("audio/Página10.wav")
    parabenAudio = audio.loadStream("audio/Parabens.wav")
end

function scene:show(event)
    if event.phase == "did" then
        restoreState()

        audio.stop()
        if soundOn then
            audio.rewind(narration)
            playNarrationWithDelay()
        end

        if not wheatImage then
            wheatImage = display.newImageRect("images/trigo.png", 400, 400)
            wheatImage.x = display.contentCenterX
            wheatImage.y = 700
            scrollView:insert(wheatImage)
        end

        if #genes == 0 then
        end
    end
end

function scene:hide(event)
    if event.phase == "will" then
        saveState()

        if narrationTimer then
            timer.cancel(narrationTimer)
        end
        audio.stop()

        if protectionCircle then
            protectionCircle:removeSelf()
            protectionCircle = nil
        end

        for _, insect in ipairs(insects) do
            insect:removeSelf()
        end
        insects = {}

        for _, gene in ipairs(genes) do
            gene:removeSelf()
        end
        genes = {}

        if feedbackText then
            feedbackText.text = ""
        end
    end
end

function scene:destroy(event)
    if narration then
        audio.dispose(narration)
        narration = nil
    end
    if parabenAudio then
        audio.dispose(parabenAudio)
        parabenAudio = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
