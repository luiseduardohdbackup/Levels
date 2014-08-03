--------------------------------------------------------------------------------------------------
-- Class    : Class
-- Author   : Peter Dwyer
-- Created  : ${date}
-- 
-- Class to do something
------------------------------------------------------------------------------------------------- 
local class = {}

-- Import all necessary requires.
local levelIcon = require("Level.LevelIcon")

-- Forward Declarations


-- local vars



------------------------------------------------------------------------------------
-- New
-- 
-- Create a new instance of this class
------------------------------------------------------------------------------------
--@Param: _p inheritance using metatables
--@Param: argTable table of any additional arguments we want to pass to this class. 
--@Returns: new instance.
------------------------------------------------------------------------------------
function class:new( _p, argTable )
    _p = _p or {}
    setmetatable( _p, self )
    
    self.__index = self
    
    -- Current level score
    self.score = argTable.score
    
    -- Status of stars
    self.star1 = { anim = argTable.star1, starStatus=argTable.star1Status }
    self.star1Threshold = argTable.star1Threshold
    
    self.star2 = { anim = argTable.star2, starStatus=argTable.star2Status }
    self.star2Threshold = argTable.star2Threshold
    
    self.star3 = { anim = argTable.star3, starStatus=argTable.star3Status }
    self.star3Threshold = argTable.star3Threshold
    
    -- Lock status for the level
    self.locked = argTable.locked
    
    -- next level after this one 
    self.nextLevel = argTable.nextLevel
    
    -- Unlocking criteria. Can be either a score or stars or previous levels or all of these
    self.requiredScore = argTable.requiredScore
    self.requiredLevels = argTable.requiredLevels
    self.requiredStars = argTable.requiredStars
    
    -- Icon for this level
    local args = 
    {
        star1 = self.star1;
        star2 = self.star2;
        star3 = self.star3;
    
        score = self.score;
        lockStatus = self.locked;
        
        iconConfig = argTable.iconConfig
    }
    
    self:prepareLevelIcon( args )

    return _p
end 

------------------------------------------------------------------------------------
-- prepareLevelIcon
-- 
-- create and setup the icon for this level. We do this when the level is created 
-- because the level state is restored from the games save data each time the game is 
-- started.  
------------------------------------------------------------------------------------
--@Param: argTable table of setup parameters for the icon i.e state of the stars. 
--@Returns: 
------------------------------------------------------------------------------------
function class:prepareLevelIcon( argTable )
    self.levelIcon =  levelIcon:new( nil, argTable )
end

------------------------------------------------------------------------------------
-- update
-- 
-- Update the level with new information based on the current gamestate i.e when the 
-- user has completed the current level. Update the score or number of stars etc. 
-- etc. Note that we only update if things have changed for the better i.e. we do 
-- not register a lower score if the player has already. Similarly we don't remove 
-- already won stars. In this was a player trying for that elusive third star
-- does not risk loosing the stars s/he already has.
------------------------------------------------------------------------------------
--@Param: argTable  table of updated parameters for the state of the level. 
--@Param: volatile  set this flag if you want the current user scores, stars etc. to 
--                  override the stored values. 
--@Returns: 
------------------------------------------------------------------------------------
function class:update( argTable, volatile )
    
    if not volatile then
        -- Update current level score if higher than previous level score
        if self.score <  argTable.score then
            self.score = argTable.score
        end
        
        -- Only add new stars.
        if self.star1.starStatus == 0 and argTable.star1.starStatus == 1 then
            self.star1.starStatus = argTable.star1.starStatus
        end

        if self.star1.starStatus == 0 and argTable.star1.starStatus == 1 then
            self.star1.starStatus = argTable.star1.starStatus
        end

        if self.star1.starStatus == 0 and argTable.star1.starStatus == 1 then
            self.star1.starStatus = argTable.star1.starStatus
        end
        
        -- Unlock the level but, never re-lock it unless the user resets all the data (which is not controlled here)
        if self.lock ~= "off" and argTable.lock == "off" then
            self.lock = argTable.lock
        end
    else
        -- This level data is volatile so everything can change even re-locking the level!
        -- As such we don't bother to validate any of the data. You broke it! You bought it!
        
        -- Set status of stars
        self.star1 = argTable.star1
        self.star2 = argTable.star2
        self.star3 = argTable.star3

        -- Lock status for the level
        self.locked = argTable.locked
    end
    
    -- update the icons for this level. They will animate again.
    self.levelIcon.setStars( self.star1, self.star2, self.star3 )
    self.levelIcon.setLock( self.lock )
end

return class