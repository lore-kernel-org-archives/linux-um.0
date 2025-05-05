Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525FDC3ABBC
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 04:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C77HDEBKWlfI32FNqP696U/05wK/KB8olYFpghgcBdg=; b=nygnTFpiL54Kbz7kJQ4OMgDWe/
	LjnhPl+L4IZFPC88ulPX5B2c4gjwqi7UMNengcAb5WH2u2wKw3wJd+z1Ce+o0CamlkTvfX1WBRqkd
	BiyIsjNMeOrFC3R39FAQGOhyzhD8iPV57xQjtUegoMQMT/pvC8fxcD7Ggf7WxA90SfW+T7guQPxwz
	dzC1fowMEhUGZZ++c0CwQC29UpptAC5iBLjrSp74vfsrAFqkBIDwp95oAb5Ytb7fEMbhKaKyQyCEx
	TbwszNL9lTlvaDGQndDeWq7+7zeOvIo2n+Z9rKmIGqeLQA5Yu+KWFkaalI1P9UjdOdO2cIr5f9ne9
	lyxk5xaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCA2p-0000000AFTx-3UCK;
	Tue, 06 May 2025 04:36:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC55W-000000090tg-18Xe
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 23:19:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 54C1B4A2E5;
	Mon,  5 May 2025 23:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5750CC4CEED;
	Mon,  5 May 2025 23:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487145;
	bh=ZkpvWBITQF3SKmzOdsoI+6jMbMBW9mXE+YR6udQhi5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBgvUz8inIu4dCrFegoVNNe0j8Sr0g6c/KPWsgA7rzuPLbRjKxizY8+eLpwOtSCHg
	 RkMW8cDHgdomZsb6qw1cduHNsIhhoA+CYUPjODgAjk4HHO4ZVT+K4tYLFoVgHIc8jZ
	 e1xsvodKX286Bo5KZncNHxFk11pSUKAplRHtL1OCXbt4i0zLsCTEsrKpLoitBA6iwc
	 eGKdWqfCciaQHjOWzWXD7A4umXhpzi4lssJjk9u6p7eGukqgyCA/JsPCzXCZTygnDP
	 nFudmB8xcAeS5aBdUpzbdt8/gVKjiU52U5FWgkcQSbDCsBh072R8R9NCSCZm9kRzmb
	 HTPg24njePH5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	dave.hansen@linux.intel.com,
	benjamin.berg@intel.com,
	richard.weiyang@gmail.com,
	kevin.brodsky@arm.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 023/114] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:16:46 -0400
Message-Id: <20250505231817.2697367-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_161906_327082_31FF69F4 
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
index 9242dc91d7519..268a238f4f9cf 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -49,6 +49,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


