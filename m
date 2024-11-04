Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A744CD1BDC8
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McKha1hmKH1clDOz2fCI8A4BsEcNH5WhtqM/+Bq5yME=; b=ZvfwVi3xw46KdqBrLZZ/uLnGQY
	ObcszyV39uUDmiqT7l7Wc9zvYlPpNn/SDkQ8eD4UrErseK4K0pzZ4CCQW9MaxV4pprsf127wc6kHU
	l3SFdrC+h9tXEwp7Z1SK2zhrCtvJ7t09nWno24Kaw4pTGB5XArrlEnE5Hk4mPlS48eYeFfdJ7q7BX
	RMICBk39AgAVj8ZCg1g5XeVn7HuECegl7YEC3Zig3LIPm+yrP0oWgWYCTe5qYCxyPcSl6P0sQhHVu
	T0sLjbrskGwW36MyP6mOEnK+q0tPeFEY8n4r3LkdANsgvwQ7HQnjOnF9843ao70Wldo0gSMWOMkyj
	Nv0XJN2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t801h-0000000EOOS-1DxM;
	Mon, 04 Nov 2024 16:34:01 +0000
Received: from out0-217.mail.aliyun.com ([140.205.0.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8006-0000000EOGK-1mVA
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 16:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730737937; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=McKha1hmKH1clDOz2fCI8A4BsEcNH5WhtqM/+Bq5yME=;
	b=GBfcYa9jGEwx/XygTj9LeZ51pxzRDtNm78bLyuJawemMdCY7/hdeVqfSa15wetxXpFF/wxKuLUs4kDT/W6CbTHjqxpiZo/Za7S6zJ40PlV6MtT831D0MyZw0Lixc30ja5ngysOi6TO+XFsLZOLL/3hPnDn0F7PIUSA+KGHZ7Vso=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bET_1730737936 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:17 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
   <stable@vger.kernel.org>
Subject: [PATCH 4/4] um: vector: Do not use drvdata in release
Date: Tue, 05 Nov 2024 00:32:03 +0800
Message-Id: <20241104163203.435515-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104163203.435515-1-tiwei.btw@antgroup.com>
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_083222_634179_3AB2E86D 
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
to get the vector_device instance. Otherwise, removing a vector device
will result in a crash:

RIP: 0033:vector_device_release+0xf/0x50
RSP: 00000000e187bc40  EFLAGS: 00010202
RAX: 0000000060028f61 RBX: 00000000600f1baf RCX: 00000000620074e0
RDX: 000000006220b9c0 RSI: 0000000060551c80 RDI: 0000000000000000
RBP: 00000000e187bc50 R08: 00000000603ad594 R09: 00000000e187bb70
R10: 000000000000135a R11: 00000000603ad422 R12: 00000000623ae028
R13: 000000006287a200 R14: 0000000062006d30 R15: 00000000623700b6
Kernel panic - not syncing: Segfault with no mm
CPU: 0 UID: 0 PID: 16 Comm: kworker/0:1 Not tainted 6.12.0-rc6-g59b723cd2adb #1
Workqueue: events mc_work_proc
Stack:
 60028f61 623ae028 e187bc80 60276fcd
 6220b9c0 603f5820 623ae028 00000000
 e187bcb0 603a2bcd 623ae000 62370010
Call Trace:
 [<60028f61>] ? vector_device_release+0x0/0x50
 [<60276fcd>] device_release+0x70/0xba
 [<603a2bcd>] kobject_put+0xba/0xe7
 [<60277265>] put_device+0x19/0x1c
 [<60281266>] platform_device_put+0x26/0x29
 [<60281e5f>] platform_device_unregister+0x2c/0x2e
 [<60029422>] vector_remove+0x52/0x58
 [<60031316>] ? mconsole_reply+0x0/0x50
 [<600310c8>] mconsole_remove+0x160/0x1cc
 [<603b19f4>] ? strlen+0x0/0x15
 [<60066611>] ? __dequeue_entity+0x1a9/0x206
 [<600666a7>] ? set_next_entity+0x39/0x63
 [<6006666e>] ? set_next_entity+0x0/0x63
 [<60038fa6>] ? um_set_signals+0x0/0x43
 [<6003070c>] mc_work_proc+0x77/0x91
 [<60057664>] process_scheduled_works+0x1b3/0x2dd
 [<60055f32>] ? assign_work+0x0/0x58
 [<60057f0a>] worker_thread+0x1e9/0x293
 [<6005406f>] ? set_pf_worker+0x0/0x64
 [<6005d65d>] ? arch_local_irq_save+0x0/0x2d
 [<6005d748>] ? kthread_exit+0x0/0x3a
 [<60057d21>] ? worker_thread+0x0/0x293
 [<6005dbf1>] kthread+0x126/0x12b
 [<600219c5>] new_thread_handler+0x85/0xb6

Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index c992da83268d..64c09db392c1 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -815,7 +815,8 @@ static struct platform_driver uml_net_driver = {
 
 static void vector_device_release(struct device *dev)
 {
-	struct vector_device *device = dev_get_drvdata(dev);
+	struct vector_device *device =
+		container_of(dev, struct vector_device, pdev.dev);
 	struct net_device *netdev = device->dev;
 
 	list_del(&device->list);
-- 
2.34.1


