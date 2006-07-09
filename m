Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FzcAy-00033C-NX for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 09:30:32 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FzcAu-0000rP-Or
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 09:30:32 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 9 Jul 2006 18:30:20 +0200
References: <20060604185212.28436.74951.stgit@memento.home.lan>
	<200606051306.53234.blaisorblade@yahoo.it>
	<200606060139.18327.ak@suse.de>
In-Reply-To: <200606060139.18327.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607091830.21167.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, Andi Kleen <ak@suse.de>

On Tuesday 06 June 2006 01:39, Andi Kleen wrote:
> On Monday 05 June 2006 13:06, Blaisorblade wrote:
> > On Sunday 04 June 2006 21:06, Andi Kleen wrote:
> > > > It isn't yet perfect, because we don't yet save floating point
> > > > context. But that will come later. Additionally, there's a potential
> > > > problem since RED zones will alternate stacks are used, unlike
> > > > x86_64, so more stack space (128 bytes more) is used. But this
> > > > shouldn't be a problem. Instead, having no red zone (like x86_64)
> > >
> > > x86-64 has a red zone.
> >
> > On the alternate stack too?

> No, there not.

It has a redzone if a new signal handler is invoked.

> > The comment in the below code confused me... even
> > if when nesting signal frames sas_ss_flags(rsp) should be 0 and so the
> > redzone will be used.
> > The below "RED-PEN" comment is probably wrong then... or not?
> >
> > arch/x86_64/kernel/signal.c:
> >         /* RED-PEN: redzone on that stack? */
>
> It's bogus because the alternative stack cannot be nested. I will remove
> it.

No, it's bogus because if we're already on the alternate stack sas_ss_flags() 
won't return 0, but stacks can be nested (in that case the default path will 
correctly setup a red zone).

From man sigaltstack:
Functions called from a signal handler executing on an alternate signal stack 
will also use the alternate signal stack. (This also applies to  any  
handlers invoked for  other  signals  while the process is executing on the 
alternate signal stack.)

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
