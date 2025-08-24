-- Загружаем модули
local Gui = loadfile("modules/gui.lua")()
local Dodge = loadfile("modules/dodge.lua")()
local Abilities = loadfile("modules/abilities.lua")()

-- Запуск GUI
Gui.init({
    toggleKey = Enum.KeyCode.RightControl, -- открытие меню
    features = {
        {name = "Auto Dodge", func = Dodge.toggle},
        {name = "Auto Abilities", func = Abilities.toggle},
    }
})