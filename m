Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bz4vm-00057V-Qx for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 19:51:34 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bz4vl-0001US-1f for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 19:51:34 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i7N2pNao018007
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Aug 2004 22:51:23 -0400 (EDT)
Message-ID: <41295BAD.2030306@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: [PATCH] Re: [uml-devel] mem= and large file support
References: <412415B0.5060102@enterasys.com>
	<200408190603.i7J63Zek004748@ccure.user-mode-linux.org>
	<412496FC.4090101@enterasys.com>
In-Reply-To: <412496FC.4090101@enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2EB0833027FB434FF264EAF4"
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
Date: Sun, 22 Aug 2004 22:51:25 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2EB0833027FB434FF264EAF4
Content-Type: multipart/mixed; boundary="------------040801000302070409080309"

This is a multi-part message in MIME format.
--------------040801000302070409080309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

yep that does it. here's the simple patch. and proof ;)

joy

linux umid=uml_1 mem=2176M root=/dev/ubd/0 \
ubd0=/local/umltest/cow/ubd0_1,/local/dbahi/root_fs.mv-31 \
ubd1=/local/umltest/cow/ubd1_1,/local/dbahi/swap_fs.256 \
uml_dir=/local/umltest/umldir hostfs=/local/umltest/hostfs/host_1 \
eth0=daemon,fe:fd:00:00:00:1,unix,/local/umltest/pipe

...

root@(none):~# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  2230177792 17244160 2212933632        0   466944  3371008
Swap:        0        0        0
MemTotal:      2177908 kB
MemFree:       2161068 kB
MemShared:           0 kB
Buffers:           456 kB
Cached:           3292 kB
SwapCached:          0 kB
Active:           2032 kB
Inactive:         2428 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      2177908 kB
LowFree:       2161068 kB
SwapTotal:           0 kB
SwapFree:            0 kB

D. Bahi wrote:

> cool - so... it's in tempfile.c : 53
> make_tempfile calls mkstemp -
> 
> so maybe a build option required to get the
> option in with this library call? but which?
> 
> info on libc says:
> 
>      When the sources are compiled with `_FILE_OFFSET_BITS == 64' on a
>      32-bit system this function is in fact `tmpfile64', i.e. the LFS
>      interface transparently replaces the old interface.
> 
> so i'll try that.
> 
> and just for 'create_mem_file' completeness
> the devanon case doesn't need attention with
> the mmap. right?
> 
> -----
> 
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM], [ALRM VTALRM IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [IO], NULL, 8) = 0
> gettimeofday({1092914208, 599204}, NULL) = 0
> getpid()                                = 24405
> open("/tmp/vm_file-3NJodS", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
> unlink("/tmp/vm_file-3NJodS")           = 0
> fchmod(3, 0777)                         = 0
> _llseek(3, 2147483648, [2147483648], SEEK_SET) = 0
> write(3, "\0", 1)                       = -1 EFBIG (File too large)
> --- SIGXFSZ (File size limit exceeded) @ 0 (0) ---
> +++ killed by SIGXFSZ +++
> 
> 
> Jeff Dike wrote:
> 
>> dbahi@enterasys.com said:
>>
>>> btw: with the 26-3um and 2.6.8.1 announce Jeff mentions the new SKAS,
>>> ! TT, STATIC allows mem= ~2.75G upper limit but do we need O_LARGEFILE
>>> somewhere? or to compile with -D_FILE_OFFSET_64_BITS 
>>
>>
>>
>> Probably.  Can you strace that and see where E2BIG is coming from?
>>
>>                 Jeff
>>
> 

-- 
db

--------------040801000302070409080309
Content-Type: text/x-diff;
 name="gt2Mwohighmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gt2Mwohighmem.patch"

--- arch/um/Makefile@@/main/patch_kernel.org/patch_linux_kernel_uml_2.4.26/3	2004-08-13 22:22:48.000000000 -0400
+++ arch/um/Makefile	2004-08-22 22:34:08.000000000 -0400
@@ -51,7 +51,7 @@
 
 CFLAGS += $(ARCH_CFLAGS) $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
 	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
-	$(MODE_INCLUDE)
+	$(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
 
 check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 

--------------040801000302070409080309--

--------------enig2EB0833027FB434FF264EAF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBKVut3XQ4zakZ3z4RAiKrAJ9Wm6BvezAzs61yCs7O4RI5xVkbNACcDW0F
VOywpmV0HAX/UgqkKr2P2ZY=
=zXut
-----END PGP SIGNATURE-----

--------------enig2EB0833027FB434FF264EAF4--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
