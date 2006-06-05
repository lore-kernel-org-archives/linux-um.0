Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnOh3-0005fW-II for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 16:41:09 -0700
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FnOh2-0002c9-3d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 16:41:09 -0700
From: Andi Kleen <ak@suse.de>
Date: Tue, 6 Jun 2006 01:39:18 +0200
References: <20060604185212.28436.74951.stgit@memento.home.lan>
	<200606042106.08121.ak@suse.de>
	<200606051306.53234.blaisorblade@yahoo.it>
In-Reply-To: <200606051306.53234.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606060139.18327.ak@suse.de>
Subject: Re: [uml-devel] [PATCH] uml: fix signal code x86-64 [for 2.6.15]
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
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Monday 05 June 2006 13:06, Blaisorblade wrote:
> On Sunday 04 June 2006 21:06, Andi Kleen wrote:
> > > It isn't yet perfect, because we don't yet save floating point context.
> > > But that will come later. Additionally, there's a potential problem since
> > > RED zones will alternate stacks are used, unlike x86_64, so more stack
> > > space (128 bytes more) is used. But this shouldn't be a problem.
> > > Instead, having no red zone (like x86_64)
> >
> > x86-64 has a red zone.
> 
> On the alternate stack too? 

No, there not.

> The comment in the below code confused me... even  
> if when nesting signal frames sas_ss_flags(rsp) should be 0 and so the 
> redzone will be used.
> The below "RED-PEN" comment is probably wrong then... or not?
> 
> arch/x86_64/kernel/signal.c:
>         /* RED-PEN: redzone on that stack? */

It's bogus because the alternative stack cannot be nested. I will remove it.



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
