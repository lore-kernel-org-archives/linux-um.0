Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxmYu-0006Kc-Qh for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 08:48:30 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxmYs-0002g0-NM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 08:48:28 -0800
Date: Thu, 29 Nov 2007 11:48:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071129164820.GA7294@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/3] UML - Add asm-um/asm.h
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[ This should accompany git-x86.patch to mainline ]

git-x86.patch introduces asm-x86/asm.h.  UML needs to follow this with
an asm/asm.h of its own.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 include/asm-um/asm.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.22/include/asm-um/asm.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22/include/asm-um/asm.h	2007-11-21 12:15:03.000000000 -0500
@@ -0,0 +1,6 @@
+#ifndef __UM_ASM_H
+#define __UM_ASM_H
+
+#include "asm/arch/asm.h"
+
+#endif

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
