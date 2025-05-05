Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521E3C3ABC2
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 02:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f5CgtVL0OD+7QeWoeIkCdI59+o9TsWaIbhIkJyzaQMw=; b=SSwC9ULK8VrTDaNA3ogSEVBa2R
	22eGxjau7OTZDTORJuvtiJTA09YEbvQqqAjYDktLH6si/3awcodEvgeDwpVpl48kz+tvoPxTXrGfH
	ZENzikHUc7qBn17RLZ6DjgCwtSQIPJVR5ezg41DdLPWyXTuM3FGPS2IOzJ7cBgfDnMrHVaJwlkSia
	4BvMJDz8+1KXjCRYxTpKGcIEdOiTH4fx2rOCb+IA/gcvKiHdVJaQGYDcpUoTWGWTII+E971A52Hjw
	Rm4V5UydAU7UlHj2DjWhUEmBn9jF9RAgOCtWY6/vwWxV/bj+QqBDONTNAHq8vcHNmPFH4eD7Auu+r
	RfXJsCNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC83K-00000009l5w-1P7e;
	Tue, 06 May 2025 02:29:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4lS-00000008v6C-0fGw
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 22:58:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CF5C8A4D29A;
	Mon,  5 May 2025 22:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA8BC4CEE4;
	Mon,  5 May 2025 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485901;
	bh=rK8UgpSEnGG6WpUj0pfBe+FyfH9qHFqoFjKvOIgzK70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2rvLQQzRDJ3JsLrKEzd/ot0nZ2Gf34/MzzJ6uWzRWjD+ncZ1w6ZkC/dUwKlb/kfC
	 oyEycdzXDsm8XfTKGTPM+Cf0cSjWGFT1hT8eq5Mr6meSUjmOWpO5MR/iHsqCGkKfpO
	 SoGnRvCYjJRVZ5GB6n+WiryMbQVzyVa4aWWd5dXueTj18Ruq3UTZPHI+UGzG9H9jDZ
	 wFDMSPxCKjakJTuTCHN0Htes/Hg6eormlulUbV7MtMZ6rnCsp2IyHuyreAnbuTM9s9
	 T+S3mjgOL2uGdfLMbcddSk+iETMpKKKH98aq46xwrTib9Ko5dlS81Cy5ELY6yo1zB7
	 xppwSbHuPiSYw==
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
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 055/294] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 18:52:35 -0400
Message-Id: <20250505225634.2688578-55-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_155822_266944_80BE21C9 
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


