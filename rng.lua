memory.usememorydomain("IWRAM")

local rn0_address = 0x0000  -- first rn
local rn1_address = 0x0002  -- 1 behind first rn
local rn2_address = 0x0004  -- 2 behind first rn

local function next_rn(r1, r2, r3)
    return ((r1 >> 5)
         ~ ((r2 << 11) & 0xFFFF)
         ~ ((r3 << 1)  & 0xFFFF)
         ~ (r2 >> 15)) % 65536
end

while true do
    local rn0 = memory.read_u16_le(rn0_address) -- 16 bit value
    local rn1 = memory.read_u16_le(rn1_address)
    local rn2 = memory.read_u16_le(rn2_address)
    local a = rn0
    local b = rn1
    local c = rn2

    for i = 1, 10 do
        local nxt = next_rn(a, b, c)
        gui.text(10, 0 + i * 15, math.floor(nxt / 655)) -- division by 655 converts to proper 0-100 integer

        c = b
        b = a
        a = nxt
    end

    emu.frameadvance()
end
