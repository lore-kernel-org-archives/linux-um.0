Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4LZ6-00052D-PH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 08:10:12 -0800
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D4LYg-0007aq-Ph for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 08:10:12 -0800
Received: from NHROCAVG2.ets.enterasys.com ([134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id j1OG9ZZC018698
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Feb 2005 11:09:35 -0500 (EST)
Message-ID: <421DFC3C.3020709@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML startup -- segfault with no mm
References: <421D59C5.9020003@enterasys.com>
	<200502241736.j1OHaFha003688@ccure.user-mode-linux.org>
In-Reply-To: <200502241736.j1OHaFha003688@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE6ACE7BD17259A921206C3F0"
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
Date: Thu, 24 Feb 2005 11:09:32 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6ACE7BD17259A921206C3F0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

thank you very very much jeff.

i'll apply and let you know.

very much looking forward to the 'update/moderinization' of the 2.4 series.

Jeff Dike wrote:

>dbahi@enterasys.com said:
>
>
>>here's a wonderfully infrequent but nagging startup failure that
>>usually has a useless (no stack depth, or just corrupt) backtrace...
>>
>>
>
>You need the uml-enable-the-timer-after-the-timer-handler.patch patch:
>
>	http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/broken-out/uml-enable-the-timer-after-the-timer-handler.patch
>
>				Jeff
>
>
>

--
db


--------------enigE6ACE7BD17259A921206C3F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCHfw83XQ4zakZ3z4RAlnuAJ9RPkil7BU7FC6zRXOeAuUzLn+8YgCePsMj
Qs9zbvWfgIZKPIuuYnE70wQ=
=xM7i
-----END PGP SIGNATURE-----

--------------enigE6ACE7BD17259A921206C3F0--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
