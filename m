Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QRmIC-0007fp-7U
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2011 14:21:04 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QRmIA-0006DD-Nj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2011 14:21:04 +0000
From: Richard Weinberger <richard@nod.at>
Date: Wed,  1 Jun 2011 16:18:43 +0200
Message-Id: <1306937924-22135-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 1/2] um: Add asm/percpu.h
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

To make SLUB work on UML we need this_cpu_cmpxchg from
asm-generic/percpu.h.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/percpu.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 arch/um/include/asm/percpu.h

diff --git a/arch/um/include/asm/percpu.h b/arch/um/include/asm/percpu.h
new file mode 100644
index 0000000..efe7508
--- /dev/null
+++ b/arch/um/include/asm/percpu.h
@@ -0,0 +1,6 @@
+#ifndef __UM_PERCPU_H
+#define __UM_PERCPU_H
+
+#include <asm-generic/percpu.h>
+
+#endif /* __UM_PERCPU_H */
-- 
1.7.5.3


------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger. 
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Data protection magic?
Nope - It's vRanger. Get your free trial download today. 
http://p.sf.net/sfu/quest-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

