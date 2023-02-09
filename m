Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C062C636D7
	for <linux-um@archiver.kernel.org>; Thu,  9 Feb 2023 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6UYuslc8LUNNovsiiDZkUtxRxLbcHj+yqP1Q+L0Qp7o=; b=axtB1gWDQF7Epm
	HR/zhuIdXaSXxzJxwnZAOaL8t9TVtfG+g9fmGSDMHNZIW3Grd04HJt+OQ3fDhSjC06gZxF6Qja4tg
	t5FoHD/C6AhsnFLf3GSxEPHB/rWHl9KdOq5aQFCtlkSKbJ7auEdNg+fTV5U90yDNspe+6sAPiuYG8
	8zGY8IUtCzd4Q5QTx3Z4taqyWeFSkB+a7OEvjrwlpzJwrYuDEbH11Cs/E2EX132XVv/g3WtALRTtE
	C9MlWDBVbGUgipgcRs00RXzdXC+XHFN5/6q87BQ0wwPCB4oP5guY5UBm3EZ4dN+1rkBp0ncmRR9xb
	y0655F6DjLy7x263Wbdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2n9-000dsf-0C; Thu, 09 Feb 2023 09:00:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2n5-000doU-Hr
	for linux-um@lists.infradead.org; Thu, 09 Feb 2023 09:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JjGzu8pgCNaBWqAHLP41lgeU0+YzjINoNn2aVmWczUk=;
	t=1675933224; x=1677142824; b=l+TzdqAT5DNks6Zvr7U2Z7GklKZ908bg4981cFCH9hy7GKc
	7uY7I0ztWadTyNPlXf/4MR8DF5zKNOSZI7tD2LwbnboBFZzj/WOFwIbcN2bhEIGnvlk7ls6V87n3m
	WTvx+IFZtw+3yhd5/cithaAkCMrpeKyKVgdpBN7VcRyiAtaF8RDNfgYzBJVRN7GKT1aw5QW8dWN2n
	F/lcI8cLl8Sda3hXBLS79Hdf4qY4QUPPJ/4l9J87kWwtfXOU7XyVyJjL4V8m/+Q13MgCLslH4ZinU
	s/rS0gDWXA94aEFF8JhCPBG5lBo2pJVqnmuxHwz/tzclRHM64dWdWaXz86NKxEQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1pQ2my-007K0c-06;
	Thu, 09 Feb 2023 10:00:20 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/4] um: virtio_uml: mark device as unregistered when breaking it
Date: Thu,  9 Feb 2023 10:00:03 +0100
Message-Id: <20230209090005.1559828-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209090005.1559828-1-benjamin@sipsolutions.net>
References: <20230209090005.1559828-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_010027_616620_82B14B7A 
X-CRM114-Status: UNSURE (   8.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

Mark the device as not registered anymore when scheduling the work to
remove it. Otherwise we could end up scheduling the work multiple times
in a row, including scheduling it while it is already running.

Change-Id: I5debd5084986f37b793cfac98d95b3a577d7a345
Fixes: af9fb41ed315 ("um: virtio_uml: Fix broken device handling in time-travel")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 588930a0ced1..dcfd0ca534ee 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -168,6 +168,8 @@ static void vhost_user_check_reset(struct virtio_uml_device *vu_dev,
 	if (!vu_dev->registered)
 		return;
 
+	vu_dev->registered = 0;
+
 	virtio_break_device(&vu_dev->vdev);
 	schedule_work(&pdata->conn_broken_wk);
 }
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
