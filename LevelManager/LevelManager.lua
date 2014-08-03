--------------------------------------------------------------------------------------------------
-- Class    : Level Manager
-- Author   : Peter Dwyer
-- Created  : ${date}
-- 
-- Creates a grid of levels that the user can choose from and manages those levels based on the 
-- score or some other criteria. 
------------------------------------------------------------------------------------------------- 
local class = {}

-- Import all necessary requires.

-- Forward Declarations

-- local vars
local levelgrid = display.newGroup();

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
    _p = _p or {};
    setmetatable( _p, self );
    
    self.__index = self;

    return _p
end 

------------------------------------------------------------------------------------
-- initialise
-- 
-- initialise the level manager based on the config file
------------------------------------------------------------------------------------
--@Param: config the configuration file to use
--@Returns: nil
------------------------------------------------------------------------------------
function class:initalise()
    -- create all levels 
    
    -- display levels in scroll grid
    
    -- add event listeners
end

------------------------------------------------------------------------------------
-- onLevelSelected
-- 
-- Handle the uiser clicking on a level
------------------------------------------------------------------------------------
--@Param: event the event to handle 
--@Returns: nil.
------------------------------------------------------------------------------------
function class:onLevelSelected( event )  
    -- launch level as overlay
end

return class