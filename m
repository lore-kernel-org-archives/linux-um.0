Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9AsL-0000ng-IO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:46:01 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9AsK-0006wh-TZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:46:01 -0800
Message-Id: <200503100216.j2A2GcDN015243@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/9] UML - Remove build dependency on perl
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
Date: Wed, 09 Mar 2005 21:16:38 -0500
To: torvalds@osdl.org
Cc: Rob Landley <rob@landley.net>, Blaisorblade <blaisorblade@yahoo.it>, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

To quote .config into config.c for building the result into the code, use sed
instead of perl, as requested by one "embedded" UML user (which notes that 
perl is a big requirement, while busybox provides sed which is used in this 
patch).

I've tested that there are only cosmethical differences in the produced
config.c file, which don't change at all the result (i.e. "a" is replaced by
"" "a" at the beginning, which is non-significant).

Reported by, and initial patch provided by, Rob Landley.
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/Makefile	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/Makefile	2005-03-08 22:19:21.000000000 -0500
@@ -4,7 +4,7 @@
 #
 
 extra-y := vmlinux.lds
-clean-files := vmlinux.lds.S
+clean-files := vmlinux.lds.S config.tmp
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
@@ -34,11 +34,25 @@
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
 
-QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
+targets += config.c
 
-quiet_cmd_quote = QUOTE   $@
-cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
+# Be careful with the below Sed code - sed is pitfall-rich!
+# We use sed to lower build requirements, for "embedded" builders for instance.
 
-targets += config.c
-$(obj)/config.c : $(src)/config.c.in $(TOPDIR)/.config FORCE
-	$(call if_changed,quote)
+$(obj)/config.tmp: $(objtree)/.config FORCE
+	$(call if_changed,quote1)
+
+quiet_cmd_quote1 = QUOTE   $@
+      cmd_quote1 = sed -e 's/"/\\"/g' -e 's/^/"/' -e 's/$$/\\n"/' \
+		   $< > $@
+
+$(obj)/config.c: $(src)/config.c.in $(obj)/config.tmp FORCE
+	$(call if_changed,quote2)
+
+quiet_cmd_quote2 = QUOTE   $@
+      cmd_quote2 = sed -e '/CONFIG/{'          \
+		  -e 's/"CONFIG"\;/""/'        \
+		  -e 'r $(obj)/config.tmp'     \
+		  -e 'a""\;'                   \
+		  -e '}'                       \
+		  $< > $@



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
