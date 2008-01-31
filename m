Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKbDC-0005OE-9z for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 07:20:22 -0800
Received: from qb-out-0506.google.com ([72.14.204.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKbDB-0002SB-Tx
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 07:20:22 -0800
Received: by qb-out-0506.google.com with SMTP id c8so737771qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Jan 2008 07:20:20 -0800 (PST)
Date: Thu, 31 Jan 2008 23:17:41 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080131151741.GE2471@hacking>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [git Patch] UML: a build error fix
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@karaya.com>, user-mode-linux-devel@lists.sourceforge.net


This patch fixed this error:

arch/um/kernel/skas/syscall.c: In function 'handle_syscall':
arch/um/kernel/skas/syscall.c:33: error: 'NR_syscalls' undeclared (first use in this function)
arch/um/kernel/skas/syscall.c:33: error: (Each undeclared identifier is reported only once
arch/um/kernel/skas/syscall.c:33: error: for each function it appears in.)
make[2]: *** [arch/um/kernel/skas/syscall.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2


Cc: Jeff Dike <jdike@karaya.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

diff --git a/arch/um/include/sysdep-i386/kernel-offsets.h b/arch/um/include/sysdep-i386/kernel-offsets.h
index 5868526..da820d2 100644
--- a/arch/um/include/sysdep-i386/kernel-offsets.h
+++ b/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -15,7 +15,11 @@
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem));
 
+static char syscalls[] = {
+#include <asm/arch/unistd.h>
+};
 void foo(void)
 {
 #include <common-offsets.h>
+DEFINE(UM_NR_syscall_max, sizeof(syscalls) - 1);
 }
diff --git a/arch/um/include/sysdep-i386/syscalls.h b/arch/um/include/sysdep-i386/syscalls.h
index 57bd79e..fb1fd94 100644
--- a/arch/um/include/sysdep-i386/syscalls.h
+++ b/arch/um/include/sysdep-i386/syscalls.h
@@ -5,6 +5,7 @@
 
 #include "asm/unistd.h"
 #include "sysdep/ptrace.h"
+#include "kern_constants.h"
 
 typedef long syscall_handler_t(struct pt_regs);
 
@@ -23,3 +24,6 @@ extern syscall_handler_t *sys_call_table[];
 extern long sys_mmap2(unsigned long addr, unsigned long len,
 		      unsigned long prot, unsigned long flags,
 		      unsigned long fd, unsigned long pgoff);
+
+#define NR_syscalls (UM_NR_syscall_max + 1)
+

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
