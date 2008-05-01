Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrbPr-0001xD-AC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 09:13:51 -0700
Received: from an-out-0708.google.com ([209.85.132.248])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrbPq-0004Cr-9e
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 May 2008 09:13:50 -0700
Received: by an-out-0708.google.com with SMTP id b21so215218ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 01 May 2008 09:13:49 -0700 (PDT)
Message-ID: <804dabb00805010913q547d115fpfd51f47c1c92f5e4@mail.gmail.com>
Date: Fri, 2 May 2008 00:13:49 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080501151551.GB6303@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
	<804dabb00804300924p3b1e1113vcbec90129ffa0f12@mail.gmail.com>
	<20080430184746.GA12021@c2.user-mode-linux.org>
	<804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
	<20080501151551.GB6303@c2.user-mode-linux.org>
Subject: Re: [uml-devel] arch/um/Makefile:100: *** missing separator. Stop.
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

On Thu, May 1, 2008 at 11:15 PM, Jeff Dike <jdike@addtoit.com> wrote:
> On Thu, May 01, 2008 at 07:35:32AM +0800, Peter Teoh wrote:
>  > /mnt/hd0/download/linux-2.6-latest>make -v
>  > GNU Make 3.81
>  > Copyright (C) 2006  Free Software Foundation, Inc.
>  > This is free software; see the source for copying conditions.
>  > There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>  > PARTICULAR PURPOSE.
>  >
>  > This program built for i686-redhat-linux-gnu
>  > /mnt/hd0/download/linux-2.6-latest>which make
>  > /usr/bin/make
>  >
>  > Any ideas?
>
>  No.  Something must be odd on your end.  Can you script a session
>  where you download the source and make this happen, then post it?  I'd
>  like to see a completely from-scratch session.
>
Ok, I tried on many different tree - linus tree, sched-devel, vfs tree
etc, and the linus tree repeated on 3 different machines - all having
the same problem as above.

Then I tried a specific stable version - 2.6.24.2.tar.bz2 as downloaded:

Filesize:
-rw-r--r-- 1 root root 46735221 Feb 15 23:27 ../linux-2.6.24.2.tar.bz2

md5sum ../linux-2.6.24.2*bz2
dd573a2fae55624ed92fa49c17583964  ../linux-2.6.24.2.tar.bz2

And after entering "strace make ARCH=um" I got the following:

/mnt/hd0/download/tmtm/linux-2.6.24.2>strace make ARCH=um
execve("/usr/bin/make", ["make", "ARCH=um"], [/* 43 vars */]) = 0
brk(0)                                  = 0x8070000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=85363, ...}) = 0
mmap2(NULL, 85363, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fe6000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000?W\0004\0\0\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1589908, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7fe5000
mmap2(0x55e000, 1308068, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x55e000
mmap2(0x698000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13a) = 0x698000
mmap2(0x69b000, 9636, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x69b000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7fe4000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7fe46c0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0x698000, 8192, PROT_READ)     = 0
mprotect(0x55a000, 4096, PROT_READ)     = 0
munmap(0xb7fe6000, 85363)               = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x8070000
brk(0x8091000)                          = 0x8091000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=56458800, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7de4000
close(3)                                = 0
rt_sigaction(SIGHUP, {0x804aaa0, [HUP], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x804aaa0, [QUIT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x804aaa0, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x804aaa0, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGXCPU, {0x804aaa0, [XCPU], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGXFSZ, {0x804aaa0, [XFSZ], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
getcwd("/mnt/hd0/download/tmtm/linux-2.6.24.2", 4096) = 38
stat64("/usr/include", {st_mode=S_IFDIR|S_ISGID|0755, st_size=20480, ...}) = 0
stat64("/usr/gnu/include", 0xbfcf7b4c)  = -1 ENOENT (No such file or directory)
stat64("/usr/local/include", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/include", {st_mode=S_IFDIR|S_ISGID|0755, st_size=20480, ...}) = 0
rt_sigaction(SIGCHLD, {0x8053810, [CHLD], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x8055980, [USR1], SA_RESTART}, {SIG_DFL}, 8) = 0
stat64(".", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, /* 32 entries */, 4096)   = 960
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
open("Makefile", O_RDONLY|O_LARGEFILE)  = 3
fstat64(3, {st_mode=S_IFREG|0664, st_size=53162, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ffa000
read(3, "VERSION = 2\nPATCHLEVEL = 6\nSUBLE"..., 4096) = 4096
read(3, "o above invocation of make\nskip-"..., 4096) = 4096
pipe([4, 5])                            = 0
vfork()                                 = 17197
close(5)                                = 0
read(4, "i386\n", 200)                  = 5
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
read(4, "", 195)                        = 0
close(4)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17197
pipe([4, 5])                            = 0
vfork()                                 = 17200
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
close(5)                                = 0
read(4, "/bin/sh\n", 200)               = 8
read(4, "", 192)                        = 0
close(4)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17200
read(3, "ll be printed. \n# If it is set t"..., 4096) = 4096
open("/mnt/hd0/download/tmtm/linux-2.6.24.2/scripts/Kbuild.include",
O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0664, st_size=9103, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ff9000
read(4, "####\n# kbuild: Generic definitio"..., 4096) = 4096
read(4, "obj\n\n# Prefix -I with $(srctree)"..., 4096) = 4096
read(4, "  $(if $(arg-check),            "..., 4096) = 911
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb7ff9000, 4096)                = 0
read(3, "ng make, including\n# mixing *con"..., 4096) = 4096
open("include/config/auto.conf", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No
such file or directory)
open("/usr/include/include/config/auto.conf", O_RDONLY|O_LARGEFILE) =
-1 ENOENT (No such file or directory)
open("/usr/local/include/include/config/auto.conf",
O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/usr/include/include/config/auto.conf", O_RDONLY|O_LARGEFILE) =
-1 ENOENT (No such file or directory)
open("include/config/auto.conf.cmd", O_RDONLY|O_LARGEFILE) = -1 ENOENT
(No such file or directory)
open("/usr/include/include/config/auto.conf.cmd",
O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/usr/local/include/include/config/auto.conf.cmd",
O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/usr/include/include/config/auto.conf.cmd",
O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
read(3, "CFLAGS\t+= -O2\nendif\n\ninclude $(s"..., 4096) = 4096
open("/mnt/hd0/download/tmtm/linux-2.6.24.2/arch/um/Makefile",
O_RDONLY|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFREG|0664, st_size=7271, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ff9000
read(4, "#\n# This file is included by the"..., 4096) = 4096
pipe([5, 6])                            = 0
vfork()                                 = 17201
close(6)                                = 0
read(5, "Linux\n", 200)                 = 6
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
read(5, "", 194)                        = 0
close(5)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17201
open("/mnt/hd0/download/tmtm/linux-2.6.24.2/arch/um/Makefile-skas",
O_RDONLY|O_LARGEFILE) = 5
fstat64(5, {st_mode=S_IFREG|0664, st_size=290, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ff8000
read(5, "# \n# Copyright (C) 2002 Jeff Dik"..., 4096) = 290
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0xb7ff8000, 4096)                = 0
open("/mnt/hd0/download/tmtm/linux-2.6.24.2/arch/um/Makefile-i386",
O_RDONLY|O_LARGEFILE) = 5
fstat64(5, {st_mode=S_IFREG|0664, st_size=1022, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ff8000
read(5, "core-y += arch/um/sys-i386/ arch"..., 4096) = 1022
open("/mnt/hd0/download/tmtm/linux-2.6.24.2/arch/x86/Makefile_32.cpu",
O_RDONLY|O_LARGEFILE) = 6
fstat64(6, {st_mode=S_IFREG|0664, st_size=2164, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ff7000
read(6, "# CPU tuning section - shared wi"..., 4096) = 2164
pipe([7, 8])                            = 0
vfork()                                 = 17202
close(8)                                = 0
read(7, "y\n", 200)                     = 2
read(7, "", 198)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
close(7)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17202
pipe([7, 8])                            = 0
vfork()                                 = 17206
close(8)                                = 0
read(7, "-falign-functions=0\n", 200)   = 20
read(7, "", 180)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
close(7)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17206
read(6, "", 4096)                       = 0
close(6)                                = 0
munmap(0xb7ff7000, 4096)                = 0
pipe([6, 7])                            = 0
vfork()                                 = 17210
close(7)                                = 0
read(6, "-mpreferred-stack-boundary=2\n", 200) = 29
read(6, "", 171)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
close(6)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17210
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0xb7ff8000, 4096)                = 0
open("/mnt/hd0/download/tmtm/linux-2.6.24.2/arch/um/Makefile-os-Linux",
O_RDONLY|O_LARGEFILE) = 5
fstat64(5, {st_mode=S_IFREG|0664, st_size=205, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ff8000
read(5, "# \n# Copyright (C) 2000 Jeff Dik"..., 4096) = 205
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0xb7ff8000, 4096)                = 0
pipe([5, 6])                            = 0
vfork()                                 = 17214
close(6)                                = 0
read(5, "-fno-unit-at-a-time\n", 200)   = 20
read(5, "", 180)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
close(5)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17214
pipe([5, 6])                            = 0
vfork()                                 = 17218
close(6)                                = 0
read(5, "/mnt/hd0/download/tmtm/linux-2.6"..., 200) = 46
read(5, "", 154)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
close(5)                                = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 17218
open("/usr/share/locale/locale.alias", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=2528, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ff8000
read(5, "# Locale name alias data base.\n#"..., 4096) = 2528
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0xb7ff8000, 4096)                = 0
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/make.mo", O_RDONLY) =
-1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/make.mo", O_RDONLY) =
-1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/make.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/make.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/make.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/make.mo", O_RDONLY) = -1 ENOENT
(No such file or directory)
write(2, "/mnt/hd0/download/tmtm/linux-2.6"...,
64/mnt/hd0/download/tmtm/linux-2.6.24.2/arch/um/Makefile:107: *** ) =
64
write(2, "missing separator", 17missing separator)       = 17
write(2, ".  Stop.\n", 9.  Stop.
)               = 9
chdir("/mnt/hd0/download/tmtm/linux-2.6.24.2") = 0
close(1)                                = 0
exit_group(2)                           = ?

Thank you Jeff for your help :-).

-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
