Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E719BCA0FF2
	for <linux-um@archiver.kernel.org>; Mon,  1 Sep 2025 00:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TPcfxaTdDhg22VmLjR3XOESkn45TTo7jogJbDCUiOmo=; b=Uxi5/lIN+/Jngb/71owAlMU8ly
	mO2LuCN1l4l66vkgH3If9F/nOeyxT16v4Uk7tTldE260NJT6xE4ta5terjpyF2ZPlOAuLN1b9Kx0m
	5MDQkwYkfd8PiJ4fHtQjBNDGOsWKciQGW08cpFmttLJlkTpTEFr0CRl3OAce5DTZT/bsJGC+ZTRck
	BIh+iQXQHYm/USsXXa7cq9X77ymJWnuyngur3jbHrLAlrBIIRje2YWM7IuJZHUoqptayosJU5yjh6
	hbQcFDW+qpHESlQrE8AnqimnS51EP1PG1Alga8aao4RNW0Z07TCJqIyk9fM+zRPhp1yxjiaSLYNnj
	5SDuJkFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ussPN-0000000Arxh-1WdE;
	Mon, 01 Sep 2025 00:28:29 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ussPK-0000000ArwI-3kiV
	for linux-um@lists.infradead.org;
	Mon, 01 Sep 2025 00:28:28 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756686463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TPcfxaTdDhg22VmLjR3XOESkn45TTo7jogJbDCUiOmo=;
	b=PiEU88wG82bCcN9qORtaMHKAs3Y8Xkmo3qfqrK2d8EsF3cLaDgebRRWPhEkh9eyMctTiWT
	RuaKZ0ideibeS0/DR0giucP8wKRb0DiyA7r4PJaFOC8GHcBTw2rGemUR43XiHqPOROuju/
	0mLoIqbBQV0qZPvOdEm5Zr+Nx2tUP6o=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH] um: Fix FD copy size in os_rcv_fd_msg()
Date: Mon,  1 Sep 2025 08:27:15 +0800
Message-Id: <20250901002715.3590541-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250831_172827_148269_1321B961 
X-CRM114-Status: UNSURE (   8.20  )
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

When copying FDs, the copy size should not include the control
message header (cmsghdr). Fix it.

Fixes: 5cde6096a4dd ("um: generalize os_rcv_fd")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 617886d1fb1e..21f0e50fb1df 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -535,7 +535,7 @@ ssize_t os_rcv_fd_msg(int fd, int *fds, unsigned int n_fds,
 	    cmsg->cmsg_type != SCM_RIGHTS)
 		return n;
 
-	memcpy(fds, CMSG_DATA(cmsg), cmsg->cmsg_len);
+	memcpy(fds, CMSG_DATA(cmsg), cmsg->cmsg_len - CMSG_LEN(0));
 	return n;
 }
 
-- 
2.34.1


