local composer = require("composer")
local analytics = require("analytics")

local scene = composer.newScene()

-- input controller commands and listeners
local inputDevices = system.getInputDevices()
local controllers = {}

-- local forward references should go here --
local startGame = nil;
local gameOver = nil;
local movePlayer = nil;
local moveRats = nil;
local spawnBonus = nil;
local consumeCrumbs = nil;
local activatePowerUp = nil;

-- local variables
local levelMusic = nil;
local chewSound = nil;
local dieSound = nil;
local mouseDieSound = nil;

local currentScore = 0;     -- Players current score for this plathrough
local hiScore = 0;          -- Hi score for the game.

local remainingLives = 0;   -- Lives remaining for this playthrough
local remainingCrumbs = 0;  -- Crumbs remaining until maze is cleared
local extraBonus = false;   -- Collect all letters to get a bonus life.

local 

---------------------------------------------------------------------------------
-- BEGINNING OF IMPLEMENTATION
---------------------------------------------------------------------------------

function onKeyEvent( event )
end

function onInputdeviceStatusChanged( event ) 
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
    local sceneGroup = self.view
    
    -- check which devices we have (if any)
    for deviceIndex = 1, #inputDevices do
        print( deviceIndex, "canVibrate", inputDevices[deviceIndex].canVibrate )
        print( deviceIndex, "connectionState", inputDevices[deviceIndex].connectionState )
        print( deviceIndex, "descriptor", inputDevices[deviceIndex].descriptor )
        print( deviceIndex, "displayName", inputDevices[deviceIndex].displayName )
        print( deviceIndex, "isConnected", inputDevices[deviceIndex].isConnected )
        print( deviceIndex, "type", inputDevices[deviceIndex].type )
        print( deviceIndex, "permenantid", tostring(inputDevices[deviceIndex].permanentId) )
        print( deviceIndex, "andoridDeviceid", inputDevices[deviceIndex].androidDeviceId ) 
        
        if inputDevices[deviceIndex].descriptor == "Joystick 1" then
            controllers[1] = inputDevices[deviceIndex]
        elseif inputDevices[deviceIndex].descriptor == "Joystick 2" then
            controllers[2] = inputDevices[deviceIndex]
        elseif inputDevices[deviceIndex].descriptor == "Joystick 3" then
            controllers[3] = inputDevices[deviceIndex]
        elseif inputDevices[deviceIndex].descriptor == "Joystick 4" then
            controllers[4] = inputDevices[deviceIndex]
        end    
    end
    
    -- Setup Million tile Engine
    composer.mte.toggleWorldWrapX(true)
    composer.mte.toggleWorldWrapY(true)
    
    -- load audio and sprites
    levelMusic = audio.loadSound( "Audio/Duke Ellington - Three Blind Mice.mp3" );
    chewSound = audio.loadSound( "Audio/chew.mp3" );
    dieSound = audio.loadSound( "Audio/rat_die.mp3" );
    mouseDieSound = audio.loadsound( "Audio/mouse_squeak.mp3" )
    
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

    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params

    if ( phase == "will" ) then
       -- Load the correct level map
       composer.mte.loadMap( params.level )
       
       -- position the player and the enemies
       
    elseif ( phase == "did" ) then
      
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

   local sceneGroup = self.view
   local phase = event.phase

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

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------
-- END OF IMPLEMENTATION
---------------------------------------------------------------------------------

-- "create" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )

-- "show" event is dispatched before scene transition begins
scene:addEventListener( "show", scene )

-- "hide" event is dispatched whenever scene transition has finished
scene:addEventListener( "hide", scene )

-- "destroy" event is dispatched before view is unloaded.
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

Runtime:addEventListener( "key", onKeyEvent )
Runtime:addEventListener( "inputDevicestatus", onInputdeviceStatusChanged )

return scene


