Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5671ACCD18E
	for <linux-um@archiver.kernel.org>; Tue, 14 Oct 2025 23:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NfNsGle/18B0Bo7Y9O3EDhKrI4Nxt/CvZdDjQHWN1cg=; b=Mv7YbJBScEm363Q97gYlXf4ccG
	iHqliuJ1xJHmxhHTfd3/dPqICqMrx9R7FfdXzKK/R9VHPd+Edt+t5sCgbKpOiS82y2rqTP6gSBlzK
	L0f0MickA5QcujdbgUKO3neBVbH+kwjT7kU3D1LxfsbwNkjAxRCVohPIm0fMoNtVhXC6zne74zviu
	kl+E1EwIChLvD2ANlV/nms1zdgpazkmVzTHYvVlX1AHbt7bMfZp3G+8a//Cq6noeJXe8Xg+Ajv3Bm
	GjZJTIGpabPP3r2/CC0I7KQ+57WPeT61Nwa8aLX9XaF5MlPDdYW9acGyaGwIUc3phqlAfibuVkFSG
	pXh5QdxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQ4-000000002Fm-1QqL;
	Tue, 14 Oct 2025 23:27:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQ2-000000002Eu-0TGb
	for linux-um@lists.infradead.org;
	Tue, 14 Oct 2025 23:27:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E486451DD;
	Tue, 14 Oct 2025 23:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B5FC4CEE7;
	Tue, 14 Oct 2025 23:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484421;
	bh=5P1c3HZEgKsH8ctIgX15GY1ZMuJMbfzZtY7o952H6bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAIs28YoYYvTrrE6xrA4Mqu+f7sL30GgVRQxjsd5CChdUvpnaZYJYVeiDell/F2IN
	 H9pgChYZCjj9nKJS6e181RNvep2M6yeUfhzb/IJ2zfnLF659Eyjx3NQ8j/gvPXAYZS
	 x3cnJiO3jzpTH46snLMjJVB0vCMNNLOdcCQbHgYvmZWyhdKt8mw1l3HRCL6GSMC5bL
	 82BWfHUGktSP1x3HxRKj0fZ1SEBQAAYADoP5dMMel/SZpsWaTnMVrIPmh21IgYY2oD
	 2cS3lRg2oVeaon1x3iJ2d8VmUbt1sGjKjr+Jhie7/jUpc5cXeod+vjihF24pc6Hyts
	 dfD5G9P7ZgSZg==
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
Subject: [RFC PATCH 0/4] Enable Clang's Source-based Code Coverage and MC/DC for x86-64
Date: Tue, 14 Oct 2025 19:26:35 -0400
Message-ID: <20251014232639.673260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829181007.GA468030@ax162>
References: <20250829181007.GA468030@ax162>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_162702_189581_807A2A80 
X-CRM114-Status: GOOD (  11.03  )
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

This series adds support for Clang's Source-based Code Coverage to the
Linux kernel, enabling more accurate coverage measurement at the source
level compared to gcov. This is particularly valuable for safety-critical
use cases (automotive, medical, aerospace) where MC/DC coverage is required
for certification.

Changes since previous patchset [1]:
- Rebased on v6.18-rc1
- Adapted to lib/crypto reorganization (curve25519 exclusion moved to
  lib/crypto/Makefile)
- Minor correctness fixes throughout the codebase

The implementation has been tested with a kernel build using Clang 18+ and
boots successfully in a KVM environment with instrumentation enabled.

[1] https://lore.kernel.org/all/20240905043245.1389509-1-wentaoz5@illinois.edu/

Wentao Zhang (4):
  llvm-cov: add Clang's Source-based Code Coverage support
  llvm-cov: add Clang's MC/DC support
  x86: disable llvm-cov instrumentation
  x86: enable llvm-cov support

 Makefile                          |   9 ++
 arch/Kconfig                      |   1 +
 arch/x86/Kconfig                  |   2 +
 arch/x86/crypto/Makefile          |   1 +
 arch/x86/kernel/vmlinux.lds.S     |   2 +
 include/asm-generic/vmlinux.lds.h |  36 +++++
 kernel/Makefile                   |   1 +
 kernel/llvm-cov/Kconfig           | 121 ++++++++++++++
 kernel/llvm-cov/Makefile          |   8 +
 kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
 kernel/llvm-cov/llvm-cov.h        | 157 ++++++++++++++++++
 lib/crypto/Makefile               |   3 +-
 scripts/Makefile.lib              |  23 +++
 scripts/mod/modpost.c             |   2 +
 14 files changed, 618 insertions(+), 1 deletion(-)
 create mode 100644 kernel/llvm-cov/Kconfig
 create mode 100644 kernel/llvm-cov/Makefile
 create mode 100644 kernel/llvm-cov/fs.c
 create mode 100644 kernel/llvm-cov/llvm-cov.h

-- 
2.51.0


