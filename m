Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FiAMu-00058N-Dr for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 06:22:44 -0700
Received: from mail.signal1network.com ([208.176.116.2]
	helo=ucontrol.mobiledns.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FiAMt-0000oA-Qz
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 06:22:44 -0700
From: Steven James <pyro@linuxlabs.com>
Message-ID: <Pine.LNX.4.58.0605220746280.664@ucontrol.mobiledns.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1328545164-1641068967-1148301916=:664"
Content-ID: <Pine.LNX.4.58.0605220914570.664@ucontrol.mobiledns.com>
Subject: [uml-devel] [BUG] 2.6.16 extra ptrace trap on syscall exit
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
Date: Mon, 22 May 2006 09:22:32 -0400 (EDT)
To: Roland McGrath <roland@redhat.com>
Cc: User-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1328545164-1641068967-1148301916=:664
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0605220914571.664@ucontrol.mobiledns.com>

Greetings,

While working on a syscall emulator similar in structure to
user-mode-linux, I found that for many but not all system calls, the
ptracing parent is notified of the system call exit twice on x86_64 hosts.

This can be trivially demonstrated by running strace on a test program
that makes a non-existant system call such as the attached ptrace_test.c
(see output below)

Further testing shows that the bug only occurs when ptracing a 64 bit
process. 32 bit target processes ptrace fine.

This problem also appears to crash user-mode-linux guest kernels running
on x86_64.

From Blaisorblade:
>I have uml/64-bit (AMD64) not working on 2.6.16/64bit, while uml-32bit
>works fine on it, and the same uml/64-bit binaries work fine on 2.6.15. I
haven't
>tracked it down fully, but could it be related? Possibly yes because I
now
>seem to recall you run 64-bit host. So you likely found our bug!


I confirm the problem does not occur on the 2.6.15.7 kernel.

strace ./ptrace_test on 2.6.16.16:
strace ./ptrace_test
execve("./ptrace_test", ["./ptrace_test"], [/* 24 vars */]) = 0
uname({sys="Linux", node="prime", ...}) = 0
brk(0)                                  = 0x501000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2b2cf0826000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=142523, ...}) = 0
mmap(NULL, 142523, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b2cf0827000
close(3)                                = 0
open("/lib64/tls/libc.so.6", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\305\1\356"...,
640) = 640
lseek(3, 624, SEEK_SET)                 = 624
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\4\0\0\0"..., 32) =
32
fstat(3, {st_mode=S_IFREG|0755, st_size=1613968, ...}) = 0
mmap(0x33ee000000, 2305992, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x33ee000000
mprotect(0x33ee12a000, 1085384, PROT_NONE) = 0
mmap(0x33ee229000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x129000) = 0x33ee229000
mmap(0x33ee22f000, 16328, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x33ee22f000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2b2cf084a000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2b2cf084b000
mprotect(0x33ee229000, 16384, PROT_READ) = 0
mprotect(0x33edd14000, 4096, PROT_READ) = 0
arch_prctl(0x1002, 0x2b2cf084ab00)      = 0
munmap(0x2b2cf0827000, 142523)          = 0
write(1, "Pyro was here!\n", 15Pyro was here!
)        = 15
write(1, "last write returned 15, (errno=0"..., 34last write returned 15,
(errno=0)
) = 34
syscall_500(0x1, 0x22, 0xffffffffffffffff, 0, 0x1, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = -1 (errno 38)
syscall_500(0x1, 0x22, 0xffffffffffffffff, 0, 0x1, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = -1 (errno 38)
inval(1) returned -1, (errno=38)
exit_group(0, 0, 0x33ee065280, 0x2, 0x3c <unfinished ... exit status 0>
==============================================================================

strace ./ptrac_test32 on 2.6.16.16:
strace ./ptrace_test32
execve("./ptrace_test32", ["./ptrace_test32"], [/* 24 vars */]) = 0
[ Process PID=3538 runs in 32 bit mode. ]
uname({sys="Linux", node="prime", ...}) = 0
brk(0)                                  = 0x804a000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(0x3, 0xffffbf18)                = 0
old_mmap(0x22cbb00000000, 8589934593, PROT_READ|PROT_WRITE, 0xf /* MAP_???
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_POPULATE|MAP_NONBLOCK|MAP_GROWSDOWN|MAP_DENYWRITE|MAP_EXECUTABLE|MAP_LOCKED|0xfffe06c0,
64768, 0x1af3ef00000000) = 0xfffffffff7fcd000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\357"..., 512)
= 512
fstat64(0x3, 0xffffbfac)                = 0
old_mmap(0x100000000000, 146028888067,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8, 0x4
/* MAP_???
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_NONBLOCK|MAP_GROWSDOWN|MAP_DENYWRITE|MAP_LOCKED|0x47dc0680,
1205695736, 0x847dd0435) = 0xfffffffff7fcc000
old_mmap(0x12acbc47dda000, 8804682956805, PROT_READ|PROT_WRITE, MAP_FILE,
0, 0) = 0x47dda000
mprotect(0x47efe000, 27836, PROT_NONE)  = 0
old_mmap(0x400047eff000, 8873402433539, PROT_READ|PROT_WRITE, MAP_FILE, 0,
0) = 0x47eff000
old_mmap(0x1cbc47f03000, 214748364803,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8,
MAP_FILE, 0, 0) = 0x47f03000
close(3)                                = 0
old_mmap(0x100000000000, 146028888067,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8, 0x4
/* MAP_???
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_NONBLOCK|MAP_GROWSDOWN|MAP_DENYWRITE|MAP_LOCKED|0x47dc0680,
2832, 0x2047dce4a2) = 0xfffffffff7fcb000
mprotect(0x47eff000, 8192, PROT_READ)   = 0
mprotect(0x47dd6000, 4096, PROT_READ)   = 0
set_thread_area(0xffffc724)             = 0
munmap(0xf7fcd000, 142523)              = 0
write(1, "Pyro was here!\n", 15Pyro was here!
)        = 15
write(1, "last write returned 15, (errno=0"..., 34last write returned 15,
(errno=0)
) = 34
syscall_500(0x1, 0xffffc9c8, 0x80484fe, 0x80484fe, 0x1, 0xffffc5b0,
0xffffc9c8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0) = -1 (errno 38)
write(1, "inval(1) returned -1, (errno=38)"..., 33inval(1) returned -1,
(errno=38)
) = 33
exit_group(0)                           = ?
=============================================================================

and strace ./ptrace_test on 2.6.15.7:
strace ./ptrace_test
execve("./ptrace_test", ["./ptrace_test"], [/* 24 vars */]) = 0
uname({sys="Linux", node="prime", ...}) = 0
brk(0)                                  = 0x501000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2aaaaaaab000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=142523, ...}) = 0
mmap(NULL, 142523, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2aaaaaaac000
close(3)                                = 0
open("/lib64/tls/libc.so.6", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\305\1\356"...,
640) = 640
lseek(3, 624, SEEK_SET)                 = 624
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\4\0\0\0"..., 32) =
32
fstat(3, {st_mode=S_IFREG|0755, st_size=1613968, ...}) = 0
mmap(0x33ee000000, 2305992, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x33ee000000
mprotect(0x33ee12a000, 1085384, PROT_NONE) = 0
mmap(0x33ee229000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x129000) = 0x33ee229000
mmap(0x33ee22f000, 16328, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x33ee22f000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2aaaaaacf000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2aaaaaad0000
mprotect(0x33ee229000, 16384, PROT_READ) = 0
mprotect(0x33edd14000, 4096, PROT_READ) = 0
arch_prctl(0x1002, 0x2aaaaaacfb00)      = 0
munmap(0x2aaaaaaac000, 142523)          = 0
write(1, "Pyro was here!\n", 15Pyro was here!
)        = 15
write(1, "last write returned 15, (errno=0"..., 34last write returned 15,
(errno=0)
) = 34
syscall_500(0x1, 0x22, 0x33ee0b8642, 0, 0x1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = -1 (errno 38)
write(1, "inval(1) returned -1, (errno=38)"..., 33inval(1) returned -1,
(errno=38)
) = 33
exit_group(0, 0, 0x33ee065280, 0x2, 0x3c <unfinished ... exit status 0>
============================================================================

G'day,
sjames


||||| |||| |||||||||||||  |||
by Linux Labs International, Inc.
   Steven James, CTO

55 Marietta Street
Suite 1830
Atlanta, Ga 30303
866 824 9737 support
---1328545164-1641068967-1148301916=:664
Content-Type: TEXT/X-CSRC; CHARSET=US-ASCII; NAME="ptrace_test.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0605220843310.664@ucontrol.mobiledns.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ptrace_test.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNs

dWRlIDx1bmlzdGQuaD4NCg0KI2luY2x1ZGUgPGxpbnV4L3VuaXN0ZC5oPg0K

I2RlZmluZSBfX05SX2ludmFsCTUwMA0KDQpfc3lzY2FsbDEobG9uZywgaW52

YWwsIGxvbmcsIHZhbCk7DQoNCmludCBtYWluKGludCBhcmdjLCBjaGFyICph

cmd2W10pIHsNCglpbnQgcmV0Ow0KCWNoYXIgKm1zZyA9ICJQeXJvIHdhcyBo

ZXJlIVxuIjsNCgljaGFyIGJ1ZmZlclsxMDI0XTsNCg0KCXJldCA9IHdyaXRl

KDEsIG1zZywgc3RybGVuKG1zZykpOw0KCXJldCA9IHNwcmludGYoIGJ1ZmZl

ciwgImxhc3Qgd3JpdGUgcmV0dXJuZWQgJWQsIChlcnJubz0lZClcbiIsIHJl

dCwgZXJybm8pOw0KCXdyaXRlKDEsIGJ1ZmZlciwgcmV0KTsNCg0KCXJldCA9

IGludmFsKDEpOw0KCXJldCA9IHNwcmludGYoIGJ1ZmZlciwgImludmFsKDEp

IHJldHVybmVkICVkLCAoZXJybm89JWQpXG4iLCByZXQsIGVycm5vKTsNCgl3

cml0ZSgxLCBidWZmZXIsIHJldCk7DQoNCglyZXR1cm4gMDsNCn0NCg==


---1328545164-1641068967-1148301916=:664--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
