Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc9bF-0006eS-2f for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 13:43:53 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cc9ak-0002H3-BP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 13:43:52 -0800
Subject: Re: [uml-devel] Re: What to do with uml_switch? 
In-Reply-To: Message from "Steve Schmidtke" <steve_schmidtke@hotmail.com> 
	of "Wed,
	08 Dec 2004 19:49:09 GMT." <BAY24-F3095F190F005AC385C24ED83B60@phx.gbl>
References: <BAY24-F3095F190F005AC385C24ED83B60@phx.gbl> 
Message-ID: <9901.1102542118@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 08 Dec 2004 16:41:58 -0500
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: blaisorblade_spam@yahoo.it, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Steve" == Steve Schmidtke <steve_schmidtke@hotmail.com> writes:
    Steve> It would be useful if daemon_user.c could be run in a
    Steve> synchronous mode such that packets are guaranteed delivered
    Steve> to the switch and guaranteed delivered to a host.  The switch
    Steve> could then mangle packets in a deterministic fashion for
    Steve> testing.

  Yes, that would be useful.
  From a practical point of view:
       s/SOCK_DGRAM/SOCK_STREAM/

  not a very useful way to operate if there is any network load, but it
may be okay for regression testing. Also realize that Linux Unix domain
datagram sockets are mostly reliable. (BSD does not have this property)

    Steve> It would also be interesting if packets could be passed in
    Steve> shared memory.  I'm wondering if it would be faster and more
    Steve> reliable at the same time.

  On a uniprocessor, perhaps.
  Evidence is that on multiprocessor systems, shared memory is not
faster than copying because of cache concurency costs.

  My opinion is that this is premature optimization.

  I having been thinking of booting all my UMLs up to single-user
prompt, swsusp them, and restore swsusp each time instead of booting
them. That may be a larger win for me.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbd1I4qHRg3pndX9AQG/HgP7BTfeATngfiD8qffUreEmSVYgmxFM/ZYz
cvS/qJjLVVghjL9Lf0KG56rOMqmVkQ47A7wE52coVLlHgXEIz0KX2j8lvuw2M3yg
4neNAulXa+yiIGf/U/GoxCe/K74cW0//tCV/Jlcl9g68AKzQ952AzEOtqy7D4hXc
sdxEKTXk//4=
=mf5Q
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
