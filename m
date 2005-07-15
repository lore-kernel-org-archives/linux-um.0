Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtSFB-0000SE-KA	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 08:36:53 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DtSF9-0002ty-1L	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 08:36:53 -0700
Message-ID: <42D7D802.2080100@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080800080608000204090009"
Subject: [uml-devel] Some changes in SKAS0
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
Date: Fri, 15 Jul 2005 17:36:34 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>, BlaisorBlade <blaisorblade_spam@yahoo.it>

This is a multi-part message in MIME format.
--------------080800080608000204090009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I tried to adapt fix-stub_segv-stack.patch to my s390.
Unfortunately sigreturn on s390 needs to have the address
of the entire signal-stackframe in r15. What is given to the
handler as a param is a pointer to the sigcontext only.
stackframe contains some space for handler's register saving
_before_ sigcontext.
So I thought about avoiding the sigreturn at all. Working on
this I found out some small points:

- there is a bug (typo) in wait_stub_done()

- stopping stub_segv_handler with a "breakpoint" without
   calling sigreturn, lets SIGSEGV being blocked after that.
   At the next SIGSEGV, I see stub_wait_done() calling panic
   just as with Rob's problem. And I see the child being gone!
   I understand, that the host unblocks SIGSEGV and sets the
   handler to SIG_DFL. But I don't understand, why the child
   already is gone after the waitpid(), without resuming it.
   I guess, this is the reason for Rob not being able to debug
   the problem.
   Thus I added SA_NOMASK to the flags for the handler.

- I changed the additional mask for the handler to be empty.
   The only exception is x86_64, that currently must use sigreturn
   and therefore still masks SIGUSR1 while the handler runs.
   In skas, userspace shouldn't receive SIGIO or SIGWINCH (I hope
   I'm right here?), SIGVTALRM already is handled by wait_stub_done.
   Then I changed i386's stub_segv_handler to stop using "int3"
   immediately after saving faultinfo.
   This new method saves some syscalls on i386 and s390 and
   simplifies s390.

All three patches are attached. They are tested in i386 and s390,
for me they work fine. I hope, the patches don't break x86_64.
Unfortunately I can't test that.
If there would be a solution for the RCX problem on x86_64, I would
prefer to use the "int3" this subarch also, making the nasty
ARCH_STUB_SEGV_MASK_SIGNAL macro obsolete.

	Bodo

--------------080800080608000204090009
Content-Type: text/x-diff;
 name="fix-wait_stub_done.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-wait_stub_done.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Fix a typo in wait_stub_done.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/os-Linux/skas/process.c~fix-wait_stub_done arch/um/os-Linux/skas/process.c
--- linux-2.6.12-rc4/arch/um/os-Linux/skas/process.c~fix-wait_stub_done	2005-07-15 10:12:50.546041239 +0200
+++ linux-2.6.12-rc4-root/arch/um/os-Linux/skas/process.c	2005-07-15 10:13:23.735743112 +0200
@@ -64,7 +64,7 @@ void wait_stub_done(int pid, int sig, ch
 	        (WSTOPSIG(status) == SIGVTALRM));
 
 	if((n < 0) || !WIFSTOPPED(status) ||
-	   (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status != SIGTRAP))){
+	   (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
 		panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
 		      "pid = %d, n = %d, errno = %d, status = 0x%x\n",
 		      fname, pid, n, errno, status);
_

--------------080800080608000204090009
Content-Type: text/x-diff;
 name="fix-SEGV-masking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-SEGV-masking.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Masking SIGSEGV in stub_segv_handler is bad. If a SIGSEGV happens
while stub_segv_handler is running, the host will force the signal,
so the child is killed. This makes stub_segv_handler hard to
debug.
So, we add SA_NOMASK to the flags in sigaction, to have SIGSEGV
unblocked, ebven while the handler runs.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/os-Linux/skas/process.c~fix-SEGV-masking arch/um/os-Linux/skas/process.c
--- linux-2.6.12-rc4/arch/um/os-Linux/skas/process.c~fix-SEGV-masking	2005-07-15 13:33:55.240371787 +0200
+++ linux-2.6.12-rc4-root/arch/um/os-Linux/skas/process.c	2005-07-15 13:35:37.379660671 +0200
@@ -182,7 +182,7 @@ static int userspace_tramp(void *stack)
 				  (unsigned long) &__syscall_stub_start;
 
 		set_sigstack((void *) UML_CONFIG_STUB_DATA, page_size());
-		set_handler(SIGSEGV, (void *) v, SA_ONSTACK,
+		set_handler(SIGSEGV, (void *) v, SA_ONSTACK | SA_NOMASK,
 			    SIGIO, SIGWINCH, SIGALRM, SIGVTALRM,
 			    SIGUSR1, -1);
 	}
_

--------------080800080608000204090009
Content-Type: text/x-diff;
 name="tune-stub_segv_handler.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tune-stub_segv_handler.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch changes stub_segv_handler for i386 (and s390 later)
to simplify it and save some syscalls.
My previous patch already left SIGSEGV unmasked while stub_segv_handler
is running.
Now, we do no longer mask *any* signals if stub_segv_handler runs.
SIG(RT)ALRM already is handled by wait_stub_done(), the other
signals (SIGIO, SIGWINCH) must not happen.
stub_segv_handler for i386 (and s390) now stop *inside* stub_segv_handler
using "int3" and do no longer call sigreturn.

For this, SIGUSR1 no longer should be blocked. So i386 (and s390) set:
   #define ARCH_STUB_SEGV_MASK_SIGNAL -1
while x86_64 sets
   #define ARCH_STUB_SEGV_MASK_SIGNAL SIGUSR1
Thus, x86_64 further uses sigreturn at the end of its stub_segv_handler
to avoid the RCX problem. As soon as that problem is solved, x86_64 also
might stop using "int3".

Using the change, we no longer need to care about correct stack pointer
for sigreturn, which would cause some nasty code on s390.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/os-Linux/skas/process.c~tune-stub_segv_handler arch/um/os-Linux/skas/process.c
--- linux-2.6.12-rc4/arch/um/os-Linux/skas/process.c~tune-stub_segv_handler	2005-07-15 14:12:15.240075682 +0200
+++ linux-2.6.12-rc4-root/arch/um/os-Linux/skas/process.c	2005-07-15 14:12:15.252071977 +0200
@@ -183,8 +183,7 @@ static int userspace_tramp(void *stack)
 
 		set_sigstack((void *) UML_CONFIG_STUB_DATA, page_size());
 		set_handler(SIGSEGV, (void *) v, SA_ONSTACK | SA_NOMASK,
-			    SIGIO, SIGWINCH, SIGALRM, SIGVTALRM,
-			    SIGUSR1, -1);
+			    ARCH_STUB_SEGV_MASK_SIGNAL, -1);
 	}
 
 	os_stop_process(os_getpid());
diff -puN arch/um/sys-i386/stub_segv.c~tune-stub_segv_handler arch/um/sys-i386/stub_segv.c
--- linux-2.6.12-rc4/arch/um/sys-i386/stub_segv.c~tune-stub_segv_handler	2005-07-15 14:12:15.242075065 +0200
+++ linux-2.6.12-rc4-root/arch/um/sys-i386/stub_segv.c	2005-07-15 14:13:17.652802252 +0200
@@ -19,13 +19,8 @@ stub_segv_handler(int sig)
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA), 
 			      sc);
 
-	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
-	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
-		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
-	/* Load pointer to sigcontext into esp, since we need to leave
-	 * the stack in its original form when we do the sigreturn here, by
-	 * hand.
+	/* Our work is done, just stop the handler.
+	 * Registers will be restored later, if userspace() restarts us.
 	 */
-	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
-		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
+	__asm__("int3");
 }
diff -puN arch/um/include/sysdep-i386/faultinfo.h~tune-stub_segv_handler arch/um/include/sysdep-i386/faultinfo.h
--- linux-2.6.12-rc4/arch/um/include/sysdep-i386/faultinfo.h~tune-stub_segv_handler	2005-07-15 14:12:15.245074138 +0200
+++ linux-2.6.12-rc4-root/arch/um/include/sysdep-i386/faultinfo.h	2005-07-15 14:12:15.253071669 +0200
@@ -26,4 +26,6 @@ struct faultinfo {
 
 #define PTRACE_FULL_FAULTINFO 0
 
+#define ARCH_STUB_SEGV_MASK_SIGNAL -1
+
 #endif
diff -puN arch/um/include/sysdep-x86_64/faultinfo.h~tune-stub_segv_handler arch/um/include/sysdep-x86_64/faultinfo.h
--- linux-2.6.12-rc4/arch/um/include/sysdep-x86_64/faultinfo.h~tune-stub_segv_handler	2005-07-15 14:12:15.247073521 +0200
+++ linux-2.6.12-rc4-root/arch/um/include/sysdep-x86_64/faultinfo.h	2005-07-15 14:12:15.253071669 +0200
@@ -26,4 +26,6 @@ struct faultinfo {
 
 #define PTRACE_FULL_FAULTINFO 1
 
+#define ARCH_STUB_SEGV_MASK_SIGNAL SIGUSR1
+
 #endif
_

--------------080800080608000204090009--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
