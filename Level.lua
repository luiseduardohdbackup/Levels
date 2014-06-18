--------------------------------------------------------------------------------------------------
-- Class    : Class
-- Author   : Peter Dwyer
-- Created  : ${date}
-- 
-- Class to do something
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
    _p = _p or {}
    setmetatable( _p, self )
    
    self.__index = self

    self.gateFailure= nil
    self.gateSuccess = nil
    
    return _p
end 


return class