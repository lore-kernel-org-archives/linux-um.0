Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfbBj-0008Rt-4k for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 02:52:19 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfbBg-00079U-PR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 02:52:19 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<20051125095502.GA32587@ccure.user-mode-linux.org>
	<200511250348.28123.rob@landley.net>
In-Reply-To: <200511250348.28123.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511250452.05006.rob@landley.net>
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
Date: Fri, 25 Nov 2005 04:52:04 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

FYI:

The mounts on a Fedora Core 4 system:

/dev/hda2 on / type ext3 (rw)
/dev/proc on /proc type proc (rw)
/dev/sys on /sys type sysfs (rw)
/dev/devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /boot type ext3 (rw)
/dev/shm on /dev/shm type tmpfs (rw)
/dev/hdb1 on /home type ext3 (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
none on /var/named/chroot/proc type proc (rw)
automount(pid1716) on /misc type autofs 
(rw,fd=4,pgrp=1716,minproto=2,maxproto=4)
automount(pid1759) on /net type autofs 
(rw,fd=4,pgrp=1759,minproto=2,maxproto=4)
nfsd on /proc/fs/nfsd type nfsd (rw)

/tmp is nothing special (it inherits / which is ext3), but /dev/shm is a tmpfs 
mount which is world writeable and has the sticky bit set.

The mounts on the x86-64 PLD system I've been borrowing (and on which I do not 
have root access):

/dev/sda3 on / type jfs (rw)
none on /proc type proc (rw,gid=17)
sysfs on /sys type sysfs (rw)
selinuxfs on /selinux type selinuxfs (rw)
/dev/sda1 on /boot type ext2 (rw)
/dev/sda5 on /usr type jfs (rw)
/dev/sda6 on /var type jfs (rw)
/dev/sda7 on /tmp type jfs (rw)
/dev/sda8 on /home type jfs (rw)
/dev/sda9 on /srv type jfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/root/pldcd-0.95.iso on /root/pld type iso9660 (rw,loop=/dev/loop0)

/tmp is an explicit scsi mount.  /dev/shm inherits / (which is jfs), but 
that's moot because the directory is not world writeable.

The shell servers from sourceforge:

/dev/md0 on / type ext3 (rw,errors=remount-ro)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/md1 on /tmp type ext3 (rw)
/dev/md2 on /var type ext3 (rw)
/dev/md3 on /usr type ext3 (rw)
/dev/md4 on /var/local type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
pr-fs-users-a:/home/users/a on /home/users/a type nfs 
(rw,nosuid,nodev,nfsvers=3,udp,rsize=16384,wsize=16384,hard,intr,addr=10.5.1.153)
... and so on [about 8 gazillion more /home/users/blah mounts trimmed].

Again, /tmp is not tmpfs (it's ext3 on a raid), but /dev/shm is a tmpfs mount 
which is world writeable and has the sticky bit set.

And I reiterate that on my ubuntu laptop /tmp is not tmpfs (it inherits my 
ext3 /) but /dev/shm is a world writeable tmpfs mount that has the sticky bit 
set.

My conclusion from this is that /dev/shm is probably a better default 
than /tmp for User Mode Linux's physical memory file, perhaps with a fallback 
to /tmp if it can't write there.  But I'd appreciate hearing from other 
people with different systems.

The assumption that tmpfs is already mounted on /tmp does not seem to be true 
on any preexisting system I can currently find out in the field.  Where have 
you seen this?

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
