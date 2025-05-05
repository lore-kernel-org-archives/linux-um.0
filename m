Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A129C3ABBC
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+WU556vJTmYNNRrARAzL1H32vbFMm77+aMknJ+QnyI=; b=JH+/W3VXcY2G6UYxCCM/EU5Wfb
	/BW31Z09pUE7pPD5SYFmE6mkWKIqQ1AvSgFaB0CVNP3vR/ZxieGQrr82HwNZ0u4dzLpZUlbzy0XeE
	Ud7aSDR5YT/rY39oltQajZCCB9D3x38Qkh2l0WK0wY/fx7gRaqcd6/NfMMAPO6iYybg8Fsc09w0bk
	iq8Ubg5AibraQK+ixgKBOpCuW5/6ImPGh/luMnWMtGNCLBoPG9KwCkZs781I5lBFRQUeNRyggWUgk
	CwADuxkjfEO05sTpXumpWBBtC3LYPkFVuKuHwztr7T0IME5gRD8ywOJ/fO/ezr9VFwO1to3SCRKaj
	jaHz9epA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC9gZ-0000000AA1H-3TSG;
	Tue, 06 May 2025 04:13:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC50z-00000008zVI-444F
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 23:14:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3F5345C5BB4;
	Mon,  5 May 2025 23:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5BCC4CEEE;
	Mon,  5 May 2025 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486865;
	bh=jW2FA8xm5AtnwtzEyIHUOqLCaeKwfjzLkHKUUBQWPc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3gjmvPOn+Yp68q+mWQa0hxPvEiaMtzfP2IFNoBynVcmFfA3sBbFB+xsTwoZ+g8Ge
	 ieqi95AOESX8836K7APzDJIIqtLZGkRJgLBxhug6GlD9AtGp4aHIflOQdaMHxy3zgM
	 PiHOm/F8lyMsVziRTFTgg5lt3btK7hlXOyj2Q8W2s0QR/zfbeVxO7ZiFI/gHsFyxxI
	 W9Z2+7Vieu88mtb65YGPXy6U4BY0apHOQ/Xs+beISj3I+JXBwSFEPyW6vy7Lqb+vjw
	 svqvTXMcjw5891gPY9avt0UmkbCyBYnrI+ioaH3vbJKxb2cJuXzdxRVhJaYltjoSRY
	 3gdsNhIwEvx5g==
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
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 032/153] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:11:19 -0400
Message-Id: <20250505231320.2695319-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_161426_048605_3D08DA99 
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
index 8e636ce029495..50be04f7b40f3 100644
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


