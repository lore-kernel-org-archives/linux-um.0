Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMqRL-0004cu-02	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:18:55 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMqRJ-0000qo-V9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:18:54 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051004171845.GK7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002183758.GR7992@ftp.linux.org.uk>
	<20051002205451.GS7992@ftp.linux.org.uk>
	<200510032030.23705.blaisorblade@yahoo.it>
	<20051004170941.GI7992@ftp.linux.org.uk>
	<20051004171419.GJ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004171419.GJ7992@ftp.linux.org.uk>
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
Date: Tue, 4 Oct 2005 18:18:45 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

	Killing unmap magic

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc3-git4-base/arch/um/Makefile RC14-rc3-git4-foo/arch/um/Makefile
--- RC14-rc3-git4-base/arch/um/Makefile	2005-09-25 23:28:27.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/Makefile	2005-10-04 13:16:14.000000000 -0400
@@ -121,7 +121,7 @@
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT="$(ELF_FORMAT)" $(CPP_MODE-y) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE) \
-	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap_fin.o
+	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap.o
 
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
diff -urN RC14-rc3-git4-base/arch/um/scripts/Makefile.unmap RC14-rc3-git4-foo/arch/um/scripts/Makefile.unmap
--- RC14-rc3-git4-base/arch/um/scripts/Makefile.unmap	2005-09-05 07:05:14.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/scripts/Makefile.unmap	1969-12-31 19:00:00.000000000 -0500
@@ -1,22 +0,0 @@
-clean-files += unmap_tmp.o unmap_fin.o unmap.o
-
-ifdef CONFIG_MODE_TT
-
-#Always build unmap_fin.o
-extra-y += unmap_fin.o
-#Do dependency tracking for unmap.o (it will be always built, but won't get the tracking unless we use this).
-targets += unmap.o
-
-#XXX: partially copied from arch/um/scripts/Makefile.rules
-$(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
-
-quiet_cmd_wrapld = LD      $@
-define cmd_wrapld
-	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< ; \
-	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
-endef
-
-$(obj)/unmap_fin.o : $(obj)/unmap.o FORCE
-	$(call if_changed,wrapld)
-
-endif
diff -urN RC14-rc3-git4-base/arch/um/sys-i386/Makefile RC14-rc3-git4-foo/arch/um/sys-i386/Makefile
--- RC14-rc3-git4-base/arch/um/sys-i386/Makefile	2005-10-04 13:15:51.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/sys-i386/Makefile	2005-10-04 13:16:14.000000000 -0400
@@ -11,6 +11,7 @@
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
+extra-$(CONFIG_MODE_TT) += unmap.o
 
-include arch/um/scripts/Makefile.unmap
+$(obj)/stub_segv.o $(obj)/unmap.o: \
+	_c_flags = $(call unprofile,$(CFLAGS))
diff -urN RC14-rc3-git4-base/arch/um/sys-x86_64/Makefile RC14-rc3-git4-foo/arch/um/sys-x86_64/Makefile
--- RC14-rc3-git4-base/arch/um/sys-x86_64/Makefile	2005-10-04 13:15:51.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/sys-x86_64/Makefile	2005-10-04 13:16:14.000000000 -0400
@@ -16,6 +16,7 @@
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
+extra-$(CONFIG_MODE_TT) += unmap.o
 
-include arch/um/scripts/Makefile.unmap
+$(obj)/stub_segv.o $(obj)/unmap.o: \
+	_c_flags = $(call unprofile,$(CFLAGS))


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
