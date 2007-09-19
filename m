Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IY2wV-0006OT-KS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 10:02:27 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IY2wT-0006rR-V5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 10:02:27 -0700
Date: Wed, 19 Sep 2007 13:02:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070919170222.GA10161@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/11] UML - Eliminate hz()
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Eliminate hz() since its only purpose was to provide a kernel-space
constant to userspace code.  This can be done instead by providing the
constant directly through kernel_constants.h.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/common-offsets.h |    2 ++
 arch/um/include/kern_util.h      |    1 -
 arch/um/kernel/time.c            |    5 -----
 arch/um/os-Linux/skas/process.c  |    5 +++--
 arch/um/os-Linux/time.c          |    7 +++----
 5 files changed, 8 insertions(+), 12 deletions(-)

Index: linux-2.6.20/arch/um/include/common-offsets.h
===================================================================
--- linux-2.6.20.orig/arch/um/include/common-offsets.h	2007-09-19 12:24:52.000000000 -0400
+++ linux-2.6.20/arch/um/include/common-offsets.h	2007-09-19 12:25:05.000000000 -0400
@@ -32,3 +32,5 @@ DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
 DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
 
 DEFINE(UM_THREAD_SIZE, THREAD_SIZE);
+
+DEFINE(UM_HZ, HZ);
Index: linux-2.6.20/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.20.orig/arch/um/include/kern_util.h	2007-09-19 12:24:52.000000000 -0400
+++ linux-2.6.20/arch/um/include/kern_util.h	2007-09-19 12:25:05.000000000 -0400
@@ -64,7 +64,6 @@ extern void paging_init(void);
 extern void init_flush_vm(void);
 extern void *syscall_sp(void *t);
 extern void syscall_trace(struct uml_pt_regs *regs, int entryexit);
-extern int hz(void);
 extern unsigned int do_IRQ(int irq, struct uml_pt_regs *regs);
 extern void interrupt_end(void);
 extern void initial_thread_cb(void (*proc)(void *), void *arg);
Index: linux-2.6.20/arch/um/kernel/time.c
===================================================================
--- linux-2.6.20.orig/arch/um/kernel/time.c	2007-09-19 12:24:52.000000000 -0400
+++ linux-2.6.20/arch/um/kernel/time.c	2007-09-19 12:25:05.000000000 -0400
@@ -11,11 +11,6 @@
 #include "kern_util.h"
 #include "os.h"
 
-int hz(void)
-{
-	return HZ;
-}
-
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
Index: linux-2.6.20/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.20.orig/arch/um/os-Linux/skas/process.c	2007-09-19 12:24:52.000000000 -0400
+++ linux-2.6.20/arch/um/os-Linux/skas/process.c	2007-09-19 12:25:05.000000000 -0400
@@ -392,8 +392,9 @@ int copy_context_skas0(unsigned long new
 	*data = ((struct stub_data) { .offset	= MMAP_OFFSET(new_offset),
 				      .fd	= new_fd,
 				      .timer    = ((struct itimerval)
-					            { { 0, 1000000 / hz() },
-						      { 0, 1000000 / hz() }})});
+					            { { 0, 1000000 / UM_HZ },
+						      { 0, 1000000 / UM_HZ }})
+				 });
 	err = ptrace_setregs(pid, thread_regs);
 	if (err < 0)
 		panic("copy_context_skas0 : PTRACE_SETREGS failed, "
Index: linux-2.6.20/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.20.orig/arch/um/os-Linux/time.c	2007-09-19 12:24:52.000000000 -0400
+++ linux-2.6.20/arch/um/os-Linux/time.c	2007-09-19 12:25:05.000000000 -0400
@@ -8,14 +8,13 @@
 #include <signal.h>
 #include <time.h>
 #include <sys/time.h>
-#include "kern_util.h"
 #include "kern_constants.h"
 #include "os.h"
 #include "user.h"
 
 int set_interval(int is_virtual)
 {
-	int usec = 1000000/hz();
+	int usec = 1000000/UM_HZ;
 	int timer_type = is_virtual ? ITIMER_VIRTUAL : ITIMER_REAL;
 	struct itimerval interval = ((struct itimerval) { { 0, usec },
 							  { 0, usec } });
@@ -43,8 +42,8 @@ void disable_timer(void)
 void switch_timers(int to_real)
 {
 	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
-	struct itimerval enable = ((struct itimerval) { { 0, 1000000/hz() },
-							{ 0, 1000000/hz() }});
+	struct itimerval enable = ((struct itimerval) { { 0, 1000000/UM_HZ },
+							{ 0, 1000000/UM_HZ }});
 	int old, new;
 
 	if (to_real) {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
