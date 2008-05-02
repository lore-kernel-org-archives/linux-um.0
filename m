Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Js4ZF-0006QY-7d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 16:21:29 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user22444)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Js4ZC-0005is-LW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 16:21:29 -0700
References: <877iel7ljp.fsf@hades.wkstn.nix> <87ve256146.fsf@hades.wkstn.nix>
	<871w4sqxgv.fsf@hades.wkstn.nix>
	<20080428164443.GB9628@c2.user-mode-linux.org>
	<871w4n9fo8.fsf@hades.wkstn.nix>
	<20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
	<20080502163020.GB7843@c2.user-mode-linux.org>
	<87bq3o5yeo.fsf@hades.wkstn.nix>
	<20080502195720.GB10369@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Sat, 03 May 2008 00:21:15 +0100
In-Reply-To: <20080502195720.GB10369@c2.user-mode-linux.org> (Jeff Dike's
	message of "Fri, 2 May 2008 15:57:20 -0400")
Message-ID: <87k5ic47is.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 2 May 2008, Jeff Dike stated:

> On Fri, May 02, 2008 at 07:55:11PM +0100, Nix wrote:
>> I'm trying something else now, arranging for os_nsecs() itself to do the
>> never-backwards stuff on the assumption that something depends on
>> monotonic timers not skipping backwards which presently they might
>> (there are callers of os_nsecs() outside of os-Linux/time.c, notably in
>> kernel/time.c, and currently they see an unadjusted time, jumping
>> backwards and forwards and whatever).
>
> This sounds like a reasonable idea.

With this patch (migrating most of the work into os_nsecs(), with a
non-NO_HZ version doing skew computations too, atop your first patch,
and making a couple of variables static for good measure), I still had
no luck:

Index: linux/arch/um/os-Linux/time.c
===================================================================
--- linux.orig/arch/um/os-Linux/time.c	2008-05-02 16:06:14.000000000 +0100
+++ linux/arch/um/os-Linux/time.c	2008-05-02 16:28:29.000000000 +0100
@@ -73,15 +73,29 @@
 	return remain;
 }
 
+static unsigned long long last_tick;
+
+#ifdef UML_CONFIG_NO_HZ
 long long os_nsecs(void)
 {
 	struct timeval tv;
+	long long this_tick;
 
 	gettimeofday(&tv, NULL);
-	return timeval_to_ns(&tv);
+	this_tick = timeval_to_ns(&tv);
+
+	/* Ensure that host time going backwards is treated as if it had stood
+	 * still.
+	 */
+
+	if ((last_tick != 0) && (this_tick < last_tick))
+		this_tick = last_tick;
+
+	last_tick = this_tick;
+
+	return this_tick;
 }
 
-#ifdef UML_CONFIG_NO_HZ
 static int after_sleep_interval(struct timespec *ts)
 {
 	return 0;
@@ -98,15 +112,22 @@
 }
 
 #else
-unsigned long long last_tick;
-unsigned long long skew;
+static unsigned long long skew;
+static int one_tick = UM_NSEC_PER_SEC / UM_HZ;
 
-static void deliver_alarm(void)
+long long os_nsecs(void)
 {
-	unsigned long long this_tick = os_nsecs();
-	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
+	struct timeval tv;
+	long long this_tick;
+
+	gettimeofday(&tv, NULL);
+	this_tick = timeval_to_ns(&tv);
+
+	/* Keep a running computation of the number of ticks lost due to host
+	 * load, and ensure that host time going backwards is treated as if it
+	 * had stood still.
+	 */
 
-	/* Protection against the host's time going backwards */
 	if ((last_tick != 0) && (this_tick < last_tick))
 		this_tick = last_tick;
 
@@ -114,13 +135,20 @@
 		last_tick = this_tick - one_tick;
 
 	skew += this_tick - last_tick;
+	last_tick = this_tick;
+
+	return this_tick;
+}
 
+static void deliver_alarm(void)
+{
+	/* Recompute the skew values and wait until skew is near-zero again. */
+	os_nsecs();
 	while (skew >= one_tick) {
 		alarm_handler(SIGVTALRM, NULL);
 		skew -= one_tick;
 	}
 
-	last_tick = this_tick;
 }
 
 static unsigned long long sleep_time(unsigned long long nsecs)

> Another thing you might try is the following:
> 	get two extra windows
> 	in one, get a "strace -p uml-pid -o strace.out -tt" ready
> 	in two, get a "date ; sudo date -s "now-5 sec" ; date" ready
> 	hit return in one, then in two, then in your UML window
> 	when the UML gives you another prompt (or you've decided it's
> hung), ^C the strace

*slap* why didn't I think of that?

... unfortunately it's not terribly informative. Here, with an earlier
gettimeofday() included for context:

00:15:10.606808 gettimeofday({1209770110, 606883}, NULL) = 0
[...]
00:15:10.804151 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == 133}], WSTOPPED|__WALL) = 9963
00:15:10.804271 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.804391 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.804499 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:10.804671 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:10.804754 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == 133}], WSTOPPED|__WALL) = 9963
00:15:10.804876 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.804994 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.805103 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:10.805249 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:10.805332 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == 133}], WSTOPPED|__WALL) = 9963
00:15:10.805453 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.805572 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.805680 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:10.805925 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:10.806020 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED|__WALL) = 9963
00:15:10.806141 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.806257 ptrace(0x34 /* PTRACE_??? */, 9963, 0, 0xde42a6c) = 0
00:15:10.806393 write(36, "6\0\0\0\0000\255*\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0000\244\0", 28) = 28
00:15:10.806613 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:10.806732 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:10.806867 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:10.806949 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED|__WALL) = 9963
00:15:05.811501 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.811674 ptrace(0x34 /* PTRACE_??? */, 9963, 0, 0xde42a6c) = 0
00:15:05.812544 write(36, "6\0\0\0\0\0\255*\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0\0\244\0", 28) = 28
00:15:05.812853 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.812983 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:05.813467 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:05.813640 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED|__WALL) = 9963
00:15:05.813797 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.813918 ptrace(0x34 /* PTRACE_??? */, 9963, 0, 0xde42a6c) = 0
00:15:05.814055 write(36, "6\0\0\0\0\220\257*\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0\220\243\0", 28) = 28
00:15:05.814276 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.814400 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:05.814559 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:05.814645 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED|__WALL) = 9963
00:15:05.814764 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.814879 ptrace(0x34 /* PTRACE_??? */, 9963, 0, 0xde42a6c) = 0
00:15:05.815003 write(36, "6\0\0\0\0\20\255*\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0 \244\0", 28) = 28
00:15:05.815198 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.815316 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:05.815453 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:05.815535 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED|__WALL) = 9963
00:15:05.815654 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.815768 ptrace(0x34 /* PTRACE_??? */, 9963, 0, 0xde42a6c) = 0
00:15:05.815890 write(36, "6\0\0\0\0 \255*\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0@\244\0", 28) = 28
00:15:05.816081 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.816234 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:05.816381 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:05.816463 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED|__WALL) = 9963
00:15:05.816582 ptrace(PTRACE_GETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.816695 ptrace(0x34 /* PTRACE_??? */, 9963, 0, 0xde42a6c) = 0
00:15:05.816819 write(36, "6\0\0\0\0\300\260*\0\20\0\0\5\0\0\0\21\0\0\0\3\0\0\0\0p\241\0", 28) = 28
00:15:05.817013 ptrace(PTRACE_SETREGS, 9963, 0, 0xde42a28) = 0
00:15:05.817132 ptrace(0x1f /* PTRACE_??? */, 9963, 0, 0) = 0
00:15:05.817274 --- SIGCHLD (Child exited) @ 0 (0) ---
00:15:05.817357 waitpid(9963, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED|__WALL) = 9963
00:15:05.817574 --- SIGVTALRM (Virtual timer expired) @ 0 (0) ---
00:15:05.817842 gettimeofday({1209770105, 817925}, NULL) = 0

So there's basically nothing unusual here. The first gettimeofday() call
after the jump, and *whoompf* we're off into the magic land of looping
with no extra syscalls to speak of at all.

Next attempt, tomorrow: run it under gdb with an LD_PRELOADed wrapper
around gettimeofday() that raises some unusual signal (SIGILL maybe)
when it spots time going backwards, then run it under gdb and trap that,
and trace forwards from there...

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
