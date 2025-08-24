local Gui = {}
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ClickGui"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Visible = true
Frame.Parent = ScreenGui

function Gui.init(config)
    -- Открытие/закрытие меню
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == config.toggleKey then
            Frame.Visible = not Frame.Visible
        end
    end)

    -- Кнопки
    local y = 10
    for _,feature in ipairs(config.features) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 180, 0, 30)
        btn.Position = UDim2.new(0, 10, 0, y)
        btn.Text = feature.name
        btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = Frame

        local enabled = false
        btn.MouseButton1Click:Connect(function()
            enabled = not enabled
            btn.BackgroundColor3 = enabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
            feature.func(enabled)
        end)

        y = y + 40
    end
end

return Gui
