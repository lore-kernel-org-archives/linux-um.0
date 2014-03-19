Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eparis@redhat.com>) id 1WQObA-0003pR-B7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 22:04:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WQOb1-0000q0-Ev for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 22:04:32 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2JM4FL5014625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 19 Mar 2014 18:04:17 -0400
From: Eric Paris <eparis@redhat.com>
Date: Wed, 19 Mar 2014 18:04:01 -0400
Message-Id: <1395266643-3139-2-git-send-email-eparis@redhat.com>
In-Reply-To: <1395266643-3139-1-git-send-email-eparis@redhat.com>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
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
Subject: [uml-devel] [PATCH 2/4] UM: implement syscall_get_arch()
To: linux-audit@redhat.com
Cc: user-mode-linux-devel@lists.sourceforge.net, Eric Paris <eparis@redhat.com>

SH: define syscall_get_arch() for superh

This patch defines syscall_get_arch() for the um platform.  It adds a
new syscall.h header file to define this.  It copies the HOST_AUDIT_ARCH
definition from ptrace.h.  (that definition will be removed when we
switch audit to use this new syscall_get_arch() function)

Signed-off-by: Eric Paris <eparis@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/x86/um/asm/syscall.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/x86/um/asm/syscall.h

diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
new file mode 100644
index 0000000..9fe77b7
--- /dev/null
+++ b/arch/x86/um/asm/syscall.h
@@ -0,0 +1,15 @@
+#ifndef __UM_ASM_SYSCALL_H
+#define __UM_ASM_SYSCALL_H
+
+#include <uapi/linux/audit.h>
+
+static inline int syscall_get_arch(void)
+{
+#ifdef CONFIG_X86_32
+	return AUDIT_ARCH_I386;
+#else
+	return AUDIT_ARCH_X86_64;
+#endif
+}
+
+#endif /* __UM_ASM_SYSCALL_H */
-- 
1.8.5.3


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

