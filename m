Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcEty-0002Zr-Jb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 19:23:34 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CcEtx-0000jU-8m
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 19:23:34 -0800
Subject: Re: [uml-devel] Re: What to do with uml_switch? 
In-Reply-To: Message from Gerd Knorr <kraxel@bytesex.org> 
	of "Wed, 08 Dec 2004 20:33:48 +0100." <20041208193348.GC4853@bytesex> 
References: <200412040452.32722.blaisorblade_spam@yahoo.it>
	<29928.1102218163@marajade.sandelman.ottawa.on.ca>
	<20041206192526.GC12953@bytesex>
	<5810.1102524702@marajade.sandelman.ottawa.on.ca>
	<20041208193348.GC4853@bytesex> 
Message-ID: <19971.1102562577@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Wed, 08 Dec 2004 22:22:57 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, Steve Schmidtke <steve_schmidtke@hotmail.com>, Felix =?iso-8859-1?Q?M=FCri?= <uml@uxu.ch>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Gerd" == Gerd Knorr <kraxel@bytesex.org> writes:
    Gerd> Hmm, not sure I like that idea.  Is this with vlan tagging
    Gerd> support?  How can this be configured?  Is the command mode the
    Gerd> only way, or can you also use some config file or command line
    Gerd> switches for that?
    >> No VLANs.

    Gerd> Would be cool I think, so you could debug vlan code in the
    Gerd> kernel using uml for example.

  Having uml_switch decode vlan tags, and split it up into multiple
logical switches, would certainly be possible.

  The log-to-pcap file might also be interesting if it could log
specific tags to specific files. That would certainly permit very easy
regression testing.
  (And you don't want to use the VLAN code in the kernel to test the
vlan code in the kernel...)

    >> Secondly, I do not put these things into uml_switch.  Rather, I
    >> *refactor* things so that uml_switch and uml_netjig share back
    >> end code. uml_switch has none of the above things, only the same
    >> port.c code.

    Gerd> Oh, so for uml_netjig you just link in some more some object
    Gerd> files which do the arp answering, packet injection and so on?
    Gerd> That wasn't clear to me.  This makes much more sense ...

  Yes.
  The idea is that uml_switch doesn't change. 
  Adding a bazillion command line switches seemed to be a loss to me.

  No doubt some have gotten bit by being unable to use mcast between
UMLs while, on say, a train. lo isn't multicast capable (at least on 2.4
host, I don't know about 2.6), and sticking in a network card just to
get multicast seems silly.
  We have a script called "localswitches", which invokes uml_netjig
under expect, and then invokes the appropriate UMLs, with the right
environment variables. The environment variables are clearly a bit
locally relevant, since they get plugged into the UML command line(s).

marajade-[nightly/testing/pluto/basic-pluto-06] mcr 1027 %localswitches east west

...

spawn /mara4/openswan-2/nightly/testing/utils/uml_netjig/uml_netjig --cmdproto -t 
OK netjig>NEWSWITCH north
OK 3 LINES
ARPREPLY=0
UML_north_CTL=/tmp/umlyntoYX.d/north/ctl
UML_north_DATA=/tmp/umlyntoYX.d/north/data
OK netjig>NEWSWITCH south
OK 3 LINES
ARPREPLY=0
UML_south_CTL=/tmp/umlyntoYX.d/south/ctl
UML_south_DATA=/tmp/umlyntoYX.d/south/data
OK netjig>NEWSWITCH northpublic
OK 3 LINES
ARPREPLY=0
UML_northpublic_CTL=/tmp/umlyntoYX.d/northpublic/ctl
UML_northpublic_DATA=/tmp/umlyntoYX.d/northpublic/data
OK netjig>NEWSWITCH southpublic
OK 3 LINES
ARPREPLY=0
UML_southpublic_CTL=/tmp/umlyntoYX.d/southpublic/ctl
UML_southpublic_DATA=/tmp/umlyntoYX.d/southpublic/data
OK netjig>NEWSWITCH east
OK 3 LINES
ARPREPLY=0
UML_east_CTL=/tmp/umlyntoYX.d/east/ctl
UML_east_DATA=/tmp/umlyntoYX.d/east/data
OK netjig>NEWSWITCH west
OK 3 LINES
ARPREPLY=0
UML_west_CTL=/tmp/umlyntoYX.d/west/ctl
UML_west_DATA=/tmp/umlyntoYX.d/west/data
OK netjig>NEWSWITCH public
OK 3 LINES
ARPREPLY=0
UML_public_CTL=/tmp/umlyntoYX.d/public/ctl
UML_public_DATA=/tmp/umlyntoYX.d/public/data
OK netjig>NEWSWITCH admin
OK 3 LINES
ARPREPLY=0
UML_admin_CTL=/tmp/umlyntoYX.d/admin/ctl
UML_admin_DATA=/tmp/umlyntoYX.d/admin/data
OK netjig>


- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbfFEIqHRg3pndX9AQFTKQP+I29St4Vr/2jOOLtLjRKCsULLF13q+IZR
Nws422J1sXbdmTsSxBEbjS0zhbRiXYqZmP8Q11G4oHxEC+zz8JPuYgU2XsfEnKhk
oDsuk89evlOgRkx3zo3S+iIbCA1gikdiiB7z3XVpGn31qmon6IJNuXlamoqjzjxd
9jAM9lu8r9A=
=c2Fv
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
