Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoUbi-0002df-9j
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 13:30:50 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AoUbg-0000ex-9k
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 13:30:48 -0800
Subject: Re: [uml-devel] Hang on boot with 2.6.*
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <200402042042.09932.blaisorblade_spam@yahoo.it>
References: <1075921947.7569.7.camel@wopr.tektonic.net>
	 <200402042042.09932.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1075930245.7569.15.camel@wopr.tektonic.net>
Mime-Version: 1.0
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 04 Feb 2004 16:30:45 -0500
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 2004-02-04 at 14:42, BlaisorBlade wrote:
> Alle 20:12, mercoled=EC 4 febbraio 2004, Matt Ayres ha scritto:
> > Hi,
> >
> > I'm still fairly new to UML so perhaps this is a known issue and there
> > is a simple workaround.
> >
> > I've tried 2.6.1-1um, 2.6.0-1um, 2.6.0-test9-1um, Ingo's A7 combo patch,
> > and Blaisorblade's v8 patches for 2.6.0.  On every single one whenever I
> > try to boot it just hangs when it should be starting init (aka. After
> > "Mounted devfs on /dev").
> >
> > So it's obvious it's probably not a kernel problem and is user error on
> > my part.  I noticed with problem with 2.4.23-1um with the RTC/high mhz
> > bug, however I disabled RTC in the kernel configs and still had this
> > problem, not to mention the older kernels did not have this problem.
> You mean that for 2.4 you get only 2.4.22-?um working and only if you dis=
able=20
> UML-rtc?

2.4.23-2um works fine as it includes the required fixes for RTC.

>=20
> > Has anyone had this problem and can offer a tip on what I am possibly
> > doing wrong? Host is 2.4.24.
>=20
> Which versions worked+ which is your command line+ post initial messages+=
 have=20
> you got skas on the host? Is the filesystem ok? Is there inside the=20
> filesystem something not ok (I especially think about a NPTL-enabled glib=
c)?

Currently 2.4.24-2um works (2.4.24 kernel with 2.4.23-2um patch). =20

Here is the command I am running and the first few lines of the boot:

root@uml8 [/home/nonaffiliated]# su - nonaffiliated -c \
>                         'nice -10 \
>                         ~/kernel \
>                         devfs=3Dmount \
>                         ubd0=3D~nonaffiliated/rootfs \
>                         ubd1=3D~nonaffiliated/swapfs \
>                         mem=3D128M umid=3Dnonaffiliated \
>                         con=3Dnull con0=3Dfd:0,fd:1 \
>                         eth0=3Dtuntap,nonaffiliated,fe:fd:0:0:8:11'
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.6.1-1um (root@uml8.tektonic.net) (gcc version 3.3.2
20031022 (Red Hat Linux 3.3.2-1)) #5 Wed Feb 4 11:57:08 CST 2004
On node 0 totalpages: 32768
  DMA zone: 32768 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: devfs=3Dmount ubd0=3D/home/nonaffiliated/rootfs
ubd1=3D/home/nonaffiliated/swapfs mem=3D128M umid=3Dnonaffiliated con=3Dnull
con0=3Dfd:0,fd:1 eth0=3Dtuntap,nonaffiliated,fe:fd:0:0:8:11 root=3D98:0


and here are the last few:

Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
blkmtd: version $Revision: 1.5 $
blkmtd: error: missing `device' name

NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
 /dev/ubd/disc0: unknown partition table
 /dev/ubd/disc1: unknown partition table
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev


The OS is RedHat 9 (glibc with NTPL), hence my reason for wanting 2.6 becau=
se it includes NTPL=20
whereas 2.4 does not.  It seems odd that 2.6 wouldn't work with a NTPL enab=
led glibc, is this a known
problem?  I've been following the threads regarding 2.6, but I seem to have=
 missed that.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
