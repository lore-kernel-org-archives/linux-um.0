Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdulR-00044z-CH for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 09:13:09 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AdulQ-0004Uz-KY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 09:13:08 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: Resolution (Re: [uml-devel] 2.4.22-[67] problems)
Message-ID: <20040106171301.GY28393@alcor.net>
References: <20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<3FFA66B3.501@vgertech.com> <3FFA7DC6.1040403@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFA7DC6.1040403@vgertech.com>
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
Date: Tue, 6 Jan 2004 09:13:01 -0800
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

On Tue, Jan 06, 2004 at 09:20:06AM +0000, Nuno Silva wrote:

> Nuno Silva wrote:
> 
> [...]
> 
> >
> >I've been doing some tests and I'd say that the problem is something 
> >regarding the NPTL+TLS+__thread features of recent libc6 (2.3.2 and 
> >2.3.3cvs)... But I'm clueless about the fix :-)
> >
> >I'll setup a chroot where I can play around with glibc setups.
> >
> 
> OK, just finished the chroot: debian unstable with glibc-2.3.3cvs 
> hand-compiled (../libc/configure --with-tls --with-__thread 
> --enable-add-ons=nptl --prefix=/ --enable-kernel=2.6.0) and removed the 
> debian's libc.
> 
> Everything runs OK with the new glibc, tested: bash, apt-get, perl, mc, 
> strace, gcc, etc.
> 
> However linux (UML's executable) doesn't run:
> puma:/uml# ls -la /proc/mm
> --w--w--w-    1 root     root            0 Jan  6 08:33 /proc/mm
> puma:/uml# uname -a
> Linux puma 2.6.0 #2 Mon Jan 5 09:25:45 WET 2004 i686 unknown unknown 
> GNU/Linux
> puma:/uml# ./linux
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> 
> [1]+  Stopped                 ./linux
> puma:/uml# fg
> ./linux
> Segmentation fault
> puma:/uml#

This looks quite different from what I and others were seeing in #224431,
which was random ENOSYS errors because the system call number in the regs
struct was being mysteriously cleared during a context switch on the cost.

> Now with strace:
> (see attached file)
> 
> Now with gdb:
> puma:/uml# gdb ./linux
> GNU gdb 6.0-debian
> Copyright 2003 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain 
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "i386-linux"...
> (gdb) run
> Starting program: /uml/linux
> Detaching after fork from child process 26378.
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> Detaching after fork from child process 26379.
> 
> Program received signal SIGSTOP, Stopped (signal).
> 0x400f18dc in clone () from /lib/libc.so.6
> (gdb) bt
> #0  0x400f18dc in clone () from /lib/libc.so.6
> #1  0x4014f000 in ?? ()
> #2  0x00000007 in ?? ()
> #3  0x00001000 in ?? ()
> #4  0xa00a7b7f in start_userspace (cpu=26379) at process.c:113
> #5  0xa00a88e2 in start_uml_skas () at process_kern.c:162
> #6  0xa00a6bcb in linux_main (argc=0, argv=0xa0000000) at um_arch.c:387
> #7  0xa000de0e in main (argc=1, argv=0xbffffa44, envp=0xbffffa4c) at 
> arch/um/main.c:146
> (gdb) cont
> Continuing.
> 
> Program received signal SIGSTOP, Stopped (signal).
> 0x400f18dc in clone () from /lib/libc.so.6
> (gdb) bt
> #0  0x400f18dc in clone () from /lib/libc.so.6
> #1  0x4014f000 in ?? ()
> #2  0x00000007 in ?? ()
> #3  0x00001000 in ?? ()
> #4  0xa00a7b7f in start_userspace (cpu=26379) at process.c:113
> #5  0xa00a88e2 in start_uml_skas () at process_kern.c:162
> #6  0xa00a6bcb in linux_main (argc=0, argv=0xa0000000) at um_arch.c:387
> #7  0xa000de0e in main (argc=1, argv=0xbffffa44, envp=0xbffffa4c) at 
> arch/um/main.c:146
> (gdb) cont
> Continuing.
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0xa001305a in panic (fmt=0xbfffc000 "") at panic.c:67
> 67      panic.c: No such file or directory.
>         in panic.c
> (gdb) bt
> #0  0xa001305a in panic (fmt=0xbfffc000 "") at panic.c:67
> #1  0xa00a7bdd in start_userspace (cpu=-1073758208) at process.c:127
> #2  0xa00a88e2 in start_uml_skas () at process_kern.c:162
> #3  0xa00a6bcb in linux_main (argc=0, argv=0xa0000000) at um_arch.c:387
> #4  0xa000de0e in main (argc=1, argv=0xbffffa44, envp=0xbffffa4c) at 
> arch/um/main.c:146
> (gdb) cont
> Continuing.
> 
> Program terminated with signal SIGSEGV, Segmentation fault.
> The program no longer exists.
> (gdb) quit
> puma:/uml#
> 
> In my tree, arch/um/kernel/skas/process.c:113 is the pid=clone(..., in
> 
> void start_userspace(int cpu)
> {
>         void *stack;
>         unsigned long sp;
>         int pid, status, n;
> 
>         stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
>                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if(stack == MAP_FAILED)
>                 panic("start_userspace : mmap failed, errno = %d", errno);
>         sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
> 
>         pid = clone(userspace_tramp, (void *) sp,
>                     CLONE_FILES | CLONE_VM | SIGCHLD, NULL);
> 
> 
> I hope this makes sense to someone because I'm off to sleep a few hours :-)
> 
> Regards,
> Nuno Silva
> 
> 
> 
> 

> execve("./linux", ["./linux"], [/* 25 vars */]) = 0
> uname({sys="Linux", node="puma", ...})  = 0
> brk(0)                                  = 0xa01f6000
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
> open("/lib/tls/i686/mmx/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/i686/mmx", 0xbffff16c) = -1 ENOENT (No such file or directory)
> open("/lib/tls/i686/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/i686", 0xbffff16c)     = -1 ENOENT (No such file or directory)
> open("/lib/tls/mmx/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/mmx", 0xbffff16c)      = -1 ENOENT (No such file or directory)
> open("/lib/tls/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls", 0xbffff16c)          = -1 ENOENT (No such file or directory)
> open("/lib/i686/mmx/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/i686/mmx", 0xbffff16c)     = -1 ENOENT (No such file or directory)
> open("/lib/i686/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/i686", 0xbffff16c)         = -1 ENOENT (No such file or directory)
> open("/lib/mmx/libutil.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/mmx", 0xbffff16c)          = -1 ENOENT (No such file or directory)
> open("/lib/libutil.so.1", O_RDONLY)     = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\16\0\000"..., 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=92994, ...}) = 0
> mmap2(NULL, 10672, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40018000
> mmap2(0x4001a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1) = 0x4001a000
> close(3)                                = 0
> open("/lib/libc.so.6", O_RDONLY)        = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0PZ\1\000"..., 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=19666162, ...}) = 0
> mmap2(NULL, 1252652, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
> mmap2(0x40142000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x127) = 0x40142000
> mmap2(0x4014b000, 7468, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014b000
> close(3)                                = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4014d000
> set_thread_area({entry_number:-1 -> 6, base_addr:0x4014d070, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
> rt_sigprocmask(SIG_SETMASK, [IO], NULL, 8) = 0
> getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
> brk(0)                                  = 0xa01f6000
> brk(0xa0217000)                         = 0xa0217000
> brk(0)                                  = 0xa0217000
> rt_sigaction(SIGINT, {0xa000dc90, [], SA_NOMASK|SA_ONESHOT}, NULL, 8) = 0
> rt_sigaction(SIGTERM, {0xa000dc90, [], SA_NOMASK|SA_ONESHOT}, NULL, 8) = 0
> rt_sigaction(SIGHUP, {0xa000dc90, [], SA_NOMASK|SA_ONESHOT}, NULL, 8) = 0
> fstat64(1, {st_mode=S_IFREG|0644, st_size=3126, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4014e000
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4014f000
> clone(child_stack=0x4014ffd8, flags=0|SIGCHLD) = 26355
> --- SIGCHLD (Child exited) @ 0 (0) ---
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> waitpid(26355, [WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP], WUNTRACED) = 26355
> ptrace(0x34 /* PTRACE_??? */, 26355, 0, 0xbffff8a0) = 0
> ptrace(PTRACE_GETREGS, 26355, 0, 0xa01d8c60) = 0
> ptrace(PTRACE_GETFPXREGS, 26355, 0, 0xa01d8d40) = 0
> ptrace(PTRACE_CONT, 26355, 0, SIG_0)    = 0
> waitpid(26355, [WIFEXITED(s) && WEXITSTATUS(s) == 1], 0) = 26355
> --- SIGCHLD (Child exited) @ 0 (0) ---
> munmap(0x4014f000, 4096)                = 0
> access("/proc/mm", W_OK)                = 0
> brk(0)                                  = 0xa0217000
> uname({sys="Linux", node="puma", ...})  = 0
> gettimeofday({1073378804, 532883}, NULL) = 0
> getpid()                                = 26354
> open("/tmp/vm_file-AukWKw", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
> unlink("/tmp/vm_file-AukWKw")           = 0
> fchmod(3, 0777)                         = 0
> _llseek(3, 33554432, [33554432], SEEK_SET) = 0
> write(3, "\0", 1)                       = 1
> fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
> mmap2(0xa0800000, 25165824, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0x800) = 0xa0800000
> mkdir("/root/.uml/", 0777)              = -1 EEXIST (File exists)
> open("/root/.uml/uPjYnh", O_RDWR|O_CREAT|O_EXCL, 0600) = 4
> close(4)                                = 0
> unlink("/root/.uml/uPjYnh")             = 0
> mkdir("/root/.uml/uPjYnh", 0777)        = 0
> open("/root/.uml/uPjYnh/pid", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE, 0644) = 4
> write(4, "26354\n", 6)                  = 6
> close(4)                                = 0
> mprotect(0xa0196000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> write(1, "Checking for the skas3 patch in "..., 79Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> ) = 79
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4014f000
> clone(child_stack=0x4014ffd8, flags=CLONE_VM|CLONE_FILES|SIGCHLD) = 26356
> --- SIGCHLD (Child exited) @ 0 (0) ---
> --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
> --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> waitpid(26356, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WUNTRACED) = 26356
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [], [IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> +++ killed by SIGSEGV +++


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
