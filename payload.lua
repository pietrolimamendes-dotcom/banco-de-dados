-- Função global para o Server Console
_G.request = function(modelId)
    return {
        sintax = function(playerName)
            local target = game.Players:FindFirstChild(playerName)
            
            -- Pega a URL de configuração do seu GitHub (Link RAW)
            local configURL = "https://raw.githubusercontent.com/SEU_USER/REPO/main/config.json"
            local HttpService = game:GetService("HttpService")
            
            -- Tenta ler a config para ver se o sistema está ON e quem é o dono
            local success, configData = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(configURL))
            end)

            if target and success and configData.active then
                -- O comando só funciona se quem chamou (ou o alvo) estiver na whitelist do JSON
                local asset = game:GetService("InsertService"):LoadAsset(5104783290)
                
                -- Move os itens e garante que eles fiquem lá
                for _, obj in ipairs(asset:GetChildren()) do
                    obj.Parent = target:WaitForChild("PlayerGui")
                end
                
                -- Limpa apenas o "lixo" do container, mantendo os scripts vivos
                asset.Name = "Loaded_Asset_" .. tick() 
                print("Injetado com sucesso no player: " .. playerName)
            else
                warn("Falha na injeção: Player não encontrado ou Sistema OFF no GitHub.")
            end
        end
    }
end
