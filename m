Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A64C77B7C
	for <linux-um@archiver.kernel.org>; Thu,  3 Jul 2025 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d7q+/Yxe5jR0gp3Z+FWT0TLKGPQbK+ZdKZXrnfhsktc=; b=nyvMDfMbCw8Hcr
	2O04h6ZGKK8cJO3dcYFiax1jVEeEWJIR4ZoMzujLh6K7OHIWdI9OFuh96pmcTt3oO4X8Z50/u5dil
	XLpe61kRi2FKbGgH1XO+o2KqAXITuu7Mr4j3aU2KqZejIoOPYv1IDPbv/UK9UPquxrBH3mmQautcM
	DnupW/7GJ4ageeqRz9fFtU4YzRCSdMbD4iAo72kzsNyW7+3oYt+3NxIMoR/R3wxObrnJ1o7p3SUhn
	+I9+z1PklRvWO+/DIoy6XzPIbaf8lAkGJW84oFoHqaIpPU2KR8ZdPgmtkC1VioTRDB6nxOBmuDv74
	BwaPXSSWJxZMzNAcvEFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKqD-0000000BeIm-0GEu;
	Thu, 03 Jul 2025 14:23:09 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJDc-0000000BMEH-1p8B
	for linux-um@lists.infradead.org;
	Thu, 03 Jul 2025 12:39:13 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d7q+/Yxe5jR0gp3Z+FWT0TLKGPQbK+ZdKZXrnfhsktc=;
	b=pK1oQduea0z5iukfeqiAd27WGS6wK1DAloPSgSXS4yz8n+n6KK0GyQbvAlnY8eP4t9YjIr
	faUR7ZTvj/37LLMDpNdex8/L5GNtEhS6eXvWVn0cb18eLPQfjZFq2bi7BsEVWUZ/MhitYn
	QdaBcsbrsT5LQfahna7pFreBV8mIXQKo/qwOl7Bj9BAQ69gFyT0vr2LZek8xR7jKeMBY/p
	xUsVA48VIPSLGzTTBOgA+RjlDIFkobZ1F0y6T44+uKhSzD9XITuS8F/ATKVDhCFvASfCe+
	nn/BN+vAAE22spMHKtx9Eia62pJ49rmPpSLn8tu3+DTY60YHX0tU6wy4jecuYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d7q+/Yxe5jR0gp3Z+FWT0TLKGPQbK+ZdKZXrnfhsktc=;
	b=/G1z44rcqxr8n4lqnZWlF0rkeM9B3WC8nj9r5wovZSLCw2wAEbTbmPTaEX4R6jJ5qtIM7T
	2RiWGy1DHBF2q3AQ==
Subject: [PATCH 0/2] um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS
Date: Thu, 03 Jul 2025 14:38:53 +0200
Message-Id: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN15ZmgC/x3M3QpAMBQA4FfRubaaIT+vImnNGadmtINI3t1y+
 d18DzAGQoY2eSDgSUyrj8jSBMys/YSCxmhQUpWykkocixOzPnHgm412btiDNrit5HcWjS3GrFb
 W5LKGWGwBLV1/3/Xv+wHfw+03bgAAAA==
X-Change-ID: 20250702-uml-have_syscall_tracepoints-9f4d182fc308
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751546346; l=896;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gcPU5yNDPFqYdoGHNrDVKHuSQLTjAociMfApXx2sB5o=;
 b=sOZ4Tue0bWL3LYqcryt9GKTmOvWQah3xZCtEyF1VD05gblm/OzycjztsqW0shMEHBuTLM5XuT
 sYaIg8SS6kGDlZdFwpyNFH9qTjYBk9hU7rNxvme2v/h65fe5N6jURBC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_053912_612031_6E0D67B2 
X-CRM114-Status: UNSURE (   4.06  )
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

We want to use this to run realtime validation monitors [0] inside UML,
to test applications for PREEMPT_RT compliance.

[0] https://lore.kernel.org/lkml/cover.1749547399.git.namcao@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      um/x86: Add system call table to header file
      um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS

 arch/um/Kconfig                   | 1 +
 arch/um/include/asm/thread_info.h | 2 ++
 arch/um/kernel/ptrace.c           | 9 +++++++++
 arch/x86/um/asm/syscall.h         | 2 ++
 4 files changed, 14 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250702-uml-have_syscall_tracepoints-9f4d182fc308

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


