Return-Path: <jcmvbkbc@gmail.com>
MIME-Version: 1.0
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com> <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 31 Jan 2019 07:23:02 -0800
Message-ID: <CAMo8BfKhjwimXrGCcPjmS0+w8o6yW=ohG-hZ7caWnGpPSF6qJA@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of memblock_alloc*()
Content-Type: text/plain; charset="UTF-8"
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, devicetree@vger.kernel.org, kasan-dev@googlegroups.com, "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, USB list <linux-usb@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, xen-devel@lists.xenproject.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Jan 21, 2019 at 12:06 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
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
> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> Acked-by: Paul Burton <paul.burton@mips.com>         # MIPS
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> ---
>  arch/xtensa/mm/kasan_init.c               |  4 ++++
>  arch/xtensa/mm/mmu.c                      |  3 +++

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

