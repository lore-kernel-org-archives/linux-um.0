Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AC6bi-0005pN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 21 Oct 2003 17:12:10 -0700
Received: from conure.mail.pas.earthlink.net ([207.217.120.54])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AC5RU-0005Fo-IN
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 21 Oct 2003 15:57:32 -0700
Received: from user-38ld18q.dialup.mindspring.com ([209.86.133.26] helo=earthlink.net)
	by conure.mail.pas.earthlink.net with smtp (Exim 3.33 #1)
	id 1AC5OT-0000w7-00
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 21 Oct 2003 15:54:26 -0700
Message-ID: <20031021225740.GA4471@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: rwhron@earthlink.net
Subject: [uml-devel] [PATCH] remove version.h where it isn't needed
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 21 Oct 2003 18:57:40 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Remove include of linux/version.h where it isn't needed.
Tested on 2.6.0-test8-uml1 with default configuration.

diff -Nur linux-2.6.0-test8-um1/arch/um/drivers/hostaudio_kern.c linux/arch/um/drivers/hostaudio_kern.c
--- linux-2.6.0-test8-um1/arch/um/drivers/hostaudio_kern.c	2003-10-21 16:57:02.000000000 -0400
+++ linux/arch/um/drivers/hostaudio_kern.c	2003-10-21 17:07:35.655017296 -0400
@@ -5,7 +5,6 @@
 
 #include "linux/config.h"
 #include "linux/module.h"
-#include "linux/version.h"
 #include "linux/init.h"
 #include "linux/slab.h"
 #include "linux/fs.h"
diff -Nur linux-2.6.0-test8-um1/arch/um/include/2_5compat.h linux/arch/um/include/2_5compat.h
--- linux-2.6.0-test8-um1/arch/um/include/2_5compat.h	2003-04-19 22:49:26.000000000 -0400
+++ linux/arch/um/include/2_5compat.h	2003-10-21 17:08:12.192462760 -0400
@@ -6,8 +6,6 @@
 #ifndef __2_5_COMPAT_H__
 #define __2_5_COMPAT_H__
 
-#include "linux/version.h"
-
 #define INIT_CONSOLE(dev_name, write_proc, device_proc, setup_proc, f) { \
 	name :		dev_name, \
 	write :		write_proc, \
diff -Nur linux-2.6.0-test8-um1/arch/um/kernel/init_task.c linux/arch/um/kernel/init_task.c
--- linux-2.6.0-test8-um1/arch/um/kernel/init_task.c	2003-10-21 16:57:02.000000000 -0400
+++ linux/arch/um/kernel/init_task.c	2003-10-21 17:09:03.325689328 -0400
@@ -8,7 +8,6 @@
 #include "linux/module.h"
 #include "linux/sched.h"
 #include "linux/init_task.h"
-#include "linux/version.h"
 #include "asm/uaccess.h"
 #include "asm/pgtable.h"
 #include "user_util.h"
diff -Nur linux-2.6.0-test8-um1/arch/um/kernel/sys_call_table.c linux/arch/um/kernel/sys_call_table.c
--- linux-2.6.0-test8-um1/arch/um/kernel/sys_call_table.c	2003-10-21 16:57:02.000000000 -0400
+++ linux/arch/um/kernel/sys_call_table.c	2003-10-21 17:08:33.848170592 -0400
@@ -5,7 +5,6 @@
 
 #include "linux/config.h"
 #include "linux/unistd.h"
-#include "linux/version.h"
 #include "linux/sys.h"
 #include "linux/swap.h"
 #include "linux/sysctl.h"


-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
