Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bxdzt-0000Kh-Ct for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 20:53:53 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bxdzs-0002Vs-QB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 20:53:53 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i7J3rjao016466
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Aug 2004 23:53:45 -0400 (EDT)
Message-ID: <41242448.8010702@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] No Bug Here: [Was: Expected SIGSTOP persists in
	2.4.26-3um ]
References: <412227A4.6060005@enterasys.com> <4123BA9D.6080201@enterasys.com>
	<200408182346.i7INkMek003723@ccure.user-mode-linux.org>
	<41240F28.1080709@enterasys.com>
In-Reply-To: <41240F28.1080709@enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE2FEE5AB580BB0B14E4CC143"
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
Date: Wed, 18 Aug 2004 23:53:44 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2FEE5AB580BB0B14E4CC143
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

here is the last bread crumb trail i can think of -

we're loading modules with our stuff and i wasn't loading modules
in the kernel.org + UML massive launches.

it seems in our stuff that mem=1024 leads, not only to more
frequent encounters of launch SIGSTOP, but also, runtime
random kernel panics (stack overflow) (unhandled irq). (we used
to use mem=512 with 2.4.24-1um (it wouldn't do HIGHMEM either)).

light bulbs?

(i'm going to try building some modules for the vanilla stuff
but there have to be others out there using modules in their
UMLs --- is anybody else seeing these?)

D. Bahi wrote:

> no sir. the versions were correct. and the reboot-patch was applied
> to the 2.4.24-1um kernel - this i originally reported as fixed, but
> in later runs it showed up again... sigh.
> 
> the errors reported were those versions w/patches mentioned + all
> our mods. more recent testing with just kernel.org + UML leads
> to believe this is something we're inducing... so should not be
> reported against what everyone else is playing with.
> 
> Jeff Dike wrote:
> 
>> dbahi@enterasys.com said:
>>
>>> I withdraw this error report against 2.4.26-3um against any plain
>>> vanilla UML kernel for that matter. 
>>
>>
>>
>> Is it possible you were mistaken about the versions, or whether the 
>> reboot-signals patch was present?
>>
>>                 Jeff
>>
> 

-- 
Damn it! Morons don't learn until they die! -- Faye Valentine, _Cowboy Bebop, The 
Movie_.

--------------enigE2FEE5AB580BB0B14E4CC143
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBJCRI3XQ4zakZ3z4RAodCAJ0UbeQWEZ69omxSSasW/5NQzWrIMQCfVEpz
iHhmiDZhyNezlNxPYpqTww8=
=+DBm
-----END PGP SIGNATURE-----

--------------enigE2FEE5AB580BB0B14E4CC143--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
