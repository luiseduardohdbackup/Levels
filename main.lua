-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Setup default states for the device
display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "magTextureFilter", "nearest" )
display.setDefault( "minTextureFilter", "nearest" )
system.activate("multitouch")

-- required includes go here --
local mte = require("mte").createMTE()
local composer = require("composer")
local analytics = require("analytics")

-- forward declarations go here --

-- local variables go here --
local movement = nil

-- Attach this instance of mte to the composer
composer.mte = mte

-- Register for flurry analytics
analytics.init("5WJZ2FQXDJH66MD6H6GR")

-- load menu screen
function onIntroComplete( event )
    storyboard.gotoScene( "menu" )
end


-- Here is the implementation of Push Notification in Corona SDK
local launchArgs = ...
local APIKEY = "ZGoweEpuVTlOVEk0TXpVMU5EWmxOR0l3TjJFMk5HVTJZamd6WWpFNUptRTljR1ZsYTJGaWIyOHRjMkZ0YzNWdVp5WQ=="

------------------------------------------------------------------------------------
-- Initialise Game
-- 
-- Initiate the game. display the animated main menu.
------------------------------------------------------------------------------------
--@Param: 
--@Returns:
------------------------------------------------------------------------------------
local function onComplete( event )
    if event.action == "clicked" then
        local i = event.index

        if i == 1 then
            system.openURL(urlPath);        
        elseif i == 2 then
            
        end
    end
      
    return true
 end
 
----------------- Grab Launch arguments --------------------------
if launchArgs and launchArgs.notification then
    if (launchArgs.notification.custom.link) then
        urlPath = launchArgs.notification.custom.link;
        native.showAlert( "Hello!", launchArgs.notification.alert, { "OK", "CANCEL" }, onComplete )          
    elseif (launchArgs.notification.custom["link"]) then
        urlPath = launchArgs.notification.custom["link"];
        native.showAlert( "Hello!", launchArgs.notification.alert, { "OK", "CANCEL" }, onComplete )   
    end
end

------------------------------------------------------------------------------------
-- NetworkListener
-- 
-- Network listener for checking push notifications
------------------------------------------------------------------------------------
--@Param: 
--@Returns:
------------------------------------------------------------------------------------
local function NetworkListener( event )    
    if ( event.isError ) then        
        --native.showAlert( "Network error!", "Error has occured from Netmera", {"OK"})    
    else        
        --native.showAlert( "Netmera", event.response, {"OK"})    
    end
end

 
------------------------------------------------------------------------------------
-- onNotification
-- 
-- Diosplay the push notification.
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
local function onNotification( event )
    if event.type == "remoteRegistration" then
        local PushToken = event.token
        local PW_APPLICATION = "PUHSOOWH_APPLICATION_ID"    -- use your app id in pushwoosh
        local PW_URL = "https://cp.pushwoosh.com/json/1.3/registerDevice"
        local deviceType = 1 -- default to iOS
        
        if ( system.getInfo("platformName") == "Android" ) then
            deviceType = 3
        end
 
        local commands_json =
        {
             ["request"] = {
                ["application"] = PW_APPLICATION,
                ["push_token"] = PushToken,
                ["language"] = system.getPreference("ui", "language"),
                ["hwid"] = system.getInfo("deviceID"),
                ["timezone"] = 3600, -- offset in seconds
                ["device_type"] = deviceType
            }
        }

        local jsonvar = {}
        jsonvar = json.encode(commands_json)

        local post = jsonvar 
        local headers = {} 
        headers["Content-Type"] = "application/json"
        headers["Accept-Language"] = "en-US"
        
        local params = {}
        params.headers = headers
        params.body = post 
        
        network.request ( PW_URL, "POST", networkListener, params )
    end
end


------------------------------------------------------------------------------------
-- onAlertComplete
-- 
-- Fired when the push alert is recieved and processing is completed
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
local function onAlertComplete( event )
        return true
end

-- Add a runtime event listener to listen for push notifications
Runtime:addEventListener( "notification", onNotification )

------------------------------------------------------------------------------------
-- onIntroComplete
-- 
-- Fired when the intro movie has finished displaying
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
local function onIntroComplete( event )
    composer.purgeOnSceneChange = true;
    composer.gotoScene( "menu" )
end

-- seed the random generator
math.randomseed(os.time());

-- play the splash movie.
media.playVideo( "splash.mp4", false, onIntroComplete )
