Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZuvd-0001Mb-Ci for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 12:48:45 -0700
Received: from [151.97.230.90] (helo=memento.home.lan)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZuvb-0008I9-VM
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 12:48:45 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 17:01:13 +0200
Message-Id: <11610972733507-git-send-email-blaisorblade@yahoo.it>
Subject: [uml-devel] uml: make Uml compile on FC6 kernel headers
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
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Ulrich Drepper <drepper@redhat.com>

From: Ulrich Drepper <drepper@redhat.com>

I need this patch to get a UML kernel to compile.  This is with the kernel
headers in FC6 which are automatically generated from the kernel tree. 
Some headers are missing but those files don't need them.  At least it
appears so since the resulting kernel works fine.

Tested on x86-64.

Signed-off-by: Ulrich Drepper <drepper@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/um/include/kern_util.h    |    1 -
 arch/um/sys-x86_64/stub_segv.c |    1 -
 2 files changed, 2 deletions(-)

diff -puN arch/um/include/kern_util.h~make-uml-copmile arch/um/include/kern_util.h
--- a/arch/um/include/kern_util.h~make-uml-copmile
+++ a/arch/um/include/kern_util.h
@@ -6,7 +6,6 @@
 #ifndef __KERN_UTIL_H__
 #define __KERN_UTIL_H__
 
-#include "linux/threads.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/faultinfo.h"
 
diff -puN arch/um/sys-x86_64/stub_segv.c~make-uml-copmile arch/um/sys-x86_64/stub_segv.c
--- a/arch/um/sys-x86_64/stub_segv.c~make-uml-copmile
+++ a/arch/um/sys-x86_64/stub_segv.c
@@ -5,7 +5,6 @@
 
 #include <stddef.h>
 #include <signal.h>
-#include <linux/compiler.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
_

Patches currently in -mm which might be from drepper@redhat.com are

make-uml-copmile.patch
honour-mnt_noexec-for-access.patch
kevent-core-files.patch
kevent-core-files-fix.patch
kevent-core-files-s390-hack.patch
kevent-poll-select-notifications.patch
kevent-socket-notifications.patch
kevent-socket-notifications-fix-2.patch
kevent-socket-notifications-fix-4.patch
kevent-timer-notifications.patch



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
