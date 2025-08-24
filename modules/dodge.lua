local Dodge = {}
local enabled = false
local humanoid

function Dodge.toggle(state)
    enabled = state
    if enabled then
        print("Auto Dodge ON")
        local player = game.Players.LocalPlayer
        humanoid = player.Character:WaitForChild("Humanoid")
        humanoid.HealthChanged:Connect(function(hp)
            if enabled and hp < 100 then
                local vim = game:GetService("VirtualInputManager")
                vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                task.wait(0.1)
                vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end
        end)
    else
        print("Auto Dodge OFF")
    end
end

return Dodge
