Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgR6C-0008EE-OB for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:18:04 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user79856)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EgR6A-0002AN-RR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 10:18:04 -0800
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511251418.43866.rob@landley.net>
	<87br08iglz.fsf@amaterasu.srvr.nix>
	<200511251631.41518.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200511251631.41518.rob@landley.net> (Rob Landley's message of
	"Fri, 25 Nov 2005 16:31:41 -0600")
Message-ID: <87br067y60.fsf@amaterasu.srvr.nix>
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
Date: Sun, 27 Nov 2005 18:17:43 +0000
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

[Sorry for response delay, steaming cold/flu]

On Fri, 25 Nov 2005, Rob Landley worried:
> On Friday 25 November 2005 15:04, Nix wrote:
>> The ~/.kde directory doesn't contain temporary files, but persistent state:
> 
> ~/.kde/share/apps/kmail/lock is persistent state?

No, but KDE is a bit of a mess in some areas, and this is one of htem.

> I do know that half the time the darn battery runs out and kde suddely shuts 
> down my desktop without the courtesy of even _warning_ me first (oh it pops 
> up a window three seconds before doing it), kmail doesn't have a chance to 
> zap this file before being killed and thus I have to drill down and zap the 
> sucker by hand or it'll refuse to run when I boot back up.

... and this is why it should be in /tmp.

> Circa Red Hat 9, konqueror's cache files were under .kde.  I have no idea what 
> the junk in .kde/share/apps/kpdf is for...

Not true as of reasonably recent Konquerors.

> But I take your point.  They've instituted a policy and tried to clean this 
> up.  Similarly, .bash_history, .bittorrent, .DCOPserver*, .mcop, and all the 
> other fun stuff written into home must be considered persistent state.

Certainly the bash history and bittorrent stuff is persistent. .mcop is
persistent (the trader cache should outlast reboots).

>> and the same is true of /var/spool,
> 
> Doesn't /var/spool/cups contains files spooled to the printer?  (I dunno, the 
> only printer in the house is hooked up to my fiance's windows machine.)

Yes. Again, if the machine reboots, you don't want to lose stuff you've got
waiting to print.

>> > things like vi would create temporary files in /tmp,
>>
>> /var/tmp, because the entire point of those files was to survive a reboot.
> 
> Is it?  I thought it was to support undo.

Nah, as this XEmacs user understands it, it's for `vi -r'. (XEmacs does that
with stuff in the local directory and/or any-directory-of-your-choice, so I
picked one under /var/tmp. :) )

>> >                                                      but these days it
>> > uses . ${filename}.swp in the same directory as the file being edited.
>>
>> Yes, and I absolutely despise this behaviour. Is there any way to force vim
>> to use /var/tmp like everyone else?
> 
> It's a compile-time option.  (I accidentally set it to use /tmp once and had 
> to figure out how to undo it.)

Is it? Oh good, I'll flip it next time I upgrade :)

>> - programs writing to $TMPDIR; config.guess, configure, and GCC are big
>> users on my systems, but lots of other apps write here for a while. Of
>> course you could point TMPDIR somewhere else, but does anyone do that?
>>
>>   There are a quite surprising number of these: generally the files live
>>   for brief instants before being unlinked, if at all. (mkstemp() creates
>> its files in $TMPDIR, after all, and often for those files minimal overhead
>> is what counts; and like it or not tmpfs has lower overhead than ext*fs.)
> 
> Files that live for brief instants never get written out to disk anyway.  

Aside: it's easy to test this by writing something that creates and
unlinks a file, dumps stuff into it, then deletes it, and loops on that:
watch the disk light. I'll write a testcase because I'm so sure I'm right.

[five minutes later]

... oops. I just, er, proved I was wrong. Ah well. You live and
learn. This was certainly true in 2.4 but in 2.6 it seems to be the case
that dirty blocks get magically undirtied if the file in question gets
completely unlinked and not kept open by anything before the blocks hit
the disk (unless the file is too large to fit in the page cache of
course; even then it might fit in tmpfs, as tmpfs is swap-backed but
even I'll admit that multi-hundred-megabyte writes to /tmp are rare
things for programs to do.)

> That's why there's the delay before dirty pages in the page cache are 
> scheduled for writeout.  So tmpfs doesn't help there.

Well, it does if the consuming program takes some time to consume the
file, or the producing program takes some time to generate it (e.g. GCC;
yes, even in -pipe mode, some temporary files in /tmp are used.)

>> - users. A *lot* of my users dump temporary crud in /tmp:
> 
> Yeah, at Rutgers we used to do that on the Sun machines to get around the disk 
> quota.

Mine do it to avoid cluttering up their $HOMEs with crap. (Well, all but
one whose home directory looks like a sewer. I avoid looking in there
unless forced.)

>> Maybe your users don't dump everything they don't care much about in
>> /tmp: mine are always sticking all sorts of things in there from
>> half-chewed LaTeX through to boring logfiles and stuff being looked over
>> on its way to the printer :)
> 
> Sounds like your users are old unix hands who cut their teeth on traditional 
> Unix boxes in the days before Linux.

Two of them are for certain: I don't know about the rest. They're not
doing it for efficiency reasons, just out of tidiness.

>> `Existing practice' seems to me to have pretty much wanted something,
>> uh, like tmpfs. But maybe your existing practice of /tmp is very different
>> from mine. (It certainly sounds like it.)
> 
> Out there in the field, today, /tmp is not usually tmpfs.

Out there in the field, today, the average Linux box is running Oracle and
very little else :(

>                                                            And nobody's seen 
> enough benefit in it to bother deploying it on the Fedora, Gentoo, and Ubuntu 
> systems I've tested.

I haven't seen a non-tmpfs-for-/tmp Linux box in years. I guess this is
another transatlantic divide thing :)

>> You've never used dar in infinint mode
> 
> Never even heard of it.

A very powerful backup program with, ahem, notable memory consumption
problems in its default configuration (unless you *like* 1Gb memory
consumption per million files, approx.)

>> or watched large matrix maths stuff 
>> churn through to completion :/
> 
> Oh I've watched large jobs thrash the heck out of a machine all afternoon.  
> Classic ray tracing, for example...

Ray tracing is a worst case; it has very little locality of reference at
all (at least not unless the ray tracer has been optimized for parallism,
which `classic' ones generally haven't been).

>> > Also, although it's pretty common to have 10 gigabytes of spare disk
>> > space on a modern laptop, it is _not_ common to have 10 gigabytes of
>> > spare swap space, and that's for a reason.  Extra space in your
>> > filesystem can be used for all sorts of things.  Extra swap space is
>> > normally wasted.
>>
>> You can zap it if you need it for something else pretty easily. swapfiles
>> are no slower than swap partitions these days, and swap partitions are easy
>> to turn into filesystems too.
> 
> I've done this, but it's not automatic.  (Did they ever make swapfiles 
> reliable so they don't lock up under low memory situations?)

As I understand it all the downsides of swapfiles (speed, reliability et
al) went away in the 2.5.x timeframe.

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
