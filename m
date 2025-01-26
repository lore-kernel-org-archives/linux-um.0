Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE2C02181
	for <linux-um@archiver.kernel.org>; Sun, 26 Jan 2025 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMCcoKmYu2iXUwJbQTVGV2jsmkWbYCGb/CE1d3c5aKw=; b=kXrdG51QQl0mMKh/KeCZUfRDhC
	QVoEq5GtxPntJ6L9d7CV61VzGYVFNtQsIoaxGstIwn+ht323f5JyZksRK6kxnDL+BJg49mFlyMMPH
	3ZKVcyNGVH3g4DbMNxbctwr//O1Xc6dNTaU+5DkKj7HfMWeMsoWGdbz8ZUpYVsvudT03Zt9cbTHee
	m7YmaZdkA0nzm5sxx3YL5Sv/VaCzJn2rXtJS6uwYR/NFZzn2a5X0MNPkd5PtkzfaHP6dqev0KHpRe
	kPc7SZbYWozGWjM9iClY2jB6SUA8UFTHT/5McM8ZBAOz4c7bR+T6hBgUQjGXuwfdsyYYx5j/R+WX7
	b7jxx2zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbxOZ-0000000HDQr-2EWN;
	Sun, 26 Jan 2025 07:49:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbxOX-0000000HDOM-1kWE
	for linux-um@lists.infradead.org;
	Sun, 26 Jan 2025 07:49:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AFF8B5C0706;
	Sun, 26 Jan 2025 07:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B87C4CED3;
	Sun, 26 Jan 2025 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877764;
	bh=iCOJADJJ/sFPbuOid5OXzq1M+MQ1WlHyV9KAisT6QLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4s+daeo5ZtRx6Gu4vJ/P5va2/Zc1aBNvpydz9rKkSVitnt5s4tQ4p7lT4T7koHi2
	 wvqpFOfNIJ4JvEi6mI2AH0DeuLwKbVe3rJ5HBW4E9DuKwRa24y9nMYZzZEoMxFBPuj
	 r3lfMvP/zDLkxMw27lf06oOh8SETm1Dsfzs9boTj7kyerxd4kK4XYTdJQnf5NnqRU7
	 2nOaBRt/YCtwpuvvVDC9No5WR+kbAukE44WO5GnFFgtxx9m3AtHPGru2xrot7i52tK
	 my4z9DG0wF6kJFGXr/ty1oVp9XX+EnLvBW/nOKu6f8wEe7Q70aCehyXls3uZlat3aP
	 plrNoZEvAzEAA==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	live-patching@vger.kernel.org
Subject: [PATCH v3 9/9] x86: re-enable EXECMEM_ROX support
Date: Sun, 26 Jan 2025 09:47:33 +0200
Message-ID: <20250126074733.1384926-10-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250126074733.1384926-1-rppt@kernel.org>
References: <20250126074733.1384926-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250125_234925_497526_E44AA2E0 
X-CRM114-Status: UNSURE (   9.59  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

after rework of execmem ROX caches

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ef6cfea9df73..9d7bd0ae48c4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,6 +83,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_EXECMEM_ROX		if X86_64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
-- 
2.45.2


