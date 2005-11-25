Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Efn4O-0004B1-Ql for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 15:33:32 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Efn4O-00045U-96
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 15:33:32 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
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
Message-Id: <200511260033.25661.blaisorblade@yahoo.it>
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
Date: Sat, 26 Nov 2005 00:33:25 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Chris Lightfoot <chris@ex-parrot.com>

On Friday 25 November 2005 22:04, Nix wrote:
> On Fri, 25 Nov 2005, Rob Landley moaned:
> > On Friday 25 November 2005 13:33, Nix wrote:

> > Actually, I consider the fact the OOM killer doesn't delete files out of
> > tmpfs mounts to be a potential disadvantage in this context.

Not quite understood this - what's the fact?

> Yeah, true, if you think the OOM killer is worthwhile (I do: most of the MM
> hackers don't. I know who knows more about the Linux kernel's MM and it's
> not me!)

Its euristics are crap (many cases breaking them), and the concept is crap: 
damn hell, a C programmer has been taught to check that malloc() can return 
NULL, not that he should patch a kernel to get a meaningful behaviour.

In fact, luckily, Linux provides a "strict overcommit policy", i.e. no 
overselling of memory.

However, the idea of an OOM could be made to work, if you can kill an app 
based on the derivative of its memory usage (i.e. how fast usage has 
increased over the last moments).

> > Using /tmp for anything has been kind of discouraged for a while, because
> > throwing any insufficiently randomized filename in there is a security
> > hole waiting to happen.

> Um, atomically create a directory,

DoS-able if filenames are predictable...

> spray all the files you like under 
> it.  Trivial. Doesn't everyone have a bit of scriptage that does that in
> $LANGUAGE_OF_CHOICE?

Never seen anybody doing it, IIRC. Not even mkstemp() (even if today I 
discover mkdtemp()).

> > Most of the remaining uses of /tmp are actually for things like named
> > sockets (where tmpfs really doesn't help at all), or for tiny little
> > files (like all the mcop crap) that on a different day would live under
> > /var.

There is no point in keeping them at reboot so why under /var?

> I suspect what causes this is that /tmp is explicitly for uses that
> *don't outlive a reboot*, and how many of those are there? Not all that
> damn many. --- at least, not all that damn many *programmatic* ones.

> > things like vi would create temporary files in /tmp,

> /var/tmp, because the entire point of those files was to survive a reboot.

> >                                                      but these days it
> > uses . ${filename}.swp in the same directory as the file being edited.

> Yes, and I absolutely despise this behaviour. Is there any way to force vim
> to use /var/tmp like everyone else?

> Since /tmp and /var/tmp serve different purposes, yes, of course. This has
> always been true; right back in the early Slackware days the boot scripts
> used to carefully scrub /tmp but leave /var/tmp alone.

> >                 What UML really _wants_ is shared memory, which has
> > traditionally been available through /dev/shm.  Insisting that /tmp
> > behave like /dev/shm because otherwise what you get doesn't behave like
> > shared memory A) doesn't make make a whole lot of sense, B) doesn't match
> > existing practice.

> `Existing practice' seems to me to have pretty much wanted something,
> uh, like tmpfs. But maybe your existing practice of /tmp is very different
> from mine. (It certainly sounds like it.)

Existing practice is there for very good reasons:

- back in 2.4, tmpfs on /tmp broke mkinitrd since it tried to loop-mount the 
new initrd, which was in /tmp. And loop-mount over tmpfs didn't work.

- now most distros tend to *suggest* mounting tmpfs there (Gentoo does suggest 
this). But since it's not back-compatible, aka if you don't know that you 
loose data, it's up to the admin to do it. And btw, the admin of the network 
I'm writing from didn't notice that a partition was not mounted on /home - 
and said me "hey! I ran yum update and it removed the whole /home!".

He had never known that "mount" lists mounts...

(Btw, the problem was that he added a new external disk, but labeled it /boot, 
like an existing /boot partition , so mount -a choked with "duplicate label 
'/boot'" and it stopped before mounting /home).

Sorry for the OT, hope it's fun ;D

> >> In fact, even when you're memory-constrained, if you *have* diskspace
> >> that you could spend on /tmp, you can swap to it instead, and spend the
> >> space on virtual memory when you're not spending it on /tmp.

> > "can" doesn't mean "should".  Yes you can make a 10 gigabyte swap
> > partition, but most people actively don't want one because if your system
> > ever winds up using more than about twice as much swap space as it has
> > physical memory, it's likely that the amount of swap thrashing you're
> > doing is getting pathological.

> You've never used dar in infinint mode or watched large matrix maths stuff
> churn through to completion :/ there really are things with insane memory
> requirements and good locality of reference. (I think the most I ever saw
> dar eat was 15Gb of swap. *gah*)

Boy, be serious - we are talking about normal systems, and you know that you'd 
better run dar on properly sized systems...

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
