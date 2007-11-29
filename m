Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ixkfw-0007Qg-5A for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 06:47:36 -0800
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ixkfu-0000gX-Sd
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 06:47:36 -0800
Received: by wa-out-1112.google.com with SMTP id k22so2378316waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Nov 2007 06:47:34 -0800 (PST)
Message-ID: <ea9232d10711290647q284f5cf7w94858828b4e7230c@mail.gmail.com>
Date: Thu, 29 Nov 2007 15:47:34 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: Fix stopping uml via mconsole.
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[I forgot to cc the uml-devel list while sending the patch.]

This patch brings back the functionality of stopping user mode linux
with the help of mconsole.

I tested it for six hours and read the code which could be impacted by
this change, so it should work fine, but I am very inexperienced and
new to the kernel and C, so I could have made a mistake somewhere.

I had two ideas, and this one was the less invasive of the two. If
this is not the right way to fix this, I can send in my second idea in
a few days.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---

diff -rupN orig/arch/um/drivers/mconsole_user.c
linux-2.6.24-rc3-mm2/arch/um/drivers/mconsole_user.c
--- orig/arch/um/drivers/mconsole_user.c        2007-11-29
15:11:56.000000000 +0100
+++ linux-2.6.24-rc3-mm2/arch/um/drivers/mconsole_user.c        2007-11-28
21:39:04.000000000 +0100
@@ -83,9 +83,8 @@ int mconsole_get_request(int fd, struct
       int len;

       req->originlen = sizeof(req->origin);
-       req->len = recvfrom(fd, &req->request, sizeof(req->request),
-                           MSG_DONTWAIT, (struct sockaddr *) req->origin,
-                           &req->originlen);
+       req->len = recvfrom(fd, &req->request, sizeof(req->request), 0,
+                           (struct sockaddr *) req->origin, &req->originlen);
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
