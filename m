Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtWHw-0000zJ-QD
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:19:12 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AtW5u-00014S-1A
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:06:46 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] syscall sysinfo error
References: <20040215163513.GA26606@neo.wh-stuttgart.de>
In-Reply-To: <20040215163513.GA26606@neo.wh-stuttgart.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Bh4MAOOdC0HhJKe"
Message-Id: <200402181644.01093.blaisorblade_spam@yahoo.it>
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
Date: Wed, 18 Feb 2004 16:44:01 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Martin =?iso-8859-15?q?Thei=DF?= <mtheiss@neo.wh-stuttgart.de>



--Boundary-00=_Bh4MAOOdC0HhJKe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 17:35, domenica 15 febbraio 2004, Martin Thei=DF ha scritto:
> recently i tried to run debian-installer on a 2.6.2 uml kernel.
> it didn't
> work. i determined the problem has to be the syscall sysinfo. it return
> zeroed values for totalram and totalswap.
0 for total swap is correct in your case, since you do not enable a swap; 0=
=20
for total ram is wrong but has been fixed in the official Uml patch 2.6.3-r=
c2=20
(it seems that it applies well onto 2.6.2; there are two rejects which must=
=20
be ignored). Or better: the patch fixes the 0 value for totalRam in=20
/proc/meminfo; that should fix also the sysinfo value, but if it does not,=
=20
just complain again.

If you want to use patch 2.6.1, apply the attached patch on top of that to =
fix=20
things.

>
> Is this a general problem of uml or is it a problem of busybox, which is
> using this method to determine the amount of free memory?
A uml 2.6 (now fixed) bug, which creates problem to anything using this=20
(correct) method. It also caused ps u to crash for a division by 0.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_Bh4MAOOdC0HhJKe
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="C-07-Ps_crash_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="C-07-Ps_crash_fix.patch"

--- 1.21/arch/um/kernel/mem.c   Thu Jan  8 07:43:01 2004
+++ edited/arch/um/kernel/mem.c Mon Jan 26 11:02:13 2004
@@ -30,7 +30,6 @@
 int kmalloc_ok = 0;
 
 static unsigned long brk_end;
-static unsigned long totalram_pages = 0;
 
 void unmap_physmem(void)
 {

--Boundary-00=_Bh4MAOOdC0HhJKe--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
