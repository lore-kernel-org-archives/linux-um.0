Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C3ECA101F
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uB+ZeSs+X9NMubgvNrYfiWUR+gb4lauP6HMzVhv7NVY=; b=xGIS0NhL7+71nSyzPNl1EmHIj5
	+Amk9xsT7WW3RXJStpT9eiaBoGj4irpELRfD+glhivjWXykoN91uOfvL5zj03ArN+qEVQ5RMKHhkV
	cDqUIo/Lq9OcEcrctTNgCXtvu5mzjwZNe/eK6oXziJMSHsCDh2K7PpFZ2RiZVbH5A70toorytlTYj
	6NHJ0oqiCxesfPQA+4pE0VstUVav29r7C9yv1Bl4W8l726IMIisfIrtn1Rn5IPNhE7v69eyntI47S
	ESxc2YsdXxiY7pcjyoFaeqVVqJzBPGDbJnOM6QJqfB5UF/GEiZq88xu2RJcsRLMxTN3EmT8/z8GKV
	WvZLM1Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XP-000000031o3-0qZn;
	Mon, 15 Sep 2025 07:22:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XM-000000031iv-0EC4
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uB+ZeSs+X9NMubgvNrYfiWUR+gb4lauP6HMzVhv7NVY=;
	t=1757920927; x=1759130527; b=UKoBtNfWMhgbIhpf2z1rr4VuHRf+rm0r+XQQS4Xr4Z8yB4+
	6Zn05qqhf2xuqPuH14AoWEPUbpneqzN/uVFkt8zlQrrDpCs7ZSoBbwVU7aOyvlu2O6/8Oq+svB621
	FaWBf8ImCnkpRFp+gataEa5KKXOzFIKYVUwnXHkeL33INY1CODlPuW4V/Kn3HtrV+wZxsefX0oRpS
	76T6i/9q7XAcNJHAk9AVsIasw83bZvm09Q/QDGsb2UENMLG8J1JzSmH+5g79lcCl3SwX7US/Ww427
	ekhhxEfFTRm88bqsT288XZhQdGnCKcxvEQzja/28bi6TE6/nuuf+V0JXJxFsADiQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XJ-00000005w6o-2p6w;
	Mon, 15 Sep 2025 09:22:05 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 5/9] tools/nolibc: use __fallthrough__ rather than fallthrough
Date: Mon, 15 Sep 2025 09:11:11 +0200
Message-ID: <20250915071115.1429196-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002208_092107_ED6C5C30 
X-CRM114-Status: GOOD (  10.28  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Use the version of the attribute with underscores to avoid issues if
fallthrough has been defined by another header file already.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 369cfb5a0e78..87090bbc53e0 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -41,8 +41,8 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* __nolibc_has_attribute(no_stack_protector) */
 
-#if __nolibc_has_attribute(fallthrough)
-#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
+#if __nolibc_has_attribute(__fallthrough__)
+#  define __nolibc_fallthrough do { } while (0); __attribute__((__fallthrough__))
 #else
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
-- 
2.51.0


