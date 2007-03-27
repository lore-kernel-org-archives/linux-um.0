Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HW1ZP-0003x0-Ot for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Mar 2007 19:37:59 -0700
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HW1ZO-0004qX-JI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Mar 2007 19:37:59 -0700
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <20070325145232.GB4901@c2.user-mode-linux.org>
References: <1174764836.15059.6.camel@athena.fprintf.net>
	<20070325012758.GA8260@c2.user-mode-linux.org>
	<1174793788.5906.16.camel@athena.fprintf.net>
	<20070325145232.GB4901@c2.user-mode-linux.org>
Content-Type: multipart/mixed; boundary="=-keWsZMMT0paN5SPJ/g84"
Date: Mon, 26 Mar 2007 22:36:01 -0400
Message-Id: <1174962961.5906.94.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] missing asm/user.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


--=-keWsZMMT0paN5SPJ/g84
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2007-03-25 at 10:52 -0400, Jeff Dike wrote:
> On Sat, Mar 24, 2007 at 11:36:28PM -0400, Daniel Gryniewicz wrote:
> > Update:  <asm/elf.h> isn't there either, but <sys/user.h> includes
> > user_regs_struct, so that's sufficient for this problem.
> 
> Hummph, I hope that's true of every other distro that people use UML on.

Bad news:  It has user_regs_struct, but not user_i387_struct or
user_fxsr_struct (at least not on x86_64).

> > The next problem is lack of <asm/page.h>.  Most files failing to build
> > with it can simply have it removed.  I've temporarily replaced PAGE_SIZE
> > with sysconf(_SC_PAGESIZE) for now, and we'll see how that works.
> 
> Send patches.
> 
> BTW, the important thing about PAGE_SIZE in the userspace side of UML
> is not that it be the same as sysconf(_SC_PAGESIZE) but that it match
> the value of PAGE_SIZE in the kernelspace side.  Obviously, these
> values will all be the same everywhere that we care about now, but I
> can think of one or two situations where it would matter.  On an
> architecture with a variable page size, the UML kernel can have a
> PAGE_SIZE of 64K but the host's sysconf can report a page size of 4K.
> In this case, it's important that PAGE_SIZE in UML userspace code be
> 64K.
> 
> So, there's UM_KERN_PAGE_SIZE in kern_constants.h which is derived
> from the kernel's PAGE_SIZE and is usable in userspace files.  Use
> that instead of sysconf().

Thanks for the pointer.  Here's a patch I've used to test.  There are
two problems with it.  First, as mentioned above, I couldn't find two
user structs anywhere in the gentoo headers.  It's possibly we could
convince the maintainers to add those back, since they're for gdb.  I'm
not sure, tho, so I just defined them inline for now.

Second, PAGE_MASK and PAGE_SHIFT.  These should be generated like
UM_KERN_PAGE_SIZE above, but I wasn't able to find where they're
generated (sorry, not up on my Kconfig magic...).

That said, the patch *does* work here on my x86_64 box, both in native
and on SUBARCH=i386 modes.  I don't have any more exotic arches than
that to test on.

Daniel

--=-keWsZMMT0paN5SPJ/g84
Content-Disposition: attachment; filename=linux-2.6.20-gentoo-headers.patch
Content-Type: text/x-patch; name=linux-2.6.20-gentoo-headers.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/include/sysdep-i386/stub.h linux-2.6.20/arch/um/include/sysdep-i386/stub.h
--- linux-2.6.20.orig/arch/um/include/sysdep-i386/stub.h	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/include/sysdep-i386/stub.h	2007-03-26 16:11:39.000000000 -0400
@@ -9,7 +9,6 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "stub-data.h"
 #include "kern_constants.h"
 #include "uml-config.h"
diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/kernel/skas/clone.c linux-2.6.20/arch/um/kernel/skas/clone.c
--- linux-2.6.20.orig/arch/um/kernel/skas/clone.c	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/kernel/skas/clone.c	2007-03-26 14:56:27.000000000 -0400
@@ -3,7 +3,6 @@
 #include <sys/mman.h>
 #include <sys/time.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "ptrace_user.h"
 #include "skas.h"
 #include "stub-data.h"
diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/os-Linux/main.c linux-2.6.20/arch/um/os-Linux/main.c
--- linux-2.6.20.orig/arch/um/os-Linux/main.c	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/os-Linux/main.c	2007-03-26 14:56:59.000000000 -0400
@@ -12,7 +12,6 @@
 #include <sys/resource.h>
 #include <sys/mman.h>
 #include <sys/user.h>
-#include <asm/page.h>
 #include "user_util.h"
 #include "kern_util.h"
 #include "mem_user.h"
diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/os-Linux/skas/mem.c linux-2.6.20/arch/um/os-Linux/skas/mem.c
--- linux-2.6.20.orig/arch/um/os-Linux/skas/mem.c	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/os-Linux/skas/mem.c	2007-03-26 16:13:41.000000000 -0400
@@ -8,7 +8,6 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
-#include <asm/page.h>
 #include <asm/unistd.h>
 #include "mem_user.h"
 #include "mem.h"
@@ -109,6 +108,8 @@ static inline long do_syscall_stub(struc
 	return ret;
 }
 
+#define PAGE_MASK   (~(UM_KERN_PAGE_SIZE-1))
+#define PAGE_SHIFT  12
 long run_syscall_stub(struct mm_id * mm_idp, int syscall,
 		      unsigned long *args, long expected, void **addr,
 		      int done)
@@ -133,7 +134,7 @@ long run_syscall_stub(struct mm_id * mm_
 	multi_op_count++;
 
 	if(!done && ((((unsigned long) stack) & ~PAGE_MASK) <
-		     PAGE_SIZE - 10 * sizeof(long))){
+		     UM_KERN_PAGE_SIZE - 10 * sizeof(long))){
 		*addr = stack;
 		return 0;
 	}
@@ -152,7 +153,7 @@ long syscall_stub_data(struct mm_id * mm
 	 * Thus in this case do_syscall_stub correctly won't be called.
 	 */
 	if((((unsigned long) *addr) & ~PAGE_MASK) >=
-	   PAGE_SIZE - (10 + data_count) * sizeof(long)) {
+	   UM_KERN_PAGE_SIZE - (10 + data_count) * sizeof(long)) {
 		ret = do_syscall_stub(mm_idp, addr);
 		/* in case of error, don't overwrite data on stack */
 		if(ret)
diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/os-Linux/start_up.c linux-2.6.20/arch/um/os-Linux/start_up.c
--- linux-2.6.20.orig/arch/um/os-Linux/start_up.c	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/os-Linux/start_up.c	2007-03-26 14:57:45.000000000 -0400
@@ -18,7 +18,6 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include <sys/types.h>
 #include "user_util.h"
 #include "kern_util.h"
@@ -79,11 +78,11 @@ static int start_ptraced_child(void **st
 	unsigned long sp;
 	int pid, n, status;
 
-	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+	stack = mmap(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if(stack == MAP_FAILED)
 		panic("check_ptrace : mmap failed, errno = %d", errno);
-	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
+	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
 	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
 	if(pid < 0)
 		panic("start_ptraced_child : clone failed, errno = %d", errno);
@@ -128,7 +127,7 @@ static int stop_ptraced_child(int pid, v
 		ret = -1;
 	}
 
-	if(munmap(stack, PAGE_SIZE) < 0)
+	if(munmap(stack, UM_KERN_PAGE_SIZE) < 0)
 		panic("check_ptrace : munmap failed, errno = %d", errno);
 	return ret;
 }
diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/sys-i386/ptrace_user.c linux-2.6.20/arch/um/sys-i386/ptrace_user.c
--- linux-2.6.20.orig/arch/um/sys-i386/ptrace_user.c	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/sys-i386/ptrace_user.c	2007-03-26 16:14:34.000000000 -0400
@@ -7,9 +7,8 @@
 #include <stddef.h>
 #include <errno.h>
 #include <unistd.h>
+#include <sys/user.h>
 #include "ptrace_user.h"
-/* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
-#include <asm/user.h>
 #include "kern_util.h"
 #include "sysdep/thread.h"
 #include "user.h"
diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/sys-i386/user-offsets.c linux-2.6.20/arch/um/sys-i386/user-offsets.c
--- linux-2.6.20.orig/arch/um/sys-i386/user-offsets.c	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/sys-i386/user-offsets.c	2007-03-26 16:10:51.000000000 -0400
@@ -1,7 +1,7 @@
 #include <stdio.h>
 #include <signal.h>
 #include <asm/ptrace.h>
-#include <asm/user.h>
+#include <sys/user.h>
 #include <stddef.h>
 #include <sys/poll.h>
 
@@ -14,6 +14,34 @@
 #define OFFSET(sym, str, mem) \
 	DEFINE(sym, offsetof(struct str, mem));
 
+/* These are gone from userspace; not sure where to pull them from */
+struct user_i387_struct {
+	long	cwd;
+	long	swd;
+	long	twd;
+	long	fip;
+	long	fcs;
+	long	foo;
+	long	fos;
+	long	st_space[20];	/* 8*10 bytes for each FP-reg = 80 bytes */
+};
+
+struct user_fxsr_struct {
+	unsigned short	cwd;
+	unsigned short	swd;
+	unsigned short	twd;
+	unsigned short	fop;
+	long	fip;
+	long	fcs;
+	long	foo;
+	long	fos;
+	long	mxcsr;
+	long	reserved;
+	long	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
+	long	xmm_space[32];	/* 8*16 bytes for each XMM-reg = 128 bytes */
+	long	padding[56];
+};
+
 void foo(void)
 {
 	OFFSET(HOST_SC_IP, sigcontext, eip);
diff --exclude-from=/home/dang/bin/scripts/diffrc -up -ruN linux-2.6.20.orig/arch/um/sys-x86_64/user-offsets.c linux-2.6.20/arch/um/sys-x86_64/user-offsets.c
--- linux-2.6.20.orig/arch/um/sys-x86_64/user-offsets.c	2007-02-04 13:44:54.000000000 -0500
+++ linux-2.6.20/arch/um/sys-x86_64/user-offsets.c	2007-03-26 14:55:27.000000000 -0400
@@ -12,7 +12,7 @@
  */
 typedef __u64 u64;
 typedef __u32 u32;
-#include <asm/user.h>
+#include <sys/user.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))

--=-keWsZMMT0paN5SPJ/g84
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-keWsZMMT0paN5SPJ/g84
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=-keWsZMMT0paN5SPJ/g84--

