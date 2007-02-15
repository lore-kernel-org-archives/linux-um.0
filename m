Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHZXs-0000uU-Rv for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 21:52:41 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHZXs-0001Xm-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 21:52:40 -0800
Date: Wed, 14 Feb 2007 21:51:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070214215123.57ef2d4a.akpm@linux-foundation.org>
In-Reply-To: <200702150443.42287.blaisorblade@yahoo.it>
References: <11715068631914-git-send-email-blaisorblade@yahoo.it>
	<20070215025423.GA9300@ccure.user-mode-linux.org>
	<200702150443.42287.blaisorblade@yahoo.it>
Mime-Version: 1.0
Subject: Re: [uml-devel] x86_64: fix 2.6.18 regression -
	PTRACE_OLDSETOPTIONS should be accepted
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org

On Thu, 15 Feb 2007 04:43:41 +0100 Blaisorblade <blaisorblade@yahoo.it> wrote:

> > I sent an equivalent patch in earlier today:
> Doh! Interesting this timing...
> 
> > Index: linux-2.6/arch/x86_64/ia32/ptrace32.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86_64/ia32/ptrace32.c
> > +++ linux-2.6/arch/x86_64/ia32/ptrace32.c
> > @@ -239,6 +239,8 @@ asmlinkage long sys32_ptrace(long reques
> >  	__u32 val;
> >
> >  	switch (request) {
> > +	case PTRACE_OLDSETOPTIONS:
> > +		request = PTRACE_SETOPTIONS;
> >  	case PTRACE_TRACEME:
> >  	case PTRACE_ATTACH:
> >  	case PTRACE_KILL:
> >
> > I change the request so that PTRACE_OLDSETOPTIONS doesn't need to
> > propogate any further.  However, it is present in include/asm-x86_64,
> > so I guess that counts as being part of the x86_64 ABI.  That being
> > the case, I guess my patch can be dropped in favor of this one.
> 
> It is handled in ptrace_request, unless there are include problems. I'm going 
> to reboot and test mine for any remaining problem.

Whatever happens, please ensure that the final fix makes it into -stable
as well.  Jeff's version of this patch wasn't cc'ed to stable@kernel.org.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
