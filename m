Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDADCCF9E5
	for <linux-um@archiver.kernel.org>; Mon, 27 Oct 2025 00:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PrMNLYQkZylc5n1vPcSLoxov+KMpq+EjdZMAgd4fn0=; b=z3WjyJ+64/QnmTMomHXANgJ1zF
	3tmPXB3ZnaNpDRmYxSinwfpEut+tQGi6nBPVqaRgQpaSkopEih48SYByrsvF7ghJOxCqQCXcz9cmk
	GupJsHbSk6VTVr5YqRQdHBBpZAvy3NxaQLtKkqt+BvOB9QA4aHzMq86QQeJ3ng4WBdsBxjCVzNYZQ
	uSMBnI/bJLm4sg7FfAgi6Kfk2AKa6iWu9QQ71jTesGqBRhdE/j+EVFHDgF/2GSdBUDlMGlJut/2xO
	BdbG6UsrucdiaPWnllr0rBtY2HAUX23AtUQxHnWxxbOjkF/xEoHCjDVxE7hmNWYsUI6L5nVvEPVyx
	NtOpjQ/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwt-0000000CtVk-2mnD;
	Mon, 27 Oct 2025 00:18:59 +0000
Received: from out-184.mta0.migadu.com ([2001:41d0:1004:224b::b8])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAwq-0000000CtTL-46Mi
	for linux-um@lists.infradead.org;
	Mon, 27 Oct 2025 00:18:58 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PrMNLYQkZylc5n1vPcSLoxov+KMpq+EjdZMAgd4fn0=;
	b=RPgmt2Zq6/tx29vMni0i4vk0rs03J2goYZRIH8kXNfJhbpqasu7y1B0zMn8hKwCXEPeRP2
	qwDRg3vvxoovXEYMOlt9+n+Z0yig9GffQJYFsm/34VSXyt2CPF9HjxN5bm4nQXrTs1vluh
	LWujaIofUYT619yAVrtIlDeTgGBqcJw=
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
Subject: [PATCH v4 8/8] um: Enable SMP support on x86
Date: Mon, 27 Oct 2025 08:18:15 +0800
Message-Id: <20251027001815.1666872-9-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_171857_336519_14076995 
X-CRM114-Status: GOOD (  11.53  )
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

Implement spinlock support for SMP on UML/x86, leveraging x86's
spinlock implementation. In addition, to support SMP on CPUs that
do not support CX8, some additional work is required. However,
considering that such CPUs are already very outdated, and x86 is
also removing support for them [1], let's enable SMP support only
on CPUs that support CX8.

[1] https://lore.kernel.org/lkml/20250515085708.2510123-1-mingo@kernel.org/

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/Kconfig        | 3 +++
 arch/x86/um/asm/spinlock.h | 8 ++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/x86/um/asm/spinlock.h

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 986045d5e638..c52fb5cb8d21 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -9,8 +9,11 @@ endmenu
 config UML_X86
 	def_bool y
 	select ARCH_BINFMT_ELF_EXTRA_PHDRS if X86_32
+	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
diff --git a/arch/x86/um/asm/spinlock.h b/arch/x86/um/asm/spinlock.h
new file mode 100644
index 000000000000..20fc77514214
--- /dev/null
+++ b/arch/x86/um/asm/spinlock.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_UM_SPINLOCK_H
+#define __ASM_UM_SPINLOCK_H
+
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+#endif /* __ASM_UM_SPINLOCK_H */
-- 
2.34.1


