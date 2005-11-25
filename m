Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Efwur-0001fw-HT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:04:21 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Efwuq-0000tc-BD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:04:21 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511251418.43866.rob@landley.net>
	<87br08iglz.fsf@amaterasu.srvr.nix>
In-Reply-To: <87br08iglz.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251631.41518.rob@landley.net>
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
Date: Fri, 25 Nov 2005 16:31:41 -0600
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Friday 25 November 2005 15:04, Nix wrote:
> The ~/.kde directory doesn't contain temporary files, but persistent state:

~/.kde/share/apps/kmail/lock is persistent state?

I do know that half the time the darn battery runs out and kde suddely shuts 
down my desktop without the courtesy of even _warning_ me first (oh it pops 
up a window three seconds before doing it), kmail doesn't have a chance to 
zap this file before being killed and thus I have to drill down and zap the 
sucker by hand or it'll refuse to run when I boot back up.

Circa Red Hat 9, konqueror's cache files were under .kde.  I have no idea what 
the junk in .kde/share/apps/kpdf is for...

But I take your point.  They've instituted a policy and tried to clean this 
up.  Similarly, .bash_history, .bittorrent, .DCOPserver*, .mcop, and all the 
other fun stuff written into home must be considered persistent state.

> and the same is true of /var/spool,

Doesn't /var/spool/cups contains files spooled to the printer?  (I dunno, the 
only printer in the house is hooked up to my fiance's windows machine.)

> > things like vi would create temporary files in /tmp,
>
> /var/tmp, because the entire point of those files was to survive a reboot.

Is it?  I thought it was to support undo.

> >                                                      but these days it
> > uses . ${filename}.swp in the same directory as the file being edited.
>
> Yes, and I absolutely despise this behaviour. Is there any way to force vim
> to use /var/tmp like everyone else?

It's a compile-time option.  (I accidentally set it to use /tmp once and had 
to figure out how to undo it.)

> - programs writing to $TMPDIR; config.guess, configure, and GCC are big
> users on my systems, but lots of other apps write here for a while. Of
> course you could point TMPDIR somewhere else, but does anyone do that?
>
>   There are a quite surprising number of these: generally the files live
>   for brief instants before being unlinked, if at all. (mkstemp() creates
> its files in $TMPDIR, after all, and often for those files minimal overhead
> is what counts; and like it or not tmpfs has lower overhead than ext*fs.)

Files that live for brief instants never get written out to disk anyway.  
That's why there's the delay before dirty pages in the page cache are 
scheduled for writeout.  So tmpfs doesn't help there.

> - users. A *lot* of my users dump temporary crud in /tmp:

Yeah, at Rutgers we used to do that on the Sun machines to get around the disk 
quota.

> the names of these files aren't predictable unless you're telepathic
> so we're pretty safe from symlink attacks. (My local users are Nice Guys
> anyway, or I shoot them. No shots have so far been necessary.)
>
> Maybe your users don't dump everything they don't care much about in
> /tmp: mine are always sticking all sorts of things in there from
> half-chewed LaTeX through to boring logfiles and stuff being looked over
> on its way to the printer :)

Sounds like your users are old unix hands who cut their teeth on traditional 
Unix boxes in the days before Linux.

> > Keep in mind that tmpfs used to be shmfs, and what it's good at is
> > providing shared memory.
>
> Yep. It just so happens that this gives good properties for transient stuff
> that should vanish no later than the next reboot, and generally lives only
> for as long as someone has it open.

*shrug*.  The truly transient stuff never leaves the page cache, no matter 
what the filesystem.  (Especially if you mount with noatime, which is the 
norm these days.)

> >                 What UML really _wants_ is shared memory, which has
> > traditionally been available through /dev/shm.  Insisting that /tmp
> > behave like /dev/shm because otherwise what you get doesn't behave like
> > shared memory A) doesn't make make a whole lot of sense, B) doesn't match
> > existing practice.
>
> `Existing practice' seems to me to have pretty much wanted something,
> uh, like tmpfs. But maybe your existing practice of /tmp is very different
> from mine. (It certainly sounds like it.)

Out there in the field, today, /tmp is not usually tmpfs.  And nobody's seen 
enough benefit in it to bother deploying it on the Fedora, Gentoo, and Ubuntu 
systems I've tested.

I suspect that knoppix uses tmpfs for /tmp, since it has no backing store.  
(Firing up knoppix 4.0 under qemu...)  Heh.  I was sort of right.  /tmp 
doesn't have anything explicitly mounted on it, but inherits the unionfs 
mount on root, which is a combination of the cdrom and a tmpfs mount 
on /ramdisk.  So it is sort of tmpfs, but not explicitly.  It seems to line 
up with Jeff's recommendations entirely by accident. :)

> > "can" doesn't mean "should".  Yes you can make a 10 gigabyte swap
> > partition, but most people actively don't want one because if your system
> > ever winds up using more than about twice as much swap space as it has
> > physical memory, it's likely that the amount of swap thrashing you're
> > doing is getting pathological.
>
> You've never used dar in infinint mode

Never even heard of it.

> or watched large matrix maths stuff 
> churn through to completion :/

Oh I've watched large jobs thrash the heck out of a machine all afternoon.  
Classic ray tracing, for example...

> there really are things with insane memory 
> requirements and good locality of reference. (I think the most I ever saw
> dar eat was 15Gb of swap. *gah*)

I'm not saying there aren't uses for it, I'm just saying it's not the norm and 
hence not a sane default.

> >                Having a runaway app have to churn through 10 gigabytes of
> > swap space before the OOM killer terminates it can turn 30 seconds of
> > paralysis into 10 minutes.  Not an improvement.
>
> The problem there is that it's churning, i.e. that its locality of
> reference is crap. Such a program should indeed not be allowed to eat that
> much swap.

Well, there's also the fact a high-end modern laptop probably has about 80 
gigs of storage space and the cheaper ones have 40 or even 20.  So eating 10 
gigs of that just isn't an option.

More laptops were sold last year than workstations.

> > Also, although it's pretty common to have 10 gigabytes of spare disk
> > space on a modern laptop, it is _not_ common to have 10 gigabytes of
> > spare swap space, and that's for a reason.  Extra space in your
> > filesystem can be used for all sorts of things.  Extra swap space is
> > normally wasted.
>
> You can zap it if you need it for something else pretty easily. swapfiles
> are no slower than swap partitions these days, and swap partitions are easy
> to turn into filesystems too.

I've done this, but it's not automatic.  (Did they ever make swapfiles 
reliable so they don't lock up under low memory situations?)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
