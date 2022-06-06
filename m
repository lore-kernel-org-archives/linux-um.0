Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny8im-000KCS-2I
	for linux-um@lists.infradead.org; Mon, 06 Jun 2022 09:08:26 +0000
Date: Mon, 6 Jun 2022 11:08:11 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v5.19-rc1
In-Reply-To: <20220606082201.2792145-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2206061104510.695137@ramsan.of.borg>
References: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com> <20220606082201.2792145-1-geert@linux-m68k.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, nvdimm@lists.linux.dev, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, 6 Jun 2022, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.19-rc1[1] compared to v5.18[2].
>
> Summarized:
>  - build errors: +9/-10

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f2906aa863381afb0015a9eb7fefad885d4e5a56/ (all 135 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4b0986a3613c92f4ec1bdc7f60ec66fea135991f/ (131 out of 135 configs)

> 9 error regressions:
>  + /kisskb/src/arch/um/include/asm/page.h: error: too few arguments to function 'to_phys':  => 105:20
>  + /kisskb/src/drivers/nvdimm/pmem.c: error: conflicting types for 'to_phys':  => 48:20
>  + /kisskb/src/drivers/nvdimm/pmem.c: error: control reaches end of non-void function [-Werror=return-type]:  => 324:1

um-x86_64/um-allyesconfig

>  + /kisskb/src/arch/xtensa/kernel/entry.S: Error: unknown pseudo-op: `.bss':  => 2176

xtensa-gcc11/xtensa-allmodconfig

>  + /kisskb/src/drivers/tty/serial/sh-sci.c: error: unused variable 'sport' [-Werror=unused-variable]:  => 2655:26

sh4-gcc11/se7619_defconfig
sh4-gcc11/sh-allmodconfig

Fix available
https://lore.kernel.org/all/4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be

>  + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 344:25

powerpc-gcc11/ppc64_book3e_allmodconfig

>  + /kisskb/src/include/ufs/ufshci.h: error: initializer element is not constant:  => 245:36

mipsel-gcc5/mips-allmodconfig
powerpc-gcc5/powerpc-allmodconfig

FTR, include/ufs/ufshci.h lacks a MAINTAINERS entry.

>  + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>  + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

sparc64-gcc5/sparc-allmodconfig

> 3 warning regressions:

>  + arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for ZPOOL:  => 61
>  + arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for ZPOOL:  => 37

Will be fixed by the m68k defconfig update for v5.20.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

