Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KAJkM-0004Ix-8W for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 00:12:22 -0700
Received: from rv-out-0708.google.com ([209.85.198.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KAJkK-0000Le-GB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 00:12:22 -0700
Received: by rv-out-0708.google.com with SMTP id f25so6401583rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Jun 2008 00:12:20 -0700 (PDT)
Date: Sat, 21 Jun 2008 18:41:55 +0800
From: Huang Weiyi <weiyi.huang@gmail.com>
Message-Id: <20080621184002.386B.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] arch/um/os-Linux/helper.c: Removed duplicated include
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
To: jdike@addtoit.com
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Removed duplicated include file <linux/limits.h> in 
arch/um/os-Linux/helper.c.

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 30860b8..b6b1096 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -15,7 +15,6 @@
 #include "os.h"
 #include "um_malloc.h"
 #include "user.h"
-#include <linux/limits.h>

 struct helper_data {
        void (*pre_exec)(void*);



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
