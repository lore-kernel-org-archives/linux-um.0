Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc4uh-00072p-HD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 08:43:39 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cc4ug-0004ly-5v
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 08:43:39 -0800
Subject: Re: [uml-devel] Re: What to do with uml_switch? 
In-Reply-To: Message from Blaisorblade <blaisorblade_spam@yahoo.it> of "Mon,
	06 Dec 2004 21:16:42 +0100."
	<200412062116.43380.blaisorblade_spam@yahoo.it> 
References: <BAY24-F43C12817C138B110B213583B30@phx.gbl>
	<200412062116.43380.blaisorblade_spam@yahoo.it> 
Message-ID: <5658.1102524139@marajade.sandelman.ottawa.on.ca>
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
Date: Wed, 08 Dec 2004 09:42:19 -0700
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Steve Schmidtke <steve_schmidtke@hotmail.com>, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Blaisorblade" == Blaisorblade  <blaisorblade_spam@yahoo.it> writes:
    Blaisorblade> Needing another UML guest to do something which can be
    Blaisorblade> accomplished in a simpler way (supposing it's not too
    Blaisorblade> badly coded / heavy / intrusive in the patch) could
    Blaisorblade> even be reported as a bug, on the reverse!

  Particularly, if you are debugging the ARP code *in* the kernel :-)

    Blaisorblade> Another problem: it's doable even without support for
    Blaisorblade> "pcap transport" in UML (which is currently broken in
    Blaisorblade> 2.6)? I know what to do to fix that (build problem
    Blaisorblade> only), only it's a bit ugly to fix - or requires pcap
    Blaisorblade> maintainers to fix up some screwage:

  I don't use the pcap transport.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbcu6YqHRg3pndX9AQGLrgP8CsnnEaRDDkZPI7yzSv1qBsRjlgoFe275
beWCJRq4soxm+u1KhWxxthgV6teI/nLz8sR7u56YmDENcxlUjfDoBJIq0qkLyuQs
v6C2bA6LazlNFulFBvL4dCNeMnsyzvZTzudh/k3NvRbSItKtoS32GvhtPLsCcq5H
qfZbVH5wnm0=
=5jVX
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
