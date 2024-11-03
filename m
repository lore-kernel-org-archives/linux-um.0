Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63995D11180
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmptGBj/+G5vo4gnOABQOC6djQbu2ag6c7bOjXrpkl4=; b=GFkGGBqyI/R3iCJ/0cmkPTcGoF
	v73SJ8Ye9kqmFxS0magG+j/s4sFSqlQv5U1bChYcyGdMhnws/9c4TWezNKzKeVjT+n7LoaCsXIK+J
	Yst8WHr0jGilbPRUxQG9WuZFSuW0AnDbidl2Vw40qxiUvcmlBJ1sxn1eBebNSPh1AgxAqAvsWA+pn
	KBH3FCy8X8GRWcgOvotgmJFwGZlBNpbBhvpWNi8MtUEZGfrzGPT5CBKx0LJvGn1vQPh+S7jfuc4Uu
	Kn7UXmq0FBv9FXpD2A2VEYGAX2T5ZZtVIGqIbpCTFYmFPHbZLekS0iKRh4/Z1sG/m+f9EgMrU0734
	2u2NyJhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7dFy-0000000BgF5-3J60;
	Sun, 03 Nov 2024 16:15:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7X-0000000Bate-1nto
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XmptGBj/+G5vo4gnOABQOC6djQbu2ag6c7bOjXrpkl4=; b=bxKGEMMHvrpkdMrwmJZkDQRSjE
	8dt7JKmZqaE/5bjCyGWJURcS5lW0u3xOBi/1478iRm8AIXHaD5t6BKdv2WyavBVKE4R2+ixyVgkn+
	baIrlbo63BDbWitCIV2fl+bHVVHcg4XsTXIuwDEZLKQ70l4/Law2rUhj/6VkzlOdrZGYVdMRUYjmk
	PVLlGR+ydJlONkkZcS3AJaIdPaJ1POfl8n7n9Vpmayvi6Mkg9wA93lY+J18BQk2S9UyHDXYKRluWS
	u6LWWQyk9mQrpN5qst1bydGcU/AdtmF26JZ+AiFRZzTl5sAIax8bYO9csNbd9q8fhrPnSVa+E5XZN
	6Ak+OKqg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7T-0000000B8NY-1V3L
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XmptGBj/+G5vo4gnOABQOC6djQbu2ag6c7bOjXrpkl4=;
	t=1730646141; x=1731855741; b=qfuwvGJIdao7Gg+jDXabHmJtJhaefuPd3MaBs1iNwVP31DM
	HfdfHN/Yexp56vgYOOO+hbi2XnytUTerw7b8s9xg/GylerFp8KC9tkcT44w0jZiUBlax/pReuU+iC
	xAfp0Srudht5Qdk6ZRIAsSWntkIQpKxs+dQWwyp7MBGeMWeOI1WVyuK3v8/fY66REbEPkTEbmVw+S
	VpqBmtsL/quW2y9EyyEc1BG2iyzp8QK88WaXuRhuSK1enyds22qHVl9GEC8hPlWp/wRLjCQ6NsaVs
	QsTzVJ+5cOjiUxC2jZImO502VtJaWOth4BrkEU4fwi7afEbvVxOJfwCnU1eYG2ZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7c7O-0000000D5Ia-2d7y;
	Sun, 03 Nov 2024 16:02:18 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/5] um: always include kconfig.h and compiler-version.h
Date: Sun,  3 Nov 2024 16:02:08 +0100
Message-ID: <20241103150211.1366452-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150211.1366452-1-benjamin@sipsolutions.net>
References: <20241103150211.1366452-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150223_980168_E200E571 
X-CRM114-Status: GOOD (  13.39  )
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

Since commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
<linux/kconfig.h>") we can safely include these files in userspace code.
Doing so simplifies matters as options do not need to be exported via
asm-offsets.h anymore.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Makefile                        |  4 +++-
 arch/um/include/shared/common-offsets.h | 18 ------------------
 arch/um/include/shared/timetravel.h     |  5 ++---
 arch/um/include/shared/user.h           |  2 +-
 arch/um/os-Linux/signal.c               |  8 ++++----
 arch/um/os-Linux/skas/process.c         |  6 ++++--
 arch/um/os-Linux/util.c                 |  4 ++--
 7 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 31e367e8ab4d..1d36a613aad8 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -71,7 +71,9 @@ KBUILD_AFLAGS += $(ARCH_INCLUDE)
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
-		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
+		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__ \
+		-include $(srctree)/include/linux/compiler-version.h \
+		-include $(srctree)/include/linux/kconfig.h
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 86537e20942a..1d00fc6b6e92 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -15,21 +15,3 @@ DEFINE(UM_THREAD_SIZE, THREAD_SIZE);
 
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
-
-#ifdef CONFIG_PRINTK
-DEFINE(UML_CONFIG_PRINTK, CONFIG_PRINTK);
-#endif
-#ifdef CONFIG_UML_X86
-DEFINE(UML_CONFIG_UML_X86, CONFIG_UML_X86);
-#endif
-#ifdef CONFIG_64BIT
-DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
-#endif
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
-#endif
-#ifdef CONFIG_UML_MAX_USERSPACE_ITERATIONS
-DEFINE(UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS, CONFIG_UML_MAX_USERSPACE_ITERATIONS);
-#else
-DEFINE(UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS, 0);
-#endif
diff --git a/arch/um/include/shared/timetravel.h b/arch/um/include/shared/timetravel.h
index c8db2f213dba..7c2b277b7eb0 100644
--- a/arch/um/include/shared/timetravel.h
+++ b/arch/um/include/shared/timetravel.h
@@ -12,14 +12,13 @@ enum time_travel_mode {
 	TT_MODE_EXTERNAL,
 };
 
-#if defined(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT) || \
-    defined(CONFIG_UML_TIME_TRAVEL_SUPPORT)
+#if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 extern enum time_travel_mode time_travel_mode;
 extern int time_travel_should_print_bc_msg;
 #else
 #define time_travel_mode TT_MODE_OFF
 #define time_travel_should_print_bc_msg 0
-#endif /* (UML_)CONFIG_UML_TIME_TRAVEL_SUPPORT */
+#endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
 void _time_travel_print_bc_msg(void);
 static inline void time_travel_print_bc_msg(void)
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index bbab79c0c074..139eb78a4767 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -38,7 +38,7 @@ extern void panic(const char *fmt, ...)
 #define UM_KERN_DEBUG	KERN_DEBUG
 #define UM_KERN_CONT	KERN_CONT
 
-#ifdef UML_CONFIG_PRINTK
+#if IS_ENABLED(CONFIG_PRINTK)
 #define printk(...) _printk(__VA_ARGS__)
 extern int _printk(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 1978eaa557e9..1c6caa9dbd6c 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -65,7 +65,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGALRM_MASK (1 << SIGALRM_BIT)
 
 int signals_enabled;
-#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+#if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 static int signals_blocked, signals_blocked_pending;
 #endif
 static unsigned int signals_pending;
@@ -75,7 +75,7 @@ static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	int enabled = signals_enabled;
 
-#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+#if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 	if ((signals_blocked ||
 	     __atomic_load_n(&signals_blocked_pending, __ATOMIC_SEQ_CST)) &&
 	    (sig == SIGIO)) {
@@ -297,7 +297,7 @@ void unblock_signals(void)
 		return;
 
 	signals_enabled = 1;
-#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+#if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 	deliver_time_travel_irqs();
 #endif
 
@@ -389,7 +389,7 @@ int um_set_signals_trace(int enable)
 	return ret;
 }
 
-#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+#if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 void mark_sigio_pending(void)
 {
 	/*
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 97856955e892..f683cfc9e51a 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -413,12 +413,14 @@ void userspace(struct uml_pt_regs *regs)
 		 */
 		if (time_travel_mode == TT_MODE_INFCPU ||
 		    time_travel_mode == TT_MODE_EXTERNAL) {
-			if (UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS &&
+#ifdef CONFIG_UML_MAX_USERSPACE_ITERATIONS
+			if (CONFIG_UML_MAX_USERSPACE_ITERATIONS &&
 			    unscheduled_userspace_iterations++ >
-			    UML_CONFIG_UML_MAX_USERSPACE_ITERATIONS) {
+			    CONFIG_UML_MAX_USERSPACE_ITERATIONS) {
 				tt_extra_sched_jiffies += 1;
 				unscheduled_userspace_iterations = 0;
 			}
+#endif
 		}
 
 		time_travel_print_bc_msg();
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 1dca4ffbd572..4193e04d7e4a 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -52,8 +52,8 @@ void setup_machinename(char *machine_out)
 	struct utsname host;
 
 	uname(&host);
-#ifdef UML_CONFIG_UML_X86
-# ifndef UML_CONFIG_64BIT
+#if IS_ENABLED(CONFIG_UML_X86)
+# if !IS_ENABLED(CONFIG_64BIT)
 	if (!strcmp(host.machine, "x86_64")) {
 		strcpy(machine_out, "i686");
 		return;
-- 
2.47.0


