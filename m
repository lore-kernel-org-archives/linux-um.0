Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <5578aa96.c528460a.20f4.1573SMTPIN_ADDED_BROKEN@mx.google.com>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2nS2-0001Xl-G8
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:22:22 +0000
Received: from hilses.de ([213.133.103.163])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2nRz-0007D4-U7
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:22:22 +0000
Received: from [10.0.0.1] (helo=localhost) by hilses.de with esmtpa (Exim 4.85)
	(envelope-from <hwhilse@gmail.com>) id 1Z2nRf-0006Of-SN
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 23:21:59 +0200
MIME-Version: 1.0
Date: Wed, 10 Jun 2015 23:21:59 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 3/3] um: Include sys/types.h for makedev(),
	major(), minor()
To: User-mode-linux Devel <User-mode-linux-devel@lists.sourceforge.net>

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

