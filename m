Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZDED-0005OJ-5O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:18:07 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KZDEC-0006Lc-No
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 16:18:05 -0700
Date: Fri, 29 Aug 2008 16:18:04 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
In-Reply-To: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
Message-ID: <alpine.DEB.1.00.0808291617370.15543@abydos.NerdBox.Net>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 6/6] VM: Annotate vmalloc
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jiayingz@google.com, dkegel@google.com

Valgrind annotations for vmalloc: Valgrind doesn't understand memory
that is mapped to more than one address.  Approximate validness by
assuming that the physical mapping won't be used while it is vmalloc'd
and copy the valid bits from the physical page when the fault handler
maps it in.

Signed-off-by: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
---

Index: linux-2.6.27-rc5/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.27-rc5.orig/arch/um/kernel/physmem.c	2008-08-29 14:17:31.000000000 -0700
+++ linux-2.6.27-rc5/arch/um/kernel/physmem.c	2008-08-29 14:24:46.000000000 -0700
@@ -6,6 +6,7 @@
  #include "linux/bootmem.h"
  #include "linux/mm.h"
  #include "linux/pfn.h"
+#include "linux/memcheck.h"
  #include "asm/page.h"
  #include "as-layout.h"
  #include "init.h"
@@ -71,6 +72,26 @@
  		panic("map_memory(0x%lx, %d, 0x%llx, %ld, %d, %d, %d) failed, "
  		      "err = %d\n", virt, fd, offset, len, r, w, x, err);
  	}
+#ifdef CONFIG_VALGRIND_SUPPORT
+	if (virt >= VMALLOC_START && virt < VMALLOC_END) {
+		/* As far as I know, the backing pages were just page alloc'd,
+		 * so they are addressable, but may be either valid or invalid
+		 * (depending on gfp_mask).  The virtual address may be part of
+		 * a vmalloc region, or a guard page, so inaddressability is ok.
+		 */
+#define CHUNK_SIZE (PAGE_SIZE/8)
+		char vbits[CHUNK_SIZE];
+		int i;
+		if (len % (CHUNK_SIZE) != 0)
+			panic("Expected len to be a multiple of page size");
+		for (i = 0; i < len; i += CHUNK_SIZE) {
+			if (VALGRIND_GET_VBITS(__va(phys + i), vbits,
+						CHUNK_SIZE) > 1)
+				panic("Expected addressable source memory");
+			VALGRIND_SET_VBITS(virt + i, vbits, CHUNK_SIZE);
+		}
+	}
+#endif
  }

  extern int __syscall_stub_start;
Index: linux-2.6.27-rc5/mm/vmalloc.c
===================================================================
--- linux-2.6.27-rc5.orig/mm/vmalloc.c	2008-08-29 14:17:38.000000000 -0700
+++ linux-2.6.27-rc5/mm/vmalloc.c	2008-08-29 14:24:46.000000000 -0700
@@ -18,6 +18,7 @@
  #include <linux/debugobjects.h>
  #include <linux/vmalloc.h>
  #include <linux/kallsyms.h>
+#include <linux/memcheck.h>

  #include <asm/uaccess.h>
  #include <asm/tlbflush.h>
@@ -428,6 +429,8 @@
  void vfree(const void *addr)
  {
  	BUG_ON(in_interrupt());
+	if (addr)
+		VALGRIND_FREELIKE_BLOCK(addr, 0);
  	__vunmap(addr, 1);
  }
  EXPORT_SYMBOL(vfree);
@@ -555,6 +558,7 @@
  						int node, void *caller)
  {
  	struct vm_struct *area;
+	void *ret;

  	size = PAGE_ALIGN(size);
  	if (!size || (size >> PAGE_SHIFT) > num_physpages)
@@ -566,7 +570,16 @@
  	if (!area)
  		return NULL;

-	return __vmalloc_area_node(area, gfp_mask, prot, node, caller);
+	VALGRIND_MAKE_MEM_NOACCESS(area->addr, area->size);
+	VALGRIND_MALLOCLIKE_BLOCK(area->addr, size, 0, 0);
+	/* This could be improved by also clearing the addessability bits of
+	 * the rounded up region of the last page */
+
+	ret = __vmalloc_area_node(area, gfp_mask, prot, node, caller);
+	if (!ret)
+		VALGRIND_FREELIKE_BLOCK(area->addr, 0);
+
+	return ret;
  }

  void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
