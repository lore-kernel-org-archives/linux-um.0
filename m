Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0EH-0001UB-Pu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:00:13 -0800
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ed0ED-0001FS-EU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:00:14 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
	<Pine.LNX.4.64.0511091547160.4627@g5.osdl.org>
	<200511160736.44659.rob@landley.net>
In-Reply-To: <200511160736.44659.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180808.57481.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 18 Nov 2005 08:08:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Wednesday 16 November 2005 14:36, Rob Landley wrote:
> Linus said this:
> > I think one reason -mm has worked so damn well (apart from you being "The
> > Calmest Man on Earth"(tm)) is because it's essentially been that buffer
> > for anything non-trivial. Sometimes the "n+2" has been a lot more than
> > "n+2" in fact, and that's often good.
> >
> > (And at the same time, -mm has enough visibility that it doesn't drive
> > developers crazy even when the "n+2" ends up being "n+5" or somethiing).
> >
> > I'd _hope_ that the same kind of situation could work for some of the
> > majos subsystem git trees too: where the maintainer tree is well enough
> > known that it gets sufficient coverage for that area that a "+2" approach
> > for merging into the default kernel is practical.
> >
> > I also think it certainly _should_ be possible for the big areas that
> > have well-defined target audiences.
>
> And so I thought a bit about what that tree would be for UML (-mm?  -bb?)
> and decided "it's gotta be Jeff's tree as defined by
> user-mode-linux.sf.net/patches.html", so I grabbed the big rolled up
> tarball there that applies on top of 2.6.15-rc1:
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.15-rc1/patches.
>tar

Definitely Jeff's tree is a first filter for his work, but I've not seen it 
working a lot as a collector, especially for little fixes - but there it 
makes sense.

I tend to send directly to Andrew and he forwards them to Linus (in many cases 
so fast that I wonder if they appear in one -mm release), but I currently do 
not have a public tree.

> And applied them all (in series order) with a for loop.

Can I suggest using quilt for this (as it's more powerful and easy to use)?

Especially when you add other patches as compile fixups...

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
