Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLDTu-0007VM-DC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 21:26:18 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CLDTt-0001gd-BC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 21:26:18 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041023035323.8343195D5@zion.localdomain>
Subject: [uml-devel] [patch 5/5] uml-add-conf-INITRAMFS_SOURCE
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
Date: Sat, 23 Oct 2004 05:53:23 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Kconfig_block |   27 ++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

diff -puN arch/um/Kconfig_block~uml-add-conf-INITRAMFS_SOURCE arch/um/Kconfig_block
--- vanilla-linux-2.6.9/arch/um/Kconfig_block~uml-add-conf-INITRAMFS_SOURCE	2004-10-22 02:27:36.844076640 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/Kconfig_block	2004-10-22 02:28:38.540697328 +0200
@@ -52,6 +52,33 @@ config BLK_DEV_INITRD
 	bool "Initial RAM disk (initrd) support"
 	depends on BLK_DEV_RAM=y
 
+#Copied directly from drivers/block/Kconfig
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
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
