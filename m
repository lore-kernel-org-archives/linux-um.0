Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GU3b8-00044w-6N for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:51:22 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GU3b7-0005pp-G9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Oct 2006 08:51:22 -0700
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
	by gwu.lbox.cz (Sendmail) with ESMTP id k91FpFtF025843
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 17:51:15 +0200
Received: from [10.76.66.65] (nbnik.linuxbox.cz [10.76.66.65])
	(authenticated bits=0)
	by linuxbox.linuxbox.cz (Sendmail) with ESMTP id k91FpDNK017757
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 17:51:13 +0200
Message-ID: <451FE3F0.1070304@linuxbox.cz>
Date: Sun, 01 Oct 2006 18:51:12 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
References: <451E9BAB.5030009@linuxbox.cz>
	<451EEB99.6030406@linuxbox.cz>	<20060930235752.GA16968@ccure.user-mode-linux.org>
	<200610011725.16069.blaisorblade@yahoo.it>
In-Reply-To: <200610011725.16069.blaisorblade@yahoo.it>
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

Hi Paolo and others,
thanks a lot for explanation. I'll just add some things I've noticed 
(and also few another questions ;):
My setup is dualcore opteron machine, running SMP 2.6.18, patched with 
skasv9-pre9 with fremap support.
guests:
vanilla 2.6.18-x86_64 SKAS
    - crashes trying to access /proc/mm
vanilla 2.6.18-x86_64 noprocmm OR skas0
    - works equally well, even performance is pretty much the same 
(measured on kernel compilation), there's just this problem with 
/sbin/halt hang
vanilla 2.6.18-x86 - doesn't matter which arguments are passed
    - hangs, strace shows following:
        old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7f40000
        mmap2(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7f3f000
        clone(child_stack=0xf7f3ffd4, flags=|SIGCHLD) = 8120
        waitpid(8120, [{WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL}], 
WSTOPPED) = 8120
        --- SIGCHLD (Child exited) @ 0 (0) ---
    and child process dies this way:
        getppid()                               = 8119
        rt_sigprocmask(SIG_BLOCK, [WINCH], [], 8) = 0
        ptrace(PTRACE_TRACEME, 0, 0, 0)         = -1 EPERM (Operation 
not permitted)
        dup(2)                                  = 4
        fcntl64(4, F_GETFL)                     = 0x8002 (flags 
O_RDWR|O_LARGEFILE)
        fstat64(0x4, 0xf7f3fa44)                = 0
        old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7f3e000
        _llseek(4, 0, 0xf7f3faa4, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
        write(4, "ptrace: Operation not permitted\n", 32) = 32
        close(4)                                = 0
        munmap(0xf7f3e000, 4096)                = 0
        kill(8120, SIGKILL)                     = 0
        +++ killed by SIGKILL +++

2.6.18-x86_64 with bb1 patch
    - SKAS crashes as expected
    - noprocmm or skas0 is weird:
       if run, panics with:
            [42949373.500000] VFS: Mounted root (ext2 filesystem) readonly.
            Usage: init 0123456SsQqAaBbCcUu
            [42949373.500000] Kernel panic - not syncing: Attempted to 
kill init!
      - aparentrly init is being executed in some strange way?
    - given init=/bin/sh hangs, tracing shows following loop:
        --- SIGCHLD (Child exited) @ 0 (0) ---
        wait4(1381, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], 
WSTOPPED, NULL) = 1381
        ptrace(PTRACE_GETREGS, 1381, 0, 0x60aec330) = 0
        ptrace(PTRACE_GETFPREGS, 1381, 0, 0x60aec408) = 0
        ptrace(PTRACE_CONT, 1381, 0, SIGSEGV)   = 0
    - round and round

I hope it helps in some way.
I'm going to try mm patches now, to see if something behaves different 
(better if possible :)
nik.
PS: your setarch patch works, thanks!

Blaisorblade wrote:
> On Sunday 01 October 2006 01:57, Jeff Dike wrote:
>   
>> On Sun, Oct 01, 2006 at 01:11:37AM +0300, Nikola Ciprich wrote:
>>     
>>> You have an idea where
>>> could be problem with shutting down? (this Virtual timer expired
>>> cycling?)
>>>       
>> Oops, missed that in your previous message.
>>
>> Where in the shutdown process is this?  There have been some previous
>> reports of hangs during swapoff which I have been unable to reproduce.
>> I spent part of a day last week pushing UMLs deeply into swap and
>> shutting them down, always successfully.
>>
>> The SIGVTALRM is normal - that's just the timer.  That strace you sent
>> looks like the idle loop, so as far as the kernel is concerned,
>> everything is fine.
>>
>>     
>>> and regarding /proc/mm, shouldn't this mm64 file be used? or what's it
>>> used for?
>>>       
>> /proc/mm64?  What would it do that /proc/mm doesn't?
>>     
>
> Well, I'll explain everything (even to Jeff, since I never documented anything 
> of this).
>
> The SKAS patch V8 supports well i386 host and i386 guest. That's all.
> SKAS patch V9-preX tries to support x86_64 host, with both 32 and 64 bit 
> guests:
>
> * 32 bit guests: a bug prevents using full SKAS3, you must pass noprocmm and 
> you'll get most performance advantages (because faultinfo works). When I 
> worked on the SKAS port to x86_64 I did not discover that something worked, 
> and I never tested support for 64bit guests.
> I latter discovered the bug is in a different portion of code - Bodo Stroesser 
> unveiled it, and I think this is the same bug that hit even Jeff's 1st 
> attempt to write SKAS4 (all I know can be found in 
> http://user-mode-linux.sourceforge.net/diary.html -> grep skas4 and you'll 
> find what I'm talking about on 23 Sep 2004).
>
> * 64bit guests: they do not support SKAS3, but the host patch gives the needed 
> support - to do that, the 1st thing to do would be to use /proc/mm64 as you 
> point out (and it could even suffice, even if I doubt that), but guest 
> kernels still try to use /proc/mm and it does not work. So you must pass 
> skas0 on the cmdline (I do not remember whether noprocmm works for this 
> case).
>
> -EINVAL is given on purpose: the request struct UML writes on /proc/mm has a 
> different layout for 32 and 64bit requests, or better a different size since 
> pointers are larger (and there's an explicit check for that - IIRC it has 
> always been there). I chose to have a separate /proc/mm64, I did not think to 
> try autodetection. And frankly my first impression is that I'd still do it 
> this way.
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
