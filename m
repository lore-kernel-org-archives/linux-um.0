Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfkkW-0005cE-Sy for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 13:04:52 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user83243)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EfkkV-0003dP-RW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 13:04:52 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511251003.42328.rob@landley.net>
	<87k6ewikte.fsf@amaterasu.srvr.nix>
	<200511251418.43866.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511251418.43866.rob@landley.net> (Rob Landley's message of
	"Fri, 25 Nov 2005 14:18:43 -0600")
Message-ID: <87br08iglz.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 25 Nov 2005 21:04:40 +0000
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Fri, 25 Nov 2005, Rob Landley moaned:
> On Friday 25 November 2005 13:33, Nix wrote:
>> Maybe this is a stupid question, but... why do *any* systems other than
>> extremely memory-constrained ones not mount tmpfs on /tmp? It seems to
>> me to have numerous advantages and no disadvantages.
> 
> Actually, I consider the fact the OOM killer doesn't delete files out of tmpfs 
> mounts to be a potential disadvantage in this context.

Yeah, true, if you think the OOM killer is worthwhile (I do: most of the MM
hackers don't. I know who knows more about the Linux kernel's MM and it's
not me!)

> Using /tmp for anything has been kind of discouraged for a while, because 
> throwing any insufficiently randomized filename in there is a security hole 
> waiting to happen.

Um, atomically create a directory, spray all the files you like under
it.  Trivial. Doesn't everyone have a bit of scriptage that does that in
$LANGUAGE_OF_CHOICE?

>                    By the time tmpfs was widely available as something you 
> might mount on /tmp, the use of /tmp had been largely replaced with things 
> like the ~/.kde directory or /var/spool/appdir with ownership and permissions 
> enforced.

The ~/.kde directory doesn't contain temporary files, but persistent state:
and the same is true of /var/spool, and /var/cache and /var/tmp for that
matter.

> Most of the remaining uses of /tmp are actually for things like named sockets 
> (where tmpfs really doesn't help at all), or for tiny little files (like all 
> the mcop crap) that on a different day would live under /var.  It's used for 
> inter-process communications, not for temporary storage space.  Long ago 

I suspect what causes this is that /tmp is explicitly for uses that
*don't outlive a reboot*, and how many of those are there? Not all that
damn many. --- at least, not all that damn many *programmatic* ones.

> things like vi would create temporary files in /tmp,

/var/tmp, because the entire point of those files was to survive a reboot.

>                                                      but these days it uses .
> ${filename}.swp in the same directory as the file being edited.

Yes, and I absolutely despise this behaviour. Is there any way to force vim
to use /var/tmp like everyone else?

>                                                                  (As a matter 
> of fact, there's even a /var/tmp that konqueror recently started storing its 
> cache in.  It used to be in ~/.kde.  So there isn't just _one_ tmp directory; 
> if you try to tmpfs mount your /tmp than you need to do more than one.)

Since /tmp and /var/tmp serve different purposes, yes, of course. This has
always been true; right back in the early Slackware days the boot scripts
used to carefully scrub /tmp but leave /var/tmp alone.

> I suspect that the real reason nobody mounts tmpfs on /tmp is that nobody 
> _bothers_.  Nobody in their right mind puts anything big under /tmp, the few 
> remaining uses are largely IPC between different users on the same machine, 
> and even X11 has mostly moved away from that.  Things like postfix and cups 
> use subdirectories under /var/spool that aren't world readable.

Well, I'd say the majority users in my case are:

- programs writing to $TMPDIR; config.guess, configure, and GCC are big users
  on my systems, but lots of other apps write here for a while. Of course
  you could point TMPDIR somewhere else, but does anyone do that?

  There are a quite surprising number of these: generally the files live
  for brief instants before being unlinked, if at all. (mkstemp() creates its
  files in $TMPDIR, after all, and often for those files minimal overhead
  is what counts; and like it or not tmpfs has lower overhead than ext*fs.)

- users. A *lot* of my users dump temporary crud in /tmp: the names of these
  files aren't predictable unless you're telepathic so we're pretty safe from
  symlink attacks. (My local users are Nice Guys anyway, or I shoot them. No
  shots have so far been necessary.)

Maybe your users don't dump everything they don't care much about in
/tmp: mine are always sticking all sorts of things in there from
half-chewed LaTeX through to boring logfiles and stuff being looked over
on its way to the printer :)

(the half-chewed LaTeX worries me slightly: maybe a baby's dummy
wouldn't go amiss.)

> Keep in mind that tmpfs used to be shmfs, and what it's good at is providing 
> shared memory.

Yep. It just so happens that this gives good properties for transient stuff
that should vanish no later than the next reboot, and generally lives only
for as long as someone has it open.

>                 What UML really _wants_ is shared memory, which has 
> traditionally been available through /dev/shm.  Insisting that /tmp behave 
> like /dev/shm because otherwise what you get doesn't behave like shared 
> memory A) doesn't make make a whole lot of sense, B) doesn't match existing 
> practice.

`Existing practice' seems to me to have pretty much wanted something,
uh, like tmpfs. But maybe your existing practice of /tmp is very different
from mine. (It certainly sounds like it.)

>> In fact, even when you're memory-constrained, if you *have* diskspace that
>> you could spend on /tmp, you can swap to it instead, and spend the space
>> on virtual memory when you're not spending it on /tmp.
> 
> "can" doesn't mean "should".  Yes you can make a 10 gigabyte swap partition, 
> but most people actively don't want one because if your system ever winds up 
> using more than about twice as much swap space as it has physical memory, 
> it's likely that the amount of swap thrashing you're doing is getting 
> pathological.

You've never used dar in infinint mode or watched large matrix maths stuff
churn through to completion :/ there really are things with insane memory
requirements and good locality of reference. (I think the most I ever saw
dar eat was 15Gb of swap. *gah*)

>                Having a runaway app have to churn through 10 gigabytes of 
> swap space before the OOM killer terminates it can turn 30 seconds of 
> paralysis into 10 minutes.  Not an improvement.

The problem there is that it's churning, i.e. that its locality of reference
is crap. Such a program should indeed not be allowed to eat that much swap.

> Also, although it's pretty common to have 10 gigabytes of spare disk space on 
> a modern laptop, it is _not_ common to have 10 gigabytes of spare swap space, 
> and that's for a reason.  Extra space in your filesystem can be used for all 
> sorts of things.  Extra swap space is normally wasted.

You can zap it if you need it for something else pretty easily. swapfiles are
no slower than swap partitions these days, and swap partitions are easy to
turn into filesystems too.

> So having tmp just be a normal directory isn't really that bad of a choice.  
> It normally manifests no downsides whatsoever.  And encouraging people to 
> use /tmp is considered a security hole.

That depends if you have telepathic local attackers :) I don't.

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
