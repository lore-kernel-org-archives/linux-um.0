Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KA5mX-0000UK-BS for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Jun 2008 09:17:41 -0700
Received: from ti-out-0910.google.com ([209.85.142.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KA5mV-0003T4-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Jun 2008 09:17:41 -0700
Received: by ti-out-0910.google.com with SMTP id y6so818393tia.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 Jun 2008 09:17:38 -0700 (PDT)
Date: Sat, 21 Jun 2008 22:34:23 +0800
From: Huang Weiyi <weiyi.huang@gmail.com>
Message-Id: <20080621223401.C97C.WEIYI.HUANG@gmail.com>
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

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

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
