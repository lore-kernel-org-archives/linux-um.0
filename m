Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg5GB-0002yR-Tk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 10:22:07 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bg5GB-0004GI-4v for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 10:22:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problems compiling 2.4 kernel
References: <s0e3cb9d.082@ORANGE.OUS.EDU>
	<200407011643.i61GhRl9002573@ccure.user-mode-linux.org>
In-Reply-To: <200407011643.i61GhRl9002573@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LuE5AERzZGIbun0"
Message-Id: <200407011936.11144.blaisorblade_spam@yahoo.it>
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
Date: Thu, 1 Jul 2004 19:36:11 +0200
To: Jeff Dike <jdike@addtoit.com>, Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_LuE5AERzZGIbun0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 18:43, gioved=EC 1 luglio 2004, Jeff Dike ha scritto:
> Anthony_Brock@ous.edu said:

The problem is another: uml Makefile don't manage properly the=20
include/asm/arch symlink, and it is not created:

> asm/arch/posix_types.h: No such file or directory
To workaround this:
cd include
<make sure that asm points to asm-um>
cd asm
ln -s ../asm-i386 arch

There is a lot of other people claiming similar problems. For instance,=20
somebody else complained that to build UML he must avoid doing "make mrprop=
er=20
ARCH=3Dum" because some files are not recreated (with 2.4.24-3).

However, Anthony, I would recommend using, for optimal stability, a 2.4.26=
=20
vanilla kernel patched with 2.4.24-1um + the attached patch.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_LuE5AERzZGIbun0
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-2.4.26-cmpxchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml-2.4.26-cmpxchg.patch"

--- linux-2.4.26/include/asm-um/system-i386.h	Wed Apr 21 15:33:45 2004
+++ linux-2.4.26-umlfix/include/asm-um/system-i386.h	Wed Apr 21 15:27:14 2004
@@ -5,35 +5,4 @@
 
 #define __HAVE_ARCH_CMPXCHG 1
 
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
-{
-	unsigned long prev;
-	switch (size) {
-	case 1:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 2:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 4:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	}
-	return old;
-}
-
-#define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-    
 #endif

--Boundary-00=_LuE5AERzZGIbun0--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
