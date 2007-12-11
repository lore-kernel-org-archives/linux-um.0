Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1vlj-0004SH-7d for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 19:26:51 -0800
Received: from apollo.fprintf.net ([208.75.87.34])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1vlg-0000iV-PG
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 19:26:51 -0800
From: Daniel Gryniewicz <dang@fprintf.net>
In-Reply-To: <1197301533.6483.440.camel@athena.fprintf.net>
References: <20071208141753.GA4667@c2.user-mode-linux.org>
	<1197301533.6483.440.camel@athena.fprintf.net>
Content-Type: multipart/mixed; boundary="=-Bgs3lXnJXFCvsAhcMDbW"
Date: Mon, 10 Dec 2007 22:26:46 -0500
Message-Id: <1197343606.6483.484.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] SKAS3 for 2.6.23
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>


--=-Bgs3lXnJXFCvsAhcMDbW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 2007-12-10 at 10:45 -0500, Daniel Gryniewicz wrote:
> On Sat, 2007-12-08 at 09:17 -0500, Jeff Dike wrote:
> > A skas3 patch which works on 2.6.23 is below. 
> 
> BTW, it would appear that applying this patch breaks building the
> resulting kernel as a guest kernel, at least on x86_64.
> asm-x86_64/proc_mm.h doesn't end up in asm/, and the #includes don't use
> asm/arch.  I don't know if it's intended that this should work as a
> guest kernel?
> 
> Daniel

Okay, attached is a patch against 2.6.23.9 + skas3 patch to make it
build (and run) as a UML guest.  I've only tested it on x86_64 (but I
did use SUBARCH=i386).  I went the route of minimal changes to get it to
build, as just including things from asm/arch/ didn't work very well.

Daniel

--=-Bgs3lXnJXFCvsAhcMDbW
Content-Disposition: attachment; filename=uml-2.6.23-skas3-guest.patch
Content-Type: text/x-patch; name=uml-2.6.23-skas3-guest.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --exclude-from=/home/dang/.scripts/diffrc -up -ruN linux-2.6.23.orig/arch/um/sys-i386/ptrace_user.c linux-2.6.23/arch/um/sys-i386/ptrace_user.c
--- linux-2.6.23.orig/arch/um/sys-i386/ptrace_user.c	2007-10-09 16:31:38.000000000 -0400
+++ linux-2.6.23/arch/um/sys-i386/ptrace_user.c	2007-12-10 22:14:01.000000000 -0500
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include "ptrace_user.h"
 /* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
-#include <asm/user.h>
+#include <sys/user.h>
 #include "kern_util.h"
 #include "sysdep/thread.h"
 #include "user.h"
diff --exclude-from=/home/dang/.scripts/diffrc -up -ruN linux-2.6.23.orig/include/asm-um/compat.h linux-2.6.23/include/asm-um/compat.h
--- linux-2.6.23.orig/include/asm-um/compat.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.23/include/asm-um/compat.h	2007-12-10 21:57:27.000000000 -0500
@@ -0,0 +1,9 @@
+#ifndef _ASM_X86_64_COMPAT_H
+#define _ASM_X86_64_COMPAT_H
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
+
+#endif /* _ASM_X86_64_COMPAT_H */
diff --exclude-from=/home/dang/.scripts/diffrc -up -ruN linux-2.6.23.orig/include/asm-um/proc_mm.h linux-2.6.23/include/asm-um/proc_mm.h
--- linux-2.6.23.orig/include/asm-um/proc_mm.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.23/include/asm-um/proc_mm.h	2007-12-10 21:56:44.000000000 -0500
@@ -0,0 +1 @@
+#include <asm/arch/proc_mm.h>
diff --exclude-from=/home/dang/.scripts/diffrc -up -ruN linux-2.6.23.orig/include/asm-um/ptrace-x86_64.h linux-2.6.23/include/asm-um/ptrace-x86_64.h
--- linux-2.6.23.orig/include/asm-um/ptrace-x86_64.h	2007-10-09 16:31:38.000000000 -0400
+++ linux-2.6.23/include/asm-um/ptrace-x86_64.h	2007-12-10 21:58:07.000000000 -0500
@@ -87,4 +87,15 @@ extern void arch_switch_to_skas(struct t
 extern long arch_prctl_skas(struct task_struct *task, int code,
 			    unsigned long __user *addr);
 
+struct ptrace_faultinfo {
+	int is_write;
+	unsigned long addr;
+};
+
+struct ptrace_ldt {
+	int func;
+  	void *ptr;
+	unsigned long bytecount;
+};
+
 #endif

--=-Bgs3lXnJXFCvsAhcMDbW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--=-Bgs3lXnJXFCvsAhcMDbW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=-Bgs3lXnJXFCvsAhcMDbW--


