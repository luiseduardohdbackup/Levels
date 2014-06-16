-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local widget = require "widget"
local composer = require( "composer" )

local scene = composer.newScene()
 

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

    -- Initialize the scene here.
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

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
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

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------
Runtime:addEventListener("enterFrame", onFrame)

return scene