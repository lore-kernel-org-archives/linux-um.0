Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANe-0002gT-J2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:06 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANb-0000ID-Ts for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:06 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001759.317908695@zion.localdomain>
Subject: [uml-devel] [patch 07/10] uml: kbuild - add even more cleaning
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
Date: Tue, 12 Oct 2004 02:17:59 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Remove one more symlink when doing

make mrproper ARCH=um

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-kbuild-add-even-more-cleaning arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-kbuild-add-even-more-cleaning	2004-10-12 01:08:08.925888512 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 01:08:08.927888208 +0200
@@ -123,7 +123,7 @@ CLEAN_FILES += linux x.i gmon.out $(ARCH
 	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
-	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
+	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
 
 archmrproper:
 	@:
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
