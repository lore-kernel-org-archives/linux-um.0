Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc54I-0007sv-G8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 08:53:34 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cc54E-0001xe-Vq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 08:53:34 -0800
Subject: Re: [uml-devel] Re: What to do with uml_switch? 
In-Reply-To: Message from Gerd Knorr <kraxel@bytesex.org> 
	of "Mon, 06 Dec 2004 20:25:27 +0100." <20041206192526.GC12953@bytesex> 
References: <200412040452.32722.blaisorblade_spam@yahoo.it>
	<29928.1102218163@marajade.sandelman.ottawa.on.ca>
	<20041206192526.GC12953@bytesex> 
Message-ID: <5810.1102524702@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 08 Dec 2004 09:51:42 -0700
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, Steve Schmidtke <steve_schmidtke@hotmail.com>, Felix =?iso-8859-1?Q?M=FCri?= <uml@uxu.ch>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Gerd" == Gerd Knorr <kraxel@bytesex.org> writes:
    >> 3) can create *multiple* switches and keep them seperate

    Gerd> Hmm, not sure I like that idea.  Is this with vlan tagging
    Gerd> support?  How can this be configured?  Is the command mode the
    Gerd> only way, or can you also use some config file or command line
    Gerd> switches for that?

  No VLANs. 
  It creates multiple sockets, and you tell the UML(s) about the multiple
interfaces. 

  Please read the mentione paper.

    Gerd> Hmm, I don't think it is a good idea to put that kind of
    Gerd> testing code into the switch daemon.  I'd make the switch
    Gerd> daemon behave as close as possible to a real switch, then use
    Gerd> the normal tools you use for real networks as well.  I think
    Gerd> uml_switch should just support a monitor port which will see

  Not practical, not reliable.
  Often, not even possible if you wish to play packets that Linux simply
can not easily produce. 

  Secondly, I do not put these things into uml_switch.
  Rather, I *refactor* things so that uml_switch and uml_netjig share
back end code. uml_switch has none of the above things, only the same
port.c code.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbcxHYqHRg3pndX9AQG3/gQAx6XsUJv3AcpqG/c7ZWPFJzZZhXILAmS4
VT1mpY3GS2BZNFEiPhaxoA9tEb1vxWiJtWhe5yGxa/oh0iy4ESp22gPlQDN/p4Iv
bwaW+CxJHE6tVi61ybdaI/9qVrWxBlzZ0CVVuTZBNuonYRQwIn15hn1JlOcahxGB
ov0jytcoSQE=
=Fj0A
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
