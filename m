Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AEAC3ABBF
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRpa309JxCh1By5Bi+wkmjg3q0ZcXJ6mrArix0u9YP4=; b=LNPOzBU4rmcsHWPKmSGX+UVEG9
	Wycudrx3QOOipKIGMap0eA7afreLCPHG0yxgbg6A21oHlJcsalbAQ7TfoZjT1JXSPXoHR1tjBCkIo
	galkFYoo6NLGawYkPENrmceRfcj5AQQrtcp0OR6C/HE9+F7f7ecEAvVbSxacvIQW3/P9s8KACKb3s
	wPaNOoM9Uh5OxGABUU8a72o5DLDYBR6LY2eL6vaekdg7zcMzCtxyLVWohtWuOfDmmqwnkQ+LD9opB
	/Qfo1d2d3bGKg4Ihq84248gU+XfcoNiulAk27qE+sehnivSBXiSn8p+x+AIy4hb9K9uBmKiWe1TlA
	8xvohEdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4fG-00000008syY-2iNF;
	Mon, 05 May 2025 22:51:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC49e-00000008ilq-40Of
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 22:19:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 29A0B5C108A;
	Mon,  5 May 2025 22:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A510C4CEE4;
	Mon,  5 May 2025 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483558;
	bh=3UEqT/+fIc974jJeUM8R4SRv1mtRRd3KVFibWheaoyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQJRpNF6WSpMW3rVVPyZqLvNyKywQGN7LCch4fkRynSLNJLXG7+xMLV8KmqwuWO3D
	 NzFQtBId34avcgFZgxuDzQBPxWbE0w7DmAQ/XmYKoYw05golDLpkUqI0PWm/2EBKK9
	 rM8vNLqmytY2DURjmvSRq3huw8CZMrfoKhD7bHOfulM4RZn1kFVGRvo7TKhXE8CZvm
	 +3Z28Jv328vO79764t9YpsNrYfqR/jBMTownyVGR20hFtu3cOpH5hq0J52CHkuncqA
	 yg4zv8VikOmHHXEquM5vB7SUGfswl6Qo+H+BLyMBGBwelSyY5vpujFokjVo2bmKJ5D
	 +3eDNptPqKtWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 114/642] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 18:05:30 -0400
Message-Id: <20250505221419.2672473-114-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_151922_072446_1D91C776 
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
index befed230aac28..91b7710c0a5f4 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -66,6 +66,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


