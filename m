Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5pwc-0005D1-AY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Feb 2005 10:48:38 -0800
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D5pwY-0008ME-8p for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Feb 2005 10:48:38 -0800
Received: from NHROCAVG2.ets.enterasys.com ([134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id j1SImPZC005360
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Feb 2005 13:48:25 -0500 (EST)
Message-ID: <42236770.6060307@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML startup -- segfault with no mm
References: <421D59C5.9020003@enterasys.com>
	<200502241736.j1OHaFha003688@ccure.user-mode-linux.org>
	<421E1F0D.4040108@enterasys.com>
	<200502281934.j1SJYRMY003256@ccure.user-mode-linux.org>
In-Reply-To: <200502281934.j1SJYRMY003256@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB1564065F92032DBF74C7CCF"
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
Date: Mon, 28 Feb 2005 13:48:16 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1564065F92032DBF74C7CCF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

yep. have exactly that:

void initial_thread_cb_skas(void (*proc)(void *), void *arg)
{
    sigjmp_buf here;

    cb_proc = proc;
    cb_arg = arg;
    cb_back = &here;

    block_signals();
    if(sigsetjmp(here, 1) == 0)
        siglongjmp(initial_jmpbuf, 2);
    unblock_signals();

    cb_proc = NULL;
    cb_arg = NULL;
    cb_back = NULL;
}


Jeff Dike wrote:

>dbahi@enterasys.com said:
>
>
>>actually - 2.4.26-3um looks like this already.
>>
>>
>
>Yeah, if I had spent a bit more time looking at the stack, I would have noticed
>that the symptom was wrong for that patch.  What's happening is that you are
>taking a timer interrupt while on the initial process stack, which can't be
>allowed because interrupts should only happen on a kernel stack.
>
>Make sure your initial_thread_cb_skas (in arch/um/kernel/skas/process.c)
>blocks signals like so:
>
>	block_signals();
>	if(sigsetjmp(here, 1) == 0)
>		siglongjmp(initial_jmpbuf, 2);
>	unblock_signals();
>
>				Jeff
>
>
>

--
db


--------------enigB1564065F92032DBF74C7CCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCI2d03XQ4zakZ3z4RAoJYAJ9IrqRV+wXgPW2JAxKMQ0JlsZCQwQCcCNii
F71dhRsNCPXn5HPQBiJlcCk=
=SCXW
-----END PGP SIGNATURE-----

--------------enigB1564065F92032DBF74C7CCF--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
