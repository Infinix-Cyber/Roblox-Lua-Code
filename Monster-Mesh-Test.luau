local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

-- Подключаем слушатель чата для активации чита
localPlayer.Chatted:Connect(function(message)
    -- Проверяем секретную команду активации (экранируем дефис)
    if string.find(message, "-# .inv%-ColaFrame") then
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local backpack = localPlayer:FindFirstChild("Backpack")
        
        -- Убеждаемся, что персонаж, хуманоид и рюкзак загружены
        if character and humanoid and backpack then
            -- Ищем Bloxy Cola в рюкзаке или уже в руках
            local colaTool = backpack:FindFirstChild("Bloxy Cola") or character:FindFirstChild("Bloxy Cola")
            
            if colaTool then
                -- Если кола в рюкзаке, автоматически берем её в руки
                if colaTool.Parent == backpack then
                    humanoid:EquipTool(colaTool)
                    task.wait(0.1) -- Небольшая задержка для завершения анимации экипировки
                end
                
                local handle = colaTool:WaitForChild("Handle")
                local colaMesh = handle:FindFirstChildOfClass("SpecialMesh")
                
                if colaMesh then
                    -- Сканируем персонажа в поисках аксессуара Monster Energy на талии
                    for _, accessory in ipairs(character:GetChildren()) do
                        if accessory:IsA("Accessory") and accessory:FindFirstChild("Handle") then
                            local accessoryMesh = accessory.Handle:FindFirstChildOfClass("SpecialMesh")
                            
                            -- Проверяем ID меша аксессуара Монстра
                            if accessoryMesh and string.find(accessoryMesh.MeshId, "81909348262833") then
                                -- Главная магия: переносим форму и текстуру Монстра на колу
                                colaMesh.MeshId = accessoryMesh.MeshId
                                colaMesh.TextureId = accessoryMesh.TextureId
                                
                                -- Удаляем оригинальный аксессуар с талии, так как он теперь в руке
                                accessory:Destroy()
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)
