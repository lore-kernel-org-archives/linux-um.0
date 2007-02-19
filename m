Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJG95-0004EH-Ej for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 13:34:03 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HJG92-0007PL-Ag
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 13:34:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 19 Feb 2007 22:33:42 +0100
References: <Pine.LNX.4.64.0701260101250.5924@sparrow>
	<200702150436.54553.blaisorblade@yahoo.it>
	<200702150542.12363.blaisorblade@yahoo.it>
In-Reply-To: <200702150542.12363.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702192233.42588.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Possible hostfs uml kernel data corruption with
	missing host directory (fc6, 2.6.20-rc5-git3 on opteron)
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
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

On Thursday 15 February 2007 05:42, Blaisorblade wrote:
> On Thursday 15 February 2007 04:36, Blaisorblade wrote:
> > On Friday 26 January 2007 16:13, Jeff Dike wrote:
> > > On Fri, Jan 26, 2007 at 04:07:05AM -0500, William Stearns wrote:
> > > > 	After bisecting the difference between the two root filesystems,
> > > > the critical change was a line in /etc/fstab:
> > > >
> > > > none            /mirrors        hostfs  defaults,/home/mirrors  0 0
> > > >
> > > > 	Woah.
> >
> > Ok, I think I have found it from code analisys (no testing done). Please
> > test the attached patch, since the bug is repeatable for you.
>
> I could reproduce the bug and since I had slab debugging enabled, I got a
> trace corresponding to what I said (with a 32bit UML). I'll test the patch
> tomorrow - I'm exhausting the battery - but I'm in the end confident it
> will work.
I've tested the patch and it fix the bug, but William, did you try it?
I like getting mails like "ok, it works for me, you can 'close' this bug".
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
