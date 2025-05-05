Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD19C3ABBE
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 04:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3//fPmFFCtxpVU2sp6og8z5EnTcFJbEbbMvNc1DzSeI=; b=VSmdY+AhKe7iG3FO22zict/lck
	PQFgU9N7owhyfQIRi66LmWy+1Pp45nufS+XkC6n2DVVNSdLvM7Nia/coeKm6K4y4/mS+UjfOJHKsL
	sZUvQmLOBMlkrc4X98JHAd+DTWU4G9ueVJ6JeXVBxbYZY72gzoX2CAsJ6n5HiyOh1J2VaNTqSmYE3
	K7Xe2ym04BYTjqtrinCbDoIjCSJ7f7lJlDB8JNTnjnEgyEsw8mYCs8CDJd4h/fqa3wO7vuuV0IqzG
	9eYRsjFFCyGbHRJAE9ajem4Pa9zD31OPOQEUSH1skhWlktT494WOYeDZyGHl8k/M/b/A+WQxJnvGL
	fEB6Oy+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAIt-0000000AJ4s-1B75;
	Tue, 06 May 2025 04:53:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC58h-000000091sD-3ou1
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 23:22:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1475C5C5BB5;
	Mon,  5 May 2025 23:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605FFC4CEE4;
	Mon,  5 May 2025 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487342;
	bh=dhO1wySfaom7bX0z5B2dpNT2HGt71Dc6VZn6YqH1lgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pm69Mmf7cPq4nylToYoYWEqM5zGM6MzPyHAgrFywlKUKQGIgTwhb2lxvzxbbloPUD
	 Iz1IEkDRfyxjDt9pYfwUHt4FiG1WZfoN2D63XXtji6w6HbN00hGW9Ao6YxyeFsx8Je
	 DpgXsKQBZPCjIlXPgVgxfgvoZdaYneJivwyLE9hzu9A/Ci3DrfNhuD0cTf/K1bqO8U
	 hrbIaI6UJrR4vv/GAZwKXKq/8bV9XSJIpLm+cnYcM1wfgmJmt0yQPmG73aF7T3O31u
	 0DN6kWI/l+nXlARbZzxwNffCCeWRXTNxetl29SUK391hVJ02WR0/VrA1QmhRWZZFL9
	 6xHI1M1MJpB/A==
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
Subject: [PATCH AUTOSEL 5.4 17/79] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:20:49 -0400
Message-Id: <20250505232151.2698893-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_162224_005781_E7B3C4CD 
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
index 417ff647fb377..06fb50218136d 100644
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


