Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joe@perches.com>) id 1WiuRq-0000yV-P9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 23:43:26 +0000
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]
	helo=smtprelay.hostedemail.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WiuRq-0007f4-0W for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 23:43:26 +0000
From: Joe Perches <joe@perches.com>
Date: Fri,  9 May 2014 16:43:11 -0700
Message-Id: <a0f82001821248eeccf32d1032a17b2d3b1f0add.1399678795.git.joe@perches.com>
In-Reply-To: <cover.1399678795.git.joe@perches.com>
References: <cover.1399678795.git.joe@perches.com>
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
Subject: [uml-devel] [PATCH 2/4] UserModeLinux: Remove unused #defines of
	UM_KERN_<LEVEL>
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

These are now unused so delete them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/um/include/shared/user.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index cef0685..4fa82c0 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -26,17 +26,6 @@
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
-/* Requires preincluding include/linux/kern_levels.h */
-#define UM_KERN_EMERG	KERN_EMERG
-#define UM_KERN_ALERT	KERN_ALERT
-#define UM_KERN_CRIT	KERN_CRIT
-#define UM_KERN_ERR	KERN_ERR
-#define UM_KERN_WARNING	KERN_WARNING
-#define UM_KERN_NOTICE	KERN_NOTICE
-#define UM_KERN_INFO	KERN_INFO
-#define UM_KERN_DEBUG	KERN_DEBUG
-#define UM_KERN_CONT	KERN_CONT
-
 #ifdef UML_CONFIG_PRINTK
 extern int printk(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
-- 
1.8.1.2.459.gbcd45b4.dirty


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

