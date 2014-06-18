--------------------------------------------------------------------------------------------------
-- Class    : Level Icon
-- Author   : Peter Dwyer
-- Created  : ${date}
-- 
-- The icon displayed for a level on the level select screen. 
-- Each individual part of the icon is a sprite and so can be individually 
-- animated
------------------------------------------------------------------------------------------------- 
local class = {};

-- Import all necessary requires.
local json = require("json");
local analytics = require("analytics");

-- Forward Declarations

-- local vars

-- Icon sprite sheets and sprite frame/animation data 
local lockData = nil;
local iconData = nil;
local starData = nil;
local iconSpriteSheet = nil;
local starSpriteSheet = nil;
local lockSpriteSheet = nil;
 

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

    -- Initialise the level status
    self.star1 = argTable.star1;
    self.star2 = argTable.star2;
    self.star3 = argTable.star3;
    
    self.score = argTable.score;
    self.locked = argTable.lockStatus;
    
    self.star1Sprite = nil;     -- Star 1
    self.star2Sprite = nil;     -- Star 2
    self.star3Sprite = nil;     -- Star 3
    self.lockSprite = nil;      -- Lock
    self.iconSprite = nil;      -- Icon background
    
    self.icon = nil;             -- Display group of the icon
    
    data = system.pathForFile( "config.json", system.ResourceDirectory );
        
    local fileHandle = io.open("config.json", "r");
    local  configData = fileHandle:read("*a");
    io.close( fileHandle );
        
    self.configData = json.decode( data );
    
    return _p;
end 

------------------------------------------------------------------------------------
-- Draw
-- 
-- Display the icon using the inital settings to determine how to draw each element 
------------------------------------------------------------------------------------
--@Param: _p inheritance using metatables
--@Param: argTable table of any additional arguments we want to pass to this class. 
--@Returns: new instance.
------------------------------------------------------------------------------------
function class:Draw()
    iconData = require( "IconData" );
    starData = require( "StarData" );
    lockData = require( "LockData" );
    
    iconSpriteSheet = graphics.newImageSheet("IconSprite.png", "LevelManager", iconData.getSheet());
    starSpriteSheet = graphics.newImageSheet("StarSprite.png", "LevelManager", starData.getSheet());
    lockSpriteSheet = graphics.newImageSheet("LockSprite.png", "LevelManager", lockData.getSheet());
    
    self.icon = display.newGroup( );
    self.icon:insert( self.iconSprite );
    
    -- Set the stars to on or off depending on the level status
    self.iconSprite = display.newSprite( iconSpriteSheet, starData.sequenceData() );
    self.star1Sprite = display.newSprite( starSpriteSheet, starData.sequenceData() );
    self.star2Sprite = display.newSprite( starSpriteSheet, starData.sequenceData() );
    self.star3Sprite = display.newSprite( starSpriteSheet, starData.sequenceData() );
    
    self.star1Sprite:setSequence(self.star1);
    self.star1Sprite:play();
    
    self.star2Sprite:setSequence(self.star2);
    self.star2Sprite:play();
    
    self.star3Sprite:setSequence(self.star3);
    self.star3Sprite:play();
   
    self.icon:insert( self.star1Sprite );
    self.icon:insert( self.star2Sprite );
    self.icon:insert( self.star3Sprite );
    
    -- If this level is locked then display the lock icon
    if self.locked then
        self.lockSprite =  display.newSprite( lockSpriteSheet, starData.sequenceData() );
        self.lockSprite:setSequence("locked");
        self.lockSprite:play();
        
        self.icon:insert( self.lockSprite );
    end
    
    self:layout( );
end

------------------------------------------------------------------------------------
-- layout
-- 
-- Layout the icon based on the information in the icon configuration file. The 
-- file contains infomration about the following 
-- relative (x,y) position of star
-- relative (x,y) position of the lock  
------------------------------------------------------------------------------------
--@Param: levelIcon reference to this icon
--@Returns:
------------------------------------------------------------------------------------
function class:layout( )
    -- position the stars within the icon
    self.star1Sprite.x = self.configData.star1.x;
    self.star1Sprite.y = self.configData.star1.y;
    self.star2Sprite.x = self.configData.star2.x;
    self.star2Sprite.y = self.configData.star2.y;
    self.star3Sprite.x = self.configData.star3.x;
    self.star3Sprite.y = self.configData.star3.y;
    
    -- If the icon is locked and it has a valid sprite then position the lock image
    if self.locked and self.lockSprite ~= nil then
        self.lockSprite.x = self.configData.lock.x;
        self.lockSprite.y = self.configData.lock.y;
    end
end

------------------------------------------------------------------------------------
-- setStars
-- 
-- Set the state of the stars. Note that this method allows for individual stars
-- to be activated or deactivated so that the player can potentially win stars 2 and 
-- 3 while missing out on star 1. This is significant for some games where stars are 
-- individually won based on different criteria and not just a score ladder. 
------------------------------------------------------------------------------------
--@Param: star1 star 1 setting
--@Param: star2 star 2 setting
--@Param: star3 star 3 setting 
--@Returns:
------------------------------------------------------------------------------------
function class:setStars( star1, star2, star3 )
    self.star1Sprite:setSequence( star1 );
    self.star1Sprite:play();
    
    self.star2Sprite:setSequence( star2 );
    self.star2Sprite:play();
    
    self.star3Sprite:setSequence( star3 );
    self.star3Sprite:play();
    
    -- Update the stored states of the stars
    self.star1 = star1;
    self.star2 = star2;
    self.star3 = star3;   
end

------------------------------------------------------------------------------------
-- setLock
-- 
-- Activate or deactivate the level lock icon.  
------------------------------------------------------------------------------------
--@Param: star1 star 1 setting
--@Param: star2 star 2 setting
--@Param: star3 star 3 setting 
--@Returns:
------------------------------------------------------------------------------------
function class:setLock( lock )
    self.lock = lock;
    self.lockSprite.setSequence( self.lock );
    self.lockSprite:play();
end


return class