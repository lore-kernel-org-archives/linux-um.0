Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1af6UB-0004pa-WF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Mar 2016 13:55:12 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1af6UA-0005Bd-Cm for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Mar 2016 13:55:11 +0000
References: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
	<1457274987-20078-2-git-send-email-elicooper@gmx.com>
	<56E08B1A.4080809@nod.at> <56E3C055.1080301@gmx.com>
	<56E51D98.7010700@nod.at>
From: Eli Cooper <elicooper@gmx.com>
Message-ID: <56E571A4.7070702@gmx.com>
Date: Sun, 13 Mar 2016 21:56:52 +0800
MIME-Version: 1.0
In-Reply-To: <56E51D98.7010700@nod.at>
Subject: Re: [uml-devel] [PATCH 1/3] um: extend _fpstate to _xstate
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Hi Richard,

On 2016/3/13 15:58, Richard Weinberger wrote:
> Eli,
>
> Am 12.03.2016 um 08:08 schrieb Eli Cooper:
>> > Hi Richard,
>> > 
>> > On 2016/3/10 4:44, Richard Weinberger wrote:
>>> >> Hmm, this needs rework. Having everything on the stack is not good.
>> > 
>> > Okay, I'll rework the functions whose stack size is greater than the
>> > warning threshold by using kmalloc.
> I fear it is not that easy. Having a kmalloc() per context switch would
> be every expensive. Even for UML.

Actually only two functions' stack frame size exceed kernel's default
warning threshold (1024 bytes) after the _xstate extension, i.e.,
copy_sc_from_user and copy_sc_to_user. That's because they have an
_xstate on stack as well as a sigcontext, which contains another
_xstate. Context switches due to signal handling are rare; thus I think
having a kmalloc() for signal handling is acceptable.
>>> >> Can you also create a selftest such that this bug cannot happen again?
>> > 
>> > It seems that instead of writing a self-test showing this problem cannot
>> > happen again, I wrote a test that manifested another bug that is not
>> > directly related to my patch.
>> > 
>> > Without applying my patch, the current UML should support XMM registers
>> > because those are covered by _fpstate and PTRACE_GETFPREGS. But it
>> > seemed that XMM registers are not restored after the signal handler returns.
>> > 
>> > In the following quick test, the main loop should run indefinitely
>> > despite XMM registers are modified by the signal handler. But in UML,
>> > the loop breaks randomly within a minute or two, showing that the
>> > registers are corrupted. So far I haven't found the cause. Any hints?
> Meh. :(
> Can you figure out whether the issue depends on the host kernel? i.e. try something older
> and Linus' tree.
> UML is a heavy user of ptrace(), maybe the recent FPU cleanup on x86 broke something.
No, it seems that this issue does not depend on the host kernel, UML
kernel, or CPU. I can reproduce this bug on a variety of combinations of
them, with the host kernel ranging from 2.6.32 to 3.19 to 4.5.

Thanks,
Eli
>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

