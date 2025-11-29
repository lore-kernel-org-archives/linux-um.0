Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95081CFD2F6
	for <linux-um@archiver.kernel.org>; Sat, 29 Nov 2025 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5bGQMHmHt61Y2L4ZBW8mkFAUL1LgjmOuklaN1EBIrcI=; b=FqRvhpFCbxleSdpRaOLBizcVyd
	nkTuwSnFVnxu8qKpObd+644hk1Xy9dNYHxvViqQfW8XjVCmrjBsWvR12DozJ+H2aQgHe9lixheuuE
	1nmo7rIhBqpnm8Nivcw13X2fqa0akgDAFUjmUwCS0GifqqCtVrTOVp5LxhJyDxp4styrfuxZKsSqG
	If3M2pOCPPP51iHACS49NZSYeUjPXD3jT3MZLrsSvlFfgQcLryNLCu0dwC/71oi2kSeVSeL6z+jSS
	/IzMMiXf8Oy7AbJx6Ah8X032NndPLsXkP+ZrBkPl4JN2EOajPS79Uol3fkT7ReRKANyhMGhEWBmSb
	o1VkyJfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPHgw-00000001RpV-26rJ;
	Sat, 29 Nov 2025 09:56:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPHgu-00000001RpA-2cQJ
	for linux-um@lists.infradead.org;
	Sat, 29 Nov 2025 09:56:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 53D8E4012D;
	Sat, 29 Nov 2025 09:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6411C4CEF7;
	Sat, 29 Nov 2025 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764410191;
	bh=D332WuuSN2u8Im5Q2thvdLGIXxokqDby1Zp25sCFMuI=;
	h=From:To:Cc:Subject:Date:From;
	b=LP38N3eiRVkhVx6YBFOP1pRu2z2ElZi5NuyK4d5LGGqThAhfgLVa6qvabi79zMHxc
	 fyC7qNNcwv5/n0kzkF+5l38/sIj7AbVQQMJJxq+gvukFvRVei2ikHcJM1BpFr+8sVe
	 nJGhYzBKiQScIV4QNBD4I5cs/9U4H9dtf6Mp8oApgQ38UyokqQoAxYa+jqTCRCgFDj
	 8EwDJM/zNNkEmTHV7k6S1Ws8ghq6nDqGjLzTQi5UvxsX7XD/bdg4WBwTIQqFJ7Pw+D
	 5z1zwUFfUe9qBm9F/Mlb9wFoZ+Zm7d6+zcB7ZN7z2JghxWQYmdZA207NHmU6amZs1f
	 HfoG+XiWSLTNw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] um: Disable KASAN_INLINE when STATIC_LINK is selected
Date: Sat, 29 Nov 2025 10:56:02 +0100
Message-ID: <2620ab0bbba640b6237c50b9c0dca1c7d1142f5d.1764410067.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=chleroy@kernel.org; h=from:subject:message-id; bh=D332WuuSN2u8Im5Q2thvdLGIXxokqDby1Zp25sCFMuI=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRqHTY2T45b7xlWMXfp+VdnYhaKHBex8K7gib0oznZJ6 q1ER5V/RykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZjIPRWG/xEphwTWuEXyi//y SW54e4fF99G/U++2P6hnllltebytU4WRYVPItAv8uc6nL9fIRseFnlE5mj47j/lIUq7Kqk/dVwy 7GAA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251129_015632_687435_1F0C23A8 
X-CRM114-Status: UNSURE (   8.94  )
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

um doesn't support KASAN_INLINE together with STATIC_LINK.

Instead of failing the build, disable KASAN_INLINE when
STATIC_LINK is selected.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511290451.x9GZVJ1l-lkp@intel.com/
Fixes: 1e338f4d99e6 ("kasan: introduce ARCH_DEFER_KASAN and unify static key across modes")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/um/Kconfig             | 1 +
 arch/um/include/asm/kasan.h | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 49781bee7905..93ed850d508e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_DISABLE_KASAN_INLINE if STATIC_LINK
 	select ARCH_NEEDS_DEFER_KASAN if STATIC_LINK
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CACHE_LINE_SIZE
diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index b54a4e937fd1..81bcdc0f962e 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,10 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-
-#if defined(CONFIG_STATIC_LINK) && defined(CONFIG_KASAN_INLINE)
-#error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
-#endif
 #else
 static inline void kasan_init(void) { }
 #endif /* CONFIG_KASAN */
-- 
2.49.0


