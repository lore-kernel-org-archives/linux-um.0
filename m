Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBvJr-0001FA-Jo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 05:41:15 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BBvJq-0001R1-Hy for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 05:41:14 -0700
Message-ID: <189201c41e30$d434cc70$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] Re: [uml-user] Network lags
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
Date: Fri, 9 Apr 2004 14:47:32 +0200
Content-Transfer-Encoding: quoted-printable
To: Joern Bredereck <jb@bw-networx.net>, user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu, Jeff Dike <jdike@addtoit.com>

hi again,

i did some testing and i`m able to reproduce this with 2.6 based uml on 2.6=
 host.
after starting some threads like

while true;do find /;done >/dev/zero 2>&1 &
while true;do dd if=3D/dev/urandom of=3D/somepath/test.dat >/dev/zero 2>&1 &
while true;do dd =EDf=3D/dev/hda of=3D/dev/zero >/dev/zero 2>&1 &

and thus stressing the I/O on host very much, all seems to run fine for som=
e time - BUT:
from time to time (didn`t examine, if this is periodic - but all runs fine =
at least >95% of the time) i get the same lags, when
pinging the uml.

since i`m stressing the I/O very heavily, the lags i see are much worse tha=
n joerns.
i sometimes get lags >60s and even error-messages from ping: sendms: no buf=
fer space available.

ok - my generated disk I/O uses most of the buffers, but shouln`t it be the=
 host kernels job,to leave some buffers reserved and
"schedule" that appropriately ?  i`m not an expert regarding scheduling - b=
ut this is what i expect from a kernel.

does anybody run a more recent (>2.6.0) HOST kernel and is also able to rep=
roduce this?
maybe this is a "scheduling question" or a question for LKML ?
maybe i`m just stupid doing such "nasty things" i shouldn`t do - and i`m ex=
pecting too much ? :D

at least, i would be interested in getting to know:

- why this happens
- how to "tune" this, that it doesn`t happen
- if this is expected behavour on "heavy loaded systems" or probably a uml =
or host-kernel bug

regards
roland




----- Original Message -----=20
From: "roland" <for_spam@gmx.de>
To: "Joern Bredereck" <jb@bw-networx.net>; <user-mode-linux-user@lists.sour=
ceforge.net>
Sent: Friday, April 09, 2004 1:10 PM
Subject: Re: [uml-user] Network lags


> Hi Joern!
> Is the uml 100% idle all the time?
> what`s going on on the host at the same time?
> uml is just another "process" on the host - and the scheduler (especially=
 I/O) of the 2.4 kernel series is not the really best.
2.6
> is MUCH better - so you probably could try 2.6 on HOST and compare, if th=
at makes a difference?
>
> could you run "vmstat 1" on the host and inside the uml while pinging?
>
> could you also ping into the other direction and put the results "side by=
 side", to see if there is a relation ?
>
> as of writing this, i searched the mailing-list archive and found a refer=
ence:
>
> http://sourceforge.net/mailarchive/message.php?msg_id=3D6285243
>
> so, you probably can do "some more" I/O on your host or on your UML  (dd =
if=3D....) and study the ping "behaviour" ?
>
>
> regards
> roland
>
>
> ----- Original Message -----=20
> From: "Joern Bredereck" <jb@bw-networx.net>
> To: <user-mode-linux-user@lists.sourceforge.net>
> Sent: Friday, April 09, 2004 12:27 PM
> Subject: [uml-user] Network lags
>
>
> > Hi,
> >
> > I have a strange problem with lagging network connections to my vserver=
s.
> >
> > Here is a typical ping to one of the uml vservers, sent from the uml ho=
st
> > itself:
> >
> > 64 bytes from 217.146.142.73: icmp_seq=3D44 ttl=3D64 time=3D0.2 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D45 ttl=3D64 time=3D0.2 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D46 ttl=3D64 time=3D0.2 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D47 ttl=3D64 time=3D235.6 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D48 ttl=3D64 time=3D0.4 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D49 ttl=3D64 time=3D0.2 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D50 ttl=3D64 time=3D0.4 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D51 ttl=3D64 time=3D0.2 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D52 ttl=3D64 time=3D0.4 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D53 ttl=3D64 time=3D2876.6 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D54 ttl=3D64 time=3D1876.7 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D55 ttl=3D64 time=3D876.7 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D56 ttl=3D64 time=3D1.8 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D57 ttl=3D64 time=3D0.3 ms
> > 64 bytes from 217.146.142.73: icmp_seq=3D58 ttl=3D64 time=3D0.4 ms
> >
> > As you can see, most of the times, the pings are just fine. But every 10
> > to 20 seconds there is a lag. Sometime only 500 ms, sometimes 3000 ms a=
nd
> > sometimes even 10 seconds long.
> >
> > You can imagine it's rellay no fun to work on a lagging vserver via ssh.
> > :-(
> >
> > The uml host itself has no networking problems with the outside world.
> > Pings to everywhere are just as they are supposed to be.
> >
> > I use the tap-devices for networking.
> >
> > vserver2:/etc/init.d# ifconfig tap1
> > tap1      Link encap:Ethernet  HWaddr 00:FF:7F:4C:C5:2F
> >           inet addr:217.146.142.84  Bcast:217.146.142.255
> > Mask:255.255.255.255
> >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> >           RX packets:3478644 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:2961598 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:1503132252 (1.3 GiB)  TX bytes:299835570 (285.9 MiB)
> >
> >
> > The uml, as well as the uml host is a Debian Woody 3.0.
> >
> > Kernels in use:
> >
> > On the host: Vanilla 2.4.23 with the host-skas-patch.
> >
> > On the uml:
> >
> > Linux version 2.4.23-1um (root@vserver1) (gcc version 2.95.4 20011002 (=
Debian prerelease)) #5 Sun Dec 21 04:26:57 CET 2003
> > On node 0 totalpages: 16384
> > zone(0): 16384 pages.
> > zone(1): 0 pages.
> > zone(2): 0 pages.
> > Kernel command line: ubd0=3D/dev/vserver/ns1 ubd1=3D/dev/vserver/swap_n=
s1 eth0=3Dtuntap,,,217.146.142.84 umid=3Dns1 mem=3D64M
root=3D/dev/ubd0
> > Calibrating delay loop... 3135.26 BogoMIPS
> > Memory: 60772k available
> > Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> > Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
> > Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> > Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
> > Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> > Checking for host processor cmov support...Yes
> > Checking for host processor xmm support...No
> > Checking that ptrace can change system call numbers...OK
> > Checking that host ptys support output SIGIO...Yes
> > Checking that host ptys support SIGIO on close...No, enabling workaround
> > Checking for /dev/anon on the host...Not available (open failed with er=
rno 2)
> > POSIX conformance testing by UNIFIX
> > Linux NET4.0 for Linux 2.4
> > Based upon Swansea University Computer Society NET3.039
> > Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
> > Initializing RT netlink socket
> > Starting kswapd
> > VFS: Disk quotas vdquot_6.5.1
> > Journalled Block Device driver loaded
> > devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> > devfs: boot_options: 0x1
> > pty: 2048 Unix98 ptys configured
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > loop: loaded (max 8 devices)
> > PPP generic driver version 2.4.2
> > Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon Ja=
nes (simon@ncm.com)
> > Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> > ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maroon.tc.umn.edu>
> > ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson <johns393@maroo=
n.tc.umn.edu>
> > md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
> > md: Autodetecting RAID arrays.
> > md: autorun ...
> > md: ... autorun DONE.
> > Initializing software serial port version 1
> > mconsole (version 2) initialized on /root/.uml/ns1/mconsole
> > Partition check:
> >  ubda: unknown partition table
> >  ubdb: unknown partition table
> > ubd : Synchronous mode
> > Initializing stdio console driver
> > Netdevice 0 : TUN/TAP backend - IP =3D 217.146.142.84
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP, IGMP
> > IP: routing cache hash table of 512 buckets, 4Kbytes
> > TCP: Hash tables configured (established 4096 bind 4096)
> > IPv4 over IPv4 tunneling driver
> > GRE over IPv4 tunneling driver
> > Linux IP multicast router 0.06 plus PIM-SM
> > ip_conntrack version 2.1 (474 buckets, 3792 max) - 292 bytes per conntr=
ack
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > IPv6 v0.8 for NET4.0
> > IPv6 over IPv4 tunneling driver
> > NET4: AppleTalk 0.18a for Linux NET4.0
> > EXT3-fs: INFO: recovery required on readonly filesystem.
> > EXT3-fs: write access will be enabled during recovery.
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: recovery complete.
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> > Mounted devfs on /dev
> > Adding Swap: 262136k swap-space (priority -1)
> > EXT3 FS 2.4-0.9.19, 19 August 2002 on ubd(98,0), internal journal
> > Virtual console 1 assigned device '/dev/ptyp1'
> > * insmod tun
> > insmod: tun: no module by that name found
> > * ifconfig tap1 217.146.142.84 netmask 255.255.255.255 up
> > * bash -c echo 1 > /proc/sys/net/ipv4/ip_forward
> > * route add -host 217.146.142.73 dev tap1
> > * bash -c echo 1 > /proc/sys/net/ipv4/conf/tap1/proxy_arp
> > * arp -Ds 217.146.142.73 eth0 pub
> > * route del -host 217.146.142.73 dev tap1
> > * bash -c echo 0 > /proc/sys/net/ipv4/conf/tap1/proxy_arp
> > * arp -i eth0 -d 217.146.142.73 pub
> > * route add -host 217.146.142.73 dev tap1
> > * bash -c echo 1 > /proc/sys/net/ipv4/conf/tap1/proxy_arp
> > * arp -Ds 217.146.142.73 eth0 pub
> > eth0: no IPv6 routers present
> >
> >
> > Any idea what could cause those lags? Any hint for further troubleshoot=
ing
> > approaches?
> >
> > Thanks!
> >
> > Joern
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dc=
lick
> > _______________________________________________
> > User-mode-linux-user mailing list
> > User-mode-linux-user@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
> >
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
