Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkbOG-0003mS-2p for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 01:15:00 -0700
Received: from ro-out-1112.google.com ([72.14.202.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IkbOF-0002Ix-Kq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 01:15:00 -0700
Received: by ro-out-1112.google.com with SMTP id o35so197847rog
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 24 Oct 2007 01:14:58 -0700 (PDT)
Date: Wed, 24 Oct 2007 16:10:47 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071024081047.GC2464@hacking>
References: <alpine.LFD.0.999.0710232057080.30120@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710232057080.30120@woody.linux-foundation.org>
Subject: [uml-devel] [Git Patch] arch/um/drivers/ubd_kern.c: fix a building
	error
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@osdl.org>, jdike@karaya.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net


Fix this uml building error:
arch/um/drivers/ubd_kern.c: In function 'do_ubd_request':
arch/um/drivers/ubd_kern.c:1118: error: implicit declaration of function 'sg_page'
arch/um/drivers/ubd_kern.c:1118: warning: passing argument 6 of 'prepare_request' makes pointer from integer without a cast
make[1]: *** [arch/um/drivers/ubd_kern.o] Error 1
make: *** [arch/um/drivers] Error 2

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
 arch/um/drivers/ubd_kern.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 3a8cd3d..440ed25 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -35,6 +35,7 @@
 #include "linux/genhd.h"
 #include "linux/spinlock.h"
 #include "linux/platform_device.h"
+#include "linux/scatterlist.h"
 #include "asm/segment.h"
 #include "asm/uaccess.h"
 #include "asm/irq.h"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
