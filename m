Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A43D1BDC7
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9Ug1sUdXc2iX3oOncxuy+ebR5G1J5WF+JdyHds/Qns=; b=lvNvmpb6IYJfzO5bbJ/4YgqbdR
	dns3/RtNWy+4J+v2D5YvoFxOOVQvyzOu8qH/EWWBDY8eePym792yZdMWEuXMYJix4sz5wGimpmQOm
	ojwmLsHyKZ/nhzeBSJ4cSemROZJNEAl7U1BhoDji6/T194YktsuY33UznyEQnCOnS+ksgsSqOq/5D
	3f1jnKiEKMgGpRgzvM+AAW8y2Rxl9w/6i1IfHY+jlzA8EVGyY5LbjZPzkkphNl1kT9BqkU5b+tS2M
	x/f2zbaytP+i/pKutst1HRmMrgfxojLtEyDeZaN7Fp25kQXdQZrbZlEJbkKkBxaZQ63yZqjHPECXM
	FCIL7HkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t801h-0000000EOOf-3p3s;
	Mon, 04 Nov 2024 16:34:01 +0000
Received: from out0-194.mail.aliyun.com ([140.205.0.194])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8006-0000000EOGN-2mUR
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 16:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730737938; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=A9Ug1sUdXc2iX3oOncxuy+ebR5G1J5WF+JdyHds/Qns=;
	b=j564S7PwVlHwwF376MYB4A3uhZGPjIh+alDY248PBTOPNyHG5lVFISeKOE0cvtjTwDr+dtj69FwvtVP7ISXEAnZ6lLnBKy3Wk1pt6Ru5cUMhVSjOtmC2btejfXBmvPOAoxO3oBED1xj0FCGfBxHQX2q8hMRFOzNBZDBAEJDBH1o=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bEN_1730737936 cluster:ay29)
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
Subject: [PATCH 3/4] um: net: Do not use drvdata in release
Date: Tue, 05 Nov 2024 00:32:02 +0800
Message-Id: <20241104163203.435515-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104163203.435515-1-tiwei.btw@antgroup.com>
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_083222_890973_B10BBD80 
X-CRM114-Status: GOOD (  11.03  )
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
to get the uml_net instance. Otherwise, removing a network device will
result in a crash:

RIP: 0033:net_device_release+0x10/0x6f
RSP: 00000000e20c7c40  EFLAGS: 00010206
RAX: 000000006002e4e7 RBX: 00000000600f1baf RCX: 00000000624074e0
RDX: 0000000062778000 RSI: 0000000060551c80 RDI: 00000000627af028
RBP: 00000000e20c7c50 R08: 00000000603ad594 R09: 00000000e20c7b70
R10: 000000000000135a R11: 00000000603ad422 R12: 0000000000000000
R13: 0000000062c7af00 R14: 0000000062406d60 R15: 00000000627700b6
Kernel panic - not syncing: Segfault with no mm
CPU: 0 UID: 0 PID: 29 Comm: kworker/0:2 Not tainted 6.12.0-rc6-g59b723cd2adb #1
Workqueue: events mc_work_proc
Stack:
 627af028 62c7af00 e20c7c80 60276fcd
 62778000 603f5820 627af028 00000000
 e20c7cb0 603a2bcd 627af000 62770010
Call Trace:
 [<60276fcd>] device_release+0x70/0xba
 [<603a2bcd>] kobject_put+0xba/0xe7
 [<60277265>] put_device+0x19/0x1c
 [<60281266>] platform_device_put+0x26/0x29
 [<60281e5f>] platform_device_unregister+0x2c/0x2e
 [<6002ec9c>] net_remove+0x63/0x69
 [<60031316>] ? mconsole_reply+0x0/0x50
 [<600310c8>] mconsole_remove+0x160/0x1cc
 [<60087d40>] ? __remove_hrtimer+0x38/0x74
 [<60087ff8>] ? hrtimer_try_to_cancel+0x8c/0x98
 [<6006b3cf>] ? dl_server_stop+0x3f/0x48
 [<6006b390>] ? dl_server_stop+0x0/0x48
 [<600672e8>] ? dequeue_entities+0x327/0x390
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
 arch/um/drivers/net_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 77c4afb8ab90..75d04fb4994a 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -336,7 +336,7 @@ static struct platform_driver uml_net_driver = {
 
 static void net_device_release(struct device *dev)
 {
-	struct uml_net *device = dev_get_drvdata(dev);
+	struct uml_net *device = container_of(dev, struct uml_net, pdev.dev);
 	struct net_device *netdev = device->dev;
 	struct uml_net_private *lp = netdev_priv(netdev);
 
-- 
2.34.1


