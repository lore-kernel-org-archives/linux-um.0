Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AaPLI-0008DT-DQ
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Dec 2003 17:03:40 -0800
Received: from externalmx.valinux.com ([198.186.202.147] helo=externalmx.vasoftware.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AaPAg-0000z7-8Q
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Dec 2003 16:52:42 -0800
Received: from mx11.sac.fedex.com ([199.81.193.118]:2884)
	by externalmx.vasoftware.com with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 4.24 #1 (Debian))
	id 1AaPA3-0008Jg-5K
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Dec 2003 16:52:03 -0800
Received: from inet04.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx11.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id hBS0onJw046085
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Dec 2003 18:50:49 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet04.prod.fedex.com (8.12.10/8.12.10) with ESMTP id hBS0olJl019327
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Dec 2003 18:50:48 -0600 (CST)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] UML build system: patch ready
In-Reply-To: <200312271933.17194.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0312280841170.2434@boston.corp.fedex.com>
References: <200312241943.37474.blaisorblade_spam@yahoo.it>
 <Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com>
 <1072468270.6872.13.camel@laptop-linux> <200312271933.17194.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 28 Dec 2003 08:50:10 +0800 (SGT)
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


On Sat, 27 Dec 2003, BlaisorBlade wrote:

> Alle 20:51, venerd=EC 26 dicembre 2003, Nigel Cunningham ha scritto:
>
> There is only one definition in the asm/ldt.h header: only the struct nam=
e has
> changed between 2.4 and 2.6. This is the only problem. Rename that struct=
 and
> you're done.
>
> > If you can get this sorted out (and tell me how), I may be able to get
> > software suspend [a bit closer to] working under UML. The lack of
> > support for modifying ldts was where I blocked when I briefly looked at
> > it a while ago.

Ok, here's my patches to make uml works. It seems to work even with
CONFIG_MODVERSIONS=3Dy.


"linux" (host) .config
	CONFIG_MODVERSIONS=3Dy
	CONFIG_PROC_MM=3Dy


"guest" (uml) .config
	CONFIG_MODVERSIONS=3Dy
	CONFIG_MODE_SKAS=3Dy
	# CONFIG_PROC_MM is not set


I'll post the compile patch for a plain linux-2.6.0 next.

Thanks,
Jeff


--- uml/arch/um/sys-i386/bugs.c.org	Sat Dec 27 23:28:01 2003
+++ uml/arch/um/sys-i386/bugs.c	Sat Dec 27 23:29:19 2003
@@ -16,6 +16,9 @@

 #define MAXTOKEN 64

+extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
+
+
 /* Set during early boot */
 int host_has_cmov =3D 1;
 int host_has_xmm =3D 0;
@@ -107,7 +110,7 @@

 static void disable_lcall(void)
 {
-	struct modify_ldt_ldt_s ldt;
+	struct user_desc ldt;
 	int err;

 	bzero(&ldt, sizeof(ldt));


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
