Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzhEx-0000Bt-0K for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 15:31:47 -0800
Received: from ruby.spiritone.com ([216.99.193.130])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IzhEv-0003r8-Lh
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 15:31:46 -0800
Received: from [192.168.0.4] (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by ruby.spiritone.com (8.13.6/8.13.4) with ESMTP id lB4NVfJI003039
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 4 Dec 2007 15:31:43 -0800
Message-ID: <4755E360.4030505@BitWagon.com>
Date: Tue, 04 Dec 2007 15:31:44 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050003010809050003030607"
Subject: [uml-devel] reading uninit memory in do_io (ubd_kern.c)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050003010809050003030607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Function do_io() in arch/um/drivers/ubd_kern.c can read uninitialized memory
when scanning the .sector_mask.  During startup the maximum .length
is 64K (and has been observed), so 128 bits are needed [512-byte sectors.]
Initialized .sector_mask has 32 bits, and initialized .cow_offset has 64,
so 32 bits must come from .bitmap_words[0]; but .bitmap_words is not
initialized by prepare_request().

If .fds[0]==.fds[1], as it is in early startup, then the net effect
of scanning the uninit .bitmap_words[0] is "merely" a randomness and
possible slowdown in I/O operations, which is better to avoid anyway.

Either call blk_queue_max_sectors() much earlier (and always) in order
to restrict all transfers to at most 32 [or 96] sectors, else apply
the attached patch to clear .bitmap_words[0].

-- 
John Reiser, jreiser@BitWagon.com


--------------050003010809050003030607
Content-Type: text/x-patch;
 name="ubd_kern.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ubd_kern.c.patch"

--- linux-2.6.23/arch/um/drivers/ubd_kern.c	2007-12-04 14:49:28.000000000 -0800
+++ new/arch/um/drivers/ubd_kern.c	2007-12-04 14:55:32.000000000 -0800
@@ -1069,6 +1069,12 @@
 	io_req->length = len;
 	io_req->error = 0;
 	io_req->sector_mask = 0;
+/* At startup, the maximum .length is 64K, and blk_queue_max_sectors()
+ * has not been called yet.  So do_io() could require 64K/(1<<9) = 128 bits:
+ * 32 in sector_mask, 64 in cow_offset, 32 in bitmap_words[0].
+ * 2007-12-04 jreiser (valgrind/memcheck)
+ */
+	io_req->bitmap_words[0] = 0;
 
 	io_req->op = (rq_data_dir(req) == READ) ? UBD_READ : UBD_WRITE;
 	io_req->offsets[0] = 0;


--------------050003010809050003030607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--------------050003010809050003030607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------050003010809050003030607--

