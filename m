Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiK6r-0005VF-Nn for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 13:05:29 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AiK6r-0007d8-43 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 13:05:29 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040118210605.GA23259@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118162112.GA15509@elte.hu>
Subject: [uml-devel] uml 2.6.1 kbuild simplifications
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
Date: Sun, 18 Jan 2004 22:06:05 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


i've attached a few makefile simplifications/cleanups below, against
your 2.6.1 UML tree. The UML build will be less verbose as well.

parallel make still does not work though - doing 'make -j10' after a
'make clean' fails. Couldnt figure out a solution, the dependencies are
really nasty.

	Ingo

--- linux/arch/um/sys-i386/util/Makefile.orig2	
+++ linux/arch/um/sys-i386/util/Makefile	
@@ -1,12 +1,9 @@
 
-host-progs	:= mk_sc
-always		:= $(host-progs) mk_thread
-targets		:= mk_thread_kern.o mk_thread_user.o
+host-progs	:= mk_sc mk_thread
+always		:= $(host-progs)
 
-mk_sc-objs	:= mk_sc.o
+mk_thread-objs	:= mk_thread_kern.o mk_thread_user.o
 
-$(obj)/mk_thread : $(obj)/mk_thread_kern.o $(obj)/mk_thread_user.o
-	$(HOSTCC) $(CFLAGS) -o $@ $^
+HOSTCFLAGS_mk_thread_kern.o := $(CFLAGS)
+HOSTCFLAGS_mk_thread_user.o := $(USER_CFLAGS)
 
-$(obj)/mk_thread_user.o : $(src)/mk_thread_user.c
-	$(HOSTCC) $(USER_CFLAGS) -c -o $@ $<
--- linux/arch/um/util/Makefile.orig2	
+++ linux/arch/um/util/Makefile	
@@ -1,18 +1,10 @@
-always		:= mk_task mk_constants
-targets		:= mk_task_user.o mk_task_kern.o \
-		   mk_constants_user.o mk_constants_kern.o
 
-$(obj)/mk_task: $(obj)/mk_task_user.o $(obj)/mk_task_kern.o
-	$(HOSTCC) -o $@ $^
+host-progs		:= mk_task mk_constants
+always			:= $(host-progs)
 
-$(obj)/mk_task_user.o: $(src)/mk_task_user.c
-	$(HOSTCC) -o $@ -c $< 
+mk_task-objs		:= mk_task_user.o mk_task_kern.o
+mk_constants-objs	:= mk_constants_user.o mk_constants_kern.o
 
-$(obj)/mk_constants : $(obj)/mk_constants_user.o $(obj)/mk_constants_kern.o
-	$(HOSTCC) -o $@ $^
+HOSTCFLAGS_mk_task_kern.o	:= $(CFLAGS)
+HOSTCFLAGS_mk_constants_kern.o	:= $(CFLAGS)
 
-$(obj)/mk_constants_user.o : $(src)/mk_constants_user.c
-	$(HOSTCC) -c $< -o $@
-
-$(obj)/mk_constants_kern.o : $(src)/mk_constants_kern.c
-	$(HOSTCC) $(CFLAGS) -c $< -o $@
--- linux/arch/um/Makefile.orig2	
+++ linux/arch/um/Makefile	
@@ -157,7 +157,8 @@ MRPROPER_FILES += $(SYMLINK_HEADERS) $(A
 		$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
 
 $(ARCH_DIR)/main.o: $(ARCH_DIR)/main.c sys_prepare
-	$(CC) $(USER_CFLAGS) $(EXTRA_CFLAGS) -c -o $@ $<
+	@ echo '  MAIN    $@'
+	@ $(CC) $(USER_CFLAGS) $(EXTRA_CFLAGS) -c -o $@ $<
 
 archmrproper:
 	@:
@@ -169,13 +170,12 @@ archmrproper:
 #		$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
 
 archclean:
-#	$(Q)for d in $(ARCH_SUBDIRS) $(ARCH_DIR)/util; \
-#	do \
-#		$(MAKE) $(clean)=$$d; \
-#	done
+	$(Q)for d in $(ARCH_SUBDIRS) $(ARCH_DIR)/util; \
+	do \
+		$(MAKE) $(clean)=$$d; \
+	done
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
-#	rm -f $(CLEAN_FILES)
 
 $(SYMLINK_HEADERS):
 	cd $(TOPDIR)/$(dir $@) ; \


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
