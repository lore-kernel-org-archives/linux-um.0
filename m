Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fedzu-0003hi-3Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 May 2006 13:12:26 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fedzu-0002y0-1C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 May 2006 13:12:26 -0700
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]
	helo=aa003msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fedzr-0004aD-Ai
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 May 2006 13:12:25 -0700
Resent-Message-ID: <20060512201304.GB27800@inferi.kami.home>
Resent-To: Paul Dwerryhouse <paul@dwerryhouse.com.au>,
	UML-devel <user-mode-linux-devel@lists.sourceforge.net>
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20060512200806.GA27800@inferi.kami.home>
References: <20060512035019.18151.73446.reportbug@doof.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512035019.18151.73446.reportbug@doof.home>
Subject: [uml-devel] Re: Bug#366915: user-mode-linux: fails when host kernel
	is linux-image-2.6.16-1-k7
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
Date: Fri, 12 May 2006 22:08:06 +0200
To: Paul Dwerryhouse <paul@dwerryhouse.com.au>, 366915@bugs.debian.org
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

Hello UML developers,

I received the following bugreport for 2.6.16 UML running on a 2.6.16
host (both are debian packages). I found a similar report on a french
site[1], it seems to be the same problem.

Can you help putting some light there?
Thanks in advance

[1]: http://forum.hardware.fr/hardwarefr/OSAlternatifs/UML-Debian-sujet-57017-1.htm

On Fri, May 12, 2006 at 01:50:19PM +1000, Paul Dwerryhouse wrote:
> Package: user-mode-linux
> Version: 2.6.16-1um-2
> Severity: normal
> 
> 
> When user-mode linux is used with a host kernel of
> linux-image-2.6.16-1-k7 (ie, the package in sid), it panics. When the
> host kernel is linux-image-2.6.15-1-k7 (also from sid), it works
> perfectly.
> 
> I've tested this with a number of guest images; debian sid, ubuntu
> breezy & dapper. Doesn't appear to be an NPTL issue; it crashes under
> 2.6.16 whether the /lib/tls libraries are present or not.
> 
> 
> The boot messages when it fails:
> 
> $ linux ubd0=uml1.img con=pty con0=fd:0,fd:1 mem=256M eth0=daemon,,unix,/var/run/vde/tap1.ctl eth1=daemon,,unix,/var/run/vde/tap1.ctl
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking PROT_EXEC mmap in /tmp...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...not found
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
> UML running in SKAS0 mode
> Linux version 2.6.16 (root@inferi) (gcc version 4.0.4 20060422 (prerelease) (Debian 4.0.3-2)) #2 Sat Apr 29 23:36:42 CEST 2006
> Built 1 zonelists
> Kernel command line: ubd0=uml1.img con=pty con0=fd:0,fd:1 mem=256M eth0=daemon,,unix,/var/run/vde/tap1.ctl eth1=daemon,,unix,/var/run/vde/tap1.ctl root=98:0
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> 
> [...]
> 
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> mapping mmap stub failed, errno = 12
> Kernel panic - not syncing: start_userspace : expected SIGSTOP, got status = 256
>  
> EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:a7e29fa8 EFLAGS: 00200246 Not tainted
> EAX: 00000000 EBX: 000013f5 ECX: 00000013 EDX: 000013f5
> ESI: 000013f1 EDI: 00000011 EBP: a7e29fc4 DS: 007b ES: 007b
> 08267af8:  [<0806f080>] show_regs+0xb4/0xb9
> 08267b24:  [<0805e08c>] panic_exit+0x23/0x3d
> 08267b38:  [<0807e495>] notifier_call_chain+0x1a/0x31
> 08267b58:  [<08072ffb>] panic+0x4f/0xca
> 08267b74:  [<0806c165>] start_userspace+0xce/0x11a
> 08267b94:  [<0805e31a>] init_new_context_skas+0xfb/0x13e
> 08267bb4:  [<080ad3f0>] do_execve+0x96/0x1df
> 08267bd8:  [<080599b8>] execve1+0x28/0x52
> 08267bfc:  [<080599f5>] um_execve+0x13/0x3f
> 08267c18:  [<0805936a>] run_init_process+0x34/0x4f
> 08267c38:  [<08059471>] init+0xec/0x117
> 08267c48:  [<0806955b>] run_kernel_thread+0x42/0x4a
> 08267cf8:  [<0805e49f>] new_thread_handler+0x7f/0xa9
> 08267d1c:  [<ffffe420>] _etext+0xf7e66406/0x0
> 
> Thanks,
> 
> Paul.
> 
> 
> 
> 
> -- System Information:
> Debian Release: testing/unstable
>   APT prefers unstable
>   APT policy: (500, 'unstable')
> Architecture: i386 (i686)
> Shell:  /bin/sh linked to /bin/bash
> Kernel: Linux 2.6.16-1-k7
> Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968)
> 
> Versions of packages user-mode-linux depends on:
> ii  uml-utilities                 20060323-3 User-mode Linux (utility programs)
> 
> user-mode-linux recommends no packages.
> 
> -- no debconf information
> 
> 
> 
-- 
mattia
:wq!


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
