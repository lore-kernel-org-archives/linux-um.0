Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6c3X-0002Pi-3d for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 14:10:59 -0800
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6c3T-0000H1-FZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 14:10:59 -0800
Received: from NHROCAVG2.ets.enterasys.com ([134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id j22MAqZC000819
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 2 Mar 2005 17:10:52 -0500 (EST)
Message-ID: <422639E7.4080405@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07EAC321FC7BFBEF6BE0F8B7"
Subject: [uml-devel] stdin lockup using con0=fd:0,fd:1 (guest 2.4.26-3um)
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
Date: Wed, 02 Mar 2005 17:10:47 -0500
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07EAC321FC7BFBEF6BE0F8B7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

did i miss the console cleanup crew?

i have a UML guest command line that uses con0=fd:0,fd:1
(or not, as this is the default for CONFIG_CON_ZERO_CHAN)

i launch new xterms using -- xterm -e '<guest cmdline>' &
(side note - can lock it w/o this too.) and users leaning on
the keyboard (most notably <enter>) while the new xterms pop
up and steal the window focus have experienced unresponsive
UML prompts.

no further keyboard input is processed...

uml_mconsole <id> reboot and things can be made better.
so the UML isn't locked up just the stdin....

i've tried to go thru stdio_init -> open_console -> line_open
to see if there was a likely place to drop a 'flush' of stdin
before we try attaching 0 -> 1 and 1 -> 0 (line_setup_irq)...
but i don't understand it all enough <frown>.

this is redhat 9 + SKAS - NPTL 2.4.20-31 host kernel
linux 2.4.26-3um guest kernel.

thank you.

--
db


--------------enig07EAC321FC7BFBEF6BE0F8B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCJjns3XQ4zakZ3z4RAlThAJ0R7WRWpDTDTn0lUHeDVwKUMz+x5ACdGJxZ
3r2qR2dmC0VwNatcsLQQgws=
=7V8N
-----END PGP SIGNATURE-----

--------------enig07EAC321FC7BFBEF6BE0F8B7--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
