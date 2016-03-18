Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1agx0Q-0001Vm-IV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 16:12:06 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1agx0P-0008G3-Im
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Mar 2016 16:12:06 +0000
References: <1458091505-967-1-git-send-email-elicooper@gmx.com>
	<56EB2DF8.8030102@nod.at> <56EB5CC9.1030601@gmx.com>
	<56EBBA61.4090405@nod.at>
From: Eli Cooper <elicooper@gmx.com>
Message-ID: <56EC293B.8020407@gmx.com>
Date: Sat, 19 Mar 2016 00:13:47 +0800
MIME-Version: 1.0
In-Reply-To: <56EBBA61.4090405@nod.at>
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
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Hi Richard,

On 2016/3/18 16:20, Richard Weinberger wrote:
> I wonder how other architectures handle this case?
> Ideally I'd like to avoid as much extra code as possible in userspace().

Please forgive my ignorance of other architectures. But to the best of
my knowledge, FPU state is not saved and restored around a system call
in x86.

I agree that we should keep userspace() minimal. So what in the first
place is the FPU state save/restore code for? Or, what (except for
sigreturn) could possibly mess the FPU state of the ptrace'd process
without it?

I tried commenting out the FPU restore code in userspace() and tested
with a bunch of kernel modules and userland programs. Nothing bad
happened so far as I can tell.

Thanks,
Eli

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

