Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc5NW-0001AY-Hu for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 09:13:26 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cc5NV-0000e7-5W
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 09:13:26 -0800
Subject: Re: [uml-devel] Re: What to do with uml_switch? 
In-Reply-To: Message from "Steve Schmidtke" <steve_schmidtke@hotmail.com> 
	of "Tue,
	07 Dec 2004 16:06:44 GMT." <BAY24-F14D010172174FC8FBD303F83B50@phx.gbl>
References: <BAY24-F14D010172174FC8FBD303F83B50@phx.gbl> 
Message-ID: <7044.1102525892@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 08 Dec 2004 10:11:32 -0700
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: blaisorblade_spam@yahoo.it, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Steve" == Steve Schmidtke <steve_schmidtke@hotmail.com> writes:
    Steve> Agreed, it would be an unwieldy solution.  And it's obvious
    Steve> you need fine grained control to manage packets in your test
    Steve> environment, sorry if it sounded like I was telling you what
    Steve> you should do.  What I was trying to point out (and thinking
    Steve> out loud) is that an ARP generator can be connected *to*
    Steve> uml_switch, it doesn't have to be built *into* uml_switch.

  Yes, that could be done.
  If you needed more sophistication than we have, then you'd want to do
exactly that.

    Steve> Strip down the UML kernel's daemon_user.c and what you have
    Steve> is a framework to talk socket datagrams to a uml_switch.  Add

  That's probably not the best idea. We put the interfaces in two places
right now... Best would be if a refactored uml_switch exported an
interface that replaced daemon_user.c :-)

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbc1w4qHRg3pndX9AQGyIgQAgnkAvJ1JWlsugt+VwwJz5Qg/qvv81lXa
nxrZ7gHWo4qn4oKE0bQS7FWgdNLnFbFm2Ii7VwYUQs9XVrYkIv0LN+DfjpRhBA3g
DB/KvaBkAAm6WNpRaoQ5hhKiBAtRE/ej3Wp/IU7EVw0Zz7e1OqplZUFlJ8dYvth4
kXOxWroli5Q=
=Izak
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
