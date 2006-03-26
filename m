Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNaIy-0000z6-Fz for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 10:49:36 -0800
Received: from moutng.kundenserver.de ([212.227.126.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FNaIu-0000yq-KG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 10:49:36 -0800
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1FNaIo-00046F-00 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 20:49:26 +0200
Received: from [84.58.132.181] (helo=gate.lan.gerd-stolpmann.de)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1FNaIo-00026M-00 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 20:49:26 +0200
Received: from flakew.lan.gerd-stolpmann.de (flakew.lan.gerd-stolpmann.de
	[192.168.0.32])
	by gate.lan.gerd-stolpmann.de (Postfix) with ESMTP id DED1DC094
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Mar 2006 20:49:25 +0200 (CEST)
From: Gerd Stolpmann <info@gerd-stolpmann.de>
Content-Type: text/plain
Message-Id: <1143398965.11224.146.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Integer overflows in new AIO ubd driver
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
Date: Sun, 26 Mar 2006 20:49:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I recently tried to benchmark the new AIO-based ubd driver (including
O_DIRECT), and ran into serious problems with filesystems > 4GB. I think
I found the problem; two overflows in ubd_kern.c (see patch).

My test system was 2.6.16 plus all patches from user-mode-linux.sf.net
minus no_cow_odirect. Symptoms were that ext3 complained that it was
tried to write blocks into the system zone, and switched the filesystem
to r/o.

I also experienced (hard) lockups when doing lots of I/O. But this seems
to be unrelated to this problem (but who knows).

Gerd

--- linux-2.6.16/arch/um/drivers/ubd_kern.c.orig        2006-03-26 16:57:11.000000000 +0200
+++ linux-2.6.16/arch/um/drivers/ubd_kern.c     2006-03-26 18:16:02.000000000 +0200
@@ -1228,7 +1228,7 @@ static void do_ubd_request(request_queue
                while(dev->start_sg < dev->end_sg){
                        struct scatterlist *sg = &dev->sg[dev->start_sg];

-                       prepare_request(req, &io_req, req->sector << 9,
+                       prepare_request(req, &io_req, (unsigned long long) req->sector << 9,
                                        sg->offset, sg->length, sg->page);

                        if(do_io(&io_req, req, dev) == -EAGAIN)
@@ -1573,7 +1573,7 @@ static int do_io(struct io_thread_req *r
                }

                off = req->offsets[bit] + req->offset +
-                       start * req->sectorsize;
+                       (unsigned long long) start * req->sectorsize;
                len = (end - start) * req->sectorsize;
                buf = &req->buffer[start * req->sectorsize];




-- 
------------------------------------------------------------
Gerd Stolpmann * Viktoriastr. 45 * 64293 Darmstadt * Germany 
gerd@gerd-stolpmann.de          http://www.gerd-stolpmann.de
Phone: +49-6151-153855                  Fax: +49-6151-997714
------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
