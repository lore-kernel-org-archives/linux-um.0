Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xSGU-0000Nm-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 07:17:42 -0700
Received: from home.linuxhacker.ru ([194.67.236.68] helo=linuxhacker.ru)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xSGU-0002su-09
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 07:17:42 -0700
Message-Id: <200309111413.h8BEDnvF019619@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] Kernel panic: I/O op mismatch
References: <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com> <200309091310.h89DAt2J002539@ccure.karaya.com> <20030909164152.GB7799@alcor.net> <3F5E057E.9030209@davidcoulson.net> <20030909170808.GC7799@alcor.net> <3F5E3295.1080004@davidcoulson.net> <200309111228.h8BCSOu9010164@car.linuxhacker.ru>
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
Date: Thu, 11 Sep 2003 18:13:50 +0400
To: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


Hello!

Oleg Drokin <green@linuxhacker.ru> wrote:
OD> Hello!

OD> David Coulson <david@davidcoulson.net> wrote:
>>> Host filesystem or UML filesystem?  Adam and I were both using ext2 inside
>>> UML when we spoke, and I'm using ext3 on the host side.
DC>> Sorry, filesystem was the wrong word to use - 'image file' is more accurate.
OD> That's how I reproduce it:

Ok, so the problem is a missed cast.
And the patch is below.

Bye,
    Oleg
--- arch/um/drivers/ubd_kern.c.orig	2003-09-11 16:49:48.000000000 +0400
+++ arch/um/drivers/ubd_kern.c	2003-09-11 18:12:10.861689280 +0400
@@ -1002,7 +1002,7 @@
 	}
 
         req->sector += ubd_part[minor].start_sect;
-	offset = req->sector << 9;
+	offset = (__u64)req->sector << 9;
 	len = req->current_nr_sectors << 9;
 
 	io_req->fds[0] = (dev->cow.file != NULL) ? dev->cow.fd : dev->fd;


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
