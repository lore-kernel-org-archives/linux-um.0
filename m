Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A025C43458
	for <linux-um@archiver.kernel.org>; Mon, 29 Jun 2026 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBDPSugJUvIfnZFt1AXtvZwTdTLodNQ1FcaAm4R/gOE=; b=GhdBAFv9xeYNfGEdmEP5mKLIkZ
	FSdz4zQTFJe/Bqx2syTHvfE7VPWzw1k7/nvuFKFHRq9MvsmIPkEKeea9HvMem7QMQTULFSgJ286LW
	7B76ReRZy8pRGNuVYmy9PtOonoYjENVMvmvms585nkxCaUNcUk/ayZXg2XP5/+W5ZrH7ywCkc/5g/
	ayw2RehzeDgfaWwthavbld5N0Fzjqersffx/7r7idEBMpfVTP+K3iSvoHLgBNa3vvF3VfFq2fHvkI
	sUKUQrX3obFNDbYwdNV1mkegxpu/1yVBm0Avrg7LkY6y1WatsFqPXaBt+701+m8eKfY6unZCADRQV
	yGntfYcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBif-0000000Eh6B-0Exc;
	Mon, 29 Jun 2026 13:08:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBid-0000000Eh3f-1yK9
	for linux-um@bombadil.infradead.org;
	Mon, 29 Jun 2026 13:08:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=qBDPSugJUvIfnZFt1AXtvZwTdTLodNQ1FcaAm4R/gOE=; b=SxGOgSgPe6L9M4fi1h54hc1Knx
	xzoBVb6B2uPIscpHZatsnlrs5OjtdJcCn5NGoIsetkr7vYWICOWfnvaRfb7r8a+hSkKaJiv42WP4M
	xUv9VDs6vC6nq+/sKdEJ7YLLEuoCKDfimnEx8TITNSIIeLi1BlNcDPSacgI+rILYlvLt+E4KZMmEc
	Rv7SDMf9YBdVmEv8yypL0da/gIcQnrvfTCiXIg9c8Yw4YEQGKjmsI/CRihj90gOJmVsVG46uVzYIH
	YMrARD2QqIOsqmlgYOcp8y29s7xByUA875SgU0TaS8EQojdiZJnkQI9PJrqMj3ArbhvIUKHy68YiX
	prVJ78JA==;
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1weBiB-000000011ez-3e9q
	for linux-um@lists.infradead.org;
	Mon, 29 Jun 2026 13:08:09 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qBDPSugJUvIfnZFt1AXtvZwTdTLodNQ1FcaAm4R/gOE=;
	b=a269f39ox2X1MkTEyXI82z8wRlh2JJbv7SBilR9vhgvdV6uTWvBdihcfse78JQYIlqynYIW5F
	E2XShrMwv0B62uSV2EBMVz/eH8zWz7eWC0+h8ubQLYc/rHkR7n0f5d0u1u+DXWnEfvHEbSxO0ei
	r7hDy9OeAn/yHuDDWTkavPM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gpmY51TlgzRhRT;
	Mon, 29 Jun 2026 20:58:17 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B76140579;
	Mon, 29 Jun 2026 21:07:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:07:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@HansenPartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <thuth@redhat.com>, <mark.rutland@arm.com>,
	<ada.coupriediaz@arm.com>, <kevin.brodsky@arm.com>, <linusw@kernel.org>,
	<yeoreum.yun@arm.com>, <song@kernel.org>, <james.morse@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <liqiang01@kylinos.cn>,
	<pengcan@kylinos.cn>, <ryan.roberts@arm.com>, <yangtiezhu@loongson.cn>,
	<sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>, <austin.kim@lge.com>,
	<jchrist@linux.ibm.com>, <arnd@arndb.de>, <thomas.weissschuh@linutronix.de>,
	<sohil.mehta@intel.com>, <andrew.cooper3@citrix.com>, <jgross@suse.com>,
	<kas@kernel.org>, <x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
Subject: [PATCH v16 11/18] arm64: ptrace: Align syscall exit work semantics with generic entry
Date: Mon, 29 Jun 2026 21:06:09 +0800
Message-ID: <20260629130616.642022-12-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629130616.642022-1-ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_140808_385637_95D9ABE9 
X-CRM114-Status: GOOD (  13.43  )
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

Streamline syscall_exit_to_user_mode_work() to align arm64's syscall
exit behavior with the generic entry framework.

[Rationale]
1. Unconditional RSEQ Execution: Relocate rseq_syscall() from the slow-path
   helper to the very beginning of syscall_exit_to_user_mode_work(). This
   ensures that RSEQ validation executes unconditionally across all exit
   scenarios, preventing it from being incorrectly bypassed on fast paths
   when CONFIG_DEBUG_RSEQ is active.

2. Centralized Exit Work Gating: Introduce the `_TIF_SYSCALL_EXIT_WORK`
   mask to aggregate exit thread flags and gate the execution of
   syscall_exit_work().

   Gating audit_syscall_exit() behind this exit-time check introduces
   no functional changes. The `SYSCALL_AUDIT` flag and its context are
   statically allocated via audit_alloc() at fork time and only freed via
   audit_free() at do_exit(). Since the flag remains persistent and static
   throughout syscall execution, checking `_TIF_SYSCALL_AUDIT` in the mask
   is fully equivalent to evaluating audit_context() inside
   audit_syscall_exit().

[Changes]
- Introduce the `_TIF_SYSCALL_EXIT_WORK` mask to bundle exit-specific
  flags.

- Relocate rseq_syscall() to run unconditionally on the outermost layer.

- Gate syscall_exit_work() via the new aggregated flag check to mirror
  the generic entry loop behavior.

No functional changes intended.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h     | 6 +++++-
 arch/arm64/include/asm/thread_info.h | 3 +++
 arch/arm64/kernel/ptrace.c           | 3 ---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 72461c22bb5e..b982398f8765 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -8,6 +8,7 @@
 #include <uapi/linux/audit.h>
 #include <linux/compat.h>
 #include <linux/err.h>
+#include <linux/rseq.h>
 
 typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
@@ -127,7 +128,10 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 {
 	unsigned long flags = read_thread_flags();
 
-	syscall_exit_work(regs, flags);
+	rseq_syscall(regs);
+
+	if (unlikely(flags & _TIF_SYSCALL_EXIT_WORK) || flags & _TIF_SINGLESTEP)
+		syscall_exit_work(regs, flags);
 }
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5d7fe3e153c8..56a2c9426a32 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -112,6 +112,9 @@ void arch_setup_new_exec(void);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_SYSCALL_EMU)
 
+#define _TIF_SYSCALL_EXIT_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
+				 _TIF_SYSCALL_TRACEPOINT)
+
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9ebe3389451c..05ceb9f2d038 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -28,7 +28,6 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
-#include <linux/rseq.h>
 
 #include <asm/compat.h>
 #include <asm/cpufeature.h>
@@ -2455,8 +2454,6 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 
 void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
 {
-	rseq_syscall(regs);
-
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
-- 
2.34.1


