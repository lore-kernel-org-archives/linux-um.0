Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHALg-0002I1-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:04 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHALa-0008Gs-GN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:17:04 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001636.12CB88693@zion.localdomain>
Subject: [uml-devel] [patch 6/6] uml: export more Symbols
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
Date: Tue, 12 Oct 2004 02:16:35 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Adds a lot more EXPORT_SYMBOLS calls.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/irq.c     |    2 ++
 linux-2.6.9-current-paolo/arch/um/kernel/ksyms.c   |    1 +
 linux-2.6.9-current-paolo/arch/um/kernel/physmem.c |    5 +++++
 3 files changed, 8 insertions(+)

diff -puN arch/um/kernel/irq.c~uml-export-Symbols arch/um/kernel/irq.c
--- linux-2.6.9-current/arch/um/kernel/irq.c~uml-export-Symbols	2004-10-12 01:22:08.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/irq.c	2004-10-12 01:22:08.000000000 +0200
@@ -441,6 +441,8 @@ int um_request_irq(unsigned int irq, int
 		err = activate_fd(irq, fd, type, dev_id);
 	return(err);
 }
+EXPORT_SYMBOL(um_request_irq);
+EXPORT_SYMBOL(reactivate_fd);
 
 /* this was setup_x86_irq but it seems pretty generic */
 int setup_irq(unsigned int irq, struct irqaction * new)
diff -puN arch/um/kernel/ksyms.c~uml-export-Symbols arch/um/kernel/ksyms.c
--- linux-2.6.9-current/arch/um/kernel/ksyms.c~uml-export-Symbols	2004-10-12 01:22:08.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/ksyms.c	2004-10-12 01:22:08.000000000 +0200
@@ -60,6 +60,7 @@ EXPORT_SYMBOL(strncpy_from_user_skas);
 EXPORT_SYMBOL(copy_to_user_skas);
 EXPORT_SYMBOL(copy_from_user_skas);
 #endif
+EXPORT_SYMBOL(uml_strdup);
 
 EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
diff -puN arch/um/kernel/physmem.c~uml-export-Symbols arch/um/kernel/physmem.c
--- linux-2.6.9-current/arch/um/kernel/physmem.c~uml-export-Symbols	2004-10-12 01:22:08.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/physmem.c	2004-10-12 01:22:08.000000000 +0200
@@ -8,6 +8,7 @@
 #include "linux/slab.h"
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
+#include "linux/module.h"
 #include "asm/types.h"
 #include "asm/pgtable.h"
 #include "kern_util.h"
@@ -220,6 +221,10 @@ void physmem_forget_descriptor(int fd)
 	kfree(desc);
 }
 
+EXPORT_SYMBOL(physmem_forget_descriptor);
+EXPORT_SYMBOL(physmem_remove_mapping);
+EXPORT_SYMBOL(physmem_subst_mapping);
+
 void arch_free_page(struct page *page, int order)
 {
 	void *virt;
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
