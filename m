Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bxlen-0005Tn-QN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Aug 2004 05:04:37 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bxlen-0007gk-80 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Aug 2004 05:04:37 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i7JC4Yao029580
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 19 Aug 2004 08:04:35 -0400 (EDT)
Message-ID: <412496FC.4090101@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] mem= and large file support
References: <412415B0.5060102@enterasys.com>
	<200408190603.i7J63Zek004748@ccure.user-mode-linux.org>
In-Reply-To: <200408190603.i7J63Zek004748@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A49B6213A909D7B3D94AD38"
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
Date: Thu, 19 Aug 2004 08:03:08 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A49B6213A909D7B3D94AD38
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

cool - so... it's in tempfile.c : 53
make_tempfile calls mkstemp -

so maybe a build option required to get the
option in with this library call? but which?

info on libc says:

      When the sources are compiled with `_FILE_OFFSET_BITS == 64' on a
      32-bit system this function is in fact `tmpfile64', i.e. the LFS
      interface transparently replaces the old interface.

so i'll try that.

and just for 'create_mem_file' completeness
the devanon case doesn't need attention with
the mmap. right?

-----

rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
gettimeofday({1092914208, 599204}, NULL) = 0
getpid()                                = 24405
open("/tmp/vm_file-3NJodS", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
unlink("/tmp/vm_file-3NJodS")           = 0
fchmod(3, 0777)                         = 0
_llseek(3, 2147483648, [2147483648], SEEK_SET) = 0
write(3, "\0", 1)                       = -1 EFBIG (File too large)
--- SIGXFSZ (File size limit exceeded) @ 0 (0) ---
+++ killed by SIGXFSZ +++


Jeff Dike wrote:

> dbahi@enterasys.com said:
> 
>>btw: with the 26-3um and 2.6.8.1 announce Jeff mentions the new SKAS,
>>! TT, STATIC allows mem= ~2.75G upper limit but do we need O_LARGEFILE
>>somewhere? or to compile with -D_FILE_OFFSET_64_BITS 
> 
> 
> Probably.  Can you strace that and see where E2BIG is coming from?
> 
> 				Jeff
> 


--------------enig0A49B6213A909D7B3D94AD38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBJJcC3XQ4zakZ3z4RAi7qAJ97AVergwz/6f346DePh4IEom4AmgCfUnX/
4KoOOCYz5uNc8hMqVatC2LM=
=S0LZ
-----END PGP SIGNATURE-----

--------------enig0A49B6213A909D7B3D94AD38--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
