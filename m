Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040909194623.GQ5330@alcor.net>
References: <7153203.1094632577758.SLOX.WebMail.wwwrun@webmail.helinet.de>
	<200409092024.17925.blaisorblade_spam@yahoo.it>
	<20040909184951.GM5330@alcor.net>
	<200409092133.35518.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409092133.35518.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] UML hanging at "Activating swap"
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
Date: Thu, 9 Sep 2004 12:46:23 -0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, Dennis Ploeger <ploeger@helinet.de>, Michael West <quagly@mitzit.net>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Sep 09, 2004 at 09:33:35PM +0200, BlaisorBlade wrote:

> On Thursday 09 September 2004 20:49, Matt Zimmerman wrote:
> > Yes, I ran into this problem when testing the 2.4.24-3um packages for
> > Debian. With previous UMLs, hwclock would simply produce an error, and the
> > process would continue, but with 2.4.24-3um, it seems to hang.  Any idea
> > why this might be?
> 
> Not at all - there is a big bug in 2.4.24-3 with modules (any iptables user 
> get crashes), and "rtc" is probably a module; that bug is fixed in 2.4.26-2, 
> which has another critical bug on console I/O fixed in 2.4.26-3, which is 
> safe (apart all the experimental work on humfs and hostfs, which make them 
> break in multiple ways). By the way, I've not heard this with any other 
> distro (on my own I've only a Slack 9.0 root fs), so a look to hwclock could 
> be useful, maybe.

hwclock has caused problems for UML in the past; one of the strange things
that it does is to try to open an fd for the console, because some
architectures use that as a means to interface to the hardware clock.

I ran hwclock under strace to find out where the hang was occurring, and
discovered that it succeeds when running under strace. :-(  Here's the output
anyway:

execve("/sbin/hwclock", ["/sbin/hwclock"], [/* 5 vars */]) = 0
uname({sys="Linux", node="(none)", ...}) = 0
brk(0)                                  = 0x80503f4
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6093, ...}) = 0
old_mmap(NULL, 6093, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\30\222"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1153784, ...}) = 0
old_mmap(NULL, 1166560, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40016000
mprotect(0x40129000, 40160, PROT_NONE)  = 0
old_mmap(0x40129000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x113000) = 0x40129000
old_mmap(0x4012f000, 15584, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4012f000
close(3)                                = 0
munmap(0x40014000, 6093)                = 0
gettimeofday({1094758887, 536067}, NULL) = 0
brk(0)                                  = 0x80503f4
brk(0x805041c)                          = 0x805041c
brk(0x8051000)                          = 0x8051000
getuid32()                              = 0
open("/dev/rtc", O_RDONLY|O_LARGEFILErequest_module[char-major-10-135]: fork failed, errno 1
)  = -1 ENODEV (No such device)
open("/dev/misc/rtc", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/tty1", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, 0x4b50, 0x9ffffab8)            = -1 EINVAL (Invalid argument)
iopl(0x3)                               = -1 ENOSYS (Function not implemented)
write(2, "hwclock is unable to get I/O por"..., 68hwclock is unable to get I/O port access:  the iopl(3) call failed.
) = 68
_exit(0)                                = ?
bash-2.05a# /mnt/usr/bin/strace /sbin/hwclock
execve("/sbin/hwclock", ["/sbin/hwclock"], [/* 5 vars */]) = 0
uname({sys="Linux", node="(none)", ...}) = 0
brk(0)                                  = 0x80503f4
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=6093, ...}) = 0
old_mmap(NULL, 6093, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\30\222"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1153784, ...}) = 0
old_mmap(NULL, 1166560, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40016000
mprotect(0x40129000, 40160, PROT_NONE)  = 0
old_mmap(0x40129000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x113000) = 0x40129000
old_mmap(0x4012f000, 15584, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4012f000
close(3)                                = 0
munmap(0x40014000, 6093)                = 0
gettimeofday({1094758918, 176968}, NULL) = 0
brk(0)                                  = 0x80503f4
brk(0x805041c)                          = 0x805041c
brk(0x8051000)                          = 0x8051000
getuid32()                              = 0
open("/dev/rtc", O_RDONLY|O_LARGEFILErequest_module[char-major-10-135]: fork failed, errno 1
)  = -1 ENODEV (No such device)
open("/dev/misc/rtc", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/dev/tty1", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, 0x4b50, 0x9ffffab8)            = -1 EINVAL (Invalid argument)
iopl(0x3)                               = -1 ENOSYS (Function not implemented)
write(2, "hwclock is unable to get I/O por"..., 68hwclock is unable to get I/O port access:  the iopl(3) call failed.
) = 68
_exit(0)                                = ?

In the course of this test, I also noticed that it is not just hwclock which
hangs, but the entire UML.  Not even mconsole works after hwclock is run.

UML in Debian has been in bad shape for some time, after the hostfs
breakage, and then all the reports of hangs in tt mode
(http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=260111), and I would very
much like to get a stable version in soon.

FWIW, you can find a Debian UML image (which should easily reproduce this
problem) here:

http://people.debian.org/~mdz/uml/Debian-3.0r2.ext2.bz2

> Also, check for Real Time Clock UML option (enabling/disabling - does it makes 
> difference?).

Currently, it is using CONFIG_UML_REAL_TIME_CLOCK=y.  This has not changed
for some time:

1.40         (mdz      16-Dec-03): CONFIG_UML_REAL_TIME_CLOCK=y

> Here you can find a splitout version of all the changes from 2.4.24-1, so that 
> you can try multiple combination of them. On the page there is the link to 
> patch-scripts, which you'll love for patch-kit management (they are the tools 
> used for the -mm tree). Give also a read to "series" and "rawSeries", inside 
> the patch-scripts folder.

Thanks.  Unfortunately, I'm very busy with work, and I'm not sure when I
will have time to try all of these patches individually.  I can say,
however, that this problem did not exist for me when using skas with
2.4.24-2um.

-- 
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
