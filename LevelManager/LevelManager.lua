--------------------------------------------------------------------------------------------------
-- Class    : ParentGate
-- Author   : Peter Dwyer
-- Created  : ${date}
-- 
-- Parent gate overlay. Causes the user to have to answer a question before acessing the links 
-- on the info pages 
------------------------------------------------------------------------------------------------- 
local class = {}

-- Import all necessary requires.

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
    _p = _p or {};
    setmetatable( _p, self );
    
    self.__index = self;

    return _p
end 


return class

