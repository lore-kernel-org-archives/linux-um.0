Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Advoc-0007n3-WA for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:20:30 -0800
Received: from mx15.sac.fedex.com ([199.81.197.54])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Advoc-0000q4-HJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 10:20:30 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx15.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id i06IKIdO000667
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 6 Jan 2004 12:20:22 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
In-Reply-To: <a06020407bc208b5b5a7a@[192.168.1.10]>
Message-ID: <Pine.LNX.4.58.0401070150290.1840@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401060258.i062wuFI023117@ccure.user-mode-linux.org>
	<a06020407bc208b5b5a7a@[192.168.1.10]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 7 Jan 2004 02:00:07 +0800 (SGT)
To: Jeff Dike <jdike@addtoit.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, Johannes Formann <johannes@formann.de>

Ok, here's the strace results.

1st is the working one (without lvm2), 2nd is the problem one (with lvm2
-- loaded by "vgscan", "vgchange -a y", "mount /u0/v0").

Without loading lvm2, uml works just fine.

Host:   	2.4.25-pre4
Guest:  	2.4.25-pre4-1um
Gcc:		2.95.3 20010315
Glibc:		2.2.5-34
Binutils:	2.14.90.0.7


Both traces are starting the same command "klog" ...



Trace 1 (without lvm2)

# strace klogd
execve("/usr/sbin/klogd", ["klogd"], [/* 34 vars */]) = 0
brk(0)                                  = 0x804e750
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
SYS_197(0x3, 0xbfffec98, 0x40015604, 0x400156ec, 0x3) = 0
mmap(0, 1628, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3"..., 1024) = 1024
SYS_197(0x3, 0xbfffece8, 0x40015604, 0x400156ec, 0x3) = 0
mmap(0, 1190528, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40017000
mprotect(0x40130000, 39552, PROT_NONE)  = 0
mmap(0x40130000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x119000) = 0x40130000
mmap(0x40136000, 14976, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40136000
close(3)                                = 0
mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x4013a000
munmap(0x40016000, 1628)                = 0
brk(0)                                  = 0x804e750
brk(0x804e780)                          = 0x804e780
brk(0x804f000)                          = 0x804f000
chdir("/")                              = 0
open("/var/run/klogd.pid", O_RDONLY)    = -1 ENOENT (No such file or
directory)
fork()                                  = 112
_exit(0)                                = ?





Trace 2 (with lvm2)
# strace klogd
execve("/usr/sbin/klogd", ["klogd"], [/* 34 vars */]) = 0
brk(0)                                  = 0x804e750
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
SYS_197(0x3, 0xbfffec98, 0x40015604, 0x400156ec, 0x3) = 0
mmap(0, 1628, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3"..., 1024) = 1024
SYS_197(0x3, 0xbfffece8, 0x40015604, 0x400156ec, 0x3) = 0
mmap(0, 1190528, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40017000
mprotect(0x40130000, 39552, PROT_NONE)  = 0
mmap(0x40130000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x119000) = 0x40130000
mmap(0x40136000, 14976, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40136000
close(3)                                = 0
mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x4013a000
munmap(0x40016000, 1628)                = 0
brk(0)                                  = 0x804e750
brk(0x804e780)                          = 0x804e780
brk(0x804f000)                          = 0x804f000
chdir("/")                              = 0
open("/var/run/klogd.pid", O_RDONLY)    = -1 ENOENT (No such file or
directory)
fork()                                  = 147
Kernel panic: Kernel mode fault at addr 0x488b5000, ip 0x400df1a4



Thanks,
Jeff

On Tue, 6 Jan 2004, Johannes Formann wrote:

> At 21:58 Uhr -0500 05.01.2004, Jeff Dike wrote:
> >jchua@fedex.com said:
> >>  Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode
> >>  fault at addr 0x48965000, ip 0x400e51a4
> >
> >Can you get a stack trace from the panic?
>
> a simple strace $comand_to_run_uml?


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
