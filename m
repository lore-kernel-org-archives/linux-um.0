Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bt9oA-0005Q8-RQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Aug 2004 11:51:14 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bt9oA-0008IV-EO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Aug 2004 11:51:14 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i76Ip5ao012638
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 6 Aug 2004 14:51:05 -0400 (EDT)
Message-ID: <4113D318.2030407@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDDDF8AAB51F04BC62251EFC6"
Subject: [uml-devel] corrections to 2.4 series incrementals: fix-smp
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
Date: Fri, 06 Aug 2004 14:51:04 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDDF8AAB51F04BC62251EFC6
Content-Type: multipart/mixed; boundary="------------090603010400090104020908"

This is a multi-part message in MIME format.
--------------090603010400090104020908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

patches to patches ? or, developers can figure this out....

this is a corrected version of the fix-smp patch found on:

   http://user-mode-linux.sourceforge.net/patches.html

The line in the available patch incorrectly adds this line:

  define_bool CONFIG_SMP $CONFIG_UML_SMP

And thus it fails to apply.


--------------090603010400090104020908
Content-Type: text/plain;
 name="fix-smp.clean"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-smp.clean"

--- linux-2.4.26_uml-patch-2.4.26-2um.orig/arch/um/config.in	2004-08-01 07:52:46.000000000 -0400
+++ linux-2.4.26_uml-patch-2.4.26-2um_incrementals/arch/um/config.in	2004-08-03 13:40:30.000000000 -0400
@@ -49,8 +49,13 @@
 bool 'Management console' CONFIG_MCONSOLE
 dep_bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ $CONFIG_MCONSOLE
 bool '2G/2G host address space split' CONFIG_HOST_2G_2G
+
 bool 'Symmetric multi-processing support' CONFIG_UML_SMP
 define_bool CONFIG_SMP $CONFIG_UML_SMP
+if [ "$CONFIG_SMP" = "y" ]; then
+    int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
+fi
+
 int 'Nesting level' CONFIG_NEST_LEVEL 0
 int 'Kernel address space size (in .5G units)' CONFIG_KERNEL_HALF_GIGS 1
 bool 'Highmem support' CONFIG_HIGHMEM

--------------090603010400090104020908--

--------------enigDDDF8AAB51F04BC62251EFC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBE9MY3XQ4zakZ3z4RAiS7AJ0bgZyDJE4sk9NXusC4wAWSp1eYAACfbylG
XYe6w3mSlNznrJQwDTH84Yw=
=TqLu
-----END PGP SIGNATURE-----

--------------enigDDDF8AAB51F04BC62251EFC6--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
