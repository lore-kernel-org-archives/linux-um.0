Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CG0Ac-0007UV-2m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:12:50 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CG0Aa-0005nt-FK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 12:12:50 -0700
Message-Id: <200410081912.i98JChr20458@trolli.pdb.fsc.net>
From: bodo.stroesser@fujitsu-siemens.com
Subject: [uml-devel] Implement vsyscall/sysenter, patch 3/4
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
Date: Fri, 08 Oct 2004 21:12:43 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, blaisorblade_spam@yahoo.it

Here access_ok_skas() and FIXADDR_USER_XXXX are fixed.
Now everything should work fine, while the processes are
running. But if a process crashes, the vsyscall-page will
not be dumped.


Signed-off-by: Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>

---


--- linux-2.6.9-rc2-orig/arch/um/kernel/skas/include/uaccess.h	2004-09-13 07:32:26.000000000 +0200
+++ linux-2.6.9-rc2/arch/um/kernel/skas/include/uaccess.h	2004-10-05 12:21:34.888370819 +0200
@@ -7,11 +7,16 @@
 #define __SKAS_UACCESS_H
 
 #include "asm/errno.h"
+#include "asm/fixmap.h"
 
 #define access_ok_skas(type, addr, size) \
 	((segment_eq(get_fs(), KERNEL_DS)) || \
 	 (((unsigned long) (addr) < TASK_SIZE) && \
-	  ((unsigned long) (addr) + (size) <= TASK_SIZE)))
+	  ((unsigned long) (addr) + (size) <= TASK_SIZE)) || \
+	 ((type == VERIFY_READ ) && \
+	  (size <= (FIXADDR_USER_END - FIXADDR_USER_START)) && \
+	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END)))
 
 static inline int verify_area_skas(int type, const void * addr, 
 				   unsigned long size)
--- linux-2.6.9-rc2-orig/include/asm-um/fixmap.h	2004-09-13 07:33:26.000000000 +0200
+++ linux-2.6.9-rc2/include/asm-um/fixmap.h	2004-10-04 19:39:31.820631117 +0200
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <asm/kmap_types.h>
+#include <asm/archparam.h>
 
 /*
  * Here we define all the compile-time 'special' virtual
@@ -34,7 +35,6 @@
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
-	FIX_VSYSCALL,
 	__end_of_fixed_addresses
 };
 
@@ -68,8 +68,8 @@
  * This is the range that is readable by user mode, and things
  * acting like user mode such as get_user_pages.
  */
-#define FIXADDR_USER_START	(__fix_to_virt(FIX_VSYSCALL))
-#define FIXADDR_USER_END	(FIXADDR_USER_START + PAGE_SIZE)
+#define FIXADDR_USER_START	VSYSCALL_BASE
+#define FIXADDR_USER_END	VSYSCALL_END
 
 extern void __this_fixmap_does_not_exist(void);
 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
