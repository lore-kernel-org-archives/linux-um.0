Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWfmV-0002kl-19
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 09:48:19 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AWfmU-0003vb-6s
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Dec 2003 09:48:18 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix
References: <200312131828.03645.blaisorblade_spam@yahoo.it> <200312132019.hBDKJ8rL002905@ccure.user-mode-linux.org>
In-Reply-To: <200312132019.hBDKJ8rL002905@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WeJ4/W97nZxLduU"
Message-Id: <200312171851.18353.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 17 Dec 2003 18:51:18 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_WeJ4/W97nZxLduU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alle 21:19, sabato 13 dicembre 2003, Jeff Dike ha scritto:

> > 2) then, the UML build system is broken for USER_OBJS.
>
> This is separate from the module problem.  It still needs fixing though.
>
> > Instead of specifying the rule each time, wouldn't it be good
> > something  such(in pseudo-code, I know there is only foreach in
> > make-language)?
> >
> > for i in USER_OBJS; do
> >   CFLAGS_$i+=USER_CFLAGS done
>
> It would be nice just to have something in one Makefile, like
> arch/um/Makefile, which makes this work.  I haven't looked at whether this
> is possible.

Aargh! I discovered how to write the above loop. BUT the problem is that 
setting CFLAGS_$i is not what we need, since that flags are added to kernel 
ones, while the kernel flags must be deleted.

So we must not do this, but instead add another rule to the main Makefiles, or 
something else patch them.
Do you need a different output(i.e. USERCC) for the USER_OBJS or it is not 
needed?

If not, I can just patch this way scripts/Makefile.lib:

c_flags         = $(if $(find $(@F),$(user-objs)), UML_user_c_flags, 
norm_c_flags)
#def. of norm_c_flags
#def. of UML_user_c_flags

In fact, the flags passed to the compiler are $(c_flags), which contain 
CFLAGS, EXTRA_CFLAGS, CFLAGS_$@ and the special, fixed kernel flags. So this 
instead is put inside norm_c_flags; 

Also, this can be moved to the main Makefile once for all (note these are 
deferred assignments):

USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) \ 
$(obj-m)),$($(f)-objs))

user-objs = $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS))
# You can put:
#  user-objs += whatever.o
# in each sub-Makefile.

I'm posting the "structure" patch for this(a bit different for various little 
details). If you agree with this, I'll go patching each needed Makefile.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_WeJ4/W97nZxLduU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="User_obj_makefiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="User_obj_makefiles.patch"

--- ./arch/um/kernel/Makefile.user_obj	2003-12-02 17:20:43.000000000 +0100
+++ ./arch/um/kernel/Makefile	2003-12-17 18:42:37.000000000 +0100
@@ -26,7 +26,8 @@
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	process.o tempfile.o time.o tty_log.o umid.o user_util.o user_syms.o
+	process.o tempfile.o time.o tty_log.o umid.o user_util.o user_syms.o \
+	frame.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 DMODULES-$(CONFIG_MODULES) = -D__CONFIG_MODULES__
@@ -36,16 +37,16 @@
 CFLAGS_user_syms.o = -D__AUTOCONF_INCLUDED__ $(DMODULES-y) $(DMODVERSIONS-y) \
 	-I/usr/include -I../include
 
-CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))
+CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS)) -fno-omit-frame-pointer
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
 
-# This has to be separate because it needs be compiled with frame pointers
-# regardless of how the rest of the kernel is built.
-
-$(obj)/frame.o: $(src)/frame.c
-	$(CC) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+## This has to be separate because it needs be compiled with frame pointers
+## regardless of how the rest of the kernel is built.
+#
+#$(obj)/frame.o: $(src)/frame.c
+#	$(CC) $(CFLAGS_$(notdir $@)) -c -o $@ $<
 
 QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
 
--- ./arch/um/Makefile.user_obj	2003-12-13 18:36:36.000000000 +0100
+++ ./arch/um/Makefile	2003-12-17 18:46:34.000000000 +0100
@@ -129,6 +129,17 @@
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
 	$(MODE_INCLUDE)
 
+USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) \ $(obj-m)),$($(f)-objs))
+user-objs = $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS))
+
+#define __set_user_cflag
+# $(1)_cflags = $$(USER_CFLAGS)
+#endef
+#
+#define set_user_cflags
+# $(foreach f, $(user-objs), $(eval $(call __set_user_cflag, $(f))))
+#endef
+
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
--- ./scripts/Makefile.lib.user_obj	2003-10-01 21:25:17.000000000 +0200
+++ ./scripts/Makefile.lib	2003-12-17 18:33:19.000000000 +0100
@@ -136,8 +136,12 @@
 basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
 modname_flags  = $(if $(filter 1,$(words $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
 
+#For UML
+is_user_obj    = $(find $(@F),$(user-objs))
+
+_c_flags       = $(if $(is_user_obj),$(USER_CFLAGS),$(CFLAGS) $(EXTRA_CFLAGS)) \
+  		 $(CFLAGS_$(*F).o)
 
-_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 _hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
 _hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
@@ -165,10 +169,12 @@
 __hostcxx_flags	=                              $(call flags,_hostcxx_flags)
 endif
 
-c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+kernelized_c_flags = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__c_flags) $(modkern_cflags) \
 		 $(basename_flags) $(modname_flags)
 
+c_flags 	= $(if $(is_user_obj), __c_flags, kernelized_c_flags)
+
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
 

--Boundary-00=_WeJ4/W97nZxLduU--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
