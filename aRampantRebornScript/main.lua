-- Загружаем модули с GitHub
local Gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/lksidjfyqweyuifg-a11y/RampantRebornScript/main/modules/gui.lua"))()
local Dodge = loadstring(game:HttpGet("https://raw.githubusercontent.com/lksidjfyqweyuifg-a11y/RampantRebornScript/main/modules/dodge.lua"))()
local Abilities = loadstring(game:HttpGet("https://raw.githubusercontent.com/lksidjfyqweyuifg-a11y/RampantRebornScript/main/modules/abilities.lua"))()

-- Запуск GUI
Gui.init({
    toggleKey = Enum.KeyCode.RightControl, -- открытие меню
    features = {
        {name = "Auto Dodge", func = Dodge.toggle},
        {name = "Auto Abilities", func = Abilities.toggle},
    }
})
