Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4SAu-0001VP-P4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 15:13:40 -0800
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D4SAq-0002Gi-7S for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 15:13:40 -0800
Received: from NHROCAVG2.ets.enterasys.com ([134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id j1ONDWZC003065
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Feb 2005 18:13:32 -0500 (EST)
Message-ID: <421E5F9A.6030109@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML 2.4 shmem.c changes? panic w/ backtrace
References: <41A35EF5.4080302@enterasys.com>
	<200411240242.iAO2gI7p006614@ccure.user-mode-linux.org>
In-Reply-To: <200411240242.iAO2gI7p006614@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3C49F89C0C52AA599B964F59"
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
Date: Thu, 24 Feb 2005 18:13:30 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C49F89C0C52AA599B964F59
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This happens everytime i try to load an application of ours that
uses shmem for syslog...

Jeff Dike wrote:

>dbahi@enterasys.com said:
>
>
>>i know things are hot and heavy in 2.6 but i hope somebody can spare a
>>thought about this panic i'm struggling to understand.
>>
>>
>
>Is this easily reproduced?
>
>The stack isn't ringing any bells with me, particularly since none of my code
>appears on the stack until the bug has already happened.
>
>				Jeff
>
>
>

--
db


--------------enig3C49F89C0C52AA599B964F59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCHl+a3XQ4zakZ3z4RAg99AJ9YmV/QI7XFBlSZ2QNzhPYO4p5QRQCeJIpc
I1JRpGZFYHQ6+wJZKoi8+ew=
=IQZo
-----END PGP SIGNATURE-----

--------------enig3C49F89C0C52AA599B964F59--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
