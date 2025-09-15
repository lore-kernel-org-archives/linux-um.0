Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E219CAC58E
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HVA8rahyRRzDT6UOZjkHUe+vnU2a954Je71AnOZJQWI=; b=ZaTfxTAJgIxti4LiPsoQ8Fde15
	n1cEAgQdJ1afK/kzWd5idPcYngm6UHXw++lmRuHs30kBEXeMqM3y+amTSEh4W/DI5KEeTUFBrZ7Ep
	vy4HXtsq87Ul+i+dwz82GEnrqBM3RcEYN8Xz/9Bx+D5gMNhVgcc+TI4JPAC9TE6e/xA7h1Ls4YHHQ
	KUuz4zmZWRGNnVw0+wER3/JNy1lAsPze6FNMqZUsCJuV9H48rg1GqebvaMQqWOQ5aUzu75G4gz+98
	2u5V/5sMM+l9Rj3XHMesefAkh07toTndxlMnYIQ9aqLueeCtm7BMMDrONYReZR3P+MpCGEjFGuRjZ
	H/OMS5Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XT-000000031ta-0Sfp;
	Mon, 15 Sep 2025 07:22:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XO-000000031lP-3pVv
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HVA8rahyRRzDT6UOZjkHUe+vnU2a954Je71AnOZJQWI=;
	t=1757920930; x=1759130530; b=ppfJpYYniQuPQKX+CwheqGXKh0/gloXGkiqTvHHMk+E9mEJ
	vL2EjkeuIFLZcquQo2OavwxWP9TCufGwUWINXC7lG6RRX9+oKkAfoBMcR9SuhkZhxSva7zKOW/W/T
	hBOPwwb+Q5v1Ga2LB7Nzjjvw2eQNmfg9nzlJvWdelr16IOryp/oSPi+JJyamvZpJSzrze8jcO4h+g
	st4y2YOlNZx3H4+EoF0xTvFFv/gGqZqYVK78ZNVEQhT5HId9Wk9/74XvWchkG8I+hKxJ3ZoW1Tscb
	Z5EOd2STd3xUd0flC/0i9mZGdRbfYSAUzr+jtTbPpSIWa8lSxyp0PlB3ioUQkyGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XL-00000005w6o-3k8S;
	Mon, 15 Sep 2025 09:22:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 7/9] um: add infrastructure to build files using nolibc
Date: Mon, 15 Sep 2025 09:11:13 +0200
Message-ID: <20250915071115.1429196-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002210_976278_E6C0987D 
X-CRM114-Status: GOOD (  11.75  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

Add NOLIBC_CFLAGS and NOLIBC_OBJS to build files against nolibc rather
than libc. With this it is possible to move to nolibc in smaller steps.

Set NOLIBC_IGNORE_ERRNO, as the nolibc errno implementation is overly
simple and cannot handle threading. nolibc provides sys_* functions that
do not emulate the libc errno behaviour and can be used instead.

Guard the syscall definition as it is a macro in nolibc.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Makefile               | 21 ++++++++++++++++++++-
 arch/um/include/shared/os.h    |  2 ++
 arch/um/scripts/Makefile.rules |  8 +++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index a3f27d791cc0..54aa26fcc32b 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -78,6 +78,25 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-include $(srctree)/include/linux/kern_levels.h \
 		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
 
+NOLIBC_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
+		-I $(srctree)/tools/include \
+		-D__EXPORTED_HEADERS__ \
+		-D__UM_HOST__ -D__UM_NOLIBC__ \
+		-DNOLIBC_NO_STARTCODE \
+		-DNOLIBC_IGNORE_ERRNO \
+		-nostdlib -nostdinc -static \
+		-I$(srctree)/include/uapi \
+		-I$(srctree)/$(HOST_DIR)/include/uapi \
+		-I$(objtree)/$(HOST_DIR)/include/generated/uapi \
+		-I $(srctree)/tools/include/nolibc \
+		-I $(srctree)/usr/include \
+		-include $(srctree)/include/generated/autoconf.h \
+		-include $(srctree)/tools/include/linux/kconfig.h \
+		-include $(srctree)/include/linux/kern_levels.h \
+		-include $(srctree)/tools/include/nolibc/nolibc.h \
+		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
+
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
 
@@ -157,4 +176,4 @@ archclean:
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
-export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
+export HEADER_ARCH SUBARCH USER_CFLAGS NOLIBC_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b35cc8ce333b..3e9f3ae61658 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -327,7 +327,9 @@ extern int __ignore_sigio_fd(int fd);
 /* tty.c */
 extern int get_pty(void);
 
+#ifndef syscall
 long syscall(long number, ...);
+#endif
 
 /* irqflags tracing */
 extern void block_signals_trace(void);
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index b4a2e0058503..5f07551935c3 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -11,6 +11,12 @@ USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 $(USER_OBJS:.o=.%): \
 	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(basetarget).o)
 
+# Similar USER_OBJS but compiled against nolibc (may include kernel headers?)
+NOLIBC_OBJS := $(foreach file,$(NOLIBC_OBJS),$(obj)/$(file))
+
+$(NOLIBC_OBJS:.o=.%): \
+	c_flags = -Wp,-MD,$(depfile) $(NOLIBC_CFLAGS) $(CFLAGS_$(basetarget).o)
+
 # These are like USER_OBJS but filter USER_CFLAGS through unprofile instead of
 # using it directly.
 UNPROFILE_OBJS := $(foreach file,$(UNPROFILE_OBJS),$(obj)/$(file))
@@ -18,7 +24,7 @@ UNPROFILE_OBJS := $(foreach file,$(UNPROFILE_OBJS),$(obj)/$(file))
 $(UNPROFILE_OBJS:.o=.%): \
 	c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS)) $(CFLAGS_$(basetarget).o)
 
-$(USER_OBJS) $(UNPROFILE_OBJS): \
+$(USER_OBJS) $(NOLIBC_OBJS) $(UNPROFILE_OBJS): \
 	CHECKFLAGS := $(patsubst $(NOSTDINC_FLAGS),,$(CHECKFLAGS))
 
 # The stubs can't try to call mcount or update basic block data
-- 
2.51.0


