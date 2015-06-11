Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2yoO-0007kg-8b
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:12 +0000
Received: from mail-wi0-f173.google.com ([209.85.212.173])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2yoN-00039J-Gy
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:12 +0000
Received: by wibdq8 with SMTP id dq8so4421046wib.1
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2015 02:30:05 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Thu, 11 Jun 2015 11:29:20 +0200
Message-Id: <1434014960-14774-4-git-send-email-hwhilse@gmail.com>
In-Reply-To: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
References: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
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
Subject: [uml-devel] [PATCH v2 3/3] um: Include sys/types.h for makedev(),
	major(), minor()
To: User-mode-linux-devel@lists.sourceforge.net

The functions in question are not part of the POSIX standard,
documentation however hints that the corresponding header shall
be sys/types.h. C libraries other than glibc, namely musl, did
not include that header via other ways and complained.

Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
---
 arch/um/os-Linux/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 08d90fb..26e0164 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -13,6 +13,7 @@
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/un.h>
+#include <sys/types.h>
 #include <os.h>
 
 static void copy_stat(struct uml_stat *dst, const struct stat64 *src)
-- 
2.4.2


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

