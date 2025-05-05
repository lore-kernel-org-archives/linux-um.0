Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057C4C3ABBC
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 03:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f5CgtVL0OD+7QeWoeIkCdI59+o9TsWaIbhIkJyzaQMw=; b=jPHEs49x7BQzwOLRYp/AHwxNFg
	hUs9EUDX0RkA6D6U/lVgEJGi8XBMQlUPEJME4Y2wyTMjHUI0VKfy/NCgVJlynn0j3jMXkkZGV8JPc
	IrI/CRt2LwDHp5vkBJBKC1N6ZQz8uM+mTxP0Q1DQ/828vu/ccL3CKsYkigsLy/addUZo+nQEaAJzK
	FMqtbZSVhappaAD6rPSrE3dFdUtjmgTvpQX8MQm9lnwGEFxCak35fCR7fth2RKrOa/FLC7JDFbJcR
	bD11m7K+SQA6K/O6M86KIJcD53mt9Xi49+IRCbk2EBbh1Co07RPyMYC6gCQdjaM8L1xbvKU5PtfAh
	10Ei3XGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC8yH-00000009zRt-1OF5;
	Tue, 06 May 2025 03:27:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4ub-00000008xg8-01HX
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 23:07:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 57ECA5C00B3;
	Mon,  5 May 2025 23:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5138C4CEE4;
	Mon,  5 May 2025 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486468;
	bh=rK8UgpSEnGG6WpUj0pfBe+FyfH9qHFqoFjKvOIgzK70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jz6UImvYDtBD0ScAzErGDFaG2YYpR+y9P6O+8fLP0p6vRY7YpbXooqAiH4GEeW1wU
	 rx8ehehmNok4gTJcoa4dM8FcpvXDQYxRiniOmpO5y8g00S7WTEnJ1UVZ9XAkoqFuFD
	 UwVjbz3uef7P7HzmsxiBrzkf80XtIqae/Zd0pud5RPvnMZ3CDi+yj12rLKrr/DyDDU
	 ShCDxbHTqpTFtXceZKnm8IxiqRcU6PNFLl3PdWs7it1fk7yRU2A9ibqtPUqeo3ODLY
	 AGm/xQZboNC1FfDMbHBeYxUWyI+X01z9Pyhoi61BszcaQRNIjWa1VHZ/IUMkDG9cyC
	 gDFPs+puk2zPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	rppt@kernel.org,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 045/212] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:03:37 -0400
Message-Id: <20250505230624.2692522-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_160749_074510_69555E2F 
X-CRM114-Status: UNSURE (   7.74  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit e82cf3051e6193f61e03898f8dba035199064d36 ]

When uml_reserved is updated, min_low_pfn must also be updated
accordingly. Otherwise, min_low_pfn will not accurately reflect
the lowest available PFN.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250221041855.1156109-1-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 38d5a71a579bc..f6c766b2bdf5e 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -68,6 +68,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


