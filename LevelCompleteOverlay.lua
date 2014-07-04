local composer = require("composer")
local analytics = require("analytics")

local scene = composer.newScene()

-- input controller commands and listeners
local inputDevices = system.getInputDevices()
local controllers = {}

-- local forward references should go here --


-- variables
local score = 0;
local best = 0;
local levelScore = 0;
local bonusLetters = nil;

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
   local parent = event.parent;

   if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        score = parent:getScore();
        levelScore = parent:getLevelScore();
        best = parent:getBestScore();
        bonusLetters = parent:getBonusLetters();
   elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        
   end
end


------------------------------------------------------------------------------------
-- hide
-- 
-- Hide the scene i.e. when changing from one scene to the next. There are two 
-- phases for this method. The "will" phase that occurs before the scene is 
-- hidden and the "did" phase occus after the scene is hidden. 
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


