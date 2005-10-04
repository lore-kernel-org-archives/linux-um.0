Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMqaj-0005CP-KW	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:28:37 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMqag-0000Do-Ts
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:28:37 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051004172827.GM7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002183758.GR7992@ftp.linux.org.uk>
	<20051002205451.GS7992@ftp.linux.org.uk>
	<200510032030.23705.blaisorblade@yahoo.it>
	<20051004170941.GI7992@ftp.linux.org.uk>
	<20051004171419.GJ7992@ftp.linux.org.uk>
	<20051004171845.GK7992@ftp.linux.org.uk>
	<20051004172446.GL7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004172446.GL7992@ftp.linux.org.uk>
Subject: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
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
Date: Tue, 4 Oct 2005 18:28:27 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

	KERN_SYMLINKS doesn't exist; the rest are already in ARCH_SYMLINKS
and don't need to be included into MRPROPER_FILES twice
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc3-git4-base/arch/um/Makefile current/arch/um/Makefile
--- RC14-rc3-git4-base/arch/um/Makefile	2005-10-04 13:19:47.000000000 -0400
+++ current/arch/um/Makefile	2005-10-02 21:13:10.000000000 -0400
@@ -142,8 +142,7 @@
 	$(ARCH_DIR)/include/user_constants.h \
 	$(ARCH_DIR)/include/kern_constants.h $(ARCH_DIR)/Kconfig.arch
 
-MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
-	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
+MRPROPER_FILES += $(ARCH_SYMLINKS)
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
