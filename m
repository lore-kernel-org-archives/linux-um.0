Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbKuk-0000C5-Pk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 07:36:38 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CbKuj-0005Wj-UL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 07:36:38 -0800
From: mcr@xelerance.com
In-Reply-To: Message from "Steve Schmidtke" <steve_schmidtke@hotmail.com> 
	of "Sun,
	05 Dec 2004 20:20:11 GMT." <BAY24-F43C12817C138B110B213583B30@phx.gbl> 
References: <BAY24-F43C12817C138B110B213583B30@phx.gbl> 
Message-ID: <4972.1102296202@marajade.sandelman.ottawa.on.ca>
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
Date: Sun, 05 Dec 2004 18:23:22 -0700
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: blaisorblade_spam@yahoo.it, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Steve" == Steve Schmidtke <steve_schmidtke@hotmail.com> writes:
    Steve> Michael Richardson wrote:
    >> uml_netjig is a tool which does the following: 1) moves packets
    >> using "daemon" mode a la uml_switch.  2) has an expect-friendly
    >> command line interface 3) can create *multiple* switches and keep
    >> them seperate

    Steve> If they are separate, why not just run multiple uml_switches?

  a) because one sometimes needs to inject packets onto multiple networks
     in a specific order. uml_netjig permits this.

  b) once one has written uml_netjig to listen to the command channel
     and all of the sockets each switch has, there is little reason not
     to combine things. It doesn't add much complexity, and it makes
     managing the switch from expect much easier.

  {oh, I forgot, if you have the libnetdissect branch of tcpdump, you
can tcpdump all networks as well, which you can not always do from a
UML. Particularly if one is debugging an issue where a UML crashes as a
result of a packet-of-death}

    >> 4) can record all packets to a .pcap file 5) can play packets
    >> from a .pcap file at a given rate (or under command line
    >> interface control) 6) can optionally answer ARP queries for
    >> imaginary nodes.

    Steve> I like these 3, but could you not just connect another UML
    Steve> guest to the switch and run arp -s pub and tcpdump to
    Steve> accomplish the same thing?

  Sure, no problem :-)
  Please send:
	 a) MORE RAM
	    16-way system

	 b) Paulo to come and debug why UMLs to "rogue", and clog up
	    memory and system state. 
	    (Remember we start and stop some 1000 of them every night)
	    The more that we run, the worse the situation.

  Starting a UML to answer ARP and ICMP echo requests is silly.
  Particularly since our test system now takes 2-3 hours to run on a
multigigahertz box with lots of ram.

    Steve> I am still not clear if uml_netjig is a separate program
    Steve> running on top of uml_switch or inside it, but (and I
    Steve> apologize for being dense if this is what you are doing) I
    Steve> think the proper way to accomplish what you want is to create
    Steve> a "-monitor <socket>" option to uml switch to filter all

  Please go read the paper.

  uml_netjig is a superset of uml_switch.
  The refactoring of it means that uml_switch has just a main() that
is much simpler than that of uml_netjig.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbO0h4qHRg3pndX9AQFxFQQA38+UCjmR4YnOGatlUFDYtbW/e+qWHAU/
4oDV9euDJiF6Tw7D4qDQ7eLMpjFvcAmDCTPGbfhXowbWDrXpGFhXZ7SxqQ0AzUIt
yyGFQeSrRp9GMvyDrQrmenI6q4rY6TtZItG1FcNz0E2g7VtnNY2YXN21+jT/Uujx
0ldP3wvZX2E=
=2gqt
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
