Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsoB4-0002zd-SN
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:13:10 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aso1q-00027v-7Y
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:03:38 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Message-Id: <200402161920.25522.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WoQMAwLZkuQVLXM"
Subject: [uml-devel] [PATCH] Rename headers with the same name
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 19:21:10 +0100
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_WoQMAwLZkuQVLXM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

With the current uml patch I get:

$ ls arch/um/kernel/*/include
arch/um/kernel/skas/include:
mmu.h  mode.h  mode_kern.h  proc_mm.h  ptrace-skas.h  skas.h  uaccess.h

arch/um/kernel/tt/include:
debug.h  mmu.h  mode.h  mode_kern.h  ptrace-tt.h  tt.h  uaccess.h
and we see that mmu.h, mode.h, mode_kern.h and uaccess.h have the same name, 
so one cannot easily specify which one he wants to include. I'm attaching a 
script to rename all the files at once (revert its effect with -r switch) and 
a patch to correct references to them + fix any compile errors.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



--Boundary-00=_WoQMAwLZkuQVLXM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="RenameModeHeaders.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="RenameModeHeaders.patch"

--- ./arch/um/include/um_uaccess.h.fix	2004-02-05 16:45:10.000000000 +0100
+++ ./arch/um/include/um_uaccess.h	2004-02-08 17:36:00.000000000 +0100
@@ -10,11 +10,11 @@
 #include "choose-mode.h"
 
 #ifdef CONFIG_MODE_TT
-#include "../kernel/tt/include/uaccess.h"
+#include "uaccess-tt.h"
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-#include "../kernel/skas/include/uaccess.h"
+#include "uaccess-skas.h"
 #endif
 
 #define access_ok(type, addr, size) \
--- ./arch/um/include/mode_kern.h.fix	2003-12-20 17:20:03.000000000 +0100
+++ ./arch/um/include/mode_kern.h	2004-02-08 17:36:00.000000000 +0100
@@ -9,11 +9,11 @@
 #include "linux/config.h"
 
 #ifdef CONFIG_MODE_TT
-#include "../kernel/tt/include/mode_kern.h"
+#include "mode_kern-tt.h"
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-#include "../kernel/skas/include/mode_kern.h"
+#include "mode_kern-skas.h"
 #endif
 
 #endif
--- ./arch/um/include/mode.h.fix	2003-12-20 17:40:55.000000000 +0100
+++ ./arch/um/include/mode.h	2004-02-08 17:36:00.000000000 +0100
@@ -9,11 +9,11 @@
 #include "uml-config.h"
 
 #ifdef UML_CONFIG_MODE_TT
-#include "../kernel/tt/include/mode.h"
+#include "mode-tt.h"
 #endif
 
 #ifdef UML_CONFIG_MODE_SKAS
-#include "../kernel/skas/include/mode.h"
+#include "mode-skas.h"
 #endif
 
 #endif
--- ./arch/um/include/um_mmu.h.fix	2003-12-20 17:20:03.000000000 +0100
+++ ./arch/um/include/um_mmu.h	2004-02-08 17:36:00.000000000 +0100
@@ -10,11 +10,11 @@
 #include "choose-mode.h"
 
 #ifdef CONFIG_MODE_TT
-#include "../kernel/tt/include/mmu.h"
+#include "mmu-tt.h"
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-#include "../kernel/skas/include/mmu.h"
+#include "mmu-skas.h"
 #endif
 
 typedef union {
--- ./arch/um/kernel/skas/exec_kern.c.fix	2003-12-20 17:20:03.000000000 +0100
+++ ./arch/um/kernel/skas/exec_kern.c	2004-02-08 18:08:57.000000000 +0100
@@ -12,7 +12,7 @@
 #include "asm/mmu_context.h"
 #include "tlb.h"
 #include "skas.h"
-#include "mmu.h"
+#include "um_mmu.h"
 #include "os.h"
 
 void flush_thread_skas(void)

--Boundary-00=_WoQMAwLZkuQVLXM
Content-Type: application/x-shellscript;
  name="RenameModeHeaders.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="RenameModeHeaders.sh"

for i in tt skas
do
  for j in uaccess mode_kern mode mmu
  do
    if [ "$1" = "-r" ]; then
      mv arch/um/kernel/$i/include/$j-$i.h arch/um/kernel/$i/include/$j.h
    else
      mv arch/um/kernel/$i/include/$j.h arch/um/kernel/$i/include/$j-$i.h
    fi
  done
done

--Boundary-00=_WoQMAwLZkuQVLXM--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
