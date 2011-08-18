Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7xj-0003H3-HJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7xi-0000HX-NM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:07 +0000
Date: Thu, 18 Aug 2011 20:08:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7xb-0007sY-Pq@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 60/91] um: kill useless include of
	user.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


everything in USER_OBJ gets it via -include user.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hostfs/hostfs_user.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index d51a983..dd7bc38 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -16,7 +16,6 @@
 #include <sys/vfs.h>
 #include "hostfs.h"
 #include "os.h"
-#include "user.h"
 #include <utime.h>
 
 static void stat64_to_hostfs(const struct stat64 *buf, struct hostfs_stat *p)
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

