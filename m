Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B76FC83F07
	for <linux-um@archiver.kernel.org>; Thu,  3 Jul 2025 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Z0MqZuZk9ZorWcjtJWd2TxVCHlbiuTD5yZSdlZfeII=; b=BDlmizb1kWIaZb5vfrZ7JABA19
	9VWanxFyr0YFXIAqPs0SjyisjWRvwzosGQXSChUTJmlSQ6Ez0hQqtu3URnoMT7YsnhnXbvSca5xZG
	Vi3aTFIqx0QuXYfK3pUVKFdHKZCUO9AQOQ/uCxBy6OVZIACwNXY4y/RV2aZHK/njpu+NJ0pR0pAqT
	VXC1rBj2kLXkgJv5fsmHVigVsHuDZDiRyBpsDuwXdUrum0HDPH/qh94R8hvDTHQRgWztYASXInGGv
	ciSLuNrGFF0JMaggfKWEgKr6VeG6gfF3IAfHnOO6bhdC/UBn6fFmvmjz4mhPCI1Z2L/i8V7hjuxNa
	WcCG+DMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKqD-0000000BeIw-1XH8;
	Thu, 03 Jul 2025 14:23:09 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJDd-0000000BMEx-0FTJ
	for linux-um@lists.infradead.org;
	Thu, 03 Jul 2025 12:39:14 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z0MqZuZk9ZorWcjtJWd2TxVCHlbiuTD5yZSdlZfeII=;
	b=vzXpOSXZEV/ki4Fz56c1LN7R+SoJv7a0tWyetgyw+Vv2V+U76gNI8tlqrmISKPXQy2SY6D
	0aqIr6/cHHuvlHMtZnazdEKO51Qb7fktkaM8LmoP47mIV/n8oERHZG4r7fNG9M1yvbgPsm
	pgYQmojQGYmXDyHS4cfaLe0WeLAH2JSdJHdKq1vUJHD7EHAGXVDsqMMuf0+2VpUmHHV7wg
	zE5IJjDCpmOvhkxkrrGUN7IBkErGnLEbnCOpVkstow06QoCV80pFViZkqdU2eV4I0PuNAr
	jbuvUxzD0pMvKIfYqx1aVt31nmEGX36gXVOXfDG5764NtgD+A6Nwf5l1tFc1hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z0MqZuZk9ZorWcjtJWd2TxVCHlbiuTD5yZSdlZfeII=;
	b=FzUfzSgGPqvzHpwS71OnYN2WaJ+oJocoZiFsGmmcKJzDy6QxguVcuw8gMFoxVG2PvZI6Na
	mYXsXWIucs0CCKDg==
Date: Thu, 03 Jul 2025 14:38:55 +0200
Subject: [PATCH 2/2] um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-uml-have_syscall_tracepoints-v1-2-23c1d3808578@linutronix.de>
References: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
In-Reply-To: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751546346; l=2501;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sS5BJFq5yl1Cpp9kuGgfCMujzkfDmeSN9fqRocDqWZY=;
 b=sGqrzfKZ+sO/4nzPW8zOoYWd7/SFalzFdwiFKLOhLCnOKZyiaLC0lwAQxnyzYWV3KIvuw15HZ
 AZJ7dueIW2tBUs+uy/X0/KmVvlNUmUJC+ibbivqmdK9MkypSeTSxHxf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_053913_235570_638FAA51 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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

Implement syscall tracepoints through the generic tracing infrastructure.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 arch/um/Kconfig                   | 1 +
 arch/um/include/asm/thread_info.h | 2 ++
 arch/um/kernel/ptrace.c           | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f08e8a7fac93d9f98384de02710542fd75d23553..c2d2d2d99bbe3f5a5dc4afaa69e02a520e326c2d 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -35,6 +35,7 @@ config UML
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 
 config MMU
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index f9ad06fcc991a2b10e2aa6059880b993e3d60a2d..b8c021f97bd17515e4f9082206addfce05b9321e 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -43,6 +43,8 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	8
 #define TIF_SECCOMP		9	/* secure computing */
 #define TIF_SINGLESTEP		10	/* single stepping userspace */
+#define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
+
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 2124624b7817439b8e1c962e8e6eb0e267db6f53..fdbb37b5c3996188d92cf307d31eeaeca1f0acce 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -9,6 +9,9 @@
 #include <linux/uaccess.h>
 #include <asm/ptrace-abi.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 void user_enable_single_step(struct task_struct *child)
 {
 	set_tsk_thread_flag(child, TIF_SINGLESTEP);
@@ -126,6 +129,9 @@ int syscall_trace_enter(struct pt_regs *regs)
 			    UPT_SYSCALL_ARG3(&regs->regs),
 			    UPT_SYSCALL_ARG4(&regs->regs));
 
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, UPT_SYSCALL_NR(&regs->regs));
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return 0;
 
@@ -142,6 +148,9 @@ void syscall_trace_leave(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SINGLESTEP))
 		send_sigtrap(&regs->regs, 0);
 
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_exit(regs, PT_REGS_SYSCALL_RET(regs));
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 

-- 
2.50.0


