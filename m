Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <41141F14.6050507@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Expedted SIGSTOP,
	got status = <blah> (UML 2.4.24-1um)
References: <410806FE.1000209@enterasys.com> <4113D92B.5040602@enterasys.com>
	<200408062246.i76Mk9QW004489@ccure.user-mode-linux.org>
	<41140ABD.7020806@enterasys.com>
	<20040807005950.GA4939@ccure.user-mode-linux.org>
In-Reply-To: <20040807005950.GA4939@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16BE8FECDAB522101A2D52F8"
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
Date: Fri, 06 Aug 2004 20:15:16 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16BE8FECDAB522101A2D52F8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> It applies because you're running an old 2.4.  That patch is in the current
> 2.4 UML.
> 

right 2.4.24 - 2.4.26 um deltas. got it.

>>   Checking for the skas3 patch in the host...found
> 
> 
> This is a different UML ...
> 
> 
>>Restarting system.
>>
>>deactivate_all_fds failed, errno = 9
>>Checking for the skas3 patch in the host...found
>>Checking for /proc/mm...found
> 
> 
> from this one, right?
> 

yes. the hung one stayed hung. next time i see it i'll attach gdb.

> If so, did the second one boot OK, and the only problem was the errno=9
> thing?

yes. just so.

again, many thanks.

--------------enig16BE8FECDAB522101A2D52F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBFB8Z3XQ4zakZ3z4RAshSAJ9Ctt/BLV91tPUdzMrb929MTtgxhgCfdN2q
Ag2CcCcb7cpsoc9gcD30W/U=
=1P6y
-----END PGP SIGNATURE-----

--------------enig16BE8FECDAB522101A2D52F8--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
