Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EaziQ-0004hO-MQ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:03:02 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EaziL-00022g-HM for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:03:02 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180716.20133.92227.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 2/9] uml: remove bogus WARN_ON,
	triggerable harmlessly on a page fault race
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 12 Nov 2005 19:07:18 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The below warning was added in place of pte_mkyoung(); if (is_write)
pte_mkdirty();

In fact, if the PTE is not marked young/dirty, our dirty/accessed bit emulation
would cause the TLB permission not to be changed, and so we'd loop, and given we
don't support preemption yet, we'd busy-hang here.

However, I've seen this warning trigger without crashes during a loop of
concurrent kernel builds, at random times (i.e. like a race condition), and I
realized that two concurrent faults on the same page, one on read and one on
write, can trigger it. The read fault gets serviced and the PTE gets marked
writable but clean (it's possible on a shared-writable mapping), while the
generic code sees the PTE was already installed and returns without action. In
this case, we'll see another fault and service it normally.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/trap_kern.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
index 95c8f87..0d4c10a 100644
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -95,7 +95,16 @@ survive:
 		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
+	/* The below warning was added in place of
+	 *	pte_mkyoung(); if (is_write) pte_mkdirty();
+	 * If it's triggered, we'd see normally a hang here (a clean pte is
+	 * marked read-only to emulate the dirty bit).
+	 * However, the generic code can mark a PTE writable but clean on a
+	 * concurrent read fault, triggering this harmlessly. So comment it out.
+	 */
+#if 0
 	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
+#endif
 	flush_tlb_page(vma, address);
 out:
 	up_read(&mm->mmap_sem);



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
