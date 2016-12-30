#include <sys/fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#if 0

#define height 240
#define width  256

#define kb (1 << 10)
#define mb (1 << 20)

#define io_union(name, bits)    \
    union {                     \
        struct {                \
            bits;               \
        } v;                    \
                                \
        uint8_t raw;            \
    } name

#define reg_union(r1, r2, r2t)  \
    union {                     \
        struct {                \
            r2t r2;             \
            uint8_t r1;         \
        } v;                    \
                                \
        uint16_t raw;           \
    } r1 ## r2                  \

#define reg_union_8(r1, r2) reg_union(r1, r2, uint8_t)

uint32_t screen[height * width] = {0};

#define color_white 0xFFFFFFFF
#define color_lgray 0xFFAAAAAA
#define color_dgray 0xFF555555
#define color_black 0xFF000000

static uint8_t nintendo_logo[0x30] = {
    0xCE, 0xED, 0x66, 0x66, 0xCC, 0x0D, 0x00, 0x0B, 0x03, 0x73, 0x00, 0x83, 0x00, 0x0C, 0x00, 0x0D,
    0x00, 0x08, 0x11, 0x1F, 0x88, 0x89, 0x00, 0x0E, 0xDC, 0xCC, 0x6E, 0xE6, 0xDD, 0xDD, 0xD9, 0x99,
    0xBB, 0xBB, 0x67, 0x63, 0x6E, 0x0E, 0xEC, 0xCC, 0xDD, 0xDC, 0x99, 0x9F, 0xBB, 0xB9, 0x33, 0x3E
};

static uint8_t gb_bootrom[0x100] = {
    0x31, 0xFE, 0xFF, 0xAF, 0x21, 0xFF, 0x9F, 0x32,
    0xCB, 0x7C, 0x20, 0xFB, 0x21, 0x26, 0xFF, 0x0E,
    0x11, 0x3E, 0x80, 0x32, 0xE2, 0x0C, 0x3E, 0xF3,
    0xE2, 0x32, 0x3E, 0x77, 0x77, 0x3E, 0xFC, 0xE0,
    0x47, 0x11, 0x04, 0x01, 0x21, 0x10, 0x80, 0x1A,
    0xCD, 0x95, 0x00, 0xCD, 0x96, 0x00, 0x13, 0x7B,
    0xFE, 0x34, 0x20, 0xF3, 0x11, 0xD8, 0x00, 0x06,
    0x08, 0x1A, 0x13, 0x22, 0x23, 0x05, 0x20, 0xF9,
    0x3E, 0x19, 0xEA, 0x10, 0x99, 0x21, 0x2F, 0x99,
    0x0E, 0x0C, 0x3D, 0x28, 0x08, 0x32, 0x0D, 0x20,
    0xF9, 0x2E, 0x0F, 0x18, 0xF3, 0x67, 0x3E, 0x64,
    0x57, 0xE0, 0x42, 0x3E, 0x91, 0xE0, 0x40, 0x04,
    0x1E, 0x02, 0x0E, 0x0C, 0xF0, 0x44, 0xFE, 0x90,
    0x20, 0xFA, 0x0D, 0x20, 0xF7, 0x1D, 0x20, 0xF2,
    0x0E, 0x13, 0x24, 0x7C, 0x1E, 0x83, 0xFE, 0x62,
    0x28, 0x06, 0x1E, 0xC1, 0xFE, 0x64, 0x20, 0x06,
    0x7B, 0xE2, 0x0C, 0x3E, 0x87, 0xE2, 0xF0, 0x42,
    0x90, 0xE0, 0x42, 0x15, 0x20, 0xD2, 0x05, 0x20,
    0x4F, 0x16, 0x20, 0x18, 0xCB, 0x4F, 0x06, 0x04,
    0xC5, 0xCB, 0x11, 0x17, 0xC1, 0xCB, 0x11, 0x17,
    0x05, 0x20, 0xF5, 0x22, 0x23, 0x22, 0x23, 0xC9,
    0xCE, 0xED, 0x66, 0x66, 0xCC, 0x0D, 0x00, 0x0B,
    0x03, 0x73, 0x00, 0x83, 0x00, 0x0C, 0x00, 0x0D,
    0x00, 0x08, 0x11, 0x1F, 0x88, 0x89, 0x00, 0x0E,
    0xDC, 0xCC, 0x6E, 0xE6, 0xDD, 0xDD, 0xD9, 0x99,
    0xBB, 0xBB, 0x67, 0x63, 0x6E, 0x0E, 0xEC, 0xCC,
    0xDD, 0xDC, 0x99, 0x9F, 0xBB, 0xB9, 0x33, 0x3E,
    0x3C, 0x42, 0xB9, 0xA5, 0xB9, 0xA5, 0x42, 0x3C,
    0x21, 0x04, 0x01, 0x11, 0xA8, 0x00, 0x1A, 0x13,
    0xBE, 0x20, 0xFE, 0x23, 0x7D, 0xFE, 0x34, 0x20,
    0xF5, 0x06, 0x19, 0x78, 0x86, 0x23, 0x05, 0x20,
    0xFB, 0x86, 0x20, 0xFE, 0x3E, 0x01, 0xE0, 0x50
};

struct gbstate {
    struct cpustate {
        reg_union(A, F, struct {
            uint8_t zero:4;
            uint8_t C:1;
            uint8_t H:1;
            uint8_t N:1;
            uint8_t Z:1;
        });

        reg_union_8(B, C);
        reg_union_8(D, E);
        reg_union_8(H, L);

        uint16_t PC;
        uint16_t SP;

        struct {
            uint8_t IME:1;
        } ext;
    } cpu;

    struct memstate {
        uint8_t bootrom[0x100];
        uint8_t vram[8 * kb];
        uint8_t wram_0[4 * kb];
        uint8_t wram_1[4 * kb];

        union {
            struct {
                uint8_t ypos;
                uint8_t xpos;
                uint8_t tileid;

                struct {
                    uint8_t priority:1;
                    uint8_t yflip:1;
                    uint8_t xflip:1;
                    uint8_t paletteid:1;
                    uint8_t unused:4;
                } attrib;
            } table[40];

            uint8_t raw[0x100];
        } oam;

        union {
            struct gbio {
                io_union(FF00_RW_JOYP,
                         uint8_t unused:2;
                         uint8_t P15:1;
                         uint8_t P14:1;
                         uint8_t P13:1;
                         uint8_t P12:1;
                         uint8_t P11:1;
                         uint8_t P10:1);

                uint8_t FF01_RW_SB;

                io_union(FF02_RW_SC,
                         uint8_t transfer_start:1;
                         uint8_t unused:6;
                         uint8_t shift_clock:1);

                uint8_t FF03;
                uint8_t FF04_RW_DIV;
                uint8_t FF05_RW_TIMA;
                uint8_t FF06_RW_TMA;

                io_union(FF07_RW_TAC,
                         uint8_t unused:5;
                         uint8_t timer_stop:1;
                         uint8_t clock_select:2);

                uint8_t FF08_FF0E[7];

                io_union(FF0F_RW_IF,
                         uint8_t unused:3;
                         uint8_t joypad:1;
                         uint8_t serial:1;
                         uint8_t timer:1;
                         uint8_t lcdstat:1;
                         uint8_t vblank:1);

                io_union(FF10_RW_NR10,
                         uint8_t unused:1;
                         uint8_t sweep_time:3;
                         uint8_t sweep_action:1;
                         uint8_t sweep_count:3);

                io_union(FF11_RW_NR11,
                         uint8_t wave_pattern:2;
                         uint8_t sound_length:6);

                io_union(FF12_RW_NR12,
                         uint8_t initial_volume:4;
                         uint8_t direction:1;
                         uint8_t sweep_count:3);

                uint8_t FF13_W_NR13;

                io_union(FF14_RW_NR14,
                         uint8_t WO_initial:1;
                         uint8_t counter:1;
                         uint8_t WO_freq3:3);

                uint8_t FF15;

                io_union(FF16_RW_NR21,
                         uint8_t wave_duty:2;
                         uint8_t WO_sound_length:6);

                io_union(FF17_RW_NR22,
                         uint8_t initial_volume:4;
                         uint8_t direction:1;
                         uint8_t sweep_count:3);

                uint8_t FF18_W_NR23;

                io_union(FF19_RW_NR24,
                         uint8_t WO_initial:1;
                         uint8_t counter:1;
                         uint8_t WO_freq3:3);

                io_union(FF1A_RW_NR30,
                         uint8_t channel_enabled:1;
                         uint8_t unused:7);

                uint8_t FF1B_RW_NR31;

                io_union(FF1C_RW_NR32,
                         uint8_t hi0:1;
                         uint8_t output_level:2;
                         uint8_t unused:5);

                uint8_t FF1D_W_NR33;

                io_union(FF1E_RW_NR34,
                         uint8_t WO_initial:1;
                         uint8_t counter:1;
                         uint8_t WO_freq3:3);

                uint8_t FF1F;

                io_union(FF20_RW_NR41,
                         uint8_t hi0:1;
                         uint8_t output_level:2;
                         uint8_t unused:5);

                io_union(FF21_RW_NR42,
                         uint8_t initial_volume:4;
                         uint8_t direction:1;
                         uint8_t sweep_count:3);

                io_union(FF22_RW_NR43,
                         uint8_t shift_freq:4;
                         uint8_t counter_step:1;
                         uint8_t div_ratio:3);

                io_union(FF23_RW_NR44,
                         uint8_t initial:1;
                         uint8_t counter:1;
                         uint8_t unused:6);

                io_union(FF24_RW_NR50,
                         uint8_t so2_vin:1;
                         uint8_t so2_level:3;
                         uint8_t so1_vin:1;
                         uint8_t so1_level:3);

                io_union(FF25_RW_NR51,
                         uint8_t s4_so2:1;
                         uint8_t s3_so2:1;
                         uint8_t s2_so2:1;
                         uint8_t s1_so2:1;
                         uint8_t s4_so1:1;
                         uint8_t s3_so1:1;
                         uint8_t s2_so1:1;
                         uint8_t s1_so1:1);

                io_union(FF26_RW_NR52,
                         uint8_t global_sound_off:1;
                         uint8_t unused:3;
                         uint8_t s4_on:1;
                         uint8_t s3_on:1;
                         uint8_t s2_on:1;
                         uint8_t s1_on:1);

                uint8_t FF27_FF2F[9];
                uint8_t FF30_FF3F_wave_samples[16];

                io_union(FF40_RW_LCDC,
                         uint8_t lcd_enable:1;
                         uint8_t window_select:1;
                         uint8_t window_enable:1;
                         uint8_t bg_window_data:1;
                         uint8_t bg_select:1;
                         uint8_t obj_size:1;
                         uint8_t obj_enable:1;
                         uint8_t bg_enable:1);

                io_union(FF41_RW_STAT,
                         uint8_t lcy:1;
                         uint8_t mode2_oam:1;
                         uint8_t mode1_vblnk:1;
                         uint8_t mode0_hblnk:1;
                         uint8_t coincidence:1;
                         uint8_t mode:2);

                uint8_t FF42_RW_SCY;
                uint8_t FF43_RW_SCX;
                uint8_t FF44_RW_LY;
                uint8_t FF45_RW_LCY;
                uint8_t FF46_W_DMA;

                io_union(FF47_RW_BGP,
                         uint8_t cshade3:1;
                         uint8_t cshade2:1;
                         uint8_t cshade1:1;
                         uint8_t cshade0:1);

                uint8_t FF48_RW_OBP0;
                uint8_t FF49_RW_OBP1;
                uint8_t FF4A_RW_WY;
                uint8_t FF4B_RW_WX;
                uint8_t FF4C_FF4F[4];
                uint8_t FF50_RW_DISABLE_BOOTROM;
                uint8_t FF51_FF7F[47];
            } v;

            uint8_t raw[0x80];
        } io;

        uint8_t hram[0x80];

        io_union(FFFF_RW_IE,
                 uint8_t vblank:1;
                 uint8_t lcdstat:1;
                 uint8_t timer:1;
                 uint8_t serial:1;
                 uint8_t joypad:1;
                 uint8_t unused:3);
    } mem;

    struct game_cart {
        union {
            struct {
                uint8_t start[0x100];

                struct {
                    uint8_t game_entry[4];
                    uint8_t logo[0x30];
                    uint8_t ascii_title[16];
                    uint8_t new_pcode[2];
                    uint8_t sgb_supported;
                    uint8_t mbc_type;
                    uint8_t romsize;
                    uint8_t extram;
                    uint8_t destination;
                    uint8_t old_pcode;
                    uint8_t game_version;
                    uint8_t header_checksum;
                    uint8_t global_checksum[2];
                } hdr;

                uint8_t page0_end[0x3EB0];
                uint8_t page_NN[0x3FC150];
            } v;

            uint8_t raw[4 * mb];
        } romdata;

        uint8_t internal_ram[128 * kb];
        uint32_t romsize, ramsize;

        uint8_t rombank_sel, rambank_sel;
    } cart;
};

void gbtick(struct gbstate *gb)
{
    // hai :D
}

uint8_t read_mem(struct gbstate *gb, uint16_t addr)
{
    gbtick(gb);

    if (addr <= 0x100) {
        return (gb->mem.io.v.FF50_RW_DISABLE_BOOTROM ? gb->cart.romdata.raw[addr] : gb->mem.bootrom[addr]);
    } else if (addr < 0x4000) {
        return gb->cart.romdata.raw[addr];
    } else if (addr < 0x8000) {
        return gb->cart.romdata.v.page_NN[(gb->cart.rombank_sel * (16 * kb)) + (addr - 0x4000)];
    } else if (addr < 0xA000) {
        return gb->mem.vram[addr - 0x8000];
    } else if (addr < 0xC000) {
        // fix extram
        return 0;
    } else if (addr < 0xD000) {
        return gb->mem.wram_0[addr - 0xC000];
    } else if (addr < 0xE000) {
        return gb->mem.wram_1[addr - 0xD000];
    } else if (addr < 0xFE00) {
        // echo into another call.. gbtick
        // is called 1 extra time, but this
        // feature is rarely used anyway
        return read_mem(gb, addr - 0x2000);
    } else if (addr < 0xFEA0) {
        return gb->mem.oam.raw[addr - 0xFE00];
    } else if (addr < 0xFF00) {
        return 0xFF;
    } else if (addr < 0xFF80) {
        return gb->mem.io.raw[addr - 0xFF00];
    } else if (addr < 0xFFFF) {
        return gb->mem.hram[addr - 0xFF80];
    } else {
        return gb->mem.FFFF_RW_IE.raw;
    }
}

void write_mem(struct gbstate *gb, uint16_t addr, uint8_t value)
{
    gbtick(gb);
    
    if (addr < 0x8000) {
        return;
    } else if (addr < 0xA000) {
        // Check if VRAM is accessible by CPU
        // before allowing writes here
    } else if (addr < 0xC000) {
        // fix extram
    } else if (addr < 0xD000) {
        gb->mem.wram_0[addr - 0xC000] = value;
        gbtick(gb);
    } else if (addr < 0xE000) {
        gb->mem.wram_1[addr - 0xD000] = value;
        gbtick(gb);
    } else if (addr < 0xFE00) {
        // echo into another call.. gbtick
        // is called 1 extra time, but this
        // feature is rarely used anyway
        return write_mem(gb, addr - 0x2000, value);
    } else if (addr < 0xFEA0) {
        // Check if OAM is accessible by CPU
        // before allowing writes here
    } else if (addr < 0xFF00) {
        return;
    } else if (addr < 0xFF80) {
        // IO Port Space. A lot of work
        // is needed here to check for
        // accessibility of specific ports
        // given cpu time. Work on this
    } else if (addr < 0xFFFF) {
        gb->mem.hram[addr - 0xFF80] = value;
        gbtick(gb);
    } else {
        gb->mem.FFFF_RW_IE.raw = value;
        gbtick(gb);
    }
}

struct gbstate *mkstate(void)
{
    struct gbstate *gb = malloc(sizeof(struct gbstate));
    memset(gb, 0, sizeof(struct gbstate));
    memcpy(gb->mem.bootrom, gb_bootrom, 0x100);
    return gb;
}

void rmstate(struct gbstate *state)
{
    free(state);
}

void gb(int argc, char **argv)
{
    int fd = open(argv[1], O_RDONLY);
    if (!fd) return;

    struct gbstate *gstate = malloc(sizeof(struct gbstate));
    memset(gstate, 0, sizeof(struct gbstate));
    read(fd, gstate->mem.rom_0, 16 * kb);

    gstate->romsize = 128 * kb;
    gstate->rombanks = gstate->romsize / (16 * kb);
    gstate->mem.rom_N = malloc(gstate->rombanks - 1);
    gstate->rombank_curr = 1;

    for (int i = 0; i < (gstate->rombanks - 1); i++)
    {
        gstate->mem.rom_N[i] = malloc(16 * kb);
        read(fd, gstate->mem.rom_N[i], 16 * kb);
    }

    close(fd);
    struct cart_hdr *header = (struct cart_hdr *)(&gstate->mem.rom_0[0x100]);
    printf("%s\n", header->ascii_title);

    if (memcmp(header->logo, nintendo_logo, 0x30)) {
        fprintf(stderr, "Warning: Logo in cartridge header did not match nintendo logo!\n");
    } else {
        fprintf(stderr, "Info: Detected verified nintendo logo.\n");
    }

    for (int i = 0; i < 0x30; i++)
    {
        for (int s = 0; s < 8; s += 2)
        {
            uint8_t block = (nintendo_logo[i] >> s) % 0x3;

            switch (block)
            {
                case 0x0: printf("0"); // 00
                case 0x1: printf("1"); // 01
                case 0x2: printf("2"); // 10
                case 0x3: printf("3"); // 11
            }
        }
    }
}

#endif
