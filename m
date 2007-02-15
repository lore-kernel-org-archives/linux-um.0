Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHXXE-0005bM-H8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 19:44:01 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HHXXC-0007Jz-O1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 19:43:52 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 15 Feb 2007 04:43:41 +0100
References: <11715068631914-git-send-email-blaisorblade@yahoo.it>
	<20070215025423.GA9300@ccure.user-mode-linux.org>
In-Reply-To: <20070215025423.GA9300@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702150443.42287.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, stable@kernel.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>

On Thursday 15 February 2007 03:54, Jeff Dike wrote:
> On Thu, Feb 15, 2007 at 03:34:23AM +0100, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Index: linux-2.6.git/arch/x86_64/ia32/ptrace32.c
> > ===================================================================
> > --- linux-2.6.git.orig/arch/x86_64/ia32/ptrace32.c
> > +++ linux-2.6.git/arch/x86_64/ia32/ptrace32.c
> > @@ -246,6 +246,7 @@ asmlinkage long sys32_ptrace(long reques
> >  	case PTRACE_SINGLESTEP:
> >  	case PTRACE_DETACH:
> >  	case PTRACE_SYSCALL:
> > +	case PTRACE_OLDSETOPTIONS:
> >  	case PTRACE_SETOPTIONS:
> >  	case PTRACE_SET_THREAD_AREA:
> >  	case PTRACE_GET_THREAD_AREA:
>
> I sent an equivalent patch in earlier today:
Doh! Interesting this timing...

> Index: linux-2.6/arch/x86_64/ia32/ptrace32.c
> ===================================================================
> --- linux-2.6.orig/arch/x86_64/ia32/ptrace32.c
> +++ linux-2.6/arch/x86_64/ia32/ptrace32.c
> @@ -239,6 +239,8 @@ asmlinkage long sys32_ptrace(long reques
>  	__u32 val;
>
>  	switch (request) {
> +	case PTRACE_OLDSETOPTIONS:
> +		request = PTRACE_SETOPTIONS;
>  	case PTRACE_TRACEME:
>  	case PTRACE_ATTACH:
>  	case PTRACE_KILL:
>
> I change the request so that PTRACE_OLDSETOPTIONS doesn't need to
> propogate any further.  However, it is present in include/asm-x86_64,
> so I guess that counts as being part of the x86_64 ABI.  That being
> the case, I guess my patch can be dropped in favor of this one.

It is handled in ptrace_request, unless there are include problems. I'm going 
to reboot and test mine for any remaining problem.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
