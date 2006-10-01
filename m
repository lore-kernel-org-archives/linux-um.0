Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU8Ql-00050U-3B for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 14:00:59 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GU8Qh-0002Tg-Db
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 14:00:56 -0700
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
	by gwu.lbox.cz (Sendmail) with ESMTP id k91L0jYC009778
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 23:00:45 +0200
Received: from [10.76.66.65] (nbnik.linuxbox.cz [10.76.66.65])
	(authenticated bits=0)
	by linuxbox.linuxbox.cz (Sendmail) with ESMTP id k91L0gEP029129
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 23:00:42 +0200
Message-ID: <45202C79.5080502@linuxbox.cz>
Date: Mon, 02 Oct 2006 00:00:41 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
References: <451E9BAB.5030009@linuxbox.cz>	<451EEB99.6030406@linuxbox.cz>	<20060930235752.GA16968@ccure.user-mode-linux.org>	<200610011725.16069.blaisorblade@yahoo.it>
	<451FE3F0.1070304@linuxbox.cz>
In-Reply-To: <451FE3F0.1070304@linuxbox.cz>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

OK, so I've tested 2.6.18-mm2, results are:
pcap network transport seems to be broken, and doesn't compile, I had to 
disable it
apart from that, all of behavior described before remains the same, 
nothing behaves neither better, nor worse...
n.

> guests:
> vanilla 2.6.18-x86_64 SKAS
>     - crashes trying to access /proc/mm
> vanilla 2.6.18-x86_64 noprocmm OR skas0
>     - works equally well, even performance is pretty much the same 
> (measured on kernel compilation), there's just this problem with 
> /sbin/halt hang
> vanilla 2.6.18-x86 - doesn't matter which arguments are passed
>     - hangs, strace shows following:
>         old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, 
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7f40000
>         mmap2(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, 
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7f3f000
>         clone(child_stack=0xf7f3ffd4, flags=|SIGCHLD) = 8120
>         waitpid(8120, [{WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL}], 
> WSTOPPED) = 8120
>         --- SIGCHLD (Child exited) @ 0 (0) ---
>     and child process dies this way:
>         getppid()                               = 8119
>         rt_sigprocmask(SIG_BLOCK, [WINCH], [], 8) = 0
>         ptrace(PTRACE_TRACEME, 0, 0, 0)         = -1 EPERM (Operation 
> not permitted)
>         dup(2)                                  = 4
>         fcntl64(4, F_GETFL)                     = 0x8002 (flags 
> O_RDWR|O_LARGEFILE)
>         fstat64(0x4, 0xf7f3fa44)                = 0
>         old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, 
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7f3e000
>         _llseek(4, 0, 0xf7f3faa4, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
>         write(4, "ptrace: Operation not permitted\n", 32) = 32
>         close(4)                                = 0
>         munmap(0xf7f3e000, 4096)                = 0
>         kill(8120, SIGKILL)                     = 0
>         +++ killed by SIGKILL +++
>
> 2.6.18-x86_64 with bb1 patch
>     - SKAS crashes as expected
>     - noprocmm or skas0 is weird:
>        if run, panics with:
>             [42949373.500000] VFS: Mounted root (ext2 filesystem) readonly.
>             Usage: init 0123456SsQqAaBbCcUu
>             [42949373.500000] Kernel panic - not syncing: Attempted to 
> kill init!
>       - aparentrly init is being executed in some strange way?
>     - given init=/bin/sh hangs, tracing shows following loop:
>         --- SIGCHLD (Child exited) @ 0 (0) ---
>         wait4(1381, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], 
> WSTOPPED, NULL) = 1381
>         ptrace(PTRACE_GETREGS, 1381, 0, 0x60aec330) = 0
>         ptrace(PTRACE_GETFPREGS, 1381, 0, 0x60aec408) = 0
>         ptrace(PTRACE_CONT, 1381, 0, SIGSEGV)   = 0
>     - round and round
>
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
