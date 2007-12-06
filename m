Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J0KBS-0005lE-SH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 09:06:47 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J0KBR-0004rO-AF
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 09:06:46 -0800
Date: Thu, 6 Dec 2007 12:06:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071206170641.GA7440@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/6] UML - fix mconsole stop
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Karol Swietlicki <magotari@gmail.com>

From: Karol Swietlicki <magotari@gmail.com>

This patch brings back the functionality of stopping user mode linux
with the help of mconsole.

[ jdike - the bug being fixed is that the mconsole file descriptor is
already set O_NONBLOCK or not, depending on whether we want no
blocking (the normal case) or we want blocking (when an mconsole stop
is in effect), so the MSG_DONTWAIT is redundant in the normal case,
and wrong when we want to block. ]

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/mconsole_user.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.22/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/mconsole_user.c	2007-12-05 10:49:25.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/mconsole_user.c	2007-12-05 12:21:05.000000000 -0500
@@ -83,9 +83,8 @@ int mconsole_get_request(int fd, struct 
 	int len;
 
 	req->originlen = sizeof(req->origin);
-	req->len = recvfrom(fd, &req->request, sizeof(req->request),
-			    MSG_DONTWAIT, (struct sockaddr *) req->origin,
-			    &req->originlen);
+	req->len = recvfrom(fd, &req->request, sizeof(req->request), 0,
+			    (struct sockaddr *) req->origin, &req->originlen);
 	if (req->len < 0)
 		return 0;
 

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
