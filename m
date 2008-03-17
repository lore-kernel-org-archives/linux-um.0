Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbJOs-0004xu-3O for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 10:45:30 -0700
Received: from triton.rz.uni-saarland.de ([134.96.7.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JbJOq-0007tr-EW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 10:45:30 -0700
Date: Mon, 17 Mar 2008 16:38:00 +0100
From: Alexander van Heukelum <heukelum@mailshack.com>
Message-ID: <20080317153800.GA4450@mailshack.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml compile fixes
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
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: heukelum@fastmail.fm

Hi all,

I need the following two changes to get my favourite uml config
to compile (and run):

make ARCH=um SUBARCH=i386 KCONFIG_ALLCONFIG=mini.config allnoconfig

with mini.config:
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE="../initramfs"
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_SLOB=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_XTERM_CHAN=y
CONFIG_PROC_FS=y
CONFIG_SYSFS=y

Please review/comment (or create a better patch for this yourself!).

(If you need one:) 
Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>

diff --git a/arch/um/include/um_malloc.h b/arch/um/include/um_malloc.h
index 0ad17cb..e5b09fa 100644
--- a/arch/um/include/um_malloc.h
+++ b/arch/um/include/um_malloc.h
@@ -8,11 +8,19 @@
 
 #include "kern_constants.h"
 
+#ifdef UML_CONFIG_SLOB
+extern void *__kmalloc_node(int size, int flags, int node);
+static inline void *kmalloc(int size, int flags)
+{
+	return __kmalloc_node(size, flags, -1);
+}
+#else
 extern void *__kmalloc(int size, int flags);
 static inline void *kmalloc(int size, int flags)
 {
 	return __kmalloc(size, flags);
 }
+#endif
 
 extern void kfree(const void *ptr);
 
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
diff --git a/include/asm-um/tlb.h b/include/asm-um/tlb.h
index 39fc475..7febf85 100644
--- a/include/asm-um/tlb.h
+++ b/include/asm-um/tlb.h
@@ -2,6 +2,7 @@
 #define __UM_TLB_H
 
 #include <linux/swap.h>
+#include <linux/pagemap.h>
 #include <asm/percpu.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
