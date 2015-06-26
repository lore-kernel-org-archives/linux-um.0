Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z8P7i-0005rN-JX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2015 08:36:34 +0000
Received: from mail-wg0-f47.google.com ([74.125.82.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z8P7h-0000eS-OO
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2015 08:36:34 +0000
Received: by wguu7 with SMTP id u7so82292872wgu.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Jun 2015 01:36:27 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Fri, 26 Jun 2015 10:36:14 +0200
Message-Id: <1435307774-3897-2-git-send-email-hwhilse@gmail.com>
In-Reply-To: <1435307774-3897-1-git-send-email-hwhilse@gmail.com>
References: <1435307774-3897-1-git-send-email-hwhilse@gmail.com>
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
Subject: [uml-devel] [PATCH] um: Do not rely on libc to provide modify_ldt()
To: user-mode-linux-devel@lists.sourceforge.net

modify_ldt() was declared as an external symbol. Despite the man
page for this syscall telling that there is no wrapper in glibc,
since version 2.1 there actually is, so linking to the glibc
works.

Since modify_ldt() is not a POSIX interface, other libc
implementations do not always provide a wrapper function.
Even glibc headers do not provide a corresponding declaration.

So go the recommended way to call this using syscall().

Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
---
 arch/x86/um/ldt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 9701a4f..6e57c22 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -11,8 +11,14 @@
 #include <os.h>
 #include <skas.h>
 #include <sysdep/tls.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+static inline int modify_ldt (int func, void *ptr, unsigned long bytecount)
+{
+	return syscall(SYS_modify_ldt, func, ptr, bytecount);
+}
 
-extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
 
 static long write_ldt_entry(struct mm_id *mm_idp, int func,
 		     struct user_desc *desc, void **addr, int done)
-- 
2.4.3


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

