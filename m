Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbOiW-0002ux-VV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 11:40:16 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CbOiV-0007bu-Ed
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 11:40:16 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041206192526.GC12953@bytesex>
References: <200412040452.32722.blaisorblade_spam@yahoo.it>
	<29928.1102218163@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29928.1102218163@marajade.sandelman.ottawa.on.ca>
Subject: [uml-devel] Re: What to do with uml_switch?
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
Date: Mon, 6 Dec 2004 20:25:27 +0100
To: Michael Richardson <mcr@marajade.sandelman.ottawa.on.ca>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, Steve Schmidtke <steve_schmidtke@hotmail.com>, Felix =?iso-8859-1?Q?M=FCri?= <uml@uxu.ch>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

>   uml_netjig is a tool which does the following:
>   
>   1) moves packets using "daemon" mode a la uml_switch.
>   2) has an expect-friendly command line interface 

Sounds ok.

>   3) can create *multiple* switches and keep them seperate

Hmm, not sure I like that idea.  Is this with vlan tagging support?
How can this be configured?  Is the command mode the only way, or can
you also use some config file or command line switches for that?

>   4) can record all packets to a .pcap file
>   5) can play packets from a .pcap file at a given rate 
>      (or under command line interface control)
>   6) can optionally answer ARP queries for imaginary nodes.

Hmm, I don't think it is a good idea to put that kind of testing code
into the switch daemon.  I'd make the switch daemon behave as close as
possible to a real switch, then use the normal tools you use for real
networks as well.  I think uml_switch should just support a monitor port
which will see all traffic (even the switched one), that is the usual
way how it's done on physical hardware.

(4) may make sense neverless, to avoid packages being lost on load
peaks.

(5) + (6) I'd keep separated for sure.  Can be done by either some
separate utility which connects to the switch daemon the same way the
uml machines do that, and then injects the packets / answers arp and so
on (probably the better option for test runs).  Or just connect the
switch daemon via tuntap device and setup proxy-arp on the host machine
to simulate the imaginary nodes, and also inject packets via tuntap
network interface.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
