Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXoY6-00065L-29	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 15:58:58 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXoXW-0002Qr-Oa	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 15:58:57 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050516060725.21CAC3DADA@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml: remove 2_5compat.h
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
Date: Mon, 16 May 2005 08:07:22 +0200
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Remove old useless header that was used in Ye Olde Times during 2.4->2.5
porting to abstract differences. It's definitions are no more used anyway, so
let's finally kill it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/ssl.c           |    1 
 linux-2.6.git-paolo/arch/um/drivers/stdio_console.c |    1 
 linux-2.6.git-paolo/arch/um/drivers/ubd_kern.c      |    1 
 linux-2.6.git-paolo/arch/um/kernel/exec_kern.c      |    1 
 linux-2.6.git-paolo/arch/um/kernel/process_kern.c   |    2 -
 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c      |    1 
 linux-2.6.git-paolo/fs/hostfs/hostfs_kern.c         |    1 
 linux-2.6.git/arch/um/include/2_5compat.h           |   24 --------------------
 8 files changed, 32 deletions(-)

diff -L arch/um/include/2_5compat.h -puN arch/um/include/2_5compat.h~uml-remove-2_5-compat /dev/null
--- linux-2.6.git/arch/um/include/2_5compat.h
+++ /dev/null	2005-05-09 17:36:13.454367832 +0200
@@ -1,24 +0,0 @@
-/* 
- * Copyright (C) 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __2_5_COMPAT_H__
-#define __2_5_COMPAT_H__
-
-#define INIT_HARDSECT(arr, maj, sizes)
-
-#define SET_PRI(task) do ; while(0)
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/drivers/ssl.c~uml-remove-2_5-compat arch/um/drivers/ssl.c
--- linux-2.6.git/arch/um/drivers/ssl.c~uml-remove-2_5-compat	2005-05-10 00:06:55.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/ssl.c	2005-05-10 00:06:55.000000000 +0200
@@ -22,7 +22,6 @@
 #include "init.h"
 #include "irq_user.h"
 #include "mconsole_kern.h"
-#include "2_5compat.h"
 
 static int ssl_version = 1;
 
diff -puN arch/um/drivers/stdio_console.c~uml-remove-2_5-compat arch/um/drivers/stdio_console.c
--- linux-2.6.git/arch/um/drivers/stdio_console.c~uml-remove-2_5-compat	2005-05-10 00:06:55.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/stdio_console.c	2005-05-10 00:06:55.000000000 +0200
@@ -28,7 +28,6 @@
 #include "irq_user.h"
 #include "mconsole_kern.h"
 #include "init.h"
-#include "2_5compat.h"
 
 #define MAX_TTYS (16)
 
diff -puN arch/um/drivers/ubd_kern.c~uml-remove-2_5-compat arch/um/drivers/ubd_kern.c
--- linux-2.6.git/arch/um/drivers/ubd_kern.c~uml-remove-2_5-compat	2005-05-10 00:06:55.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/ubd_kern.c	2005-05-10 00:06:55.000000000 +0200
@@ -49,7 +49,6 @@
 #include "irq_user.h"
 #include "irq_kern.h"
 #include "ubd_user.h"
-#include "2_5compat.h"
 #include "os.h"
 #include "mem.h"
 #include "mem_kern.h"
diff -puN arch/um/kernel/process_kern.c~uml-remove-2_5-compat arch/um/kernel/process_kern.c
--- linux-2.6.git/arch/um/kernel/process_kern.c~uml-remove-2_5-compat	2005-05-10 00:06:55.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/process_kern.c	2005-05-10 00:06:55.000000000 +0200
@@ -43,7 +43,6 @@
 #include "tlb.h"
 #include "frame_kern.h"
 #include "sigcontext.h"
-#include "2_5compat.h"
 #include "os.h"
 #include "mode.h"
 #include "mode_kern.h"
@@ -189,7 +188,6 @@ void default_idle(void)
 
 	while(1){
 		/* endless idle loop with no priority at all */
-		SET_PRI(current);
 
 		/*
 		 * although we are an idle CPU, we do not want to
diff -puN arch/um/kernel/exec_kern.c~uml-remove-2_5-compat arch/um/kernel/exec_kern.c
--- linux-2.6.git/arch/um/kernel/exec_kern.c~uml-remove-2_5-compat	2005-05-10 00:06:55.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/exec_kern.c	2005-05-10 00:06:55.000000000 +0200
@@ -16,7 +16,6 @@
 #include "kern.h"
 #include "irq_user.h"
 #include "tlb.h"
-#include "2_5compat.h"
 #include "os.h"
 #include "time_user.h"
 #include "choose-mode.h"
diff -puN arch/um/kernel/trap_kern.c~uml-remove-2_5-compat arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~uml-remove-2_5-compat	2005-05-10 00:06:55.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-05-10 00:06:55.000000000 +0200
@@ -23,7 +23,6 @@
 #include "kern.h"
 #include "chan_kern.h"
 #include "mconsole_kern.h"
-#include "2_5compat.h"
 #include "mem.h"
 #include "mem_kern.h"
 
diff -puN fs/hostfs/hostfs_kern.c~uml-remove-2_5-compat fs/hostfs/hostfs_kern.c
--- linux-2.6.git/fs/hostfs/hostfs_kern.c~uml-remove-2_5-compat	2005-05-10 00:06:55.000000000 +0200
+++ linux-2.6.git-paolo/fs/hostfs/hostfs_kern.c	2005-05-10 00:06:55.000000000 +0200
@@ -23,7 +23,6 @@
 #include "kern_util.h"
 #include "kern.h"
 #include "user_util.h"
-#include "2_5compat.h"
 #include "init.h"
 
 struct hostfs_inode_info {
_


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
