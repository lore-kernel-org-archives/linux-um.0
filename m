Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACFaz-0005Hx-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 22 Oct 2003 02:48:01 -0700
Received: from conure.mail.pas.earthlink.net ([207.217.120.54])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AC5Sm-0005Kr-Gp
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 21 Oct 2003 15:58:52 -0700
Received: from user-38ld18q.dialup.mindspring.com ([209.86.133.26] helo=earthlink.net)
	by conure.mail.pas.earthlink.net with smtp (Exim 3.33 #1)
	id 1AC5Pr-0001Fq-00
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 21 Oct 2003 15:55:51 -0700
Message-ID: <20031021225906.GB4471@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: rwhron@earthlink.net
Subject: [uml-devel] [PATCH] remove duplicate #includes
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
Date: Tue, 21 Oct 2003 18:59:06 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Remove doubley #included headers files.
Tested with 2.6.0-test8-uml1 with default configuration.

diff -Nur linux-2.6.0-test8-um1/arch/um/drivers/ubd_user.c linux/arch/um/drivers/ubd_user.c
--- linux-2.6.0-test8-um1/arch/um/drivers/ubd_user.c	2003-10-21 17:03:01.360716368 -0400
+++ linux/arch/um/drivers/ubd_user.c	2003-10-21 17:00:30.962580360 -0400
@@ -15,7 +15,6 @@
 #include <sys/time.h>
 #include <sys/fcntl.h>
 #include <sys/socket.h>
-#include <string.h>
 #include <sys/mman.h>
 #include <sys/param.h>
 #include "asm/types.h"
diff -Nur linux-2.6.0-test8-um1/arch/um/kernel/frame_kern.c linux/arch/um/kernel/frame_kern.c
--- linux-2.6.0-test8-um1/arch/um/kernel/frame_kern.c	2003-04-19 22:51:23.000000000 -0400
+++ linux/arch/um/kernel/frame_kern.c	2003-10-21 17:01:04.072546880 -0400
@@ -6,7 +6,6 @@
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
 #include "asm/signal.h"
-#include "asm/uaccess.h"
 #include "asm/ucontext.h"
 #include "frame_kern.h"
 #include "sigcontext.h"
diff -Nur linux-2.6.0-test8-um1/arch/um/os-Linux/drivers/ethertap_kern.c linux/arch/um/os-Linux/drivers/ethertap_kern.c
--- linux-2.6.0-test8-um1/arch/um/os-Linux/drivers/ethertap_kern.c	2003-06-16 22:03:36.000000000 -0400
+++ linux/arch/um/os-Linux/drivers/ethertap_kern.c	2003-10-21 17:01:39.024233416 -0400
@@ -8,7 +8,6 @@
 #include "linux/init.h"
 #include "linux/netdevice.h"
 #include "linux/etherdevice.h"
-#include "linux/init.h"
 #include "net_kern.h"
 #include "net_user.h"
 #include "etap.h"


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
