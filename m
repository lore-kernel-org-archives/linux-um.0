Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGODl-00062J-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 02 Nov 2003 11:49:09 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AGODl-00015s-0F
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 02 Nov 2003 11:49:09 -0800
Subject: Re:[uml-devel] Partitioning scheme for ubd's
Message-ID: <20031102.111506.-2022799.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 2 Nov 2003 11:15:01 -0800
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

1) well the device names are at least internally consistent.
and there are some devices like blah0p1 already.
also the proposed scheme for dealing with devices above 26
is currently a mess, hdaa hdaaa, since with the last patch
set I was using I had 400 disks mounted... mounting /dev/ubdpa1
ick... we only need one disk controller for a effectively unlimited
of disk drives which could be called c0dXpY if desired...
I don't know of any easy way to generate base26[a-z]
numbers from normal numbers.
So we might want to instead use ubd0p1 see cpqarray.txt ciss.txt
in /usr/src/linux/Documentation

2) Yes loop mounting a partitioned device is a pain
see however the offset option to the loop device
e.g. mount -oloop,offset=16384 partitioned_fs /mnt/loop
will mount the first partition
the calculation is based on the default geometry
512 byte/sector
32 sectors/track
128 heads/cylinder
and the first partition is at C0T1S0
1 track in from start so 512 * 32 = 16384
DOS partitions are a pain...
2nd and later are usually at CXT0S0
cylinder X which has offset $(( 512 * 32 * 128 * X ))
2097152 is not a handy number
and the X is 1 less then the start address shown in fdisk
fdisk's expert mode "x" shows the correct number in the
cylinder column

3) you could combine several ubd into one device in
theory, the device mapper might work for this and a
plugin to do this through the partition code should be
possible but I would expect a mess, you would have
to use the device tree to find all the ubd's and merge
them into a single device and then based on which
partition you want to use map back to the real ubd
devices, so it should be possible but messy.

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
