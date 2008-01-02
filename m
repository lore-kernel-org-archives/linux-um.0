Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA7mO-0007dq-51 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 09:53:24 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JA7mN-0008VE-FQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 09:53:24 -0800
Message-Id: <E1JA7m0-0007nP-Fi@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 02 Jan 2008 18:53:00 +0100
Subject: [uml-devel] UML woes in 2.6.24-rc6-mm1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The below patch was needed to make UML compile in latest -mm.

But sometimes it doesn't boot and does weird things (this is a sample
with init=/bin/bash):

[    0.420000] EXT3-fs: mounted filesystem with ordered data mode.
[    0.420000] VFS: Mounted root (ext3 filesystem) readonly.
(none):/# ls
(none):/# ls -al
total 70
drwxr-xr-x 23 root root   1024 May  4  2007 .
drwxr-xr-x 23 root root   1024 May  4  2007 ..
drwxr-xr-x  2 root root   2048 Feb 18  2007 bin
drwxr-xr-x  2 root root   1024 May 16  2005 boot
[...]
(none):/# ls
Segmentation fault
(none):/# ls -l
: : No such file or directory

Miklos
----

Index: linux/arch/um/Kconfig
===================================================================
--- linux.orig/arch/um/Kconfig	2008-01-02 14:54:04.000000000 +0100
+++ linux/arch/um/Kconfig	2008-01-02 17:01:36.000000000 +0100
@@ -223,6 +223,10 @@ config KERNEL_STACK_ORDER
 
 endmenu
 
+config HZ
+	int
+	default 100
+
 source "init/Kconfig"
 
 source "drivers/block/Kconfig"
Index: linux/include/asm-um/param.h
===================================================================
--- linux.orig/include/asm-um/param.h	2007-10-09 22:31:38.000000000 +0200
+++ linux/include/asm-um/param.h	2008-01-02 17:02:31.000000000 +0100
@@ -10,7 +10,7 @@
 #define MAXHOSTNAMELEN  64      /* max length of hostname */
 
 #ifdef __KERNEL__
-#define HZ 100
+#define HZ CONFIG_HZ
 #define USER_HZ	100	   /* .. some user interfaces are in "ticks" */
 #define CLOCKS_PER_SEC (USER_HZ)  /* frequency at which times() counts */
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
