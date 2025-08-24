-- Bootstrap + safe module loader
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
while not Players.LocalPlayer do task.wait(0.05) end

local function safeLoad(url, name)
    print("[Loader] Fetching", name, url)
    local okGet, src = pcall(function()
        return game:HttpGet(url)
    end)
    if not okGet then
        warn("[Loader] HttpGet failed for " .. tostring(name) .. ": " .. tostring(src))
        return nil
    end
    local okLoad, modOrErr = pcall(function()
        return loadstring(src)()
    end)
    if not okLoad then
        warn("[Loader] loadstring failed for " .. tostring(name) .. ": " .. tostring(modOrErr))
        return nil
    end
    print("[Loader] Loaded", name)
    return modOrErr
end

-- Load modules from GitHub Raw
local base = "https://raw.githubusercontent.com/lksidjfyqweyuifg-a11y/RampantRebornScript/main/modules/"
local Gui       = safeLoad(base .. "gui.lua",       "gui")
local Dodge     = safeLoad(base .. "dodge.lua",     "dodge")
local Abilities = safeLoad(base .. "abilities.lua", "abilities")

if not (Gui and Dodge and Abilities) then
    warn("[Loader] One or more modules failed to load. Aborting init.")
    return
end

print("[Loader] Initializing GUI...")
Gui.init({
    toggleKey = Enum.KeyCode.RightControl,
    features = {
        { name = "Auto Dodge",     func = Dodge.toggle     },
        { name = "Auto Abilities", func = Abilities.toggle },
    }
})
print("[Loader] GUI initialized. Press RightCtrl to toggle.")