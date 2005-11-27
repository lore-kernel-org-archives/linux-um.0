Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgS5K-0003BF-St for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:21:14 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgS5H-0002Mi-UC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 11:21:13 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511271837.14625.blaisorblade@yahoo.it>
	<200511271259.35968.rob@landley.net>
In-Reply-To: <200511271259.35968.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511272020.52664.blaisorblade@yahoo.it>
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
Date: Sun, 27 Nov 2005 20:20:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 19:59, Rob Landley wrote:
> On Sunday 27 November 2005 11:37, Blaisorblade wrote:
> > > Like "/tmp/uml.ctl" in arch/um/drivers/daemon_kern.c, line 70?

> Any user can create /tmp/uml.ctl and the sticky bit prevents anybody else
> from deleting it, so any user can block UML switch from working right.
There's a switch for the path, so it's only an inconvenience.

> Under /var/run you can have a persistent directory belonging to a GID or
> some such that UML switch is setgid to, so under /var you are at least
> _capable_ of dealing with this sort of thing...

> What argument for hurd systems?
They by default have /usr -> /.
> Hard drives are enormous these days, and 
> if your OS itself is larger than 10 gigs there's something deeply wrong
> with it. (Your application data may be huge, but that's not your OS.)

I usually size / as 500M, and split away /usr and /var on LVM. 
Especially /usr, I've been growing it via LVM 3 times this week.

> Try "rdinit=/bin/sh", that affects what init gets run on the initramfs.
> (Assuming the initramfs has a comand shell...)

Missing from Documentation/filesystems/ramfs-rootfs-initramfs.txt.

> So this was fixed in util-linux then?

Don't remember the bug.

> (I know _busybox_ gets it right, but 
> that's because I took it into account in my rewrite...)

> http://www.busybox.net/lists/busybox/2005-August/015285.html

I never tested --move, only --bind.

Also, umount has other shortcomings: for instance, umount dev will 
umount /dev, even if I meant a udev mount on /mnt/gen32/dev with dev on first 
column (or something like that). I.e. umount tries to absolutize paths 
relative to /.

Also, umount /var when /var is bind-mounted elsewhere is ambiguous, and I've 
no idea of a proper solution.

(However, take this with a grain of salt - I'm trying to code rather than 
talking today, and I'm failing almost fully).

> > > Just symlink it to /proc/mounts and recognize
> > > that any tool that can't handle that is a buggy tool that needs to be
> > > fixed.

> > No - the kernel doesn't allow storing the full set of infos which are
> > added by mount there. And frankly I don't want the kernel to do that.

> For which use? 

Don't recall exactly...

> I got the loopback functionality working just fine (to the 
> point where you don't have to specify -o loop anymore.

With busybox I guess - you using it on a non-embedded system? I though it was 
thought to be _small_ and feature-limited.

> If you try to mount 
> a file instead of a block device, it'll do the losetup for you.  I'm
> pondering adding support for "mount -o offset=12345 file.img /woot" even...

You get a namespace conflict that way - the day a fs supports offset= you're 
burned.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
