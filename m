Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNit-0008Gj-OR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:52:51 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BfNit-0003hP-6V for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:52:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [mgedmin@b4net.lt: Bug#256873: user-mode-linux: fails
	to start (kernel panic)]
References: <20040629182711.GM5243@alcor.net>
In-Reply-To: <20040629182711.GM5243@alcor.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u2b4AS/My3xqpiU"
Message-Id: <200406292106.22260.blaisorblade_spam@yahoo.it>
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
Date: Tue, 29 Jun 2004 21:06:22 +0200
To: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net
Cc: Marius Gedminas <mgedmin@b4net.lt>, 256873-forwarded@bugs.debian.org



--Boundary-00=_u2b4AS/My3xqpiU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 20:27, marted=EC 29 giugno 2004, Matt Zimmerman ha scritto:
> I am receiving many reports from my users that 2.4.26-1um is less
> functional than past versions, especially (but not exclusively) where
> hostfs is concerned.  Are others experiencing problems as well?  I am
> considering reverting the Debian packages to 2.4.24-1um, which was the la=
st
> version which was stable for me (it had only one frustrating hostfs bug,
> where readdir() would read forever).

I definitely agree. There are some bugfix from 2.4.24-2 to add there, but t=
hey=20
can wait for now (they are far less fatal). Also, the attached patch is=20
needed as forward-port to 2.4.26: use vanilla 2.4.26+ 2.4.24-1um + the=20
attached fixlet. Don't downgrade to the security-bugged 2.4.24/.25.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_u2b4AS/My3xqpiU
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

--Boundary-00=_u2b4AS/My3xqpiU--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
