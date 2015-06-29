Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z9Vi1-0005WA-Hm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 09:50:37 +0000
Received: from mail-wi0-f181.google.com ([209.85.212.181])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z9Vi0-0007r8-SJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 09:50:37 +0000
Received: by wicnd19 with SMTP id nd19so66134038wic.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 Jun 2015 02:50:30 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Mon, 29 Jun 2015 11:50:32 +0200
Message-Id: <1435571432-21125-2-git-send-email-hwhilse@gmail.com>
In-Reply-To: <1435571432-21125-1-git-send-email-hwhilse@gmail.com>
References: <3faa85268de72e64ff74175f2cf74021@hilses.de>
	<1435571432-21125-1-git-send-email-hwhilse@gmail.com>
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
Subject: [uml-devel] [PATCH v2] um: Do not rely on libc to provide
	modify_ldt()
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
 arch/x86/um/ldt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 9701a4f..836a1eb 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -12,7 +12,10 @@
 #include <skas.h>
 #include <sysdep/tls.h>
 
-extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
+static inline int modify_ldt (int func, void *ptr, unsigned long bytecount)
+{
+	return syscall(__NR_modify_ldt, func, ptr, bytecount);
+}
 
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

