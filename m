Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZwSx-0001yf-1i for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:15 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZwSw-0002Sh-Gz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:15 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 23:27:09 +0200
Message-Id: <20061017212709.26445.54420.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 03/10] uml: fix prototypes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix prototypes in user.h - was needed when including user.h in kernelspace, as
we did in previous patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/user.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/user.h b/arch/um/include/user.h
index acadce3..6921f3e 100644
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -6,6 +6,10 @@
 #ifndef __USER_H__
 #define __USER_H__
 
+/* Both on kernelspace and userspace this will provide the size_t definition. It should, at
+ * least. But on userspace it won't hurt surely. */
+#include <linux/types.h>
+
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern int printk(const char *fmt, ...)
@@ -13,9 +17,8 @@ extern int printk(const char *fmt, ...)
 extern void schedule(void);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
-/* These use size_t, however unsigned long is correct on both i386 and x86_64. */
-extern unsigned long strlcpy(char *, const char *, unsigned long);
-extern unsigned long strlcat(char *, const char *, unsigned long);
+extern size_t strlcpy(char *, const char *, size_t);
+extern size_t strlcat(char *, const char *, size_t);
 
 #endif
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
