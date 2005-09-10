Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE9iU-0006lh-OO	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:42 -0700
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EE9iS-0002ZJ-PO	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:42 -0700
Message-Id: <20050910174630.063774000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Content-Disposition: inline; filename=fix-close-eintr
Subject: [uml-devel] [patch 7/7] uml: retry host close() on EINTR
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 10 Sep 2005 19:44:59 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

When calling close() on the host, we must retry the operation when we get
EINTR.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -17,6 +17,7 @@
 #include <sys/uio.h>
 #include "os.h"
 #include "user.h"
+#include "user_util.h"
 #include "kern_util.h"
 
 static void copy_stat(struct uml_stat *dst, struct stat64 *src)
@@ -300,7 +301,7 @@ int os_connect_socket(char *name)
 
 void os_close_file(int fd)
 {
-	close(fd);
+	CATCH_EINTR(close(fd));
 }
 
 int os_seek_file(int fd, __u64 offset)

--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
