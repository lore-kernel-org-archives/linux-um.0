Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgX0w-0001Oy-JI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 16:37:02 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgX0v-0001r0-1L
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 16:37:02 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511271259.35968.rob@landley.net>
	<200511272020.52664.blaisorblade@yahoo.it>
In-Reply-To: <200511272020.52664.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271541.12899.rob@landley.net>
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
Date: Sun, 27 Nov 2005 15:41:12 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 13:20, Blaisorblade wrote:
> > Try "rdinit=/bin/sh", that affects what init gets run on the initramfs.
> > (Assuming the initramfs has a comand shell...)
>
> Missing from Documentation/filesystems/ramfs-rootfs-initramfs.txt.

I only dredged through the source and found it shortly after posting that 
document.  I need to update the thing, but I'm hoping to get mdev merged into 
busybox (and switch_root properly tested, and the issue of what to do 
about /dev/console sorted out).  Then I can put together a minimal busybox 
initramfs package and reference that.

> > So this was fixed in util-linux then?
>
> Don't remember the bug.

I found it myself testing corner cases to figure out how busybox mount should 
work.

> > (I know _busybox_ gets it right, but
> > that's because I took it into account in my rewrite...)
> >
> > http://www.busybox.net/lists/busybox/2005-August/015285.html
>
> I never tested --move, only --bind.

They had the same problem when I tested.  The information being stored 
in /etc/mtab wasn't the information actually needed to umount.

> Also, umount has other shortcomings: for instance, umount dev will
> umount /dev, even if I meant a udev mount on /mnt/gen32/dev with dev on
> first column (or something like that). I.e. umount tries to absolutize
> paths relative to /.

Try the busybox version.  There were loud complaints from some of the users, 
and I fixed all the ones I knew about at the time.  (Although I believe I 
still need to add --rbind, which is trivial..)

> Also, umount /var when /var is bind-mounted elsewhere is ambiguous, and
> I've no idea of a proper solution.

Leave the bind mount.

It's a bit like:

mount /dev/hda one
mount /dev/hda two
umount /dev/hda

The kernel umounts the most recent one, not all of them.  I need to upgrade 
umount so that you can do "umount -a /dev/hda".  Right now umount -a ignores 
arguments...

It's a to-do item.

> (However, take this with a grain of salt - I'm trying to code rather than
> talking today, and I'm failing almost fully).

My to-do list is growing faster than I'm retiring items on it, but what else 
is new?

> > I got the loopback functionality working just fine (to the
> > point where you don't have to specify -o loop anymore.
>
> With busybox I guess - you using it on a non-embedded system?

Yup.  I'm using it in place of the gnu tools in a system capable of rebuilding 
itself from source code.

http://www.landley.net/code/firmware

I had to upgrade lots of busybox in order make that work, but it does now.  
(The -devel version, anyway.  1.01 is a bit behind the times.  Should be a 
new release around new year's.)

> I though it was thought to be _small_ and feature-limited.

It's configurable.  It tries to pack as much functionality into as small a 
space as it can, and lets you configure how much functionality you want.

The "everything enabled" version is around a megabyte, but that megabyte 
replaces bzip2, coreutils, e2fsprogs, file, findutils, gawk, grep, inetutils, 
less, modutils, net-tools, patch, procps, sed, shadow, sysklogd, sysvinit, 
tar, util-linux, and vim.

> > If you try to mount
> > a file instead of a block device, it'll do the losetup for you.  I'm
> > pondering adding support for "mount -o offset=12345 file.img /woot"
> > even...
>
> You get a namespace conflict that way - the day a fs supports offset=
> you're burned.

*shrug*  The same argument could be made about any other argument that mount 
interprets.  (Currently: loop, defaults, noauto, ro, rw, nosuid, suid, dev, 
nodev, exec, noexec, sync, async, remount, atime, noatime, diratime, 
nodiratime, bind, move, and rbind.)

And no, I didn't invent mount interpreting any of that.  I can make it depend 
on loopback support (which is already a config option for mount; you can 
disable features out of the apps in busybox to shrink the size).

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
