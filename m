Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKSt4-0007mV-KS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 19:41:10 -0700
Received: from pimout2-ext.prodigy.net ([207.115.63.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CKSt3-000872-IG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Oct 2004 19:41:10 -0700
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041021024054.GA17968@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML: INITRAMFS_SOURCE noise/build fix
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
Date: Wed, 20 Oct 2004 19:40:54 -0700
To: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@osdl.org>

Trivial patch (copy & yank) so UML builds don't generate a warning
from linux/usr/Makefile:gen_cmd_list when CONFIG_INITRAMFS_SOURCE
isn't defined (maybe the Makefile shouldn't require
CONFIG_INITRAMFS_SOURCE to be set?).

Signed-off-by: cw@f00f.org

diff -Nru a/arch/um/Kconfig_block b/arch/um/Kconfig_block
--- a/arch/um/Kconfig_block	2004-10-20 19:36:35 -07:00
+++ b/arch/um/Kconfig_block	2004-10-20 19:36:35 -07:00
@@ -52,6 +52,34 @@
 	bool "Initial RAM disk (initrd) support"
 	depends on BLK_DEV_RAM=y
 
+# copied directly from drivers/block/Kconfig
+
+config INITRAMFS_SOURCE
+	string "Source directory of cpio_list"
+	default ""
+	help
+	  This can be set to either a directory containing files, etc to be
+	  included in the initramfs archive, or a file containing newline
+	  separated entries.
+
+	  If it is a file, it should be in the following format:
+	    # a comment
+	    file <name> <location> <mode> <uid> <gid>
+	    dir <name> <mode> <uid> <gid>
+	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
+
+	  Where:
+	    <name>      name of the file/dir/nod in the archive
+	    <location>  location of the file in the current filesystem
+	    <mode>      mode/permissions of the file
+	    <uid>       user id (0=root)
+	    <gid>       group id (0=root)
+	    <dev_type>  device type (b=block, c=character)
+	    <maj>       major number of nod
+	    <min>       minor number of nod
+
+	  If you are not sure, leave it blank.
+
 config MMAPPER
 	tristate "Example IO memory driver"
 	depends on BROKEN


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
