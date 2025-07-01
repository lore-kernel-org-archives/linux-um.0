Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66518C83038
	for <linux-um@archiver.kernel.org>; Tue,  1 Jul 2025 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hAcx+KveVgQI7nWTg7IjJViCo+yDeNlxgo8eh4bw59s=; b=ghrz8mmHZTTO5LMm46kR9WNMg3
	fid3yNvpVlhyWLh+YeDXekwvwBKooq9qRIJRUQTkm4Hx+8MCP57KW7m5xfrPe7rgZZmKry8JjJb2P
	w6ZAFg/VzNKleMwGCYrjYw7MLFtrpeCwsaKUSiky8LteF2jwu0p0qa2uVQ4BODexA40e0u3h+IpIu
	8xZu6bmyRgDQIGU8N40gPjRNDQ1k0hZTh5uwpCiK3JmFPtIdL6dOfh1yB9O+Bt6ua03dmIKZKrN7H
	HJ/8oNAKgnHdrdUeTRn7XP4X1DIjENfJNhFW96iu0ChXuSo/qgB4GWX8nP1fSMBkaY1e0V00Q4+HZ
	KiEeFYRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWd71-00000005v8l-3ZHN;
	Tue, 01 Jul 2025 15:41:35 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWbTw-00000005bo5-3qAe
	for linux-um@lists.infradead.org;
	Tue, 01 Jul 2025 13:57:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD4822EC6;
	Tue,  1 Jul 2025 06:56:52 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0EE73F58B;
	Tue,  1 Jul 2025 06:57:05 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 21/23] um: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
Date: Tue,  1 Jul 2025 14:56:14 +0100
Message-Id: <20250701135616.29630-22-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_065708_992354_521F388A 
X-CRM114-Status: GOOD (  12.73  )
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

Instead of having the core code guess the note name for each regset,
use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-um@lists.infradead.org
Cc: x86@kernel.org
---
 arch/x86/um/ptrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/um/ptrace.c b/arch/x86/um/ptrace.c
index 3275870330fe..c982ab7103f1 100644
--- a/arch/x86/um/ptrace.c
+++ b/arch/x86/um/ptrace.c
@@ -236,7 +236,7 @@ static int generic_fpregs_set(struct task_struct *target,
 
 static struct user_regset uml_regsets[] __ro_after_init = {
 	[REGSET_GENERAL] = {
-		.core_note_type	= NT_PRSTATUS,
+		USER_REGSET_NOTE_TYPE(PRSTATUS),
 		.n		= sizeof(struct user_regs_struct) / sizeof(long),
 		.size		= sizeof(long),
 		.align		= sizeof(long),
@@ -246,7 +246,7 @@ static struct user_regset uml_regsets[] __ro_after_init = {
 #ifdef CONFIG_X86_32
 	/* Old FP registers, they are needed in signal frames */
 	[REGSET_FP_LEGACY] = {
-		.core_note_type	= NT_PRFPREG,
+		USER_REGSET_NOTE_TYPE(PRFPREG),
 		.n		= sizeof(struct user_i387_ia32_struct) / sizeof(long),
 		.size		= sizeof(long),
 		.align		= sizeof(long),
@@ -257,10 +257,10 @@ static struct user_regset uml_regsets[] __ro_after_init = {
 #endif
 	[REGSET_FP] = {
 #ifdef CONFIG_X86_32
-		.core_note_type	= NT_PRXFPREG,
+		USER_REGSET_NOTE_TYPE(PRXFPREG),
 		.n		= sizeof(struct user32_fxsr_struct) / sizeof(long),
 #else
-		.core_note_type	= NT_PRFPREG,
+		USER_REGSET_NOTE_TYPE(PRFPREG),
 		.n		= sizeof(struct user_i387_struct) / sizeof(long),
 #endif
 		.size		= sizeof(long),
@@ -270,7 +270,7 @@ static struct user_regset uml_regsets[] __ro_after_init = {
 		.set		= generic_fpregs_set,
 	},
 	[REGSET_XSTATE] = {
-		.core_note_type	= NT_X86_XSTATE,
+		USER_REGSET_NOTE_TYPE(X86_XSTATE),
 		.size		= sizeof(long),
 		.align		= sizeof(long),
 		.active		= generic_fpregs_active,
-- 
2.34.1


