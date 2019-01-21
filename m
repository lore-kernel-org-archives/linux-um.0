MIME-Version: 1.0
Date: Mon, 21 Jan 2019 09:39:40 +0100
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
	<1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
Message-ID: <CAMuHMdUhaTv0E3oMjMjoW0XReZgB=bm+8OGUvuDtLPBJzGQYjw@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of memblock_alloc*()
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, kasan-dev@googlegroups.com, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-um@lists.infradead.org, USB list <linux-usb@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Openrisc <openrisc@lists.librecores.org>, sparclinux <sparclinux@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, the arch/x86 maintainers <x86@kernel.org>, xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-um.lists.infradead.org>

On Mon, Jan 21, 2019 at 9:06 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
>
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
>
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

>  arch/m68k/atari/stram.c                   |  4 ++++
>  arch/m68k/mm/init.c                       |  3 +++
>  arch/m68k/mm/mcfmmu.c                     |  6 ++++++
>  arch/m68k/mm/motorola.c                   |  9 +++++++++
>  arch/m68k/mm/sun3mmu.c                    |  6 ++++++
>  arch/m68k/sun3/sun3dvma.c                 |  3 +++

For m68k:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

