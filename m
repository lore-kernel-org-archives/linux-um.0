Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD7DD11101
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmptGBj/+G5vo4gnOABQOC6djQbu2ag6c7bOjXrpkl4=; b=r74gBbzaw0tQVEmK7UAsMKwEDQ
	g/d+sFiKL2dg/vxgtwiSiKN8FU3PS687J+5xxvcKSnMTVEiPwiogqadhTtKPS0othiy36RHbWYzRx
	v7t9a84kfY8HVy1jvEpghbgpxqWkrMKAH3okI3NhzdoaVnyjLkGL75kPWuTx22gXO3Is3bcavZ0er
	GVwL6Ps3/zGQ/UVkz0gl7Cx05dRwKRb5xcZLzH59wJOcjjny76+fpZzUQsSiDpPyrPpCe2lJupSBK
	xNpIH6vaNzU8OLyq98Gqn3GFrzqY0X7G5rDSzp8eUxTne1ZhOr0vN5YISbeGVNO+tixxIvkUnMcAg
	FTi+8TWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAP-0000000BbTE-0UFW;
	Sun, 03 Nov 2024 15:05:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAO-0000000BbSj-0a32
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:05:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XmptGBj/+G5vo4gnOABQOC6djQbu2ag6c7bOjXrpkl4=; b=a2liglYdoIxAGil61rE4rDl9xM
	iIUZfa9Qx9oqVogRK+rAeJl72IoYx3EhrSQS1Z5De6xWbB4k0eHYvH3/9VNRzuxhfc+9WFnPqYE5y
	PFE4AY/AiP81Yx28GdrhG9WBGRcszC4WOgqJjFrKu8+LKHviI/fCVcB/4vX3QhNCHopkoaZf0N+mb
	rVulgwOe0MiO/k6mftom4BtgXk2J9itq+eHBK99JqDADWDaY91DXcK71taIM3yFaox+5EOGbDCz40
	4uLnb9QuXzbItFRuVz4tF/tNcAInBf5pMfeIFvEcUsHDAJMypCy4W1APt4oZcjnY0L484PV+yfHwl
	uc/HkzHw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAL-0000000B8fO-0qVu
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XmptGBj/+G5vo4gnOABQOC6djQbu2ag6c7bOjXrpkl4=;
	t=1730646321; x=1731855921; b=mDWbkzUVaishU1SQSYqdl0KWEJmoDKsBufhjyKhEvlEXbtm
	iqC0Db4NB8SddbUkUBIVZqeY1CIQjXkbpCzGQXeyqfzS9qAh7XWCKmpwceGwbFgMNCaj0EzAdqu9r
	6BAYMsNFyzWp+gjiOE1MKs/ZwrwEPdS5/NLWzxz9oQGdECpZIOSvKRtwE7u3v2ZD0uo+e2paNkQex
	rN7ot4ZvGlXdsJDJOYlb5abpfyfe4nvVy4uEZ1vC8ZZtOJCqUii1vNwovIQ96vKQ90H9lLKUJptpU
	ZXEEC78Ga1DPBE9arOA7R7ifywtW9wz5x4IUkQKcJLNiISz2qmdstizzMfJlc6/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7cAJ-0000000D5NG-02ro;
	Sun, 03 Nov 2024 16:05:20 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 2/5] um: always include kconfig.h and compiler-version.h
Date: Sun,  3 Nov 2024 16:05:03 +0100
Message-ID: <20241103150506.1367695-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150506.1367695-1-benjamin@sipsolutions.net>
References: <20241103150506.1367695-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150521_356665_F780B254 
X-CRM114-Status: GOOD (  13.61  )
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


