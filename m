Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFUhY-0002vu-IM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 05:22:36 -0800
Received: from ag-out-0708.google.com ([72.14.246.244])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFUhV-0004Jc-1g
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 05:22:36 -0800
Received: by ag-out-0708.google.com with SMTP id 26so168883agb.5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Jan 2008 05:22:32 -0800 (PST)
Date: Thu, 17 Jan 2008 21:21:08 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080117132108.GC2693@hacking>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080117023514.9df393cf.akpm@linux-foundation.org>
Subject: [uml-devel] [-mm Patch] UML: fix a building error
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 17, 2008 at 02:35:14AM -0800, Andrew Morton wrote:
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc8/2.6.24-rc8-mm1/
>

Hi, Andrew!

Building uml failed in current -mm tree. ;(

The below patch fixes this building error:
...
include/asm/arch/system.h:8:22: error: asm/nops.h: No such file or directory
...

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

Index: linux/include/asm-um/nops.h
===================================================================
--- /dev/null
+++ linux/include/asm-um/nops.h
@@ -0,0 +1,6 @@
+#ifndef __UM_NOPS_H
+#define __UM_NOPS_H
+
+#include "asm/arch/nops.h"
+
+#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
