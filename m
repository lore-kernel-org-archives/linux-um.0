Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A34CCD184
	for <linux-um@archiver.kernel.org>; Tue, 14 Oct 2025 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ahe+677CuItOdldLOvGaCypCb6CPjDUyBHc2bowxPwg=; b=Scpr0+sJ/jOoFhtgUjOdrDw68x
	1eIXmvxfzuKrYSn1MPErEuXMT3usEC7HIR/Jbm7XUVosojjbw7MUXHNbyqsnh42hYCiGQHhFmuj44
	m3Xv8FbmLkp4U7nTQ77W2p/BlYA2KHUGvtksx6hiGzFlEXAk0b2ArD4MIbOdkN2ghTcgd7a4/Oqxc
	xVSk1SEeMl/jsNfuYmvJ1EQl9Ft+I6uJSZW8IDGH8Y1qbOipXjY8QXjBatwAhXfOOtfSW5sU1TZM/
	/9jtMtkht8nKZYYuec5HSXkM/wHBGTbmYXi9UdkO1kPZkddlrwz4kT31u2Jl9w+JuKpbZqqUBbDw6
	t+Hanrbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQO-000000002SL-2wt2;
	Tue, 14 Oct 2025 23:27:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQM-000000002QT-1phE
	for linux-um@lists.infradead.org;
	Tue, 14 Oct 2025 23:27:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 05A5143323;
	Tue, 14 Oct 2025 23:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA00FC2BC9E;
	Tue, 14 Oct 2025 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484441;
	bh=1TpApqFhm/8zdJyy1fMGH2+/kuKom2S6e7bMBlVrzaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJhaVLVTpMS4DhVN7xy3hEHyuXzk6r43Kn+AEBSzU4LXGX5jF4QabLgDvRkZUOKH8
	 VFZxTTtQcb11/rIXUHJtJr+al0C307wX0VVOKSZg4oLtkQAEqIgWf7Ale4uJTxzLro
	 rtMyu3zruLexE+RU6YBjkWHr59gAB48cmJxSxWjpPE5JNxjffZGX+zfU7WWJHg4WR2
	 /U9nAL9NZcc8MvoBcG41B0tz1oz6SyABCYR5QmcwJHl0LG2AuADxSeXZ2ZhHA0/4gK
	 JZtRxO5EDXwMN97Dz8fuGlvmFVZ/ie8Mtmp5ZddzB8hF+nmbYd6y7PM3Qn+sqPnKbJ
	 z0eAFrjQwzmWg==
From: Sasha Levin <sashal@kernel.org>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	sashal@kernel.org,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: [RFC PATCH 4/4] x86: enable llvm-cov support
Date: Tue, 14 Oct 2025 19:26:39 -0400
Message-ID: <20251014232639.673260-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014232639.673260-1-sashal@kernel.org>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_162722_487572_D7DF21C2 
X-CRM114-Status: UNSURE (   7.41  )
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

From: Wentao Zhang <wentaoz5@illinois.edu>

Set ARCH_HAS_* options to "y" in kconfig and include section description in
linker script.

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig              | 2 ++
 arch/x86/kernel/vmlinux.lds.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a2..7764562df838b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -90,6 +90,8 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_LLVM_COV		if X86_64
+	select ARCH_HAS_LLVM_COV_PROFILE_ALL	if X86_64
 	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d7af4a64c211b..d2caff2a1abff 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -203,6 +203,8 @@ SECTIONS
 
 	BUG_TABLE
 
+	LLVM_COV_DATA
+
 	ORC_UNWIND_TABLE
 
 	/* Init code and data - will be freed after init */
-- 
2.51.0


