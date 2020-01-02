.nds
CustomStuffRegion equ 0x21DA340
Offset equ CustomStuffRegion-DefaultCustomDataStart

.open "arm9.bin",0x02000000

; Edit this value to match with your ARM9.bin file length! 
; The value is set for a PAL arm9.bin decompressed using EFE by Gericom
DefaultCustomDataStart equ 0x21773C0

.thumb
; Put thumb replacement instructions here!
.arm
; Put arm replacement instructions here!

; Regenerate autoload tables, make sure not to remove this.
AutoloadTableGeneration:
.org 0x2000B4C
    dcd 0x2000E00
    dcd 0x2000E24

.org 0x200F01C
    dcd CustomStuffRegion+LengthOfTheFile-ExtraDataStartingPosition

.org 0x2000E00
    dcd 0x1FF8000
    dcd 0x7FA0
    dcd 0x0
    dcd 0x27E0000
    dcd 0xE0
    dcd 0x0
    dcd CustomStuffRegion
    .area 4,0
        dcd 0x0+LengthOfTheFile-ExtraDataStartingPosition
    .endarea
.close

; Adding new content at the end of the ARM9.bin
.open "arm9.bin",0x02000000+Offset
.skip DefaultCustomDataStart-0x2000000

ExtraDataStartingPosition:
; Put your new dcds over here! 
; Make sure to refer to them from the replacements in .thumb and .arm
; Also, due to the way Autoload tables are generated, a minimal length of this section
; needs to be at least 0x20 bytes. But you will easily exceed that, I'm sure of this!
LengthOfTheFile:
.close