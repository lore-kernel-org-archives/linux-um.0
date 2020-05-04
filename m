Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-12.nifty.com ([210.131.2.79])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVW9L-0006cJ-Pj
 for linux-um@lists.infradead.org; Mon, 04 May 2020 08:08:29 +0000
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] kbuild: remove {CLEAN,MRPROPER,DISTCLEAN}_DIRS
Date: Mon,  4 May 2020 17:08:07 +0900
Message-Id: <20200504080807.126396-2-masahiroy@kernel.org>
In-Reply-To: <20200504080807.126396-1-masahiroy@kernel.org>
References: <20200504080807.126396-1-masahiroy@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>, Richard Weinberger <richard@nod.at>, Masahiro Yamada <masahiroy@kernel.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Merge {CLEAN,MRPROPER,DISTCLEAN}_DIRS into {CLEAN,MRPROPER,DISTCLEAN}_FILES
because the difference is just the -r option passed to the 'rm' command.

Do likewise as commit 1634f2bfdb84 ("kbuild: remove clean-dirs syntax").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile         | 22 ++++++----------------
 arch/um/Makefile |  2 +-
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index ffd80afcd0bb..8a7c931cc0d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1389,14 +1389,14 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += include/ksym
-CLEAN_FILES += modules.builtin modules.builtin.modinfo modules.nsdeps
+CLEAN_FILES += include/ksym \
+	       modules.builtin modules.builtin.modinfo modules.nsdeps
 
 # Directories & files removed with 'make mrproper'
-MRPROPER_DIRS  += include/config include/generated          \
+MRPROPER_FILES += include/config include/generated          \
 		  arch/$(SRCARCH)/include/generated .tmp_objdiff \
-		  debian/ snap/ tar-install/
-MRPROPER_FILES += .config .config.old .version \
+		  debian snap tar-install \
+		  .config .config.old .version \
 		  Module.symvers \
 		  signing_key.pem signing_key.priv signing_key.x509	\
 		  x509.genkey extra_certificates signing_key.x509.keyid	\
@@ -1404,12 +1404,10 @@ MRPROPER_FILES += .config .config.old .version \
 		  *.spec
 
 # Directories & files removed with 'make distclean'
-DISTCLEAN_DIRS  +=
 DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
 
 # clean - Delete most, but leave enough to build external modules
 #
-clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
 
 PHONY += archclean vmlinuxclean
@@ -1422,7 +1420,6 @@ clean: archclean vmlinuxclean
 
 # mrproper - Delete all generated files, including .config
 #
-mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
 mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
 mrproper-dirs      := $(addprefix _mrproper_,scripts)
 
@@ -1431,18 +1428,15 @@ $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
 mrproper: clean $(mrproper-dirs)
-	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 
 # distclean
 #
-distclean: rm-dirs  := $(wildcard $(DISTCLEAN_DIRS))
 distclean: rm-files := $(wildcard $(DISTCLEAN_FILES))
 
 PHONY += distclean
 
 distclean: mrproper
-	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 	@find $(srctree) $(RCS_FIND_IGNORE) \
 		\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
@@ -1732,7 +1726,6 @@ $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
 clean: $(clean-dirs)
-	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
 		\( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
@@ -1827,11 +1820,8 @@ tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
-quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
-      cmd_rmdirs = rm -rf $(rm-dirs)
-
 quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
-      cmd_rmfiles = rm -f $(rm-files)
+      cmd_rmfiles = rm -rf $(rm-files)
 
 # Run depmod only if we have System.map and depmod is executable
 quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 275f5ffdf6f0..3f27aa3ec0a6 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -140,7 +140,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_DIRS += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += arch/$(SUBARCH)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

