Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiHh9-0003Xy-N4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:47 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AiHh8-0003BN-Qf for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:30:46 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml-patch-2.6.1
References: <200401140725.i0E7Pr9b001444@uml.user-mode-linux.org>
In-Reply-To: <200401140725.i0E7Pr9b001444@uml.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EMrCArlgxp4YOdK"
Message-Id: <200401181723.32498.blaisorblade_spam@yahoo.it>
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
Date: Sun, 18 Jan 2004 17:23:32 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>



--Boundary-00=_EMrCArlgxp4YOdK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> This patch updates UML to 2.6.1. 

Try disabling CONFIG_MODE_TT and you'll see that 
arch/um/kernel/skas/include/uaccess.h doesn't compile (it uses EFAULT but 
errno.h is included only by arch/um/kernel/tt/include/uaccess.h).

Also, I never saw depmod (on modules_install, with the patches I said you to 
merge) giving this:
WARNING: 
/home/paolo/Uml/slack90.mnt/lib/modules/2.6.1-1um/kernel/fs/hostfs/hostfs.ko 
needs unknown symbol mknod
WARNING: 
/home/paolo/Uml/slack90.mnt/lib/modules/2.6.1-1um/kernel/fs/hostfs/hostfs.ko 
needs unknown symbol lstat64

This happens because hostfs is not compiled with -O2, since now -O2 is added 
to CFLAGS after including arch/??/Makefile. The inlines that do the needed 
wrapping are defined(in /usr/include/sys/stat.h) only if _OPTIMIZE_ if 
defined (probably because inlines don't work otherwise, but other inlines are 
defined anyway, so there is also a libc bug). So, I'm attaching the fix.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_EMrCArlgxp4YOdK
Content-Type: text/x-diff; charset="iso-8859-1"; name="FixHostfs-compile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="FixHostfs-compile.patch"

--- ./arch/um/Makefile.fix	2004-01-18 10:07:33.000000000 +0100
+++ ./arch/um/Makefile	2004-01-18 17:18:17.000000000 +0100
@@ -137,8 +137,21 @@
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
+#From main Makefile, these options are set after including the ARCH makefile.
+#So copy them here.
+
+ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
+USER_CFLAGS		+= -Os
+else
+USER_CFLAGS		+= -O2
+endif
+
+ifndef CONFIG_FRAME_POINTER
+USER_CFLAGS		+= -fomit-frame-pointer
+endif
+
 ifdef CONFIG_DEBUG_INFO
-USER_CFLAGS          += -g
+USER_CFLAGS		+= -g
 endif
 
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds.s \

--Boundary-00=_EMrCArlgxp4YOdK--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
