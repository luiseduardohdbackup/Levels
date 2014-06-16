-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local composer = require("composer")
local json = require ( "json" )
local analytics = require("analytics")

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
-- registerDevice
-- 
-- Register this device with the push service.
------------------------------------------------------------------------------------
--@Param: deviceToken The device ID used by the push server to register a unique user
--@Returns:
------------------------------------------------------------------------------------
local function registerDevice(deviceToken)  
        local headers = {}
        headers["X-netmera-api-key"] = APIKEY
        headers["Content-Type"] = "application/json"
 
 
        commands_json =
            {
             ["registrationId"] = deviceToken,
             ["platform"] = "ANDROID",
             ["tags"] = {"tag1", "tag2"},                
            }        
 
        postData = json.encode(commands_json)
        print("postData: " .. postData)
        data = ""
        local params = {}
        params.headers = headers
        params.body = postData
        network.request( "http://api.netmera.com/push/1.1/registration" ,"POST", NetworkListener,  params)
end
 
------------------------------------------------------------------------------------
-- onNotification
-- 
-- Initiate the game. display the animated main menu.
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
local function onNotification( event )    
    if event.type == "remoteRegistration" then        
        registerDevice(event.token)    
    elseif event.type == "remote" then    
        -- The code below will only trigger if the app is alive and kicking
        -- *************************************************************************    
        -- native.showAlert( "remote", json.encode( event ), { "OK" } )    
        --[[ notification table contains:    
        launchArgs.notification.type - "remote"    
        launchArgs.notification.name - "notification"    
        launchArgs.notification.sound - "sound file or 'default'"    
        launchArgs.notification.alert - "message specified during push"    
        launchArgs.notification.badge - "5" -- badge value that was sent    
        launchArgs.notification.applicationstate - "inactive"    --]]   
        if event.custom and event.custom["link"] then
            urlPath = event.custom["link"]
        end
        
        native.showAlert( "Hello!", event.alert, { "OK", "CANCEL" }, onComplete )   
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

-- play the intro movie.
media.playVideo( "Ladybird.mp4", false, onIntroComplete )
