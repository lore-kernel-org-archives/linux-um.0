Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9052AD1BDC5
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBSdLAG+Y+l3AdDcU6iNR/8vWTUM90B1ihEg9KDjLlE=; b=kXHIUPK/CYndpOsWNRFmiH6y5O
	clz4j6pSCR7K0DnSNxekEQpdK8hp+LcvjrWReOP+jtDOnnLb3lHT7FJ4ztng7rwC+L/w3iJUM+tzg
	OsECpAE/qla7fy8bU4T2gpw/X7R57VqG6fo0Il5/e3/IZlN4+dVxL/hGkKPkshFmVbZi2bTmhiK1j
	0WyOgSMYlrxFPxUdVBksFLhhF3Ao+W1AFB/iCGkHkxNCU0+AoY7Qx2e1cDGG3jRIO1Ma23W17DqdW
	geGpUyy3nqbx870t9kB6dhdv7jjoU27dDi0TTS3eqFzBUsgyDSIieVy8OVHz54Tp3TjpRBeYXc7U2
	+t3dGuWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t801g-0000000EOOM-45Bu;
	Mon, 04 Nov 2024 16:34:00 +0000
Received: from out0-220.mail.aliyun.com ([140.205.0.220])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8005-0000000EOGI-3Udb
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 16:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730737936; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tBSdLAG+Y+l3AdDcU6iNR/8vWTUM90B1ihEg9KDjLlE=;
	b=BXuEOiYYC6FCzRJOkMZh/9muhT0zbjkAJrbeJY1T/3RLbIkXFjNIY6mwaDEUlfrU20JCsKeXr8Wb/z50Wa2+3DEVU7zY71tkf6CdA4YVpBg7PijjVIk/HHjLVpW5bWSnaehxCCc0R1d/a+aKDUzvIfjMzuL1CQc+Z8yp8EIGZ4U=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bEK_1730737936 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:16 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
   <stable@vger.kernel.org>
Subject: [PATCH 2/4] um: ubd: Do not use drvdata in release
Date: Tue, 05 Nov 2024 00:32:01 +0800
Message-Id: <20241104163203.435515-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104163203.435515-1-tiwei.btw@antgroup.com>
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_083222_031413_D8FFE1D0 
X-CRM114-Status: GOOD (  10.18  )
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

The drvdata is not available in release. Let's just use container_of()
to get the ubd instance. Otherwise, removing a ubd device will result
in a crash:

RIP: 0033:blk_mq_free_tag_set+0x1f/0xba
RSP: 00000000e2083bf0  EFLAGS: 00010246
RAX: 000000006021463a RBX: 0000000000000348 RCX: 0000000062604d00
RDX: 0000000004208060 RSI: 00000000605241a0 RDI: 0000000000000348
RBP: 00000000e2083c10 R08: 0000000062414010 R09: 00000000601603f7
R10: 000000000000133a R11: 000000006038c4bd R12: 0000000000000000
R13: 0000000060213a5c R14: 0000000062405d20 R15: 00000000604f7aa0
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 17 Comm: kworker/0:1 Not tainted 6.8.0-rc3-00107-gba3f67c11638 #1
Workqueue: events mc_work_proc
Stack:
 00000000 604f7ef0 62c5d000 62405d20
 e2083c30 6002c776 6002c755 600e47ff
 e2083c60 6025ffe3 04208060 603d36e0
Call Trace:
 [<6002c776>] ubd_device_release+0x21/0x55
 [<6002c755>] ? ubd_device_release+0x0/0x55
 [<600e47ff>] ? kfree+0x0/0x100
 [<6025ffe3>] device_release+0x70/0xba
 [<60381d6a>] kobject_put+0xb5/0xe2
 [<6026027b>] put_device+0x19/0x1c
 [<6026a036>] platform_device_put+0x26/0x29
 [<6026ac5a>] platform_device_unregister+0x2c/0x2e
 [<6002c52e>] ubd_remove+0xb8/0xd6
 [<6002bb74>] ? mconsole_reply+0x0/0x50
 [<6002b926>] mconsole_remove+0x160/0x1cc
 [<6002bbbc>] ? mconsole_reply+0x48/0x50
 [<6003379c>] ? um_set_signals+0x3b/0x43
 [<60061c55>] ? update_min_vruntime+0x14/0x70
 [<6006251f>] ? dequeue_task_fair+0x164/0x235
 [<600620aa>] ? update_cfs_group+0x0/0x40
 [<603a0e77>] ? __schedule+0x0/0x3ed
 [<60033761>] ? um_set_signals+0x0/0x43
 [<6002af6a>] mc_work_proc+0x77/0x91
 [<600520b4>] process_scheduled_works+0x1af/0x2c3
 [<6004ede3>] ? assign_work+0x0/0x58
 [<600527a1>] worker_thread+0x2f7/0x37a
 [<6004ee3b>] ? set_pf_worker+0x0/0x64
 [<6005765d>] ? arch_local_irq_save+0x0/0x2d
 [<60058e07>] ? kthread_exit+0x0/0x3a
 [<600524aa>] ? worker_thread+0x0/0x37a
 [<60058f9f>] kthread+0x130/0x135
 [<6002068e>] new_thread_handler+0x85/0xb6

Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index f19173da64d8..66c1a8835e36 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -779,7 +779,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 
 static void ubd_device_release(struct device *dev)
 {
-	struct ubd *ubd_dev = dev_get_drvdata(dev);
+	struct ubd *ubd_dev = container_of(dev, struct ubd, pdev.dev);
 
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
-- 
2.34.1


