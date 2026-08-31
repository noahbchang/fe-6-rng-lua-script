memory.usememorydomain("IWRAM")

while true do
    local rn0 = memory.read_u16_le(0x0000) -- First locally generated RN
    local rn1 = memory.read_u16_le(0x0002) -- 1 rn behind rn0
    local rn2 = memory.read_u16_le(0x0004) -- 2 rns behind rn0
    gui.text(10, 10, rn / 655)
    emu.frameadvance()
end
