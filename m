Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgS92-0003H2-T4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:25:04 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgS8y-0006TW-CI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:25:04 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511251631.41518.rob@landley.net>
	<87br067y60.fsf@amaterasu.srvr.nix>
In-Reply-To: <87br067y60.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271324.36565.rob@landley.net>
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
Date: Sun, 27 Nov 2005 13:24:36 -0600
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 12:17, Nix wrote:
> [Sorry for response delay, steaming cold/flu]
>
> On Fri, 25 Nov 2005, Rob Landley worried:
> > On Friday 25 November 2005 15:04, Nix wrote:
> >> The ~/.kde directory doesn't contain temporary files, but persistent
> >> state:
> >
> > ~/.kde/share/apps/kmail/lock is persistent state?
>
> No, but KDE is a bit of a mess in some areas, and this is one of htem.

My fiance's laptop has xfce on it.  Her assessment?  "The mouse is cute."  And 
she doesn't actively hate it.

Pondering switching over to that.  It'd mean giving up Konqueror, but that's 
the Konqueror developers' fault for gluing it to hundreds of megabytes of 
unnecessary crap...

> > I do know that half the time the darn battery runs out and kde suddely
> > shuts down my desktop without the courtesy of even _warning_ me first (oh
> > it pops up a window three seconds before doing it), kmail doesn't have a
> > chance to zap this file before being killed and thus I have to drill down
> > and zap the sucker by hand or it'll refuse to run when I boot back up.
>
> ... and this is why it should be in /tmp.

As with all pid files, it should check and see if there is a currently running 
process with that PID (and that this process is using the same binary as it 
is, which you can find under /proc) and if not, zap the pid file as stale.  
There should probably be a library function for this, it's to let you find 
the currently running instance.  You should confirm once you find...

> > Circa Red Hat 9, konqueror's cache files were under .kde.  I have no idea
> > what the junk in .kde/share/apps/kpdf is for...
>
> Not true as of reasonably recent Konquerors.

It's now under /var/tmp, as I mentioned.  (Apparently, they want the cache to 
persist between reboots, despite the fact I told it cookies shouldn't.  So 
when _is_ /var/tmp cleaned, anyway?  Randomly?)

> > But I take your point.  They've instituted a policy and tried to clean
> > this up.  Similarly, .bash_history, .bittorrent, .DCOPserver*, .mcop, and
> > all the other fun stuff written into home must be considered persistent
> > state.
>
> Certainly the bash history and bittorrent stuff is persistent. .mcop is
> persistent (the trader cache should outlast reboots).

*shrug*.  The only one I know what it actually does is the bash history...

> >> and the same is true of /var/spool,
> >
> > Doesn't /var/spool/cups contains files spooled to the printer?  (I dunno,
> > the only printer in the house is hooked up to my fiance's windows
> > machine.)
>
> Yes. Again, if the machine reboots, you don't want to lose stuff you've got
> waiting to print.

Actually, I do.  Very much so, in some cases.  But I can see it being a 
preference...

> >> >                                                      but these days it
> >> > uses . ${filename}.swp in the same directory as the file being edited.
> >>
> >> Yes, and I absolutely despise this behaviour. Is there any way to force
> >> vim to use /var/tmp like everyone else?
> >
> > It's a compile-time option.  (I accidentally set it to use /tmp once and
> > had to figure out how to undo it.)
>
> Is it? Oh good, I'll flip it next time I upgrade :)

Also look for a vimrc file under /etc somewhere.  You can override just about 
anything from there.

> > Files that live for brief instants never get written out to disk anyway.
>
> Aside: it's easy to test this by writing something that creates and
> unlinks a file, dumps stuff into it, then deletes it, and loops on that:
> watch the disk light. I'll write a testcase because I'm so sure I'm right.
>
> [five minutes later]
>
> ... oops. I just, er, proved I was wrong. Ah well. You live and
> learn. This was certainly true in 2.4 but in 2.6 it seems to be the case
> that dirty blocks get magically undirtied if the file in question gets
> completely unlinked and not kept open by anything before the blocks hit
> the disk (unless the file is too large to fit in the page cache of
> course; even then it might fit in tmpfs, as tmpfs is swap-backed but
> even I'll admit that multi-hundred-megabyte writes to /tmp are rare
> things for programs to do.)

You were right about noatime not being the default, though.  Should be, but 
then "should be" is Jeff's argument for tmpfs on /tmp and I'm the one pushing 
against that.  (Patch forthcoming, I added it to the front my to-do list, 
might even get to it this evening.)

> > That's why there's the delay before dirty pages in the page cache are
> > scheduled for writeout.  So tmpfs doesn't help there.
>
> Well, it does if the consuming program takes some time to consume the
> file, or the producing program takes some time to generate it (e.g. GCC;
> yes, even in -pipe mode, some temporary files in /tmp are used.)

In theory that's idle disk time and the sucker is very CPU limited in that 
case.  More or less by definition.  (But if the disk is highly bogged by 
something else.  Of course then it's possible you're swapping, so...)

> >> - users. A *lot* of my users dump temporary crud in /tmp:
> >
> > Yeah, at Rutgers we used to do that on the Sun machines to get around the
> > disk quota.
>
> Mine do it to avoid cluttering up their $HOMEs with crap. (Well, all but
> one whose home directory looks like a sewer. I avoid looking in there
> unless forced.)

Doesn't everybody's ~ look like a junk drawer?  Every time I reinstall I start 
with a fresh home directory and the previous stuff in /home/old or some such, 
and copy stuff over as I need it.

> > Sounds like your users are old unix hands who cut their teeth on
> > traditional Unix boxes in the days before Linux.
>
> Two of them are for certain: I don't know about the rest. They're not
> doing it for efficiency reasons, just out of tidiness.

My programming style tends to have this in common with farming: The end result 
is as tidy as I can make it, but the workspace is piles of dirt with trenches 
dug in it.  (Laws and sausage are apparently made the same way.)

> >> `Existing practice' seems to me to have pretty much wanted something,
> >> uh, like tmpfs. But maybe your existing practice of /tmp is very
> >> different from mine. (It certainly sounds like it.)
> >
> > Out there in the field, today, /tmp is not usually tmpfs.
>
> Out there in the field, today, the average Linux box is running Oracle and
> very little else :(

Not in my experience.  Start by thinking about apache, and from what I've seen 
mysql installations outnumber Oracle (not in dollar volume but in units and 
users).

I was rooting for postgresql for a while, but apparently there's not as much 
middle ground as you'd think.  These days I'm rooting for the simple entirely 
in-memory databases...

> >                                                            And nobody's
> > seen enough benefit in it to bother deploying it on the Fedora, Gentoo,
> > and Ubuntu systems I've tested.
>
> I haven't seen a non-tmpfs-for-/tmp Linux box in years. I guess this is
> another transatlantic divide thing :)

You see a lot of hand-tuned systems.  I see a lot of "IT isn't really what we 
do" systems and a lot of "put it together myself with duct tape", and haven't 
seen much in between recently.

> > Oh I've watched large jobs thrash the heck out of a machine all
> > afternoon. Classic ray tracing, for example...
>
> Ray tracing is a worst case; it has very little locality of reference at
> all (at least not unless the ray tracer has been optimized for parallism,
> which `classic' ones generally haven't been).

Hence the thrashing, yes. :)

> >> You can zap it if you need it for something else pretty easily.
> >> swapfiles are no slower than swap partitions these days, and swap
> >> partitions are easy to turn into filesystems too.
> >
> > I've done this, but it's not automatic.  (Did they ever make swapfiles
> > reliable so they don't lock up under low memory situations?)
>
> As I understand it all the downsides of swapfiles (speed, reliability et
> al) went away in the 2.5.x timeframe.

I knew they were improving it, but I hadn't been following too closely.

*ponders current setup*. I could do tmpfs backed by a swap file living on an 
ext2 partition that's loopback mounted from a hostfs that's exported from an 
ext3 partition.  I wonder if that has a bat's chance of actually working?

Of course at that point, I'd have an almost unbearable urge to stick QEMU in 
there somewhere.  On general principles.

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
