Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ffk2h-0003Eu-4q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 May 2006 13:51:51 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ffk2f-0005Fi-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 May 2006 13:51:51 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Bug#366915: user-mode-linux: fails when host
	kernel is linux-image-2.6.16-1-k7
References: <20060512035019.18151.73446.reportbug@doof.home>
	<20060512200806.GA27800@inferi.kami.home>
In-Reply-To: <20060512200806.GA27800@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605151239.49362.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Mon, 15 May 2006 12:39:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mattia Dongili <malattia@linux.it>, Paul Dwerryhouse <paul@dwerryhouse.com.au>, 366915@bugs.debian.org

On Friday 12 May 2006 22:08, Mattia Dongili wrote:
> Hello UML developers,
>
> I received the following bugreport for 2.6.16 UML running on a 2.6.16
> host (both are debian packages). I found a similar report on a french
> site[1], it seems to be the same problem.
>
> Can you help putting some light there?
> Thanks in advance
>
> [1]:
> http://forum.hardware.fr/hardwarefr/OSAlternatifs/UML-Debian-sujet-57017-1.
>htm

I also get a problem specific to host 2.6.16 kernels, but that's when I run 
x64 guests on x64 2.6.16 hosts (x86 32-bit guests work normally); I've not 
tested 32-bit 2.6.16 hosts.

The error message is different. However, I can't exclude there is the same 
root cause acting in a different way, but I've now debugged this a bit and 
this seems unlikely.

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Warning: unable to open an initial console.
Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, 
errno = 0, status = 2943


Modules linked in:
Pid: 1, comm: init Not tainted 2.6.16.9-bs2
RIP: 0033:[<00000000400101ba>]
RSP: 0000007f7f9ec358  EFLAGS: 00000246
RAX: 000000000050a000 RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000000000000026 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000040000000
R10: 0000000040000a18 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000040001dd0 R14: 0000000000000008 R15: 0000000000400040
Call Trace:
6031bc48:  [<6000fe8c>] panic_exit+0x27/0x42
6031bc58:  [<60034f15>] notifier_call_chain+0x1f/0x2f
6031bc78:  [<6002784a>] panic+0xcf/0x165
6031bcb8:  [<601791f9>] __libc_waitpid+0x39/0xc0
6031bcd8:  [<6001e7f6>] set_signals+0x26/0x53
6031bd08:  [<60021640>] move_registers+0x45/0x7e
6031bd58:  [<6002295f>] userspace+0x213/0x265
6031bdc0:  [<6000a17f>] init+0x0/0x13d
6031bdd8:  [<60010410>] new_thread_handler+0x121/0x12f
6031be38:  [<6016c9a0>] __restore_rt+0x0/0x10
6031bee8:  [<6016cc59>] kill+0x9/0x20

> > When user-mode linux is used with a host kernel of
> > linux-image-2.6.16-1-k7 (ie, the package in sid), it panics. When the
> > host kernel is linux-image-2.6.15-1-k7 (also from sid), it works
> > perfectly.

> > mapping mmap stub failed, errno = 12
> > Kernel panic - not syncing: start_userspace : expected SIGSTOP, got
> > status = 256

> > EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:a7e29fa8 EFLAGS:
> > 00200246 Not tainted EAX: 00000000 EBX: 000013f5 ECX: 00000013 EDX:
> > 000013f5
> > ESI: 000013f1 EDI: 00000011 EBP: a7e29fc4 DS: 007b ES: 007b
> > 08267af8:  [<0806f080>] show_regs+0xb4/0xb9
> > 08267b24:  [<0805e08c>] panic_exit+0x23/0x3d
> > 08267b38:  [<0807e495>] notifier_call_chain+0x1a/0x31
> > 08267b58:  [<08072ffb>] panic+0x4f/0xca
> > 08267b74:  [<0806c165>] start_userspace+0xce/0x11a
> > 08267b94:  [<0805e31a>] init_new_context_skas+0xfb/0x13e
> > 08267bb4:  [<080ad3f0>] do_execve+0x96/0x1df
> > 08267bd8:  [<080599b8>] execve1+0x28/0x52
> > 08267bfc:  [<080599f5>] um_execve+0x13/0x3f
> > 08267c18:  [<0805936a>] run_init_process+0x34/0x4f
> > 08267c38:  [<08059471>] init+0xec/0x117
> > 08267c48:  [<0806955b>] run_kernel_thread+0x42/0x4a
> > 08267cf8:  [<0805e49f>] new_thread_handler+0x7f/0xa9
> > 08267d1c:  [<ffffe420>] _etext+0xf7e66406/0x0
> >
> > Thanks,
> >
> > Paul.
> >
> >
> >
> >
> > -- System Information:
> > Debian Release: testing/unstable
> >   APT prefers unstable
> >   APT policy: (500, 'unstable')
> > Architecture: i386 (i686)
> > Shell:  /bin/sh linked to /bin/bash
> > Kernel: Linux 2.6.16-1-k7
> > Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968)
> >
> > Versions of packages user-mode-linux depends on:
> > ii  uml-utilities                 20060323-3 User-mode Linux (utility
> > programs)
> >
> > user-mode-linux recommends no packages.
> >
> > -- no debconf information

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
