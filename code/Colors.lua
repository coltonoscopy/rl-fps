--[[
    Color RGB tables for the Dawnbringer palette, for procedural coloration
    and drawing.
]]

gColors = {}

function makeColor(name, r, g, b)
    gColors[name] = {
        ['r'] = r, ['g'] = g, ['b'] = b
    }
end

makeColor('black', 0x00, 0x00, 0x00)
makeColor('black_purple', 0x22, 0x20, 0x34)
makeColor('dark_purple', 0x45, 0x28, 0x3c)
makeColor('purple', 0x66, 0x39, 0x31)
makeColor('brown', 0x8f, 0x56, 0x3b)
makeColor('light_brown', 0xdf, 0x71, 0x26)
makeColor('orange', 0xd9, 0xa0, 0x66)
makeColor('dark_tan', 0xee, 0xc3, 0x9a)
makeColor('tan', 0xfb, 0xf2, 0x36)
makeColor('yellow', 0x99, 0xe5, 0x50)
makeColor('lime', 0x6a, 0xbe, 0x30)
makeColor('green', 0x37, 0x94, 0x6e)
makeColor('teal', 0x4b, 0x69, 0x2f)
makeColor('dark_green', 0x52, 0x4b, 0x24)
makeColor('dark_brown', 0x32, 0x3c, 0x39)
makeColor('dark_green_brown', 0x3f, 0x3f, 0x74)
makeColor('dark_vivid_purple', 0x30, 0x60, 0x82)
makeColor('dark_steel', 0x5b, 0x6e, 0xe1)
makeColor('dark_aqua', 0x63, 0x9b, 0xff)
makeColor('aqua', 0x5f, 0xcd, 0xe4)
makeColor('light_steel', 0xcb, 0xdb, 0xfc)
makeColor('white', 0xff, 0xff, 0xff)
makeColor('gray', 0x9b, 0xad, 0xb7)
makeColor('red_gray', 0x84, 0x7e, 0x87)
makeColor('brown_gray', 0x69, 0x6a, 0x6a)
makeColor('dark_brown_gray', 0x59, 0x56, 0x52)
makeColor('bright_purple', 0x76, 0x42, 0x8a)
makeColor('red', 0xac, 0x32, 0x32)
makeColor('light_red', 0xd9, 0x57, 0x63)
makeColor('pink', 0xd7, 0x7b, 0xba)
makeColor('brown_green', 0x8f, 0x97, 0x4a)
makeColor('bright_brown', 0x8a, 0x6f, 0x30)
