Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734B9C4345F
	for <linux-um@archiver.kernel.org>; Sun,  5 May 2024 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9tJdhokC07t5AKnNYTYSjj5ZbBWyfN8CQQLC/CMUQK8=; b=3GGB9cSJQseUpawxodBjiTdTEp
	BXHQkMv6yq8IVK38RF0mvPbSfX0LvEqgnKhiagWRM6eq2XccQ3uTt6esalLURM8rJqlmysnF1Ki1M
	rXn/W24GCm24I8mK9IQ7m5Db7/pIICzz3OADASMBQ452p4rJ/MhiMDSka3e9RneDuR/gmyK/lPjOh
	optAZY+3TQ6qhgbmFZyn5zoL8HKZAwbsyphzu+e6qKGAgRvKZfrA4I/rhby0aSjJ8c2q1HHy/qyx6
	3x4kpcwhFFjvd9t7aY9V5Hg7G3YHkFVjW7EPbCs1hvuf7lWbOBxq3VEUdTX0WNSh2p/jAbJIG/UJq
	+56OHyLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3PXI-00000003B8P-0aI0;
	Sun, 05 May 2024 00:15:24 +0000
Received: from mx.treblig.org ([2a00:1098:5b::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3PXE-00000003B7N-1Ezb
	for linux-um@lists.infradead.org;
	Sun, 05 May 2024 00:15:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9tJdhokC07t5AKnNYTYSjj5ZbBWyfN8CQQLC/CMUQK8=; b=Fo8bw0j2JsDDYWQh
	FPvHs1HYh4xomYTT6G9Rdn6Voo6ryiCiFtJOeVl8wEYYiSurf8ve/gWX2/JuxUU4oAT36WGaNSD8g
	0ZCxmJce00vFdgc/TtmTPbSS8N++zmksHYFK894nF5gLZHGNEAqaGziObeKZtsvlwLtqPGV6vSnpu
	/Kcf/dOuprw/ClTAcgh3FrMdav2hNk7E8a2bTC/AFZVW1CLPRSQ/0T9sEHJahgrp9LQsAF22a/gnF
	wo+vMlnctMQxarWjMR6hy6MVhPoXB5EVEzML3XdHOMEddtvw7YlauXoymFvRHGNo+7YfottsHLpCX
	129XPP1c+hen0brlUg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3PX5-004kAq-0i;
	Sun, 05 May 2024 00:15:11 +0000
From: linux@treblig.org
To: richard@nod.at,
	hch@lst.de
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Date: Sun,  5 May 2024 01:15:08 +0100
Message-ID: <20240505001508.255096-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_171520_472792_3E8711FD 
X-CRM114-Status: UNSURE (   7.73  )
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit fb5d1d389c9e ("ubd: open the backing files in ubd_add")

removed the last use of ubd_mutex.
Remove it.

Build and kernel startup test only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/um/drivers/ubd_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 63fc062add708..2b855240fbabf 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -106,7 +106,6 @@ static inline void ubd_set_bit(__u64 bit, unsigned char *data)
 #define DRIVER_NAME "uml-blkdev"
 
 static DEFINE_MUTEX(ubd_lock);
-static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
 
 static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg);
-- 
2.45.0


