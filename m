Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AaXZx-0002Kl-N1
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 28 Dec 2003 01:51:21 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AaXZx-0002NT-Cq
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 28 Dec 2003 01:51:21 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031228095115.GL17472@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net> <20031228093317.GK17472@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228093317.GK17472@alcor.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 28 Dec 2003 01:51:15 -0800
To: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

On Sun, Dec 28, 2003 at 01:33:17AM -0800, Matt Zimmerman wrote:

> On Sat, Dec 20, 2003 at 05:06:56PM -0800, Matt Zimmerman wrote:
> 
> > On Sat, Dec 20, 2003 at 04:52:57PM -0800, Matt Zimmerman wrote:
> > 
> > > sh-2.05a# apt-get source -b hello
> > > apt-get: error while loading shared libraries: /lib/libm.so.6: cannot read
> > > file data: Error 38
> > > sh-2.05a# 
> > > sh-2.05a# apt-get source -b hello
> > > Reading Package Lists... Done
> > > Building Dependency Tree... Done
> > > 
> > > And of course, I haven't been able to get this to happen in the debugger
> > > (yet).
> > 
> > Well, with enough attempts, I'm able to get it to happen in gdb.  However, I
> > can't get it down to a single syscall, and can't do it reliably.  I tried
> > setting a breakpoint at the point in syscall_kern.c where it can return
> > -ENOSYS, but it never hits it.
> 
> It looks like in the case where it breaks, the system call number is 0, so
> it is passing the test in execute_syscall_skas, and instead invoking
> sys_ni_syscall.  Here is the regs struct in one instance:
> 
> $16 = {regs = {tt = {syscall = 2, sc = 0xbfffd68c}, skas = {regs = {2, 
>         3221214860, 14, 14, 3221214860, 3221214492, 4294967258, 43, 43, 0, 0, 
>         4, 1074631684, 35, 2097815, 3221214444, 43}, fp = {
>         0 <repeats 27 times>}, xfp = {2098047, 0 <repeats 31 times>, 
>         4294967295, 2734743551, 16401, 0, 0, 3413842944, 16404, 
>         0 <repeats 88 times>, 2726428672}, fault_addr = 0, fault_type = 1, 
>       trap_type = 0, syscall = 0, is_user = 1}}}
> 
> The process isn't invoking syscall 0 (in this case it was actually __NR_select
> (82)).  syscall matches ORIG_EAX, though, so I guess something is going wrong
> earlier, maybe in move_registers?

This is making less and less sense.  handle_trap has this code:

	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
	UPT_SYSCALL_NR(regs) = syscall_nr;
	if(syscall_nr < 1){
		relay_signal(SIGTRAP, regs);
		return;
	}

As I understand it, PT_SYSCALL_NR refers to ORIG_EAX, and UPT_SYSCALL_NR
refers to skas.syscall.  i.e., syscall=0 can't happen.  So either things are
not as they seem, or something is happening to regs between here and
execute_syscall_skas.  Maybe there is some disconnect between uml_pt_regs
and pt_regs?  I can't think how, though.  the structs are identical in
asm/ptrace.h.  In fact, the only differences are these:

--- ptrace.h-2.4        2003-12-28 01:44:17.000000000 -0800
+++ ptrace.h-2.6        2003-12-28 01:44:20.000000000 -0800
@@ -49,15 +49,14 @@
 #define PTRACE_GETFPXREGS         18
 #define PTRACE_SETFPXREGS         19
 
-#define PTRACE_SETOPTIONS         21
+#define PTRACE_OLDSETOPTIONS         21
 
-/* options set using PTRACE_SETOPTIONS */
-#define PTRACE_O_TRACESYSGOOD     0x00000001
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
-extern void show_regs(struct pt_regs *);
 #endif
 
 #endif


-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
