Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzXTU-0008N7-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 02:20:16 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BzXTQ-0004G8-S7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Aug 2004 02:20:14 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] gdkfb
Message-ID: <20040824091116.GA1138@bytesex>
References: <Pine.LNX.4.58.0408021210420.23627@anakin>
	<87isb9yjfj.fsf@bytesex.org>
	<Pine.LNX.4.58.0408232116540.13834@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408232116540.13834@anakin>
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
Date: Tue, 24 Aug 2004 11:11:16 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

> That's indeed simple. Have you tried running on X with depth 24?

Looks much better now, hope I didn't broke 16 bpp ;)

  Gerd

--- arch/um/drivers/x11_user.c~	2004-08-23 14:56:49.000000000 +0200
+++ arch/um/drivers/x11_user.c	2004-08-24 11:06:44.286858589 +0200
@@ -233,7 +233,7 @@
 	if (0 == n)
 		goto fail_free;
 	win->vi = info[0];
-	bytes_pp = (win->vi.depth+7)/8;
+//	bytes_pp = (win->vi.depth+7)/8;
 	XFree(info);
 	if (win->vi.class != TrueColor && win->vi.class != DirectColor)
 		goto fail_free;
@@ -246,6 +246,7 @@
 				      width, height);
 	if (NULL == win->ximage)
 		goto shm_error;
+	bytes_pp = win->ximage->bitmap_pad/8;
 	win->shminfo.shmid = shmget(IPC_PRIVATE,
 				    win->ximage->bytes_per_line * win->ximage->height,
 				    IPC_CREAT | 0777);


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
