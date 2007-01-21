Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H8fHD-0008Ai-Bb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jan 2007 08:10:40 -0800
Received: from mxfep04.bredband.com ([195.54.107.79])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H8fHA-0001Da-D8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jan 2007 08:10:39 -0800
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
	by mxfep04.bredband.com with ESMTP id
	<20070121161029.ITNI2732.mxfep04.bredband.com@ironport2.bredband.com>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 Jan 2007 17:10:29 +0100
Date: Sun, 21 Jan 2007 17:11:11 +0100 (CET)
From: Joel Palmius <joel.palmius@miun.se>
In-Reply-To: <45B37CB4.2050908@nagafix.co.uk>
Message-ID: <Pine.LNX.4.64.0701211709500.3755@ligur.home.jwp.se>
References: <200701171715.35504.blaisorblade@yahoo.it>
	<45AE684D.7070802@theshore.net>
	<45AE67C0.5080003@nagafix.co.uk> <45AE7DFC.9050704@nagafix.co.uk>
	<45B0A4B7.7050702@nagafix.co.uk>
	<1169222858.11134.52.camel@athena.fprintf.net>
	<45B0EE71.5040908@nagafix.co.uk>
	<1169224702.11134.71.camel@athena.fprintf.net>
	<45B0F512.6020308@nagafix.co.uk> <45B10106.6060107@nagafix.co.uk>
	<45B12269.8040203@nagafix.co.uk>
	<Pine.LNX.4.64.0701211534310.3499@ligur.home.jwp.se>
	<45B37CB4.2050908@nagafix.co.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] buggy UML AMD64?
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
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

I tested a (host) kernel build without the *_FS_SECURITY thingies, but 
with same result. I guess the problem is something else.

   // Joel


On Sun, 21 Jan 2007, Antoine Martin wrote:

> Joel Palmius wrote:
>> Confirmed on my athlon64 gentoo setup. I've been running 2.6.14.3 as
>> host kernel for ages (since I was too wimpy to try to upgrade a host
>> kernel remote on a machine that required binary proprietary drivers).
>>
>> On 2.6.14.3 x86_64 all my 32bit UMLs run fine with various guest kernels
>> compiled in various circumstances.
> on x86 I was able to upgrade as far as 2.6.15.x, 2.6.16 and later broke.
> So you may be able to upgrade by one minor release (not much - and
> 2.6.15 is no longer maintained, whereas 2.6.16 is... damn)
>
>> On 2.6.18-gentoo-r6 x86_64 (genkernel), all guest UMLs spin up to 100%
>> and does nothing, no output whatsoever.
> Finally someone confirms what I have been seeing for ages!
> Maybe the devs can find out what is going on now...
>
> It does look like a host kernel issue, but since other people are
> reporting no errors with the same kernels, I wouldn't completely discard
> the possibility that glibc has something to do with this.
> Also, there was a report today that *_FS_SECURITY is causing problems.
> Do you happen to have *_FS_SECURITY options switched on (on the host)?
>
> Antoine
>
>
>
>
>> Strace says:
>>
>> execve("./vmlinux", ["./vmlinux"], [/* 28 vars */]) = 0
>> [ Process PID=13658 runs in 32 bit mode. ]
>> uname({sys="Linux", node="master", ...}) = 0
>> brk(0)                                  = 0xffffffffa0314000
>> brk(0xa0314844)                         = 0xffffffffa0314844
>> set_thread_area(0xffdb51d0)             = 0
>> brk(0xa0335844)                         = 0xffffffffa0335844
>> brk(0xa0336000)                         = 0xffffffffa0336000
>> getrlimit(RLIMIT_STACK, {rlim_cur=-4286578688, rlim_max=4292563436}) = 0
>> rt_sigaction(SIGINT, {0xc0000000a001cad8, [], 0}, NULL, 8) = 0
>> rt_sigprocmask(SIG_UNBLOCK, [INT], NULL, 8) = 0
>> rt_sigaction(SIGTERM, {0xc0000000a001cad8, [],
>> SA_INTERRUPT|SA_ONESHOT|0x161e48}, NULL, 8) = 0
>> rt_sigprocmask(SIG_UNBLOCK, [TERM], NULL, 8) = 0
>> rt_sigaction(SIGHUP, {0xc0000000a001cad8, [], 0}, NULL, 8) = 0
>> rt_sigprocmask(SIG_UNBLOCK, [HUP], NULL, 8) = 0
>> fstat64(0x1, 0xffdb4ad8)                = 0
>> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
>> 0x1000) = 0xfffffffff7fe8000
>> mmap2(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC,
>> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0x1000) = 0xfffffffff7fe7000
>> clone(child_stack=0xf7fe7fd4, flags=|SIGCHLD) = 13659
>> --- SIGCHLD (Child exited) @ 0 (0) ---
>> waitpid(13659, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP}], WSTOPPED) =
>> 13659
>> ptrace(0x15 /* PTRACE_??? */, 13659, 0, 0x1) = -1 EINVAL (Invalid
>> argument)
>>
>>
>> Pity... I had finally decided to upgrade the host kernel... :-)
>>
>>   // Joel
>>
>>
>> On Fri, 19 Jan 2007, Antoine Martin wrote:
>>
>>> Antoine Martin wrote:
>>>>>>> I have downgraded the x86 boxes to 2.6.15.7 and these are up and
>>>>>>> running again. But I can't do that for all of them, and this is just
>>>>>>> not an option for some of the amd64 boxes.
>>>>>>
>>>>>> My setup is:
>>>>> Thanks for that. That is very similar to mine.
>>>>> I don't think this has anything to do with the guest... So I'll try to
>>>>> remove the skas3 patch from the host and see how it goes.
>>>>>
>>>> I did, and no improvement... x86 guests still hang.
>>>> Could you post a binary guest kernel somewhere so I can try that?
>>>> (even if it isn't static - glibc should be similar since we're using
>>>> Gentoo amd64)
>>>> If that still does not work then I can be certain that it is something
>>>> to do with the host.
>>> I've just tried on 3 more hosts, all AMD64 Gentoo fully up to date,
>>> kernel 2.6.19.2. No skas, no exec shield, no selinux, plain kernel.org:
>>> None of them work with any of the 32-bit kernels!
>>> It prints nothing, just sits there spinning at 100% cpu.
>>> So I am now totally convinced that i haven't got a weird setup.
>>> Something else is broken in UML.
>>>
>>> On fully up to date Fedora Core 6 x86_64, the kernel does display
>>> something before crashing:
>>> # uname -a
>>> Linux localhost.localdomain 2.6.18-1.2869.fc6 #1 SMP Wed Dec 20 14:51:34
>>> EST 2006 x86_64 x86_64 x86_64 GNU/Linux
>>> # ./kernel32-2.6.19.2
>>> Checking that ptrace can change system call numbers...OK
>>> Checking syscall emulation patch for ptrace...missing
>>> Checking for tmpfs mount on /dev/shm...OK
>>> Checking PROT_EXEC mmap in /dev/shm/...OK
>>> Checking for the skas3 patch in the host:
>>>   - /proc/mm...not found
>>>   - PTRACE_FAULTINFO...not found
>>>   - PTRACE_LDT...not found
>>> UML running in SKAS0 mode
>>>
>>> [root@localhost home]#
>>>
>>> This is 100% repeatable. Plain Fedora.
>>> Many users will have a similar setup and will just give up on UML.
>>> So I as I said before, UML is currently unusable for most people out
>>> there running fairly recent systems.
>>>
>>> Antoine
>>>
>>> -------------------------------------------------------------------------
>>> Take Surveys. Earn Cash. Influence the Future of IT
>>> Join SourceForge.net's Techsay panel and you'll get the chance to
>>> share your
>>> opinions on IT & business topics through brief surveys - and earn cash
>>> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>>> _______________________________________________
>>> User-mode-linux-devel mailing list
>>> User-mode-linux-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>>
>>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
