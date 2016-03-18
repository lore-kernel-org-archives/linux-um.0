Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1agpeV-0001Yn-9y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 08:20:59 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1agpeT-0002J8-S0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 08:20:59 +0000
References: <1458091505-967-1-git-send-email-elicooper@gmx.com>
	<56EB2DF8.8030102@nod.at> <56EB5CC9.1030601@gmx.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56EBBA61.4090405@nod.at>
Date: Fri, 18 Mar 2016 09:20:49 +0100
MIME-Version: 1.0
In-Reply-To: <56EB5CC9.1030601@gmx.com>
Subject: Re: [uml-devel] [PATCH] um: fix FPU register double-restore after
	sigreturn
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
To: Eli Cooper <elicooper@gmx.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Eli,

Am 18.03.2016 um 02:41 schrieb Eli Cooper:
> Hi Richard,
> 
> On 2016/3/18 6:21, Richard Weinberger wrote:
>> Where exactly are the FPU regs restored in the sigregturn case?
>> Not sure if I fully understand the error scenario.
> 
> Well, sys_sigreturn() or sys_rt_sigreturn() calls copy_sc_from_user(),
> and the latter copies fpstate, which is the saved FPU state before the
> signal handler was invoked, from sigframe and restores it.
> That is correct: after returning from the signal handler, the process is
> in the same FPU state before it was invoked.
> 
> However, userspace() saves the FPU state before a system call and
> restores it after. In the sigreturn case, after sys_sigreturn() returns,
> which has already made FPU in the right state, userspace() overwrites it
> by making it in the state prior to the sigreturn was called (i.e., the
> signal handler's state). That leaves the process in question a corrupted
> FPU state.

Okay. That's what I thought/feared.
I wonder how other architectures handle this case?
Ideally I'd like to avoid as much extra code as possible in userspace().

Thanks,
//richard

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

