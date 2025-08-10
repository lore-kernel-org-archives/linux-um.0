Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77921C87FDA
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QSESnP/sa4r5ORTRPvhvwWnuR1/omMMQhE1G5EL1OGY=; b=jp5E/BdR0DO/jYrN99EXktxakI
	lUT3V6Pt+oYq6c7/HEJEfBtNM6mYYgy/8r4ZuTOp/U9O/KOOI9nefT2zdNM6YprLsjshb4jSzjoPS
	IxN4tTvBthoGtTuEll5Ei2zv/JBM/A+wWCQA5c/ciZtneqTg8witGn0rP3hfcCNuroSYVtSC6tdER
	iDo988mk+KgZWqdegeaeDR+mt/AxLvIJH4bcdAJHHRxU1Id+HQTsR+2f1ikScXQNcRrq4cR+tNAG6
	W6N11CVQLzT8wmWPJyHNn9UBgrCGjSU8ALKWdg04M67KA0UNk4AZ7dKImwxOxf9a4hxhbM9XtT8Gz
	xtGK9jmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyyc-00000005IMR-0zV1;
	Sun, 10 Aug 2025 05:52:14 +0000
Received: from out-188.mta0.migadu.com ([91.218.175.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyya-00000005IKV-1h2T
	for linux-um@lists.infradead.org;
	Sun, 10 Aug 2025 05:52:13 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSESnP/sa4r5ORTRPvhvwWnuR1/omMMQhE1G5EL1OGY=;
	b=Hi93vIdcf0W3EHnEsbeGb4QIEQTZQ0PT2A+lOa0ejHdBO6J2cSIhyGyHiQe/U62f1qr6Ka
	2gdCGKXDCB4QSz8JYCOeEuomWlHWOdxmM6jaBjDE9sdwPedUswcIpQTswQvPA+6NEGlr48
	T08gcv0Zi4RW4Q0hKheFIvji31+TMUc=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
Date: Sun, 10 Aug 2025 13:51:30 +0800
Message-Id: <20250810055136.897712-5-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250809_225212_595896_D4EAB53C 
X-CRM114-Status: GOOD (  11.17  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

Turn signals_enabled, signals_pending and signals_active into
thread-local variables. This enables us to control and track
signals independently on each CPU thread. This is a preparation
for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/irqflags.h   |  4 ++--
 arch/um/include/shared/longjmp.h |  3 +--
 arch/um/include/shared/os.h      |  1 +
 arch/um/kernel/ksyms.c           |  2 +-
 arch/um/os-Linux/signal.c        | 11 ++++++++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index 1e69ef5bc35e..31e49e0894c5 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -2,7 +2,7 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-extern int signals_enabled;
+int um_get_signals(void);
 int um_set_signals(int enable);
 void block_signals(void);
 void unblock_signals(void);
@@ -10,7 +10,7 @@ void unblock_signals(void);
 #define arch_local_save_flags arch_local_save_flags
 static inline unsigned long arch_local_save_flags(void)
 {
-	return signals_enabled;
+	return um_get_signals();
 }
 
 #define arch_local_irq_restore arch_local_irq_restore
diff --git a/arch/um/include/shared/longjmp.h b/arch/um/include/shared/longjmp.h
index 8863319039f3..c53e43d980c8 100644
--- a/arch/um/include/shared/longjmp.h
+++ b/arch/um/include/shared/longjmp.h
@@ -5,7 +5,6 @@
 #include <sysdep/archsetjmp.h>
 #include <os.h>
 
-extern int signals_enabled;
 extern int setjmp(jmp_buf);
 extern void longjmp(jmp_buf, int);
 
@@ -15,7 +14,7 @@ extern void longjmp(jmp_buf, int);
 
 #define UML_SETJMP(buf) ({				\
 	int n, enable;					\
-	enable = *(volatile int *)&signals_enabled;	\
+	enable = um_get_signals();			\
 	n = setjmp(*buf);				\
 	if(n != 0)					\
 		um_set_signals_trace(enable);		\
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b35cc8ce333b..324d4eed3385 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -243,6 +243,7 @@ extern void send_sigio_to_self(void);
 extern int change_sig(int signal, int on);
 extern void block_signals(void);
 extern void unblock_signals(void);
+extern int um_get_signals(void);
 extern int um_set_signals(int enable);
 extern int um_set_signals_trace(int enable);
 extern void deliver_alarm(void);
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index f2fb77da08cf..96314c31e61c 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -6,8 +6,8 @@
 #include <linux/module.h>
 #include <os.h>
 
+EXPORT_SYMBOL(um_get_signals);
 EXPORT_SYMBOL(um_set_signals);
-EXPORT_SYMBOL(signals_enabled);
 
 EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 11f07f498270..58da8c6ece98 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -68,12 +68,12 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGCHLD_BIT 2
 #define SIGCHLD_MASK (1 << SIGCHLD_BIT)
 
-int signals_enabled;
+static __thread int signals_enabled;
 #if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 static int signals_blocked, signals_blocked_pending;
 #endif
-static unsigned int signals_pending;
-static unsigned int signals_active = 0;
+static __thread unsigned int signals_pending;
+static __thread unsigned int signals_active;
 
 static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
@@ -342,6 +342,11 @@ void unblock_signals(void)
 	}
 }
 
+int um_get_signals(void)
+{
+	return signals_enabled;
+}
+
 int um_set_signals(int enable)
 {
 	int ret;
-- 
2.34.1


