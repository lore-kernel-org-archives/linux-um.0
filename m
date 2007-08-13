Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Sun, 12 Aug 2007 23:39:11 -0700
From: joe@perches.com
Message-ID: <46bffc8f.k8F7SBEYGP7ozPij%joe@perches.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] [525/2many] MAINTAINERS - USER-MODE LINUX
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jdike@karaya.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index c50b6b1..7d1f87d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4964,6 +4964,9 @@ L:	user-mode-linux-devel@lists.sourceforge.net
 L:	user-mode-linux-user@lists.sourceforge.net
 W:	http://user-mode-linux.sourceforge.net
 S:	Maintained
+F:	Documentation/uml/UserModeLinux-HOWTO.txt
+F:	arch/um/
+F:	include/asm-um/
 
 FAT/VFAT/MSDOS FILESYSTEM:
 P:	OGAWA Hirofumi

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
