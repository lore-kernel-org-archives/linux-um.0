Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bxcb0-0008FE-A8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 19:24:06 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bxcaw-0000ge-Ds for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 19:24:06 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id WAA29998
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Aug 2004 22:28:00 -0400 (EDT)
Message-ID: <41240F28.1080709@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] No Bug Here: [Was: Expected SIGSTOP persists in
	2.4.26-3um ]
References: <412227A4.6060005@enterasys.com> <4123BA9D.6080201@enterasys.com>
	<200408182346.i7INkMek003723@ccure.user-mode-linux.org>
In-Reply-To: <200408182346.i7INkMek003723@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6FD3F5D4D3AC95B436BFE759"
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
Date: Wed, 18 Aug 2004 22:23:36 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FD3F5D4D3AC95B436BFE759
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

no sir. the versions were correct. and the reboot-patch was applied
to the 2.4.24-1um kernel - this i originally reported as fixed, but
in later runs it showed up again... sigh.

the errors reported were those versions w/patches mentioned + all
our mods. more recent testing with just kernel.org + UML leads
to believe this is something we're inducing... so should not be
reported against what everyone else is playing with.

Jeff Dike wrote:

> dbahi@enterasys.com said:
> 
>>I withdraw this error report against 2.4.26-3um against any plain
>>vanilla UML kernel for that matter. 
> 
> 
> Is it possible you were mistaken about the versions, or whether the 
> reboot-signals patch was present?
> 
> 				Jeff
> 


--------------enig6FD3F5D4D3AC95B436BFE759
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBJA8t3XQ4zakZ3z4RApVnAJ9hzF6HGcxf9TRjfewPEeRfwHg0hQCfUb7B
8FPhme8Ft2sdBtBkTOyW6YY=
=1Gm/
-----END PGP SIGNATURE-----

--------------enig6FD3F5D4D3AC95B436BFE759--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
