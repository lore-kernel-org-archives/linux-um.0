Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1Wvk-00083s-Tf for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:09:40 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1Wvk-0001dC-06 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:09:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] help needed for running uml on a sarge
References: <1359.157.182.42.226.1090946399.squirrel@www.csee.wvu.edu>
	<200407272357.02784.a_mulyadi@telkom.net>
	<50485.151.205.59.135.1091030391.squirrel@www.csee.wvu.edu>
In-Reply-To: <50485.151.205.59.135.1091030391.squirrel@www.csee.wvu.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408241743.16572.blaisorblade_spam@yahoo.it>
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
Date: Tue, 24 Aug 2004 17:43:16 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: atanugul@csee.wvu.edu, a_mulyadi@telkom.net, user-mode-linux-user@lists.sourceforge.net

Alle 17:59, mercoled=EC 28 luglio 2004, atanugul@csee.wvu.edu ha scritto:
> Hi!
> I downloaded some root file sytems and got the following errors on a
> Debian 2.6.3-1-386 when I tired to run UML
> 1)with Debian-3.0r0.ext2 rootfs


> Checking root file system...
> fsck 1.27 (8-Mar-2002)
> fsck.ext2: No such file or directory while trying to open /dev/ubd/0
> /dev/ubd/0:
> The superblock could not be read or does not describe a correct ext2
> filesystem.  If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
>     e2fsck -b 8193 <device>
>
>
> fsck failed.  Please repair manually and reboot.  Please note
> that the root file system is currently mounted read-only.  To
> remount it read-write:
>
>  # mount -n -o remount,rw /
>
> CONTROL-D will exit from this shell and REBOOT the system.
>
> (none):~#
The /etc/fstab inside this rootFs tries to access /dev/ubd/0, which exists =

only if you use DevFS: you can enable it, in the kernel config and/or by=20
adding devfs=3Dmount to the command line. Or you can loop-mount the rootfs,=
=20
create /dev/ubd? with this

for i in 0 1 2 3 4 5 6 7; do mknod ubd$i b 98 $[ $i * 16 ]; done

and edit /etc/fstab to refer to it. I.e. replace /dev/ubd/0 with /dev/ubd0,=
=20
and repeat for other /dev/ubd/# to /dev/ubd#.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
