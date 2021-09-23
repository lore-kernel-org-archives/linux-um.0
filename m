Return-Path: <linux-sh-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20210923074335.12583-1-rppt@kernel.org>
In-Reply-To: <20210923074335.12583-1-rppt@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Sep 2021 09:01:46 -0700
Message-ID: <CAHk-=wiJB8H5pZz-AKaSJ7ViRtdxQGJT7eOByp8DJx2OwZSYwA@mail.gmail.com>
Subject: Re: [PATCH 0/3] memblock: cleanup memblock_free interface
Content-Type: text/plain; charset="UTF-8"
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, devicetree <devicetree@vger.kernel.org>, iommu <iommu@lists.linux-foundation.org>, kasan-dev <kasan-dev@googlegroups.com>, KVM list <kvm@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-efi <linux-efi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-usb@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-um.lists.infradead.org>

On Thu, Sep 23, 2021 at 12:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The core change is in the third patch that makes memblock_free() a
> counterpart of memblock_alloc() and adds memblock_phys_alloc() to be a

^^^^^^^^^^^^^^^^^^^
> counterpart of memblock_phys_alloc().

That should be 'memblock_phys_free()'

HOWEVER.

The real reason I'm replying is that this patch is horribly buggy, and
will cause subtle problems that are nasty to debug.

You need to be a LOT more careful.

From a trivial check - exactly because I looked at doing it with a
script, and decided it's not so easy - I found cases like this:

-               memblock_free(__pa(paca_ptrs) + new_ptrs_size,
+               memblock_free(paca_ptrs + new_ptrs_size,

which is COMPLETELY wrong.

Why? Because now that addition is done as _pointer_ addition, not as
an integer addition, and the end result is something completely
different.

pcac_ptrs is of type 'struct paca_struct **', so when you add
new_ptrs_size to it, it will add it in terms of that many pointers,
not that many bytes.

You need to use some smarter scripting, or some way to validate it.

And no, making the scripting just replace '__pa(x)' with '(void *)(x)'
- which _would_ be mindless and get the same result - is not
acceptable either, because it avoids one of the big improvements from
using the right interface, namely having compiler type checking (and
saner code that people understand).

So NAK. No broken automated scripting patches.

               Linus

