Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfpYS-0005cI-0W for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 18:12:44 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user72991)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EfpYQ-0006KN-Ro
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 18:12:43 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511251418.43866.rob@landley.net>
	<87br08iglz.fsf@amaterasu.srvr.nix>
	<200511260033.25661.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511260033.25661.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's
	message of "Sat, 26 Nov 2005 00:33:25 +0100")
Message-ID: <87sltk9my7.fsf@amaterasu.srvr.nix>
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
Date: Sat, 26 Nov 2005 02:12:32 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>, Chris Lightfoot <chris@ex-parrot.com>

On Sat, 26 Nov 2005, blaisorblade@yahoo.it announced authoritatively:
> On Friday 25 November 2005 22:04, Nix wrote:
>> On Fri, 25 Nov 2005, Rob Landley moaned:
>> > On Friday 25 November 2005 13:33, Nix wrote:
> 
>> > Actually, I consider the fact the OOM killer doesn't delete files out of
>> > tmpfs mounts to be a potential disadvantage in this context.
> 
> Not quite understood this - what's the fact?

I'm not sure why deleting files is considered a good thing, but I guess
it *does* mean that sticking files in a tmpfs reduces the freedom of the
OOM killer somewhat. Still, it's rarely (OK, in my experience never) a
problem.

If it's a problem you have both hostile users and no size limits on /tmp
and you therefore have bigger problems anyway. :)

>> Yeah, true, if you think the OOM killer is worthwhile (I do: most of the MM
>> hackers don't. I know who knows more about the Linux kernel's MM and it's
>> not me!)
> 
> Its euristics are crap (many cases breaking them), and the concept is crap: 
> damn hell, a C programmer has been taught to check that malloc() can return 
> NULL, not that he should patch a kernel to get a meaningful behaviour.

Yeah, but it does sort of work. Personally I prefer to just never run out
of memory :)

> In fact, luckily, Linux provides a "strict overcommit policy", i.e. no 
> overselling of memory.

... alas, I run a number of programs that rely on memory overcommitment
(some of them rely on sparse files and mmap()-thereof as well).

> However, the idea of an OOM could be made to work, if you can kill an app 
> based on the derivative of its memory usage (i.e. how fast usage has 
> increased over the last moments).

... and the VM appears to be growing things that might help in that area :)

>> > Using /tmp for anything has been kind of discouraged for a while, because
>> > throwing any insufficiently randomized filename in there is a security
>> > hole waiting to happen.
> 
>> Um, atomically create a directory,
> 
> DoS-able if filenames are predictable...

... with a random name, obviously. :)

>> spray all the files you like under 
>> it.  Trivial. Doesn't everyone have a bit of scriptage that does that in
>> $LANGUAGE_OF_CHOICE?
> 
> Never seen anybody doing it, IIRC. Not even mkstemp() (even if today I 
> discover mkdtemp()).

Oh. I do it all the time. I prefer not to work under the assumption that
I'm more brilliant than thirty years of Unix hackers and spotted
something none of them did, but so be it...

(and yes, mkdtemp() is cool, and since it's a directory name it avoids the
tiny little vast gaping problems with mktemp().)

>> `Existing practice' seems to me to have pretty much wanted something,
>> uh, like tmpfs. But maybe your existing practice of /tmp is very different
>> from mine. (It certainly sounds like it.)
> 
> Existing practice is there for very good reasons:
> 
> - back in 2.4, tmpfs on /tmp broke mkinitrd since it tried to loop-mount the 
> new initrd, which was in /tmp. And loop-mount over tmpfs didn't work.

Ah, well, I never use initrd if I can avoid it, and a bug in one tool is
a reason to *fix that tool*, not rejig teh whole damn system.

> - now most distros tend to *suggest* mounting tmpfs there (Gentoo does suggest 
> this). But since it's not back-compatible, aka if you don't know that you 
> loose data, it's up to the admin to do it. And btw, the admin of the network 
> I'm writing from didn't notice that a partition was not mounted on /home - 
> and said me "hey! I ran yum update and it removed the whole /home!".
> 
> He had never known that "mount" lists mounts...

Hey, I made that mistake at least once, after arranging for home
directories to get bind-mounted into place and then forgetting that I'd
done it, so three years later when the bind-mounting broke due to stupid
script bugs I was running around in a panic for some time wondering
where everyone's $HOME had gone.

(and `mount', of course, only lists mounts if you trust /proc/mounts to
be accurate. What does it look like in this brave new world of shared
subtrees? Obviously /etc/mtab *must* be a symlink to /proc/mounts, now,
only oops that breaks the quota tools...)

> (Btw, the problem was that he added a new external disk, but labeled it /boot, 
> like an existing /boot partition , so mount -a choked with "duplicate label 
> '/boot'" and it stopped before mounting /home).

I think now is an appropriate time to say

I HATE FSCKING MTAB

(in three-part harmony, probably)

> Sorry for the OT, hope it's fun ;D

It's terribly early on Saturday morning, I've got a cold, and I can't
sleep. Staying *on*-topic is likely to be impossible.

>> You've never used dar in infinint mode or watched large matrix maths stuff
>> churn through to completion :/ there really are things with insane memory
>> requirements and good locality of reference. (I think the most I ever saw
>> dar eat was 15Gb of swap. *gah*)
> 
> Boy, be serious - we are talking about normal systems, and you know that you'd 
> better run dar on properly sized systems...

I still boggle that infinint mode is the default for that tool. Its
memory requirements are sane if you ask it to use 64-bit longs instead,
but oh no the default must be an unbounded-size (minimum ~64-byte-long)
numeric class because it's so *common* for you to have >2^64 files in
your backup, or individual files >2^64 bytes long in that backup.

Bah. Silly design decision.

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
