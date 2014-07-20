-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local widget = require ("widget");
local composer = require( "composer" );
local analytics = require( "analytics" );
local levelManager = require("LevelManager.LevelManager")

local scene = composer.newScene();

-- Load menu sprite data
local menuData = require("menuSpriteData");

-- input controller commands and listeners
local inputDevices = system.getInputDevices();
local controllers = {};

-- local forward references should go here --
local onInfoReleased = nil;
local onOptionReleased = nil;
local onPlayReleased = nil;
local onContinueReleased = nil;
local animateMenu = nil;
local checkControllers = nil;

local mouseSquishSound = audio.loadSound( "Audio/mouse_squeak.mp3" );
-- local ambientMusic = audio.loadSound("Audio/Duke Ellington - Three Blind Mice.mp3");

---------------------------------------------------------------------------------
-- BEGINNING OF IMPLEMENTATION
---------------------------------------------------------------------------------

function onKeyEvent( event )
    
end

function onInputdeviceStatusChanged( event )
    
end

------------------------------------------------------------------------------------
-- checkControllers
-- 
-- Start a new game. 
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
checkControllers = function()
     -- check which devices we have (if any)
    for deviceIndex = 1, #inputDevices do
        print( deviceIndex, "canVibrate", inputDevices[deviceIndex].canVibrate );
        print( deviceIndex, "connectionState", inputDevices[deviceIndex].connectionState );
        print( deviceIndex, "descriptor", inputDevices[deviceIndex].descriptor );
        print( deviceIndex, "displayName", inputDevices[deviceIndex].displayName );
        print( deviceIndex, "isConnected", inputDevices[deviceIndex].isConnected );
        print( deviceIndex, "type", inputDevices[deviceIndex].type );
        print( deviceIndex, "permenantid", tostring(inputDevices[deviceIndex].permanentId) );
        print( deviceIndex, "andoridDeviceid", inputDevices[deviceIndex].androidDeviceId );
        
        if inputDevices[deviceIndex].descriptor == "Joystick 1" then
            controllers[1] = inputDevices[deviceIndex];
        elseif inputDevices[deviceIndex].descriptor == "Joystick 2" then
            controllers[2] = inputDevices[deviceIndex];
        elseif inputDevices[deviceIndex].descriptor == "Joystick 3" then
            controllers[3] = inputDevices[deviceIndex];
        elseif inputDevices[deviceIndex].descriptor == "Joystick 4" then
            controllers[4] = inputDevices[deviceIndex];
        end    
    end
end

------------------------------------------------------------------------------------
-- onPlayReleased
-- 
-- Start a new game. 
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
onPlayReleased = function( event )
    if event.phase == "pressed" then
        audio.play( mouseSquishSound )
    elseif event.phase == "release" then
        composer.gotoScene( "LevelManager\LevelManagerScene" )
    end
end

------------------------------------------------------------------------------------
-- onContinueReleased
-- 
-- Continue with a previously suspended game
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
onContinueReleased = function( event )
    if event.phase == "pressed" then
        audio.play( mouseSquishSound )
    elseif event.phase == "release" then
        composer.gotoScene( "Game" )
    end    
end

------------------------------------------------------------------------------------
-- onInfoReleased
-- 
-- Show the instructions and information screen 
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
onInfoReleased = function( event )
    if event.phase == "pressed" then
        audio.play( mouseSquishSound )
    elseif event.phase == "release" then
        composer.gotoScene( "Information" )
    end    
end

------------------------------------------------------------------------------------
-- onOptionReleased
-- 
-- Bring up the game options when the options button is pressed and released
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
onOptionReleased = function( event )
    if event.phase == "pressed" then
        audio.play( mouseSquishSound )
    elseif event.phase == "release" then
        composer.gotoScene( "Options" )
    end    
end


------------------------------------------------------------------------------------
-- create
-- 
-- Create the scene. This is where all of the post processing should occur.
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
function scene:create( event )
    local sceneGroup = self.view;
end


------------------------------------------------------------------------------------
-- show
-- 
-- show the scene. This method has two phases "will" and "did". The will phase 
-- occurs before the scene has moved on screen while the did phase occurs after the
-- scene has moved on screen.
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
function scene:show( event )

   local sceneGroup = self.view;
   local phase = event.phase;

   if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        checkControllers()
        
        -- Display the main menu background image
        local background = display.newImageRect( "mainMenuBackground.png", "Menu");
        background.x =  (display.contentWidth / 2) - ( background.width / 2 );

        -- get te sprites for the menu
        local menuSpriteSheet = graphics.newImageSheet("menuSprites", "Menu", menuData.getSheet());

        -- Load all menu buttons
        local playButton = widget.newButton
        {
            sheet = menuSpriteSheet,
            defaultFrame = menuData.getFrame( "PlayButton" ),
            overFrame = menuData.getFrame( "PlayButtonOver" ),
            width = 300,
            height = 300,
            onEvent = onPlayReleased,
        }

        local continueButton = widget.newButton
        {
            sheet = menuSpriteSheet,
            defaultFrame = menuData.getFrame( "ContinueButton" ),
            overFrame = menuData.getFrame( "ContinueButtonOver" ),
            width = 300,
            height = 300,
            onEvent = onContinueReleased
        }

        local optionButton = widget.newButton
        {
            sheet = menuSpriteSheet,
            defaultFrame = menuData.getFrame( "OptionButton" ),
            overFrame = menuData.getFrame( "OptionButtonOver" ),
            width = 300,
            height = 300,
            onEvent = onOptionReleased
        }

        local infoButton = widget.newButton
        {
            sheet = menuSpriteSheet,
            defaultFrame = menuData.getFrame( "InfoButton" ),
            overFrame = menuData.getFrame( "InfoButtonOver" ),
            width = 300,
            height = 300,
            onEvent = onInfoReleased
        }

        -- positon menu items


        -- add menu items to view
        sceneGroup:insert( playButton );
        sceneGroup:insert( continueButton );
        sceneGroup:insert( optionButton );
        sceneGroup:insert( infoButton );
        
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Add the dynamic animations to the menu to give it some pop.
      animateMenu();
   end
end


------------------------------------------------------------------------------------
-- hide
-- 
-- Hide the scene i.e. when changing from one scene to the next. There are two 
-- phases for this method. the will phase that occurs when before the scene is 
-- hidden and the did phase that occus after the scene is hidden 
------------------------------------------------------------------------------------
--@Param: even
--@Returns:
------------------------------------------------------------------------------------
function scene:hide( event )

   local sceneGroup = self.view;
   local phase = event.phase;

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end


------------------------------------------------------------------------------------
-- destroy
-- 
-- Destroy the scene. This is where all tidy-up code should live such as tidying up 
-- any timers or event listeners. 
------------------------------------------------------------------------------------
--@Param: event
--@Returns:
------------------------------------------------------------------------------------
function scene:destroy( event )

   local sceneGroup = self.view;

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------
-- END OF IMPLEMENTATION
---------------------------------------------------------------------------------

-- "create" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene );

-- "show" event is dispatched before scene transition begins
scene:addEventListener( "show", scene );

-- "hide" event is dispatched whenever scene transition has finished
scene:addEventListener( "hide", scene );

-- "destroy" event is dispatched before view is unloaded.
scene:addEventListener( "destroy", scene );

---------------------------------------------------------------------------------

Runtime:addEventListener( "key", onKeyEvent );
Runtime:addEventListener( "inputDevicestatus", onInputdeviceStatusChanged );

return scene;
