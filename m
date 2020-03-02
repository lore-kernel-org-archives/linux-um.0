MIME-Version: 1.0
Date: Mon, 2 Mar 2020 09:22:41 +0100
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
	<1583131666-15531-2-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1583131666-15531-2-git-send-email-anshuman.khandual@arm.com>
Message-ID: <CAMuHMdUfm0X3cgEDzzF6fs0HQj83OPR=xVjQaT7uVDi2WbtHog@mail.gmail.com>
Subject: Re: [RFC 1/3] mm/vma: Define a default value for VM_DATA_DEFAULT_FLAGS
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Linux MM <linux-mm@kvack.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Salter <msalter@redhat.com>, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, Nick Hu <nickhu@andestech.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Jeff Dike <jdike@addtoit.com>, Chris Zankel <chris@zankel.net>, Andrew Morton <akpm@linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Mar 2, 2020 at 7:48 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> There are many platforms with exact same value for VM_DATA_DEFAULT_FLAGS
> This creates a default value for VM_DATA_DEFAULT_FLAGS in line with the
> existing VM_STACK_DEFAULT_FLAGS. While here, also define some more macros
> with standard VMA access flag combinations that are used frequently across
> many platforms. Apart from simplification, this reduces code duplication
> as well.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/page.h       |  3 ---

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

