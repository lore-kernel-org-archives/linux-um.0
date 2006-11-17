Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlBuW-0004Dh-AG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 14:10:12 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GlBuU-0006mp-Ig
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 14:10:12 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 17 Nov 2006 23:09:51 +0100
References: <335f7ed41.45513990@default.domain> <20061108081924.GA13080@SteX>
	<20061112224310.GA9721@SteX>
In-Reply-To: <20061112224310.GA9721@SteX>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611172309.51833.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Pkg-uml-devel] Are you aware to 386945 and lkml
	0609.2/1537.html
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
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it, Jeff Dike <jdike@addtoit.com>
Cc: pkg-uml-devel@lists.alioth.debian.org, shaulka@012.net.il

On Sunday 12 November 2006 23:43, Stefano Melchior wrote:
> On Wed, Nov 08, 2006 at 09:19:24AM +0100, Stefano Melchior wrote:
> Dear UML developer,
> it was reported by Debian users that the new convention in sysvinit
> package to prevent shm to be exec breaks some application.
> For this moment, I mean in order to allow the upcoming stable release
> Etch to be released, the changes to the package were reverted only to
> avoid dosemu and u-m-l package related not to be broken.
>
> As mentioned in the following mail [*], it would be possible to provide a
> kernel side support for this sysvinit security need: the patch linked at
> the
>
> http://uwsg.iu.edu/hypermail/linux/kernel/0609.2/1537.html
>
> can come in help.
Yes, the reasoning of that patch seems correct, and merging it would fix the 
problem also IMHO. I've just looked at reasoning behind patch refusal.

I've followed the link on the email, and found the containing thread. Reading 
the thread from this point onwards may explain a bit more:

http://marc.theaimsgroup.com/?l=full-disclosure&m=107451398723595&w=2

So, allowing /lib/ld-linux.so.2 /tmp/foo to work is bad (right) and that 
questionable patch to fix it was merged. A more proper patch would be needed 
to fix that.

One of the strongest technical reasons for the patch to do that is that 
mapping with PROT_READ and remapping with PROT_EXEC is allowed.
However, this also shows a possible horrible workaround for both UML and 
dosemu, i.e. exploiting this missing check.

Both trivial to implement and kludgy to do. What do you think?

> Would it be possible to manage this issue/need in order 
> to introduce this patch in the kernel?

We can fix this issue by trying to merge the patch, if you mean this (I do not 
understand well your sentence), but it seems difficult to merge it.

> What do you think it would be good to fix this issue?

> Thank you in advance
>
> SteX
>
> [*]
>
> > On Wed, Nov 08, 2006 at 01:57:36AM +0200, shaulka@012.net.il wrote:
> > Dear,
> >
> > >   I can't  run rootstrap. I believe the reason is
> > >
> > >     http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386945
> > >
> > > Just want to make sure you are aware of that.
> > >
> > >   While searching about it, I came across
> > > http://uwsg.iu.edu/hypermail/linux/kernel/0609.2/1537.html.
> >
> > please, have a look at the #396506 which reported the same question, and
> > Mattia answered that it was already fixed in "sysvinit-2.86.ds1-28". This
> > should be ready for etch.

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
