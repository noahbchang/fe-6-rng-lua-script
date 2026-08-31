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
    local rn_list = {}

    for i = 1, 10 do
        local nxt = next_rn(a, b, c)
        gui.text(10, 10 + i * 15, math.floor(nxt / 655)) -- division by 655 converts to proper 0-100 integer
        rn_list[i] = math.floor(nxt / 655)
        c = b
        b = a
        a = nxt
    end

    for i = 0, 2 do
        local true_hit_rn = (rn_list[3 * i + 1] + rn_list[3 * i + 2]) / 2
        local crit = rn_list[3 * i + 3]
        gui.text(50, 25 + i * 30, "True hit RN: " .. true_hit_rn)
        gui.text(50, 40 + i * 30, "Crit RN: " .. crit)
    end 

    emu.frameadvance()
end
