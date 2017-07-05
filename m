Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dSsqj-0000PE-28
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 22:32:45 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSsqi-0004li-53
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 22:32:45 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu,  6 Jul 2017 00:32:33 +0200
Message-Id: <20170705223233.10492-1-thomas@m3y3r.de>
Subject: [uml-devel] [PATCH 1/3] um: stub-data.h: remove superfluous include
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
 arch/um/include/shared/skas/stub-data.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index a9deece..13f404e 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,8 +8,6 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
-#include <time.h>
-
 struct stub_data {
 	unsigned long offset;
 	int fd;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

