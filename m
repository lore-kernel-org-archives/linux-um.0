Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAqIv-0000T5-2U for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 06:40:05 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CAqIu-0000uZ-4N for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 06:40:04 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C39@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Subject: [uml-devel] Syscalls breaking out
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
Date: Fri, 24 Sep 2004 15:39:44 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Hi Jeff, Hi BlaisorBlade,

as stated in the thread "Minor problems with interrupted sytemcalls",
two cooperating processes running on UML easily can break out and
execute systemcalls on the host system. To do this, the parent process
singlesteps the child, then the child's systemcalls are executed on the
host.
The code in "kern_do_signal()", that should fix this, handles tt-mode
only (before my patch "interrupted systemcalls" the code even was
skipped), and it handles "int 0x80" systemcalls only! Thus, if the host
supports "sysenter", this instruction can be used to break out from
both, tt- and skas-mode. This can be done, because the hosts
vsyscall-page is available to all processes on the host, even UML
processes.

How should this be fixed? Here my idea:

- move the flag "singlestep_syscall" from thread.mode.tt to thread
- remove singlestepping_tt() and singlestepping_skas(). Add
singlestepping() instead which will check thread.singlestep_syscall
- modify kern_do_signal() to check user's next instruction for a syscall
via is_syscall() in tt-mode AND skas-mode. Also it should do this check
after handle_signal() has been called (signal handler starting could
have failed or signal handler starts with a syscall).
- is_syscall() should check for "int 0x80" and "sysenter", but should
check eax too. If eax contains a invalid systemcall number, the host
kernel will skip the syscall tracing and singlestepping is broken.

A related issue: the host's vsyscall-page is visible and executable to
all processes on the host. This means, it is visible to the UML
processes too. AFAIK this cannot be changed. But UML itself doesn't know
about this page. So it cannot be accessed via ptrace from one uml
process to another. Calling copy_from_user() from is_syscall() would
return an error as well, if a UML user process jumps into the
vsyscall-page while it is singlestepped.
This could be solved by using a ptrace( PEEKTEXT, ...)-call to
host-kernel, but I don't like it. We want to read 2 bytes only, while
ptrace always reads 4 bytes. What about UEIP pointing to the last 3
bytes of a page? What I would prefer, is to support "sysenter" /
vsyscall-page in UML. AFAICS the only way to do that, is to make the
hosts syscall-page available in UML. How to do this:

- in UML's main() check the ELF auxiliary vector for information about
the vsyscall-page (I've written a small test, it's easy to acquire the
info).
- modify the macro "ARCH_DLINFO" to use the hosts vsyscall info, if
present. If there is no info from the host, the macro should no longer
insert anything into the auxiliary vector!
- if the host has a vsyscall page, create a fixed entry for it in UML's
page-table (to be done once at UML start).
- if the host has a vsyscall-page and this page contains
"__kernel_sigreturn" and "__kernel_rt_sigreturn", UML could be modified
to use these (instead of the restorer-stub written to users stack)

If I'm right, UML should automatically support sysenter, if the host
supports it!

Do you agree with my ideas?
I could create a patch for this. Would you welcome it?
(It would overlap with my previos patch, should I merge them?)

Greets
Bodo



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
