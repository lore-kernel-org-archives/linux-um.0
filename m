Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFtPf-0007aV-TU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 04:59:55 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFtPc-0003Du-DI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 04:59:55 -0700
Message-Id: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
From: bodo.stroesser@fujitsu-siemens.com
Subject: Re: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
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
Date: Fri, 08 Oct 2004 13:59:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lars.Ellenberg@linbit.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it

caker@theshore.net said:
> Ok, so a new combination.  This is 2.4.27 + 2.4.26-um + all the incremental + Bodo's
> sysemu-panic patch.  It works fine on non-sysemu hosts, and on a host with the
> original version of sysemu.
> 
> I think the key here is that this host has the latest (v5) SKAS patch, whereas the
> 2.6.7 host kernel used the standard sysemu patch.

Please note, my knowledge about this only comes from reading the source code only.
Thus, if I'm wrong, tell me.

AFAICS, the behavior of the latest skas patches for 2.4 and 2.6 regarding sysemu
is *very* different. And I believe, the 2.6 is wrong!

Problem:
On both host versions a process will stop, if it is started with PTRACE_SYSEMU and
if it tries to execute a systemcall. But what happens with the traced systemcall
when it is resumed differs between the two host versions.
On host 2.4 the syscall will immediately return to user presenting the result that
had been written to the stack via ptrace(). This is done no matter if the process
is resumed with PTRACE_SYSEMU, PTRACE_SYSCALL, PTRACE_SINGLESTEP or PTRACE_CONT.
On host 2.6 the syscall will immediately return to user only if the process is
restarted with PTREACE_SYSEMU! In the other cases the syscall will be executed on
the host, the result from this will overwrite the result written via ptrace().
The check for host's sysemu-support done in UML differs between the sysemu-patches
for UML-2.4 and UML-2.6:
- In UML-2.4 "getpid()" is written as result (eax) of the systemcall, which fakes
  the syscall-result on a 2.4-host, but does nothing on a 2.6, where it again is
  overwritten by running the syscall on the host! Thus, a UML-2.4 will run on
  hosts with sysemu-support only, if it is a 2.4 host!
- In UML-2.6 "getpid()" is written to the number of the systemcall! But the result
  in eax is not written, it still contains the original syscall number. On a
  2.4-host this number is returned. In most cases this will let the further checks
  in UML succeed, but no guarantee...
  On a 2.6-host the systemcall with the faked number now will be processed on the
  host. In most cases the number should be invalid, thus the result is -ENOSYS,
  the checks in UML will succeed. But what happens, if the faked syscall number is
  a number known on the host ...
  Thus a UML-2.6 will run on all host versions (in most cases ...)

Solution:
- the host-patch for 2.6 should be modified. Before calling ptrace_notify()
  do_syscall_trace() should save the state of the PTRACE_SYSEMU (true/false) and
  should use that saved state as return value.
- check_sysemu() in UML-2.6 should be modified to write the result, not the sycall
  number. And it should do it in a portable way.

By the way: it is not enough to change the checks only. The 2.6-host's behavior
will cause problems as well, if a process in UML is singlestepped. And there will
be problems, if someone switches off sysemu while UML is running.

Bodo

> 
> ----
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> Checking PROT_EXEC mmap in /tmp...OK
> Checking for /dev/anon on the host...Not available (open failed with errno 6)
> Linux version 2.4.27-linode35-3um (caker@host4.linode.com) (gcc version 3.2.2
> 20030222 (Red Hat Linux 3.2.2-5)) #1 Wed Oct 6 11:31:28 EDT 2004
> On node 0 totalpages: 16384
> zone(0): 16384 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: mem=64M fake_ide fakehd con=null con0=fd:0,fd:1 devfs=nomount
> root=/dev/ubda ubda=/linodes/luctourangeau/13588.fs
> ubdb=/linodes/luctourangeau/13586.fs eth0=tuntap,luctourangeau_0,fe:fd:46:55:10:64
> token_max=400000 token_refill=512
> fakehd : Changing ubd_gendisk.major_name to "hd".
> Calibrating delay loop... 3787.98 BogoMIPS
> Memory: 59436k available
> Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Checking for host processor cmov support...Yes
> Checking for host processor xmm support...No
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...<0>Kernel panic: check_ptrace : child
> exited with status 0x100
> In idle task - not syncing
>  <6>SysRq : Show Regs
> 
> EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
>     Not tainted
> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
> Call Trace: [<80315778>] [<80317cb6>] [<800115f3>] [<801adc3a>] [<801992f5>]
>    [<8001e3fa>] [<80013cb4>] [<80193f0d>] [<8033efe0>] [<800075c5>] [<803178fa>]
>    [<8019d8a0>] [<80007b65>] [<800024b2>] [<8019d8a0>] [<80002459>] [<8019d8c5>]
>    [<8019d8a0>] [<80193fad>] [<8019d8a0>] [<80193f88>] [<8019d8a0>] [<8019d609>]
>    [<8019d8a0>] [<8019d07d>] [<802b0108>] [<802b0371>]
> 
> -Chris


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
