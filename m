Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1aggIk-00050a-JU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2016 22:21:54 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aggIj-0000va-3z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2016 22:21:54 +0000
References: <1458091505-967-1-git-send-email-elicooper@gmx.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56EB2DF8.8030102@nod.at>
Date: Thu, 17 Mar 2016 23:21:44 +0100
MIME-Version: 1.0
In-Reply-To: <1458091505-967-1-git-send-email-elicooper@gmx.com>
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

Am 16.03.2016 um 02:25 schrieb Eli Cooper:
> This patch prevents userspace() from incorrectly restoring FPU registers
> after a sigreturn or rt_sigreturn system call, which has already restored
> FPU registers to the state prior to the signal handler was invoked.
> 
> Fixes FPU state corruption after invoking the signal handler.

First of all, thanks a lot for hunting down these nasty issues!

Where exactly are the FPU regs restored in the sigregturn case?
Not sure if I fully understand the error scenario.

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

