Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJFX4-00HJIf-BC
 for linux-um@lists.infradead.org; Mon, 08 Mar 2021 13:02:48 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: allow not setting extra rpaths in the linux binary
Date: Mon,  8 Mar 2021 14:02:37 +0100
Message-Id: <20210308140237.ec2ecc0123db.Ib0c23e3dda8322f9306a9dd04146e797eb0690b2@changeid>
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
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

There doesn't seem to be any reason for the rpath being set in
the binaries, at on systems that I tested on. On the other hand,
setting rpath is actually harming binaries in some cases, e.g.
if using nix-based compilation environments where /lib & /lib64
are not part of the actual environment.

Add a new Kconfig option (under EXPERT, for less user confusion)
that allows disabling the rpath additions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig      | 13 +++++++++++++
 arch/um/Makefile     |  3 ++-
 arch/x86/Makefile.um |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f64d774706e5..e5cc1aea223c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -105,6 +105,19 @@ config LD_SCRIPT_DYN
 	depends on !LD_SCRIPT_STATIC
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config LD_SCRIPT_DYN_RPATH
+	bool "set rpath in the binary" if EXPERT
+	default y
+	depends on LD_SCRIPT_DYN
+	help
+	  Add /lib (and /lib64 for 64-bit) to the linux binary's rpath
+	  explicitly.
+
+	  You may need to turn this off if compiling for nix systems
+	  that have their libraries in random /nix directories and
+	  might otherwise unexpected use libraries from /lib or /lib64
+	  instead of the desired ones.
+
 config HOSTFS
 	tristate "Host filesystem"
 	help
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1cea46ff9bb7..12a7acef0357 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -118,7 +118,8 @@ archprepare:
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN) += $(call cc-option, -no-pie)
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	-fno-stack-protector $(call cc-option, -fno-stack-protector-all)
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 1db7913795f5..b3c1ae084180 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -44,7 +44,7 @@ ELF_FORMAT := elf64-x86-64
 
 # Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
 
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
+LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
 endif
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

