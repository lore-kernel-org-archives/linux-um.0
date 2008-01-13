Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JE2ay-0000wG-3v for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 05:09:48 -0800
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JE2ax-00027i-N6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 05:09:48 -0800
Received: by rv-out-0910.google.com with SMTP id g11so4884235rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 13 Jan 2008 05:09:47 -0800 (PST)
Message-ID: <478A0D9F.90207@finnie.org>
Date: Sun, 13 Jan 2008 05:09:51 -0800
From: Ryan Finnie <ryan@finnie.org>
MIME-Version: 1.0
References: <4789C771.5070100@finnie.org> <478A0C0C.9030503@finnie.org>
In-Reply-To: <478A0C0C.9030503@finnie.org>
Subject: Re: [uml-devel] [RFC PATCH] SKAS3 for 2.6.24-rc7 (2nd try)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1394356658=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1394356658==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE71F5E91B73FE075B71575C4"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE71F5E91B73FE075B71575C4
Content-Type: multipart/mixed; boundary="------------080803020505030901090108"

This is a multi-part message in MIME format.
--------------080803020505030901090108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Oh, and it appears that with a little glue (attached), the SKAS3 and
SKAS4 patches can co-exist.  I currently have a host running with both
SKAS3 and SKAS4 guests running on it.  And if you apply SKAS3, SKAS4 and
the glue to a guest, it should be able to run on SKAS3 or SKAS4 hosts
(with SKAS4 being preferred if the host has both SKAS3 and SKAS4).

Repeating Jeff's warning about SKAS4: "This is very experimental at this
point.  Don't let it near anything resembling a production system."
(Though SKAS4 has been working quite well for me in testing.)

RF

 arch/x86/ia32/ptrace32.c     |    4 ++--
 arch/x86/kernel/ptrace_32.c  |    2 +-
 arch/x86/kernel/ptrace_64.c  |    2 +-
 include/asm-x86/ptrace-abi.h |    2 +-
 include/asm-x86/ptrace.h     |    2 +-
 mm/proc_mm.c                 |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)


--------------080803020505030901090108
Content-Type: text/x-patch;
 name="2.6.24-rc7-skas3-skas4-glue.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="2.6.24-rc7-skas3-skas4-glue.patch"

diff -ruN linux-2.6.24-rc7.a/arch/x86/ia32/ptrace32.c linux-2.6.24-rc7.b/=
arch/x86/ia32/ptrace32.c
--- linux-2.6.24-rc7.a/arch/x86/ia32/ptrace32.c	2008-01-13 04:07:30.00000=
0000 -0800
+++ linux-2.6.24-rc7.b/arch/x86/ia32/ptrace32.c	2008-01-13 04:06:23.00000=
0000 -0800
@@ -273,7 +273,7 @@
 	case PTRACE_EX_FAULTINFO:
 	case PTRACE_FAULTINFO:
 	case PTRACE_LDT:
-	case PTRACE_SWITCH_MM:
+	case OLD_PTRACE_SWITCH_MM:
 #endif
 		break;
=20
@@ -433,7 +433,7 @@
 		break;
 	}
=20
-	case PTRACE_SWITCH_MM: {
+	case OLD_PTRACE_SWITCH_MM: {
 		struct mm_struct *old =3D child->mm;
 		struct mm_struct *new =3D proc_mm_get_mm(data);
=20
diff -ruN linux-2.6.24-rc7.a/arch/x86/kernel/ptrace_32.c linux-2.6.24-rc7=
=2Eb/arch/x86/kernel/ptrace_32.c
--- linux-2.6.24-rc7.a/arch/x86/kernel/ptrace_32.c	2008-01-13 04:07:30.00=
0000000 -0800
+++ linux-2.6.24-rc7.b/arch/x86/kernel/ptrace_32.c	2008-01-13 04:06:23.00=
0000000 -0800
@@ -647,7 +647,7 @@
 		break;
 	}
=20
-	case PTRACE_SWITCH_MM: {
+	case OLD_PTRACE_SWITCH_MM: {
 		struct mm_struct *old =3D child->mm;
 		struct mm_struct *new =3D proc_mm_get_mm(data);
=20
diff -ruN linux-2.6.24-rc7.a/arch/x86/kernel/ptrace_64.c linux-2.6.24-rc7=
=2Eb/arch/x86/kernel/ptrace_64.c
--- linux-2.6.24-rc7.a/arch/x86/kernel/ptrace_64.c	2008-01-13 04:07:30.00=
0000000 -0800
+++ linux-2.6.24-rc7.b/arch/x86/kernel/ptrace_64.c	2008-01-13 04:06:23.00=
0000000 -0800
@@ -601,7 +601,7 @@
 		break;
 	}
=20
-	case PTRACE_SWITCH_MM: {
+	case OLD_PTRACE_SWITCH_MM: {
 		struct mm_struct *old =3D child->mm;
 		struct mm_struct *new =3D proc_mm_get_mm64(data);
=20
diff -ruN linux-2.6.24-rc7.a/include/asm-x86/ptrace-abi.h linux-2.6.24-rc=
7.b/include/asm-x86/ptrace-abi.h
--- linux-2.6.24-rc7.a/include/asm-x86/ptrace-abi.h	2008-01-13 04:07:30.0=
00000000 -0800
+++ linux-2.6.24-rc7.b/include/asm-x86/ptrace-abi.h	2008-01-13 04:06:23.0=
00000000 -0800
@@ -68,7 +68,7 @@
 #define PTRACE_FAULTINFO 52
 /* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
 #define PTRACE_LDT 54
-#define PTRACE_SWITCH_MM 55
+#define OLD_PTRACE_SWITCH_MM 55
 #define PTRACE_EX_FAULTINFO	  56
=20
 #define PTRACE_OLDSETOPTIONS      21
diff -ruN linux-2.6.24-rc7.a/include/asm-x86/ptrace.h linux-2.6.24-rc7.b/=
include/asm-x86/ptrace.h
--- linux-2.6.24-rc7.a/include/asm-x86/ptrace.h	2008-01-13 04:07:30.00000=
0000 -0800
+++ linux-2.6.24-rc7.b/include/asm-x86/ptrace.h	2008-01-13 04:06:23.00000=
0000 -0800
@@ -146,7 +146,7 @@
 #define PTRACE_FAULTINFO	  52
 /* 53 was used for PTRACE_SIGPENDING, don't reuse it. */
 #define PTRACE_LDT		  54
-#define PTRACE_SWITCH_MM 	  55
+#define OLD_PTRACE_SWITCH_MM 	  55
 #define PTRACE_EX_FAULTINFO	  56
=20
 struct ptrace_faultinfo {
diff -ruN linux-2.6.24-rc7.a/mm/proc_mm.c linux-2.6.24-rc7.b/mm/proc_mm.c=

--- linux-2.6.24-rc7.a/mm/proc_mm.c	2008-01-13 04:07:30.000000000 -0800
+++ linux-2.6.24-rc7.b/mm/proc_mm.c	2008-01-13 04:06:23.000000000 -0800
@@ -32,7 +32,7 @@
 }
=20
 /*
- * This is to be used in PTRACE_SWITCH_MM handling. We are going to set
+ * This is to be used in OLD_PTRACE_SWITCH_MM handling. We are going to =
set
  * child->mm to new, and we must first correctly set new->dumpable.
  * Since we take task_lock of child and it's needed also by the caller, =
we
  * return with it locked.

--------------080803020505030901090108--

--------------enigE71F5E91B73FE075B71575C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHig2kKZYQqSA+yiURAkJ4AJ9iCzRBnbBOZAjTkq+0hDXD7RLjTwCfScRT
xLRdTQwJNie6Ay0LJNiSf+U=
=TSAQ
-----END PGP SIGNATURE-----

--------------enigE71F5E91B73FE075B71575C4--


--===============1394356658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1394356658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1394356658==--

