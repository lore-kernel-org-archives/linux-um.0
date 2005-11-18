Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0tb-0002q2-1B for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:42:55 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ed0ta-0007fW-DP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:42:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
	<200511180808.57481.blaisorblade@yahoo.it>
	<200511180117.03742.rob@landley.net>
In-Reply-To: <200511180117.03742.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180851.38683.blaisorblade@yahoo.it>
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
Date: Fri, 18 Nov 2005 08:51:38 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Friday 18 November 2005 08:17, Rob Landley wrote:
> On Friday 18 November 2005 01:08, Blaisorblade wrote:
> > On Wednesday 16 November 2005 14:36, Rob Landley wrote:
> > > Linus said this:

Btw, where does this quote come from?

> > > > I think one reason -mm has worked so damn well (apart from you being
> > > > "The Calmest Man on Earth"(tm)) is because it's essentially been that
> > > > buffer for anything non-trivial. Sometimes the "n+2" has been a lot
> > > > more than "n+2" in fact, and that's often good.
> > > >
> > > > (And at the same time, -mm has enough visibility that it doesn't
> > > > drive developers crazy even when the "n+2" ends up being "n+5" or
> > > > somethiing).

I don't quite get this +2/+5 discussion.

> > > > I'd _hope_ that the same kind of situation could work for some of the
> > > > majos subsystem git trees too: where the maintainer tree is well
> > > > enough known that it gets sufficient coverage for that area that a
> > > > "+2" approach for merging into the default kernel is practical.
> > > >
> > > > I also think it certainly _should_ be possible for the big areas that
> > > > have well-defined target audiences.

> > Definitely Jeff's tree is a first filter for his work, but I've not seen
> > it working a lot as a collector, especially for little fixes - but there
> > it makes sense.

> > I tend to send directly to Andrew and he forwards them to Linus (in many
> > cases so fast that I wonder if they appear in one -mm release), but I
> > currently do not have a public tree.

> So there currently _is_ no one UML tree that people interested in the most
> recent UML developments can check out.  We basically have to wait until it
> hits mainline.

Patches go in -mm first. Currently Andrew is often very quick at merging them.

Also, fixups tend to have less needs for testing - and they're often 
backported to -bs.

Also, I don't tend to merge big patches without first checking.

> That's sad.  I think I'll stick with Jeff's tree as the closest I've come
> so far...

> > > And applied them all (in series order) with a for loop.
> >
> > Can I suggest using quilt for this (as it's more powerful and easy to
> > use)?
> >
> > Especially when you add other patches as compile fixups...

> I'm not applying the other patches at the moment.  Right now I'm just
> trying to get Jeff's tree to build for me.

Which means applying your own fixups.

> If I have time tonight I'm 
> going to cherry-pick his patch list to see which ones I can get to compile,
> and give him the list of each one that breaks my build (and how).

I suggest quilt exactly because it automates one big task - managing the 
stacks of applied and unapplied patches. Will "patch" suggest you which patch 
is the top one? Quilt will. That's why I suggest you to try it.

> I just 
> mentioned that #2 of the recent 4 sent to Andrew broke the build for me,
> but that's not the only breakage I see from Jeff's tree.  (I currently have
> access to four different build environments.  I was focusing on the PLD
> x86-64 system I'm borrowing, but right now I'm focusing on my ubuntu
> laptop.  Then knoppix, and then my Linux From Scratch system with gcc 4.0.2
> and uClibc...

> Expect to be hearing from me a lot. :)

No problem... just be patient for fixes. And IMHO you shouldn't feel so shy 
about fixing such compile problems (no complaining!) I don't expect you to 
debug the stub problems, but the rest should be easier to work with.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
