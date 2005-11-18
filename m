Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed1oY-00050s-PY for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 00:41:46 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed1oV-0000iv-8E
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 00:41:46 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
	<200511180117.03742.rob@landley.net>
	<200511180851.38683.blaisorblade@yahoo.it>
In-Reply-To: <200511180851.38683.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180241.33265.rob@landley.net>
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
Date: Fri, 18 Nov 2005 02:41:33 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 18 November 2005 01:51, Blaisorblade wrote:
> On Friday 18 November 2005 08:17, Rob Landley wrote:
> > On Friday 18 November 2005 01:08, Blaisorblade wrote:
> > > On Wednesday 16 November 2005 14:36, Rob Landley wrote:
> > > > Linus said this:
>
> Btw, where does this quote come from?

Linux-kernel, last wednesday.

http://seclists.org/lists/linux-kernel/2005/Nov/3391.html

> > > > > I think one reason -mm has worked so damn well (apart from you
> > > > > being "The Calmest Man on Earth"(tm)) is because it's essentially
> > > > > been that buffer for anything non-trivial. Sometimes the "n+2" has
> > > > > been a lot more than "n+2" in fact, and that's often good.
> > > > >
> > > > > (And at the same time, -mm has enough visibility that it doesn't
> > > > > drive developers crazy even when the "n+2" ends up being "n+5" or
> > > > > somethiing).
>
> I don't quite get this +2/+5 discussion.

Context from the rest of the thread, which started here:
http://seclists.org/lists/linux-kernel/2005/Nov/3290.html

n is release number.  It was about the 2 week merge window and the fact that 
it's a fairly sucky time to do new development.  (It's for merging stuff that 
you already got to work, and then bug fixes.)  The -mm tree is for shaking 
bugs out of stuff that worked for you, but may not get merged into linus's 
tree immediately.

> > > > > I'd _hope_ that the same kind of situation could work for some of
> > > > > the majos subsystem git trees too: where the maintainer tree is
> > > > > well enough known that it gets sufficient coverage for that area
> > > > > that a "+2" approach for merging into the default kernel is
> > > > > practical.
> > > > >
> > > > > I also think it certainly _should_ be possible for the big areas
> > > > > that have well-defined target audiences.
> > >
> > > Definitely Jeff's tree is a first filter for his work, but I've not
> > > seen it working a lot as a collector, especially for little fixes - but
> > > there it makes sense.
> > >
> > > I tend to send directly to Andrew and he forwards them to Linus (in
> > > many cases so fast that I wonder if they appear in one -mm release),
> > > but I currently do not have a public tree.
> >
> > So there currently _is_ no one UML tree that people interested in the
> > most recent UML developments can check out.  We basically have to wait
> > until it hits mainline.
>
> Patches go in -mm first. Currently Andrew is often very quick at merging
> them.

The problem is (as the discussion brought up), Andrew's tree integrates many 
things.  If you want to test _just_ one subsystem, there's usually a tree you 
can go to to get just -linus plus the new subsystem.

> Also, fixups tend to have less needs for testing - and they're often
> backported to -bs.

"backported"?  So is -bs more stable than mainline?  I thought it was your 
development tree...

> Also, I don't tend to merge big patches without first checking.

Testing -mm (except for fun) doesn't work for me because too much other stuff 
is in there and if something breaks I don't know what it is.  (It's nice to 
test it and be able to give a thumbs up if it passes.  But failure in -mm is 
not always a useful data point.  Certainly not without "ok, -linus plus 
-uml-current worked, so something else in -mm is breaking UML on x86-64 
building under PLD..."

> > I'm not applying the other patches at the moment.  Right now I'm just
> > trying to get Jeff's tree to build for me.
>
> Which means applying your own fixups.

When absolutely necessary, yes.  In theory Jeff's tree works for Jeff so i'm 
trying to get it to work for me _without_ fixing it myself.  (Instead I bug 
_him_. :)  But I'm on a wildly different distro (ubuntu on x86 and PLD on 
x86-64) and things like maszur's headers or the /lib64 thing I haven't got 
much choice to patch myself.

I try not to _keep_ these patches.  You'll notice I post them here in hopes 
mainline fixes the problem (whether my fix or a different one).

> > If I have time tonight I'm
> > going to cherry-pick his patch list to see which ones I can get to
> > compile, and give him the list of each one that breaks my build (and
> > how).
>
> I suggest quilt exactly because it automates one big task - managing the
> stacks of applied and unapplied patches. Will "patch" suggest you which
> patch is the top one?

What I'm currently doing is:

for in in `cat patches/series`
do
  echo $i
  patch -p1 -i patches/$i
done

I.E. I'm letting Jeff's "series" indicate which order they should go in.

I have nothing against quilt but learning new tools tends to go on my todo 
list.  I go down enough tangential ratholes in an average day as it is. :)

> Quilt will. That's why I suggest you to try it. 

I'm trying very hard to _avoid_ managing my own tree, thanks.  If I ever have 
more than about three patches I'm applying to the tree at once, it's time to 
either push to get them in mainline or upgrade to a newer version.

With the linux kernel I'm applying squashfs (which I would very much like to 
see in mainline but I seem to have missed that flamewar this time 'round), 
and one three line removal.  The rest is fixups to 2.6.15-rc1 that I hope to 
see in -rc2 or -rc3.

For systems I do lots of new development on, I just use subversion.

> > I just
> > mentioned that #2 of the recent 4 sent to Andrew broke the build for me,
> > but that's not the only breakage I see from Jeff's tree.  (I currently
> > have access to four different build environments.  I was focusing on the
> > PLD x86-64 system I'm borrowing, but right now I'm focusing on my ubuntu
> > laptop.  Then knoppix, and then my Linux From Scratch system with gcc
> > 4.0.2 and uClibc...
> >
> > Expect to be hearing from me a lot. :)
>
> No problem... just be patient for fixes.

I know. :)

> And IMHO you shouldn't feel so shy  about fixing such compile problems (no
> complaining!) I don't expect you to debug the stub problems, but the rest
> should be easier to work with. 

I fixed the header #include problem myself once I understood that Jeff had 
never used Mazur's headers.  He took my patch for that.

The /lib64 thing I have no _clue_ how the linker stage of the linux kernel 
works (it has a linker script to tell ld what to do, and does black magic 
with elf segments so it can put stuff into the init segment and make a module 
export list and...  Ummm..  Eek.)  I know my patch there is wrong (it breaks 
x86), figuring out what to do about that is a todo item..

The recent breakage I saw with patches.tar was too much damage for Jeff _not_ 
to have seen, so it was either some kind of compiler version problem where my 
patches were likely to break _his_ system, or else I didn't understand what 
was going on.  (And #2 was the case: once I found out it was the 0 length 
files, I could fix that.  I didn't expect 0 length files screwing up the 
#include search paths.  The #include search paths are confusing, I'm still a 
bit fuzzy on the difference between include and include2, actually...)

I'm happy to debug stuff myself, when I can.  And to submit patches...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
