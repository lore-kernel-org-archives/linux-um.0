Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1YwVt7-00015I-1a
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 13:24:21 +0000
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YwVt3-0007RA-Df
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 13:24:21 +0000
Received: by wicmc15 with SMTP id mc15so22716606wic.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 24 May 2015 06:24:11 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Sun, 24 May 2015 15:23:54 +0200
Message-Id: <1432473834-26391-1-git-send-email-hwhilse@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] um: handle GCC 5.x like GCC 4.x
To: user-mode-linux-devel@lists.sourceforge.net

Compiler compatibility macros were conditionally defined based on
the compiler version. The it tested __GNUC__, but compared it to
a maximum value of 4, breaking compilation on now current GCC 5.x.
Thus, the check is extended to check for version 4.x and beyond.

Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
---
 arch/um/include/shared/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index b3906f8..ecdec48 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -54,7 +54,7 @@ typedef void (*exitcall_t)(void);
 #endif
 
 #else
-#if __GNUC__ == 4
+#if __GNUC__ >= 4
 # define __used			__attribute__((__used__))
 #endif
 #endif
-- 
2.4.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

