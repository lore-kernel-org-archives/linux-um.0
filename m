Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bt9t1-0006Pa-LQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Aug 2004 11:56:15 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bt9t1-0005PI-7M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Aug 2004 11:56:15 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i76Iu7ao012879
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 6 Aug 2004 14:56:07 -0400 (EDT)
Message-ID: <4113D445.3050104@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEF56A0735643AC14677A0D20"
Subject: [uml-devel] corrections to 2.4 series incrementals: multiple-includes
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
Date: Fri, 06 Aug 2004 14:56:05 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF56A0735643AC14677A0D20
Content-Type: multipart/mixed; boundary="------------090306050506020607010501"

This is a multi-part message in MIME format.
--------------090306050506020607010501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

patches to patches ? or, developers can figure this out....

this is a corrected version of the fix-smp patch found on:

   http://user-mode-linux.sourceforge.net/patches.html

The line in the available patch incorrectly attempts to patch
arch/um/os/drivers/ethertap_kern.c instead of um/os-Linux/drivers
(a clean tree):

And thus fails to apply completely.

--------------090306050506020607010501
Content-Type: text/plain;
 name="multiple-includes.clean"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="multiple-includes.clean"

--- linux-2.4.26_uml-patch-2.4.26-2um.orig/arch/um/kernel/frame_kern.c	2004-08-01 07:52:46.000000000 -0400
+++ linux-2.4.26_uml-patch-2.4.26-2um_incrementals/arch/um/kernel/frame_kern.c	2004-08-03 13:37:27.000000000 -0400
@@ -6,7 +6,6 @@
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
 #include "asm/signal.h"
-#include "asm/uaccess.h"
 #include "asm/ucontext.h"
 #include "frame_kern.h"
 #include "sigcontext.h"
--- linux-2.4.26_uml-patch-2.4.26-2um.orig/arch/um/os-Linux/drivers/ethertap_kern.c	2004-08-01 07:52:46.000000000 -0400
+++ linux-2.4.26_uml-patch-2.4.26-2um_incrementals/arch/um/os-Linux/drivers/ethertap_kern.c	2004-08-03 13:38:02.000000000 -0400
@@ -8,7 +8,6 @@
 #include "linux/init.h"
 #include "linux/netdevice.h"
 #include "linux/etherdevice.h"
-#include "linux/init.h"
 #include "net_kern.h"
 #include "net_user.h"
 #include "etap.h"

--------------090306050506020607010501--

--------------enigEF56A0735643AC14677A0D20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBE9RF3XQ4zakZ3z4RArsaAJ9aoDqJZxFrQnWvSp9GRbBFdi4ZzwCfUUlX
t7hBLNXlgpJRJJfguhuuQHQ=
=lkKC
-----END PGP SIGNATURE-----

--------------enigEF56A0735643AC14677A0D20--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
