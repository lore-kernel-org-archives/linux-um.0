Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfxY5-0003X8-1u for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:44:53 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfxY4-0003bJ-AF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 02:44:53 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<87br08iglz.fsf@amaterasu.srvr.nix>
	<200511260033.25661.blaisorblade@yahoo.it>
In-Reply-To: <200511260033.25661.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511260444.29470.rob@landley.net>
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
Date: Sat, 26 Nov 2005 04:44:29 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Friday 25 November 2005 17:33, Blaisorblade wrote:
> On Friday 25 November 2005 22:04, Nix wrote:
> > On Fri, 25 Nov 2005, Rob Landley moaned:
> > > On Friday 25 November 2005 13:33, Nix wrote:
> > >
> > > Actually, I consider the fact the OOM killer doesn't delete files out
> > > of tmpfs mounts to be a potential disadvantage in this context.
>
> Not quite understood this - what's the fact?

That a normal user can allocate persistent memory, that outlives all their 
processes, with no special priviledges, and that the limits on it are per 
system rather than per user.  (In theory you can apply quota to /tmp but I've 
never seen anybody do it.  And yeah, shmfs is no worse than shmget, for 
obvious reasons.  Apparently System V wasn't big into reference counting.).

I'm not saying it's a disproportionately enormous downside, I'm just saying it 
is one compared to having /tmp on a normal filesystem.  DRAM tends to be a 
much more scarce resource than disk space these days.

> > Yeah, true, if you think the OOM killer is worthwhile (I do: most of the
> > MM hackers don't. I know who knows more about the Linux kernel's MM and
> > it's not me!)
>
> Its euristics are crap (many cases breaking them), and the concept is crap:

Expecting DRAM to work properly is a heuristic.  (And ECC memory is a backup 
heuristic on top of that.)

> damn hell, a C programmer has been taught to check that malloc() can return
> NULL, not that he should patch a kernel to get a meaningful behaviour.

Since when does malloc() return null?  It happily succeeds as long as there's 
enough virtual address space, you only later run out of physical memory due 
to page faults on normal access.  (And if you run in no overcommit mode you 
get spurious OOMs every time a pig like mozilla forks, even though it's about 
to exec.  Unless we're back to wasting huge amounts of swap space so that in 
a real OOM situation we thrash endlessly and which your average laptop may 
not have to spare...)

I'm not saying it's unsolvable.  I'm saying that the OOM killer is better than 
the hard lockups I used to see before.  (Admittedly not much better, echo 0 
> /proc/sys/vm/swappiness and the OOM killer goes all rabid.  But oh well.)

> In fact, luckily, Linux provides a "strict overcommit policy", i.e. no
> overselling of memory.

Yup.  And the default is?  (And which distros have a different default?)

> However, the idea of an OOM could be made to work, if you can kill an app
> based on the derivative of its memory usage (i.e. how fast usage has
> increased over the last moments).

There are better heuristics, sure.

> > > Using /tmp for anything has been kind of discouraged for a while,
> > > because throwing any insufficiently randomized filename in there is a
> > > security hole waiting to happen.
> >
> > Um, atomically create a directory,
>
> DoS-able if filenames are predictable...

It is possible to work out all the ramifications of using /tmp to do so in a 
safe manner.

Whether it's a can of worms your average programmer should be exposed to is 
another matter.

What's the advantage of using /tmp?  Your home directory generally isn't world 
writeable (and if it is you have bigger problems), and that's a fine place 
for temp files.  Besides, lots of tempfiles are the kind that "sed -i" 
creates, and although you want them to be unpredictable (in case you do use 
it in a world writeable directory), you also want to be able to mv the result 
to the final filename, and you can't do that across different filesystems, so 
having it in the same directory makes sense.  We've got much better ways of 
doing IPC these days (it's useful for users doing "sed -f", but in scripts 
you can make arbitrarily long command lines these days), and a program that 
needs to remember something can keep it in ram.  What's left?  Batch jobs 
submitted to your outgoing mailer or your print spooler don't live in /tmp 
anymore, they live in /var/spool...

> > > Most of the remaining uses of /tmp are actually for things like named
> > > sockets (where tmpfs really doesn't help at all), or for tiny little
> > > files (like all the mcop crap) that on a different day would live under
> > > /var.
>
> There is no point in keeping them at reboot so why under /var?

Why have "pid" files always lived under /var?  (It conceptually doesn't make 
sense for them to live across reboots, and yet that's been the standard all 
along...)

It's normal in /var for there to be persistent directories with known 
permissions that an application can create an then depend on being there.  
And being able to scribble in a private directory is enough of an advantage I 
don't think anybody cares about the persisting across reboot semantics one 
way or the other.

This is a guess as to the last 30 years of usage, by the way...

> > `Existing practice' seems to me to have pretty much wanted something,
> > uh, like tmpfs. But maybe your existing practice of /tmp is very
> > different from mine. (It certainly sounds like it.)
>
> Existing practice is there for very good reasons:
>
> - back in 2.4, tmpfs on /tmp broke mkinitrd since it tried to loop-mount
> the new initrd, which was in /tmp. And loop-mount over tmpfs didn't work.

I vaguely remember this being fixed. :)

> - now most distros tend to *suggest* mounting tmpfs there (Gentoo does
> suggest this). But since it's not back-compatible, aka if you don't know
> that you loose data, it's up to the admin to do it. And btw, the admin of
> the network I'm writing from didn't notice that a partition was not mounted
> on /home - and said me "hey! I ran yum update and it removed the whole
> /home!".
>
> He had never known that "mount" lists mounts...

I try not to assume that people know everything there is to know about Unix.  
I first used a Unix variant on a vax back in the 80's (dialing into my 
father's work computer to download amiga programs), spent three years poking 
at Sun workstations at Rutgers, and have used Linux as my primary desktop OS 
since 1998 (when I _finally_ got a video card that xfree86 could actually 
use).  I've wandered through the kernel source code, built my own 
distributions from source code for several different projects, debugged and 
reimplemented strange command line esoterica for busybox...

And despite this, I still encounter new things every couple of weeks.  I think 
the most useful one I learned this year was the "lsof" command.  The most 
recent might have been "setsid", depending on what the threshold is...  No 
wait, it was learning that "uname" isn't just a command line utility but is 
actually a syscall.  That was yesterday.

So when I see "you can configure your system like this, but the default is..." 
I immediately go "ok, 90% of the systems out there will have the default, 
we'd better at least not exhibit pathological behavior with that".

And the default seems to be that /tmp ain't tempfs, but /dev/shm is.

> (Btw, the problem was that he added a new external disk, but labeled it
> /boot, like an existing /boot partition , so mount -a choked with
> "duplicate label '/boot'" and it stopped before mounting /home).

He's using Red Hat, isn't he? :)

(Been there, done that, moved the darn labels to /dev/hda4 and such.  Wouldn't 
recommend that with SCSI because the scsi bus detects devices via chicken 
entrails and then enumerates them in sequence (with no gaps) on a first come 
first served basis.  With ATA, /dev/hdd3 means second controller, slave 
device, third partition, and that doesn't move unless you physically unplug 
it from its connector cable, no matter what else you plug in.  The whole 
_reason_ Red hat has this boot label stuff is some people have an unreasoning 
love of SCSI devices. :)

> Sorry for the OT, hope it's fun ;D
>
> > >> In fact, even when you're memory-constrained, if you *have* diskspace
> > >> that you could spend on /tmp, you can swap to it instead, and spend
> > >> the space on virtual memory when you're not spending it on /tmp.
> > >
> > > "can" doesn't mean "should".  Yes you can make a 10 gigabyte swap
> > > partition, but most people actively don't want one because if your
> > > system ever winds up using more than about twice as much swap space as
> > > it has physical memory, it's likely that the amount of swap thrashing
> > > you're doing is getting pathological.
> >
> > You've never used dar in infinint mode or watched large matrix maths
> > stuff churn through to completion :/ there really are things with insane
> > memory requirements and good locality of reference. (I think the most I
> > ever saw dar eat was 15Gb of swap. *gah*)
>
> Boy, be serious - we are talking about normal systems, and you know that
> you'd better run dar on properly sized systems...

$ man dar
No manual entry for dar

google dar:  Daughters of the American Revolution, Dar Williams, Dar-us-Salam 
Islamic Publications...

google dar linux:
Some french disk archiving tool, apparently.  I generally just use tarballs or 
rsync.

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
