Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEC2W-0004MD-ID for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 12:29:00 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEC1M-0005Cv-Sa for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 12:29:00 -0700
Received: from minna.local (pD9E76209.dip.t-dialin.net [217.231.98.9])
	by mail.linbit.com (LINBIT Mail Daemon) with ESMTP id 871461435D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun,  3 Oct 2004 21:27:43 +0200 (CEST)
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
Message-ID: <TxmNOBlZgGMNgCaYmCBYR9A=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<200410031711.26138.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <200410031711.26138.blaisorblade_spam@yahoo.it>
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
Date: Sun, 3 Oct 2004 21:29:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

/ 2004-10-03 17:11:26 +0200
\ BlaisorBlade:
> On Sunday 03 October 2004 04:36, Lars Ellenberg wrote:
> > in the upcomming new heartbeat design of linux-ha, we use relatively
> > large udp packets (passing large xml blobs back and forth between the
> > nodes). now, cluster development and testing is convenient on UML.
> >
> > but:
> >  uml seems to silently and systematically lose all fragmented
> >  udp packets, that is packages larger than mtu, and 1480 byte
> >  max for xml blobs just does not work out too good ...
> 
> > I investigated a little bit (using two simple perl snippets to
> > generate/[not]receive the udp packets), and it turns out that:
> 
> >  sending large (up to 64K; fragmented) udp packets
> >  using tuntap:
> >   HOST -> UML  works.
> >   UML  -> HOST nope :(
> >   UML <-> UML  nope :( [ neither with mcast or other ]
> >
> >  looking into /proc/net/snmp on the UMLs and the HOST
> >  show on the not receiving side an increase of
> >  InHdrError!
> >  (it never is reassembled into a proper udp packet)
> >
> > this is easy to reproduce (because it just happens all the time)
> > tested with 2.6.6 and 2.6.8 plus respective UML patches.
> 
> Have you tried to use different UML transports (ethertap/uml_switch)- 

tuntap with uml_switch, uml_switch -hub
multicast

> tcpdump'ing the traffic - other things?

host tcpdump sees packets, they appear to be correct.

tcpdump in the uml segfaults
on the second fragment for two-fragment udp packet :-) 

> Changing the host version?

host linux kernel:
2.4.21-suse something, 2.4.26, 2.6.6, 2.6.8

> Increasing the MTU somewhere (but seems not to work)?

right. does not work.

> What is strange is that the UML code does not even parse the IP header
> when using tuntap - it only works at the Ethernet layer.
> IIRC, the fragmentation happens at the IP layer...

hm... 
I only describe what I see.

> Also, can you post the scripts you use?

attached.
on one side: perl UdpRecv.pl &
on other uml, host, or same system, does not matter:
perl UdpSend.pl [<target ip>]

btw, uml to itself via uml-lo does work...

> > it seems to me that UML corrupts the ip header of
> > fragmented udp packets somehow at sending time.
> >
> > I wonder, if someone uses nfs over udp on uml, this should
> > be a long known issue and turn up loads of hits in a search.
> > I did not find a single reference to that problem, though.
> 
> Does NFS uses large UDP packets?

sometimes.
and yes, I just exported from uml,
nfs-mounted on host, did an ls in a directory with MANY files,
and it never came back
(udp never reached host, host increases InHdrError)
blocksize of exported file system was 1024, mtu is 1500, on would assume
it should just work ... but that is still an other problem.


thanks,

	lge

--bg08WKrSYDhXBjb5
Content-Type: application/x-perl
Content-Disposition: attachment; filename="UdpRecv.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w=0Ause strict;=0Ause Socket;=0Ause Sys::Hostname;=0A=0Amy=
 ( $count, $hisiaddr, $hispaddr, $histime,=0A     $host, $iaddr, $paddr, $p=
ort, $proto,=0A     $rin, $rout, $rbuf ); =0A=0A$iaddr =3D "\0\0\0\0";=0A$p=
roto =3D getprotobyname('udp');=0A$port  =3D 2222;=0A$paddr =3D sockaddr_in=
($port, $iaddr); # 0 means let kernel pick=0A=0Asocket(SOCKET, PF_INET, SOC=
K_DGRAM, $proto)   || die "socket: $!";=0Abind(SOCKET, $paddr)             =
             || die "bind: $!";=0A=0A$| =3D 1;=0A$rin =3D '';=0Avec($rin, f=
ileno(SOCKET), 1) =3D 1;=0A=0A# timeout after 10.0 seconds=0Awhile (select(=
$rout =3D $rin, undef, undef, 100.0)) {=0A    $rbuf =3D '';=0A    ($hispadd=
r =3D recv(SOCKET, $rbuf, 102400, 0))        || die "recv: $!";=0A    ($por=
t, $hisiaddr) =3D sockaddr_in($hispaddr);=0A    # $host =3D gethostbyaddr($=
hisiaddr, AF_INET);=0A    # $histime =3D unpack("N", $rtime) - $SECS_of_70_=
YEARS ;=0A    printf "%d.%d.%d.%d < ", unpack "CCCC", $hisiaddr;=0A    prin=
tf "%d/%d\n", length($rbuf), unpack("N", $rbuf);=0A}=0A
--bg08WKrSYDhXBjb5
Content-Type: application/x-perl
Content-Disposition: attachment; filename="UdpSend.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w=0Ause strict;=0Ause Socket;=0Ause Sys::Hostname;=0A=0Amy=
 ( $count, $hisiaddr, $hispaddr, $histime,=0A     $host, $iaddr, $paddr, $p=
ort, $proto,=0A     $i, $sbuf ); =0A=0A$iaddr =3D "\0\0\0\0";=0A$proto =3D =
getprotobyname('udp');=0A$port  =3D 2222;=0A$paddr =3D sockaddr_in(0, $iadd=
r); # 0 means let kernel pick=0A=0Asocket(SOCKET, PF_INET, SOCK_DGRAM, $pro=
to)   || die "socket: $!";=0Abind(SOCKET, $paddr)                          =
|| die "bind: $!";=0A=0A#print "getsockopt:",=0A# unpack("L",getsockopt(SOC=
KET,SOL_SOCKET,SO_SNDBUF)),=0A# "\n";=0A# setsockopt(SOCKET,SOL_SOCKET,SO_S=
NDBUF,1)      || die "setsockopt: $!";=0Aprint "getsockopt:",=0A unpack("L"=
,getsockopt(SOCKET,SOL_SOCKET,SO_SNDBUF)),=0A "\n";=0A=0A$| =3D 1;=0A=0A$ho=
st =3D $ARGV[0] || "192.168.200.254";=0A$hisiaddr =3D inet_aton($host)    |=
| die "unknown host";=0A$hispaddr =3D sockaddr_in($port, $hisiaddr);=0A=0A#=
 expect this to fail at 64K ...=0Afor ($i =3D 100; $i <=3D 100000; $i+=3D10=
0) {=0A	$sbuf =3D pack("N",$i) . ("X" x ($i - 4));=0A	$count =3D send(SOCKE=
T, $sbuf, 0, $hispaddr);=0A	defined($count) || die "send $host: $!";=0A	pri=
ntf "%-12s > %d/%d\n", $host, $count, $i;=0A	last if $count < $i;=0A	# sele=
ct(undef,undef,undef,0.1);=0A	sleep 1;=0A}=0A
--bg08WKrSYDhXBjb5--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
