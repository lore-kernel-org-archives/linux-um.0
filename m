Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9wHs-0002TT-Cy for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Jan 2007 20:32:36 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1H9wHs-0008Pn-4A
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Jan 2007 20:32:36 -0800
Date: Wed, 24 Jan 2007 20:31:26 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20070124203126.36e78674.akpm@osdl.org>
In-Reply-To: <200701232333.29655.blaisorblade@yahoo.it>
References: <20070122201317.GA8594@linuxtv.org>
	<200701230902.30715.blaisorblade@yahoo.it>
	<20070123131730.GA9286@linuxtv.org>
	<200701232333.29655.blaisorblade@yahoo.it>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] [UML] fix mknod
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
Cc: Jeff Dike <jdike@karaya.com>, Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, 23 Jan 2007 23:33:29 +0100
Blaisorblade <blaisorblade@yahoo.it> wrote:

> On Tuesday 23 January 2007 14:17, Johannes Stezenbach wrote:
> > On Tue, Jan 23, 2007 at 09:02:30AM +0100, Blaisorblade wrote:
> > > On Monday 22 January 2007 21:13, Johannes Stezenbach wrote:
> > > > I was playing with user-mode Linux and found that mknod creates
> > > > devices node in hostfs with wrong major/minor numbers.
> > > > The patch below fixes it for me.
> > >
> > > Hmpf. Still having this bug on hostfs is quite bad. Thanks for reporting.
> 
> I've now seen - we never fixed this one, we fixed the analogous problem 
> on 'ls' output and friends (in init_inode, which is used in many places).
> 
> > > It should be hostfs_user.c to take major and minor and to combine them
> > > correctly - it can use libc's macros.
> >
> > Right, below is a better patch.
> 
> Exactly what I meant, thanks!
> I'd say:
> Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> This can go to 2.6.20, and possibly even to -stable (after either me or Jeff 
> tests it once).

So..  did you test it?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
