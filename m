Return-Path: <rppt@linux.ibm.com>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 01/21] openrisc: prefer memblock APIs returning virtual address
Date: Mon, 21 Jan 2019 10:03:48 +0200
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
Message-Id: <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, devicetree@vger.kernel.org, kasan-dev@googlegroups.com, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org, xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-um.lists.infradead.org>

The allocation of the page tables memory in openrics uses
memblock_phys_alloc() and then converts the returned physical address to
virtual one. Use memblock_alloc_raw() and add a panic() if the allocation
fails.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/openrisc/mm/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d157310..caeb418 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -105,7 +105,10 @@ static void __init map_ram(void)
 			}
 
 			/* Alloc one page for holding PTE's... */
-			pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
+			pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
+			if (!pte)
+				panic("%s: Failed to allocate page for PTEs\n",
+				      __func__);
 			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
 
 			/* Fill the newly allocated page with PTE'S */
-- 
2.7.4


