Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xo2I-00011N-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 06:32:30 -0700
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xo2H-0004XW-OJ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 06:32:29 -0700
Received: from [194.97.55.148] (helo=mx5.freenet.de)
	by mout0.freenet.de with asmtp (Exim 4.22)
	id 19xo2F-0000IA-QJ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:32:27 +0200
Received: from b2aea.pppool.de ([213.7.42.234] helo=home.petschge.de)
	by mx5.freenet.de with esmtp (Exim 4.22 #1)
	id 19xo2E-0007s8-FM
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:32:27 +0200
Received: from localhost (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 973343BCE5
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:30:31 +0200 (CEST)
Received: from mars (localhost.petschge.de [127.0.0.1])
	by home.petschge.de (Postfix on Linux (i386)) with ESMTP id 3A25B3BCE4
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:30:28 +0200 (CEST)
Content-Type: text/plain; charset="iso-8859-15"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
MIME-Version: 1.0
Message-Id: <200309121530.27560.petschge@gmx.de>
Subject: [uml-devel] Re: 2.6.0 uptime bug
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Sep 2003 15:30:27 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

> Ok 2.6.0-test5 gives the correct uptime on i386 and the wrong huge
> uptime as uml. My patch doesn't break anything on i386 but I'm going
> to fix this bug in the uml part of the kernel.

Finally I found the very bug itself. wall_to_monotonic is not=20
initialised correctly on uml. The following patch fixes this:

-----

--- ./arch/um/kernel/time.c.orig        Fri Sep 12 15:19:21 2003
+++ ./arch/um/kernel/time.c     Fri Sep 12 15:14:57 2003
@@ -19,6 +19,10 @@

 extern struct timeval xtime;

+extern struct timespec wall_to_monotonic;
+
+struct timespec now;
+
 struct timeval local_offset =3D { 0, 0 };

 void timer(void)
@@ -84,6 +88,10 @@
        if(signal(SIGVTALRM, boot_timer_handler) =3D=3D SIG_ERR)
                panic("Couldn't set SIGVTALRM handler");
        set_interval(ITIMER_VIRTUAL);
+
+       do_posix_clock_monotonic_gettime(&now);
+       wall_to_monotonic.tv_sec =3D -now.tv_sec;
+       wall_to_monotonic.tv_nsec =3D -now.tv_nsec;
 }

 void do_gettimeofday(struct timeval *tv)
-----

The wrong setup of wall_to_monotonic makes the bug arch-dependant. I=20
finally found this when I compared a linux-2.6.0-test5  running as uml=20
to a linux-2.6.0-test5 running inside a vmware. This patch is far less=20
intrusive than the patch I posted September 6th.

mfg,
Patrick "Petschge" Kilian

--=20
Morgens wollte sie ihn sp=FCren, mit den Lippen zart ber=FChren,
...und zum blasen heranzuf=FChren, heiss floss es in sie hinein.
Ja so ein Kaffe. Der ist fein



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
