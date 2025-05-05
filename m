Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94440C3ABBF
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIjkiEFBWewgxkCT3o5kIdfw8QqlWQhMgYlQjugXgRk=; b=hk2uTraG2bO4hTrALsorfRT0A9
	vvVC1jUrbhghlMAajVIUeahpaxgBdFmM29Yo2UeUD+JyPb41S8l58+nYj5y4O2/UwAIBY3Pm2ZwKN
	GesKjQ/SWPdlwDavb2EgpDu0TSnanhqwrT2Rg47CAzgZh6VsIzSmwR6efGdAUa6acidIBCn6tjYTm
	SDIIVJhUqNySZK2FbJRjZRzBAIKmRclISD0uzPHCYvVj4cEGIS5RG9yTHr+zy/7i8A+iXxD0SVxPc
	ZdDApCwxRz76ArHew6PgLvNx3CQRJS14Il1H/BYjAmC0X5IbB2m6RPOhxE9wuCRivpJBQhFQ2WFZS
	+uobRmeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC6fH-00000009Phi-0cM2;
	Tue, 06 May 2025 01:00:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4W4-00000008q1c-1DAg
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 22:42:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 57ABB44BE7;
	Mon,  5 May 2025 22:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CA8C4CEED;
	Mon,  5 May 2025 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484947;
	bh=kB3Of2TAfMWjq4ISnDkHwtPTUxxjDoqlJgVbF9jFa5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEW8USIOHYaxsOxllC0RCLxuGJfEibAjzNccldMpjj/NmOw73MX78T3IQom6QS8hh
	 B3FFcKY6NThbXniWQt1p3pxTMqd4bgOs4gnjDYWbSlhFVtOqM1x5fAZLyIwzJGFKqZ
	 d/wXcMCHvq2XnOo6pxpdT/a1+R6sx+/mb5/UjBDume4afUY14mmJpHfXgQmDNXvgU1
	 yLyJ170yA93RwBGmjsCM6nGrXWgX9gosloq2FtQGiVM5aXu0CATjovcpHARgDo7T/f
	 9+icDeIqu9EaX7sFXS/4XPd9w6ojbEYD8aFswcup6Bfmh1cGhS30AsMpkMTuYLEGm0
	 ktUs+LRSHEzJw==
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
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 090/486] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 18:32:46 -0400
Message-Id: <20250505223922.2682012-90-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_154228_347843_43F280EB 
X-CRM114-Status: UNSURE (   8.03  )
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
index a5b4fe2ad9315..6ca9ea4a230bc 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -70,6 +70,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


