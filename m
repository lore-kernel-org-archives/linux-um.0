Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dTPOe-0005c0-BR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:17:56 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dTPOd-0001GK-1O
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:17:56 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri,  7 Jul 2017 11:17:31 +0200
Message-Id: <20170707091731.20147-1-thomas@m3y3r.de>
In-Reply-To: <20170706210543.18885-1-thomas@m3y3r.de>
References: <20170706210543.18885-1-thomas@m3y3r.de>
Subject: [uml-devel] [PATCH] um: v2: Use generic NOTES macro
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
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
To: user-mode-linux-devel@lists.sourceforge.net

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/include/asm/common.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 133055311dce..9e6d5997cfc4 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -15,7 +15,7 @@
   PROVIDE (_unprotected_end = .);
 
   . = ALIGN(4096);
-  .note : { *(.note.*) }
+  NOTES
   EXCEPTION_TABLE(0)
 
   BUG_TABLE
-- 
2.13.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

