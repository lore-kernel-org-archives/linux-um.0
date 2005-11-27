Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgLwZ-0001ME-EZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 04:47:47 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EgLwY-0007CB-2e
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Nov 2005 04:47:47 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Using lilo on ubda?
References: <200511261303.42684.rob@landley.net>
	<20051127052216.GA18684@supersonic.ruhr.de>
In-Reply-To: <20051127052216.GA18684@supersonic.ruhr.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511270647.10473.rob@landley.net>
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
Date: Sun, 27 Nov 2005 06:47:03 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andreas Wohlfeld <agw@supersonic.ruhr.de>

On Saturday 26 November 2005 23:22, Andreas Wohlfeld wrote:
> On Sat, Nov 26, 2005 at 01:03:42PM -0600, Rob Landley wrote:
> > Lilo is saying that ubda is not a device with partitions.
> >
> > Anybody know what it's talking about?  (I've got a ubda1.  I'm trying to
> > make a disk image I can test boot with qemu without having to boot a
> > knoppix image to do it...)
>
> Did you use fdisk on your hard file or do you use ist as a super floppy?

I'm trying to create a partitioned image file to feed as a hard drive image to 
qemu.

I eventually made the lilo installer happy by specifying _everything_:
disk=/dev/ubda
  bios=0x80
  cylinders=128
  heads=16
  sectors=63
  partition=/dev/ubda1
    start=63

The actual booting part isn't occurring yet.  (Getting "L 99 99 99 99 99"...)  
I may have the partition offset wrong.  Run my partition finding script... 
Yup, I told sfdisk not to leave a gap here so it starts at sector 1, I 
remember now...  And now the kernel decompression is going "ran out of input 
data" because I didn't update my length hack for the new kernel I just 
built...  Forgot to make some symlinks...  Ah, I left "mknod" out of 
busybox...

Work progresses.  Slowly, as usual... :)


> Try testing it with a second hardfile and (c)fdisk it with partitions.
>
> Most of us use several hard files as super floppies not putting any
> partition table on the disk (you can see a message about that during
> boot, I think).

It's partitioned but the first partition was starting at sector 1.

#!/bin/sh
CYLINDERS=128
HEADS=16
SECTORS=63

dd if=/dev/zero of=hda.img bs=$[$HEADS*$SECTORS*512] count=$CYLINDERS
sfdisk -uS -C $CYLINDERS -H 16 -S 63  hda.img << EOF
1,$[16*63*$CYLINDERS-1],83
EOF

The old dos compatible partitions would have used a starting cylinder of 
$SECTORS instead of 1, but LILO doesn't need the gap.  (I think grub might.)

You can actually use losetup to mount a partition via -o 
$[$cylinder*$sector*$head*512] (where cylinder is actually starting cylinder 
-1, because it's how much to _skip_ and cylinder numbering starts at 1).  You 
can't feed a "length" option to losetup (only offset), but now you know what 
the blocks-count option to mke2fs is for. :)

Yes, I do this sort of thing all the time.  For fun.

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
