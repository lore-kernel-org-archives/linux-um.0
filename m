Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AE5C83F04
	for <linux-um@archiver.kernel.org>; Thu,  3 Jul 2025 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vcx/so/3k8VD9Ap+AUgy3oJHi9GyHmwgfiWauDxMCYY=; b=pktggZTNK9iTKktYKVmKORA7dy
	C46HI0WGIgy4qsIKJwUZF55ksdDy5bzJGxqPBaJppWeo8L90L1lGURP+koo1bkX4ZqkOrBEgi85Eg
	U1vhFCp21/0K7MoxOsEhRWedyiPrMX/9dNpF0wzXtt6YonHz5Etg23OC0+2YlvWrjtLw+wfYYXYAy
	lIDwsoVSAdGwg6O25cIMK7nsL962o+VO0rP2qa1Ca5n/ZhtG96pPaW+0/T5E1wDeMjPkAiGSXnz9U
	4WWHBZEg/Lu1Zhxd0bNYQChHvY8zQ8GQJIae2H0yKcNsgwyYPpxYGYuCwoKBtz2I1lbbsVESu3dv+
	yK8D4+Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKqC-0000000BeIg-3DdY;
	Thu, 03 Jul 2025 14:23:08 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJDc-0000000BMEk-2bbS
	for linux-um@lists.infradead.org;
	Thu, 03 Jul 2025 12:39:13 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcx/so/3k8VD9Ap+AUgy3oJHi9GyHmwgfiWauDxMCYY=;
	b=1c3998twe8q2VIRZGXUR/TUVkdP35BAI8WhBf15U2vkd9nXv5KEnfkup3dzhQY7G9nuZ8o
	coo+ZPDsNLwR5oukURfgPBWEprha3AGcKcNAp2JhaHeHtuUPzyf0hBgAuXL813bjz09cYp
	fzhRDCgQZrL1fJ4y/2mI9hOfFDWZmq7vXvhyJVih4ysRDkqu/3Xi3/T32AW8CJBZm38yZ4
	bjxRBWIKwcR6B2+JLxGDQnK9mzl5GUlRISnR62kkuGdfvjrS9sFHj3Kb9fxxatP5NTehjd
	5GqHHDpYlkOObschA64X5Vbw9O4HeLo6Y8o4SqkeO8FQq+pb8wIArAhNOGRaug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcx/so/3k8VD9Ap+AUgy3oJHi9GyHmwgfiWauDxMCYY=;
	b=8ENub7MTQ9ozltCc8o8iylbEHeyl1FOJxDYI50zRsNIx9+so3PEL+4+CTZJNDWcluXdh8Q
	w1ehTLM1Trx6onCA==
Date: Thu, 03 Jul 2025 14:38:54 +0200
Subject: [PATCH 1/2] um/x86: Add system call table to header file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-uml-have_syscall_tracepoints-v1-1-23c1d3808578@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751546346; l=951;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xcrXOaelxL04XilVAZ1JMakfSWcihwh5TW+sSTImz6s=;
 b=4YZBROzuNLwLwf0oaRMm6LoaR/56kwmtURacuzbbceaAcHcpWk82d4D5oEOJTIXUnmTc+gYON
 9a0m1VkDCn3Dil7iYabU+S4ssnsrMg63dSMIo/n6vp+NCmVxMZDUgQ2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_053912_800249_5869C70A 
X-CRM114-Status: UNSURE (   7.27  )
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

The generic system call tracing infrastructure requires access to the
system call table. The symbol is already visible to the linker but is
lacking a public declaration.

Add a public declaration.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 arch/x86/um/asm/syscall.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
index 56a2f0913e3c0307958eb47815a7634447cb1390..d6208d0fad51a95f3d56879c1bceb50c3ec0f6b2 100644
--- a/arch/x86/um/asm/syscall.h
+++ b/arch/x86/um/asm/syscall.h
@@ -9,6 +9,8 @@ typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 					  unsigned long, unsigned long,
 					  unsigned long, unsigned long);
 
+extern const sys_call_ptr_t sys_call_table[];
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_X86_32

-- 
2.50.0


