Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@brocade.com>) id 1ZvRQd-0000fy-TG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 14:58:47 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZvRQc-0003xd-P5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 14:58:47 +0000
From: Anton Ivanov <aivanov@brocade.com>
Date: Sun,  8 Nov 2015 14:58:22 +0000
Message-Id: <1446994702-21240-1-git-send-email-aivanov@brocade.com>
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
Subject: [uml-devel] [PATCH] Missing includes in start up
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <aivanov@brocade.com>

Modifying RLIMIT requires including sys/time.h and sys/resource.h

Signed-off-by: Anton Ivanov <aivanov@brocade.com>
---
 arch/um/os-Linux/start_up.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 425162e..c1811df 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -16,6 +16,8 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include "init.h"
 #include "os.h"
 #include "mem_user.h"
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

