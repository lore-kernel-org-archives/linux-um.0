Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZuvd-0001Mg-Qz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 12:48:45 -0700
Received: from [151.97.230.90] (helo=memento.home.lan)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZuvd-0008IA-F9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 12:48:45 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 17:05:31 +0200
Message-Id: <11610975311236-git-send-email-blaisorblade@yahoo.it>
Subject: [uml-devel] uml: remove warnings added by previous -stable patch
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add needed includes for syscall() function, also to remove warnings spit out by
GCC; they were added by previous -stable patch, and at least on my system
(Ubuntu x86-64) these warnings do show up.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.18/arch/um/os-Linux/sys-i386/tls.c
===================================================================
--- linux-2.6.18.orig/arch/um/os-Linux/sys-i386/tls.c
+++ linux-2.6.18/arch/um/os-Linux/sys-i386/tls.c
@@ -1,4 +1,6 @@
 #include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
 #include <linux/unistd.h>
 #include "sysdep/tls.h"
 #include "user_util.h"
Index: linux-2.6.18/arch/um/os-Linux/tls.c
===================================================================
--- linux-2.6.18.orig/arch/um/os-Linux/tls.c
+++ linux-2.6.18/arch/um/os-Linux/tls.c
@@ -1,6 +1,8 @@
 #include <errno.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 #include <asm/ldt.h>
+#include <unistd.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
