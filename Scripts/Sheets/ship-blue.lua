--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:b863bdf82f29f8146708df3878009266:53ddcb61fd224e4da50450589037431b:f4a3e0f8a3414d5964b81f64d74761d3$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {

        {
            -- a_ship2C_01
            x=133,
            y=54,
            width=35,
            height=51,

        },
        {
            -- a_ship2C_02
            x=90,
            y=54,
            width=41,
            height=51,

        },
        {
            -- a_ship2C_03
            x=43,
            y=74,
            width=45,
            height=50,

        },
        {
            -- a_ship2C_04
            x=38,
            y=1,
            width=46,
            height=51,

        },
        {
            -- a_ship2D_01
            x=86,
            y=1,
            width=45,
            height=51,

        },
        {
            -- a_ship2D_02
            x=133,
            y=1,
            width=41,
            height=51,

        },
        {
            -- a_ship2D_03
            x=170,
            y=54,
            width=35,
            height=51,

        },
        {
            -- a_ship2D_04
            x=176,
            y=1,
            width=31,
            height=51,

        },
        {
            -- bullet02_lv1_01
            x=38,
            y=54,
            width=17,
            height=18,

        },
        {
            -- bullet02_lv2_01
            x=24,
            y=85,
            width=17,
            height=21,

        },
        {
            -- bullet02_lv3_01
            x=1,
            y=85,
            width=21,
            height=25,

        },
        {
            -- Mobile - Storm Strikers - FA-220_15
            x=1,
            y=1,
            width=35,
            height=82,

        },
    },

    sheetContentWidth = 208,
    sheetContentHeight = 125
}

SheetInfo.frameIndex =
{

    ["a_ship2C_01"] = 1,
    ["a_ship2C_02"] = 2,
    ["a_ship2C_03"] = 3,
    ["a_ship2C_04"] = 4,
    ["a_ship2D_01"] = 5,
    ["a_ship2D_02"] = 6,
    ["a_ship2D_03"] = 7,
    ["a_ship2D_04"] = 8,
    ["bullet02_lv1_01"] = 9,
    ["bullet02_lv2_01"] = 10,
    ["bullet02_lv3_01"] = 11,
    ["Mobile - Storm Strikers - FA-220_15"] = 12,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
