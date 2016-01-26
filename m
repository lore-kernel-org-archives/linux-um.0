Return-Path: <richard@nod.at>
Subject: Re: [PATCH 21/22] mtd: cs553x: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-22-git-send-email-richard@nod.at>
 <CAMuHMdX_nH9U9gU4NH0KWPDVXBZmLbQDUp8MVXFpcciwKjmwuA@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56A77B7B.2000305@nod.at>
Date: Tue, 26 Jan 2016 14:58:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX_nH9U9gU4NH0KWPDVXBZmLbQDUp8MVXFpcciwKjmwuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Bill Pringlemeir <bpringlemeir@nbsps.com>, Stefan Agner <stefan@agner.ch>, Alex Smith <alex.smith@imgtec.com>, Zhou Wang <wangzhou1@hisilicon.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Anup Patel <anup.patel@broadcom.com>, MTD Maling List <linux-mtd@lists.infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Geert,

Am 26.01.2016 um 12:00 schrieb Geert Uytterhoeven:
> Hi Richard,
> 
> On Mon, Jan 25, 2016 at 11:24 PM, Richard Weinberger <richard@nod.at> wrote:
>> Not every arch has io memory nor can this driver ever work
>> on UML/i386.
>> So, unbreak the build by fixing the dependencies.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  drivers/mtd/nand/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index 545d82b..b253654 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -311,6 +311,7 @@ config MTD_NAND_CAFE
>>  config MTD_NAND_CS553X
>>         tristate "NAND support for CS5535/CS5536 (AMD Geode companion chip)"
>>         depends on X86_32
>> +       depends on !UML && HAS_IOMEM
> 
> I don't think there's a need for the !UML dependency?
> Hence just "depends on X86_32 && HAS_IOMEM"?

Strictly speaking this would work as HAS_IOMEM implies !UML.
The build error shows that it fails also because UML/i386 is x86_32
but lacks some x86_32 stuff:

drivers/mtd/nand/cs553x_nand.c: In function ‘cs553x_init_one’:
drivers/mtd/nand/cs553x_nand.c:212:2: error: implicit declaration of function ‘ioremap’ [-Werror=implicit-function-declaration]
  this->IO_ADDR_R = this->IO_ADDR_W = ioremap(adr, 4096);
  ^
drivers/mtd/nand/cs553x_nand.c:212:36: warning: assignment makes pointer from integer without a cast [enabled by default]
  this->IO_ADDR_R = this->IO_ADDR_W = ioremap(adr, 4096);
                                    ^
drivers/mtd/nand/cs553x_nand.c:256:2: error: implicit declaration of function ‘iounmap’ [-Werror=implicit-function-declaration]
  iounmap(this->IO_ADDR_R);
  ^
drivers/mtd/nand/cs553x_nand.c: In function ‘is_geode’:
drivers/mtd/nand/cs553x_nand.c:266:19: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
  if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
                   ^
drivers/mtd/nand/cs553x_nand.c:266:34: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function)
  if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
                                  ^
drivers/mtd/nand/cs553x_nand.c:266:34: note: each undeclared identifier is reported only once for each function it appears in
drivers/mtd/nand/cs553x_nand.c:267:19: error: ‘struct cpuinfo_um’ has no member named ‘x86’
      boot_cpu_data.x86 == 5 &&
                   ^
drivers/mtd/nand/cs553x_nand.c:268:19: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
      boot_cpu_data.x86_model == 10)
                   ^
drivers/mtd/nand/cs553x_nand.c:271:20: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
  if ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC ||
                    ^
drivers/mtd/nand/cs553x_nand.c:271:35: error: ‘X86_VENDOR_NSC’ undeclared (first use in this function)
  if ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC ||
                                   ^
drivers/mtd/nand/cs553x_nand.c:272:20: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
       boot_cpu_data.x86_vendor == X86_VENDOR_CYRIX) &&
                    ^
drivers/mtd/nand/cs553x_nand.c:272:35: error: ‘X86_VENDOR_CYRIX’ undeclared (first use in this function)
       boot_cpu_data.x86_vendor == X86_VENDOR_CYRIX) &&
                                   ^
drivers/mtd/nand/cs553x_nand.c:273:19: error: ‘struct cpuinfo_um’ has no member named ‘x86’
      boot_cpu_data.x86 == 5 &&
                   ^
drivers/mtd/nand/cs553x_nand.c:274:19: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
      boot_cpu_data.x86_model == 5)

Maybe a "depends on X86_32 && !UML" would make more sense. hmm?

Thanks,
//richard

