local Gui = {}
local UserInputService = game:GetService("UserInputService")

local function getSafeParent()
    local coreGui = game:FindFirstChildOfClass("CoreGui") or game.CoreGui
    -- syn.protect_gui (Synapse/etc)
    if syn and syn.protect_gui then
        local sg = Instance.new("ScreenGui")
        syn.protect_gui(sg)
        sg.Name = "ClickGui"
        sg.Parent = coreGui
        return sg
    end
    -- gethui (some executors expose gethui)
    local ok, ui = pcall(function()
        if gethui then return gethui() end
    end)
    if ok and ui then return ui end
    -- Fallback
    local sg = Instance.new("ScreenGui")
    sg.Name = "ClickGui"
    sg.Parent = coreGui
    return sg
end

local ScreenGui = getSafeParent()

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Visible = true -- keep visible for testing
Frame.Parent = ScreenGui

function Gui.init(config)
    -- Toggle menu
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == config.toggleKey then
            Frame.Visible = not Frame.Visible
        end
    end)

    -- Buttons
    local y = 10
    for _, feature in ipairs(config.features or {}) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 180, 0, 30)
        btn.Position = UDim2.new(0, 10, 0, y)
        btn.Text = feature.name or "Feature"
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Parent = Frame

        local enabled = false
        btn.MouseButton1Click:Connect(function()
            enabled = not enabled
            btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            if feature.func then
                local ok, err = pcall(feature.func, enabled)
                if not ok then warn("[GUI] Feature error:", err) end
            end
        end)

        y = y + 40
    end
end

return Gui