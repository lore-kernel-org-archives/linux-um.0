Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgXuS-0004sM-KJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 17:34:24 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgXuP-0007zn-OE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 17:34:24 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511260547.10683.rob@landley.net>
	<877jau7xjc.fsf@amaterasu.srvr.nix>
In-Reply-To: <877jau7xjc.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511271907.45529.rob@landley.net>
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
Date: Sun, 27 Nov 2005 19:07:45 -0600
To: Nix <nix@esperi.org.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 12:31, Nix wrote:
> >             I personally symlink /bin, /sbin, and /lib to the
> > corresponding /usr directories and consolidate the whole mess, myself. 
> > Yes, you have to patch gcc's paths (in collect2) to not search _both_
> > /lib and /usr/lib because if gnu's linker finds the same symbols in two
> > different libraries it statically links them in rather than trying to
> > figure out which one is right, resulting in executables as big as if
> > they're statically linked but still refusing to run if they can't find
> > their shared libraries at run time.  That's a bug in ld.
>
> I'll say! I'll see if I can fix that (if it isn't already fixed: I'm having
> trouble reproducing it here, with binutils 2.16.91.0.2...)

It might have been.  I noticed it 4 or 5 years ago and have gone out of my way 
to avoid the problem ever since (as a simple cleanliness thing).  I noticed 
an excessively bloated image earlier this year but I think it simply hadn't 
stripped debug info...

In theory, a standard linux image where you "mv /lib/* /usr/lib; rm /lib; ln 
-s /usr/lib /lib" (probably from a knoppix CD because that's _not_ going to 
be happy halfway through).  And then try to compile stuff...

If that doesn't show the problem, it's probably fixed.  (And I _think_ the 
problem was actually in collect2, not in ld.  And collect2 is part of gcc.)

> >                                                  These are still nebulous
> > future plans with no actual deadline, but they include moving to
> > dynamically assigned major/minor numbers (so you need something like udev
> > to populate /dev),
>
> How terrible. :)

If static device number assignments go away, then drivers have to register 
with sysfs in order to export device nodes.  The exports you have to bind to 
to register with sysfs are GPLONLY.  Interesting, eh?

> >                 having userspace find and mount the real root partition
> > (so when you're booting from a USB key but your root paritition lives on
> > an NFS server that in order to access it you have to dhcp yourself an
> > address, nslookup the server name, and then login with a public key from
> > said USB stick...)  All the various partitioning schemes could be moved
> > over to device mapper.  And so on.
>
> It's a little annoying for those of us *without* horribly complex boot
> schemes; I guess there'll be a `default initramfs' which replicates the
> current behaviour.

Yup.  I'm doing one for busybox (slowly), and the klibc guys are also working 
their way towards one which has about a 50% chance of becoming "the 
standard".  (The busybox one may become "the standard" for embedded systems.)

The Red Hat people are slowly migrating their initrd image over to initramfs, 
although "not horribly complex" is long gone in that arena.  The gentoo 
people have theirs, and the debian people have theirs, and the Linux From 
Scratch people are evolving theirs, all home-grown...

Who else is interesting?  Possibly SuSE.  No idea what they're up to since the 
founder and lead architect quit last month.

> > They'd proposed a serious kernel crapectomy "for 2.7" back before 2.7 got
> > put on indefinite hold.  How they're rolling it out now, we dunno.  They
> > seem to be happy chewing their current mouthful, at the moment...
>
> Yeah, the change rate of the kernel doesn't exactly seem to be at an
> all-time low :)

Source control and delegation have been good to Linus.

Way back when I posted that "patch penguin" recommendation I was highlighting 
patch integration as a serious bottleneck, and as is normal for Linus he 
barfed on the proposed solution and found a better way to do it, automating 
his way around the problem with better merging tools.  This let him delegate 
entire subsystems to trusted people and trivially merge the results, and thus 
the Lieutenants layer formed between him and normal maintainers.  (It used to 
take someone like Alan Cox to maintain a separate tree and marshall the 
changes from that as a stream of patches Linus could integrate, and Linus had 
to fix up the rejects.  Now it's just a "please pull" request that takes 
Linus a minute or two to handle; the tools do all the integration work.)

All this is why they decided to try going without a development fork but 
instead doing rolling updates.  With better integration tools and a dozen 
subsystem maintainers to spread the load, they can now evaluate and merge 
each month or two what would have been a year's worth of patches back in 
2000.

If you can do a year and a half's worth of integration in three months, what's 
the point of a development fork?  They haven't quite figured out how to 
handle things like the 2.4 to 2.6 modules rewrite, but they introduced the 
feature removal schedule as step in that direction.  So devfs->udev is 
working like "add udev, deprecate devfs, eventually yank"...

> Yeah, but what does /proc/mounts say? Does it show only references that the
> querying process can see?
>
> ... actually, hey, yes, it's a symlink to /proc/self/mounts, so it does the
> right thing already. Nifty.

Has for a while now. :)

> >> Obviously /etc/mtab *must* be a symlink to /proc/mounts, now,
> >> only oops that breaks the quota tools...)
> >
> > I rewrote busybox mount so that things work properly with /proc/mounts. 
> > And I vaguely remember coming up with an in-house patch to fix the quota
> > tools (they were upset by rootfs) something like four years ago.
>
> Please feed it upstream to the quota tools people before I have to write
> the same damn patch ;)))

Alas, that was four years ago at an employer I stopped working for when their 
venture capital ran out.  Haven't used quota since.

> > Everybody hates /etc/mtab.  It doesn't work if you chroot.  It can't
> > handle --bind or --move mounts...  Just symlink it to /proc/mounts and
> > recognize that any tool that can't handle that is a buggy tool that needs
> > to be fixed.
>
> Well, ideally the kernel should allow mount(2) to feed it *arbitrary*
> options in the `data' argument, reflecting those it doesn't understand
> back into /proc/mounts.

It does, but there are some it has to interpret already.  (For example, rw or 
ro involve setting the MS_RDONLY flag to the correct value.  There are 
several such flags: MS_NOSUID, MS_NODEV, MS_NOEXEC, MS_SYNCHRONOUS, 
MS_REMOUNT, MS_NOATIME, and so on...)

> That would avoid breaking the quota tools and, 
> um, whatever else depends on this (I've seen distributed administration
> tools that mark up filesystems with custom options in the expectation
> that they'll land in mtab, too: I think there's some automated fstab
> editor in HAL that does the same thing).

Trust me, this would just be adding to infrastructure that's already there.  
If you pass "mount -o walrus=enormous" it'll pass it on to the kernel.  
(Well, busybox will.  Don't ask me what the mainline mount does, I haven't 
looked at its sources...)

> [...]
>
> > First time I've heard of the tool, but then back under 2.4.7 I remember I
> > had rsync regularly triggering the OOM killer.  Not because rsync was
> > leaking, but because the servers backing up only had 128 megs of memory
> > and the balancing was _terrible_ so the dentry cache and page cache would
> > squeeze out anonymous pages to the point where rsync itself got OOM
> > killed...
>
> Ick, yes. I switched to 2.4 around that time and switched right back to
> 2.2 again because the MM had so many problems...

I stuck it out.  Same with 2.6 (which I've been using since 2.6.0-pre3, which 
once upon a time used to kernel panic if the orinoco wireless driver ever 
lost touch with its access point)...

> > People who want truly insane amounts of memory these days (often for
> > graphics or video editing) tend to mmap their data files directly and
> > work in there. Once again rendering insane amounts of swap less useful...
>
> Not necessarily, given the existence of MAP_PRIVATE. (The problem with
> working directly in data files without MAP_PRIVATE is that if you lose
> power at *any* time, your data file is toast.)

Did you catch Linus's long rant about how MAP_PRIVATE is deeply stupid and 
that Linux will never really implement it?

And you can fsync and do stuff like journaling within a file.  (Except with 
mmap it's msync.)

> > If we had a "treat this like it's on tmpfs" madvice, that would be
> > ideal...
>
> Agreed. Combine that with per-user filesytems and, well, give every user
> a small tmpfs mount of their own on /tmp and let apps use suitably
> advised mmaps for everything else :)

No, just use the madvise(NO_SYNC).  Then tmpfs becomes completely irrelevant 
because any arbitrary file backed mapping can be treated as memory.  (Not 
pinned, but still treated as shared memory.)

I vaguely remember some discussion about this on linux-kernel, some time ago.  
I wonder how it came out?  (2.6.15-rc2 mman.h doesn't show anything...)

> (security holes? but other users can't *see* that /tmp, which is why it's
> mode 640, just like their $HOME...)

Or you could just add the madvise() like I mentioned and forget about tmpfs 
completely.

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
