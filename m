Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM6XI-0005ai-HH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 08:13:28 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CM6XH-0003wk-Fx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 08:13:28 -0700
Message-ID: <417D19EC.6090809@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Bad handling of invalif systemcalls
References: <4177D503.2030409@fujitsu-siemens.com>
	<200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
	<417D1277.3090603@fujitsu-siemens.com>
In-Reply-To: <417D1277.3090603@fujitsu-siemens.com>
Content-Type: multipart/mixed; boundary="------------070905080106050809080802"
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
Date: Mon, 25 Oct 2004 17:21:16 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070905080106050809080802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bodo Stroesser wrote:
> Jeff Dike wrote:
> 
>>
>> I would be tempted to #define SIGSYSCALL (SIGTRAP + 0x80) or something 
>> just
>> to make the +0x80 bit less magic-looking.
> 
> O.K. I defined it in signal_user.h, hope it's OK there. Consequently the
> definition is used in arch/um/kernel/ptrace.c to replace the 0x80 at the
> call to ptrace_notify().
> 
>>
>> In the SIGTRAP case, you might as well inline do_sigtrap.  One line 
>> functions
>> are pretty much a waste.
> 
> Sorry, I tried to inline it, but it failed to compile. At the moment 
> tracer.c
> contains functions without much knowledge about task structure only. 
> Without
> including the specific headers, inlining cannot be used.
> 
> So, attached you'll find the revised patches.
> 
> Bodo
Sorry, I missed one change. There still 0x80 is used in the first patch.
Thus, attached the final version (hopefully ...)

Bodo


--------------070905080106050809080802
Content-Type: text/plain;
 name="patch-TRACESYSGOOD-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-TRACESYSGOOD-1"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Patch 1/3 to implement usage of PTRACE_O_TRACESYSGOOD
This is necessary, to fix UMLs bad behavior when a process does
a systemcall with syscall-number less than 0.

Insert a check for availability and function of
  ptrace(PTRACE_SETOPTIONS,,,PTRACE_O_TRACESYSGOOD)
into the normal ptrace checks at startup.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

diff -puNr a/arch/um/include/signal_user.h b/arch/um/include/signal_user.h
--- a/arch/um/include/signal_user.h	2004-10-25 13:05:37.008823813 +0200
+++ b/arch/um/include/signal_user.h	2004-10-25 12:18:02.060620621 +0200
@@ -14,6 +14,8 @@ extern void set_handler(int sig, void (*
 extern int set_signals(int enable);
 extern int get_signals(void);
 
+#define SYSCALL_TRAP 0x80
+
 #endif
 
 /*
diff -puNr a/arch/um/kernel/process.c b/arch/um/kernel/process.c
--- a/arch/um/kernel/process.c	2004-10-25 13:05:37.008823813 +0200
+++ b/arch/um/kernel/process.c	2004-10-25 11:41:57.287362002 +0200
@@ -13,6 +13,7 @@
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/ptrace.h>
@@ -255,6 +256,9 @@ void __init check_ptrace(void)
 	printk("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
+	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
+
 	while(1){
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			panic("check_ptrace : ptrace failed, errno = %d", 
@@ -262,8 +266,8 @@ void __init check_ptrace(void)
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected SIGTRAP, "
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP|SYSCALL_TRAP)))
+			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
 			      "got status = %d", status);
 		
 		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,
diff -puNr a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
--- a/arch/um/kernel/ptrace.c	2004-10-25 13:05:37.009823648 +0200
+++ b/arch/um/kernel/ptrace.c	2004-10-25 12:27:41.169919438 +0200
@@ -17,6 +17,7 @@
 #include "kern_util.h"
 #include "ptrace_user.h"
 #include "skas_ptrace.h"
+#include "signal_user.h"
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -319,7 +320,7 @@ void syscall_trace(union uml_pt_regs *re
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				 ? 0x80 : 0));
+				 ? SYSCALL_TRAP : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do

--------------070905080106050809080802--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
