Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jdike@addtoit.com>) id 1agxmX-00084I-I5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 17:01:49 +0000
Received: from u16576595.onlinehome-server.com ([74.208.238.6]
	helo=euler.addtoit.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1agxmW-0001pl-IV for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 17:01:49 +0000
Date: Fri, 18 Mar 2016 12:42:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20160318164243.GA979@parts.user-mode-linux.org>
References: <1458091505-967-1-git-send-email-elicooper@gmx.com>
	<56EB2DF8.8030102@nod.at> <56EB5CC9.1030601@gmx.com>
	<56EBBA61.4090405@nod.at> <56EC293B.8020407@gmx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56EC293B.8020407@gmx.com>
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
To: Eli Cooper <elicooper@gmx.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 19, 2016 at 12:13:47AM +0800, Eli Cooper wrote:
> I agree that we should keep userspace() minimal. So what in the first
> place is the FPU state save/restore code for? Or, what (except for
> sigreturn) could possibly mess the FPU state of the ptrace'd process
> without it?

My (vague) recollection was that with libc in there, I couldn't be
confident that it wouldn't unexpectedly use FP for something.  So,
saving and restoring FP state was a hedge against that happening.

				Jeff
-- 
Jeff Dike
AddToIt
978-254-0789 (o)
978-394-8986 (c)

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

