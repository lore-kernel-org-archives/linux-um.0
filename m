Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Mon, 21 Jul 2008 11:46:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080721154658.GA6860@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Fix for 2.6.26 ptrace crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Peter Teoh <htmldeveloper@gmail.com>, Boaz Harrosh <bharrosh@panasas.com>, David Shane Holden <dpejesh@yahoo.com>, "david.r" <david.r@seznam.cz>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>

I believe I figured out the ptrace crash that showed up with 2.6.26,
thanks to Toralf F=F6rster.

The patch is below.

I have one confirmation that this fixes the problem - I'd like a few
more just to be sure.

			Jeff

-- =

Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/include/init.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.orig/arch/um/include/init.h	2008-02-18 11:53:50.000000000 =
-0500
+++ linux-2.6.22/arch/um/include/init.h	2008-07-20 18:06:35.000000000 -0400
@@ -45,6 +45,8 @@ typedef void (*exitcall_t)(void);
 # define __section(S) __attribute__ ((__section__(#S)))
 #endif
 =

+#if __GNUC__ =3D=3D 3
+
 #if __GNUC_MINOR__ >=3D 3
 # define __used			__attribute__((__used__))
 #else
@@ -52,6 +54,12 @@ typedef void (*exitcall_t)(void);
 #endif
 =

 #else
+#if __GNUC__ =3D=3D 4
+# define __used			__attribute__((__used__))
+#endif
+#endif
+
+#else
 #include <linux/compiler.h>
 #endif
 /* These are for everybody (although not all archs will actually

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
