Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D7CC30658
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JTD+puuf2bcAHQxuwe4ZIRhChWots5RuxoXoldU9UdI=; b=HKtA2B2Tmwnu3cKJYkg6I43sIP
	7s09/gOcrn+MZUh1qUIbrqz29pUEwQBLTDKy4uWPD1h0peRKMUB9vVBfgJD3rGlTrhtQfoIEbFM8l
	rbu401KeIbLuws3qsy1ZGKrLwjEHAbZjt0/Jrbkp9DHhJ6N9qW9bUx5joFHCIdFoigozb7xIqgh+j
	VLfEtQU/iOn0Od1n96VcYpH6JnTlte3YdiW+nex4Rk58HUEy+NaEIsegz2uAD9h7TVgFVfyPQQoch
	NmNm/TNrDJgOvTOrUN6rFil8rSKtrny+fdLPZ1bdeLdaAjf4Qm4GERmAMeWMur0h1uhQnFdPjeV3o
	Vogw9SHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYpp-00000005z6N-2bXg;
	Tue, 02 Jul 2024 08:25:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYpm-00000005z5n-42nB
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 08:25:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JTD+puuf2bcAHQxuwe4ZIRhChWots5RuxoXoldU9UdI=; t=1719908754; x=1721118354; 
	b=qlv1gTEYski94lPnw/AAB8OTRD4+4SHIGKsJ5H3fwYyQZP64EOoiqOp2/n2qMt/HWEWMUw7aRij
	2S5r82QaNKIC+T+ZduzJE7QvwJU2Qja+nnH+XYPnOr1EP075aUTExUGPxYQP0WlJMRM9JA8aPOL4O
	3JdFdYzAGmj5tTDXb3bvpmlbzxWCTDxMjM4dh5bfVCDWe2cLMMJ/a6uiJrlbnmlCa/ArV28R9MHyZ
	HC5l+1g9HGPo2MOzH1BC+jOiP0Hma0NQfJUd+JT60T69EXtQuute2OhOEsth73ArkxFrhkAwyCrAB
	EsgAk2sYVqGJxmxf8WM3cOfdN6D44HsWG3hQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOYpk-00000004yIE-0c8b;
	Tue, 02 Jul 2024 10:25:52 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v10] um: Enable preemption in UML
Date: Tue,  2 Jul 2024 10:25:50 +0200
Message-ID: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_012555_028488_0D8953FF 
X-CRM114-Status: GOOD (  12.31  )
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

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Since userspace state is saved in the MM process, kernel using
FPU still doesn't really need to do anything, so this really
is as simple as enabling preemption. The irq critical section
in sigio_handler() needs preempt_disable()/preempt_enable().

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
[vastly simplify, fix x86/um Makefile, rewrite commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v10:
 - rebase on top of various other patchsets, including Benjamin's
   page table updates: https://patchwork.ozlabs.org/project/linux-um/list/?series=408104
 - fix x86/um Makefile
 - remove FPU save/restore code since it's not needed
---
 arch/um/Kconfig      | 2 +-
 arch/um/kernel/irq.c | 2 ++
 arch/x86/um/Makefile | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 1faefc0a18ea..dca84fd6d00a 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NO_PREEMPT
+	select ARCH_NO_PREEMPT_DYNAMIC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index ceda4bd2e5ed..534e91797f89 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -238,7 +238,9 @@ static void _sigio_handler(struct uml_pt_regs *regs,
 
 void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
+	preempt_disable();
 	_sigio_handler(regs, irqs_suspended);
+	preempt_enable();
 }
 
 static struct irq_entry *get_irq_entry_by_fd(int fd)
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 17b85209c43d..36e67fc97c22 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -31,7 +31,6 @@ obj-y += syscalls_64.o vdso/
 
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
-subarch-$(CONFIG_PREEMPTION) += ../entry/thunk_64.o
 
 endif
 
-- 
2.45.2


