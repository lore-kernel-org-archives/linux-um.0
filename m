Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF16082BE1
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oVBAYPr5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+j7Y3YJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GqcWEQ1VRg+ccd2eEjcUctdPiQFmVOTmfqLuCh8z6ec=; b=oVBAYPr5nvec56
	r3EYQWLZqF81blLuCUfvBL2yy2NX5u0YRM3PRKW6rPb2L5c0cccgrxj1zZp6NMeLD70islL1pDL3k
	uSeHS2BQlZud/NZfXOm56jDDyBoS2cIscr3jDv8MiWdLr6/jCZGBgHeQK0lFM38rmz07GZ7NOO0wK
	wUFQVXjFiXUIvBS7aQ54g4vMJrKsz7Iz+KV7v6DNF1syglUMfYUCyR9mweMGPKuDABsWB81h2N5GD
	hl6Eyt0one+Gk7e4duI9Xo1jQ1LtKcNtoQKEqKIiVmLOe2K3sayLJEDkpYofkJZwdEzA/7s/wWr/A
	973JDkSbYdQ//iCeoYGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Qv-00000009ecq-01YI;
	Thu, 05 Nov 2026 16:35:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Qh-00000009eYv-0A19
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:35:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 799A260A56;
	Thu,  5 Nov 2026 16:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EBB1F00919;
	Thu,  5 Nov 2026 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896510;
	bh=GqcWEQ1VRg+ccd2eEjcUctdPiQFmVOTmfqLuCh8z6ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+j7Y3YJjsE20Sue5GfwqQINtPxgqaF84BY36sEXqgIR67MJhZa7kQEHayZQLspZA
	 y781Nu26erj76D6fCE04haQsfEl+BH9Q8c0o1tdZUtzO7FyGHfYMJtfmt4q2+f74Uq
	 G5p/hA0y1kY4Pz7NpL16tJK/bcUpbgBZretJqVwYAhOfHZWNGHB2mMP12bZ8Xt2hZ4
	 I5Bet3pNOnCukp/14WqG2twgFL739fTxd6mQEJexaBSNm19WiNgPc12Jpa6fUIyPvB
	 OT97GMMdtrv4rLq7knsvNNlxEq1SWWgG9sko6JjhV/mJiynlOYNRvfUNsKpWMeYcOX
	 eEtiZdT/3W37A==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 4/7] x86: require minimum 64 byte cache lines
Date: Thu,  5 Nov 2026 17:34:35 +0100
Message-ID: <20261105163440.2381661-5-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163440.2381661-1-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

Later x86-32 CPUs like Pentium-M, K7 and Atom use 64 byte cache lines
and are incompatible with kernels built for smaller values of
X86_L1_CACHE_SHIFT.

Pentium-4 CPUs have 128 byte cache lines but are compatible with
cache operations that expect the lines to be 64 bytes.

Older CPUs have smaller cache lines of 16 or 32 bytes but work
correctly when X86_L1_CACHE_SHIFT is set to a larger value.

Remove the per-CPU tuning and always build for 64 or 128 byte
cache lines that work correctly in any CPU.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 832e4bd9f6e0..382c9023c855 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -180,8 +180,8 @@ config MVIAC7
 	bool "VIA C7"
 	depends on X86_32
 	help
-	  Select this for a VIA C7.  Selecting this uses the correct cache
-	  shift and tells gcc to treat the CPU as a 686.
+	  Select this for a VIA C7.  Selecting this tells gcc to treat the
+	  CPU as a 686.
 
 config MATOM
 	bool "Intel Atom"
@@ -250,9 +250,7 @@ config X86_INTERNODE_CACHE_SHIFT
 config X86_L1_CACHE_SHIFT
 	int
 	default "7" if MPENTIUM4
-	default "6" if MK7 || MPENTIUMM || MATOM || MVIAC7 || X86_GENERIC || X86_64
-	default "4" if MGEODEGX1
-	default "5" if MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MVIAC3_2 || MGEODE_LX
+	default "6"
 
 config X86_F00F_BUG
 	def_bool y
-- 
2.53.0


