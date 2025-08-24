local Abilities = {}
local enabled = false

local abilityKeys = {Enum.KeyCode.One, Enum.KeyCode.Two} -- кнопки умений

function Abilities.toggle(state)
    enabled = state
    if enabled then
        print("Auto Abilities ON")
        task.spawn(function()
            while enabled do
                for _,key in ipairs(abilityKeys) do
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendKeyEvent(true, key, false, game)
                    task.wait(0.1)
                    vim:SendKeyEvent(false, key, false, game)
                    task.wait(0.2)
                end
                task.wait(5) -- задержка (кд)
            end
        end)
    else
        print("Auto Abilities OFF")
    end
end

return Abilities
