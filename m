Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96191C25B7D
	for <linux-um@archiver.kernel.org>; Mon, 27 May 2024 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aPhgJtNbevvD4n484o242Ca+ulgY/TKUr1VEB8WBEMY=; b=DFYw1fPU5p7Oq50D0MlkGqtIv0
	5PTlPDrZFWS2MGA7VGzeGTXFKCkZUpLua/NOcQgGOEteLlmkD6zUzupR1rU6CWKIoaXGvuN/I+a5e
	0ep3xa/WA31J08ZS0ZDYxJrubwwa4xYZm1GLbOUDVGXRmSpmyi2jenhFA7fW4a0I2tNa1WKCRA0+R
	rwoJuoBX2y9qvsxIu4Zk3b1mN0tNuPzAt7/+M9/FdclcSC7xdDUNF7Byw+ciPxZXyWOa3MXFMqPR0
	7+XWeF7UcOmtYGAPFQJMq36JLQdHNRSbQSyHUGS36eK+dLFaG/oJj4JlfTLN6SIwsFMXm9FPfXOXX
	Zzq8E0dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaar-0000000F9Mh-1Fgc;
	Mon, 27 May 2024 13:40:53 +0000
Received: from out0-216.mail.aliyun.com ([140.205.0.216])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaam-0000000F9If-1QYb
	for linux-um@lists.infradead.org;
	Mon, 27 May 2024 13:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716817242; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aPhgJtNbevvD4n484o242Ca+ulgY/TKUr1VEB8WBEMY=;
	b=OtnmIl3/yZRV0edkh4EGzshltXPZmSryZsuhBZh6PHyRz4UtbH4xe43PTZiMc/cu6ow2RFXcvZVmI3YDrI2LbmYbILe+I9zgWiFZXpUBhxJok8C8ljCt/0qil83opvFEsAOjSxVZWPhh5C5nXrF1aN5F0XaErw6vvW8wgdl3ZXY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021168;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XofsrHN_1716817238;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XofsrHN_1716817238)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 21:40:38 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/2] um: Remove /proc/sysemu support code
Date: Mon, 27 May 2024 21:40:24 +0800
Message-Id: <20240527134024.1539848-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
References: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_064049_037946_AC292844 
X-CRM114-Status: UNSURE (   7.41  )
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

Currently /proc/sysemu will never be registered, as sysemu_supported
is initialized to zero implicitly and no code updates it. And there is
also nothing to configure via sysemu in UML anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 67 ----------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index d2134802f6a8..79f41f06a98f 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -237,73 +237,6 @@ int copy_from_user_proc(void *to, void __user *from, int size)
 	return copy_from_user(to, from, size);
 }
 
-static atomic_t using_sysemu = ATOMIC_INIT(0);
-int sysemu_supported;
-
-static void set_using_sysemu(int value)
-{
-	if (value > sysemu_supported)
-		return;
-	atomic_set(&using_sysemu, value);
-}
-
-static int get_using_sysemu(void)
-{
-	return atomic_read(&using_sysemu);
-}
-
-static int sysemu_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "%d\n", get_using_sysemu());
-	return 0;
-}
-
-static int sysemu_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sysemu_proc_show, NULL);
-}
-
-static ssize_t sysemu_proc_write(struct file *file, const char __user *buf,
-				 size_t count, loff_t *pos)
-{
-	char tmp[2];
-
-	if (copy_from_user(tmp, buf, 1))
-		return -EFAULT;
-
-	if (tmp[0] >= '0' && tmp[0] <= '2')
-		set_using_sysemu(tmp[0] - '0');
-	/* We use the first char, but pretend to write everything */
-	return count;
-}
-
-static const struct proc_ops sysemu_proc_ops = {
-	.proc_open	= sysemu_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-	.proc_write	= sysemu_proc_write,
-};
-
-static int __init make_proc_sysemu(void)
-{
-	struct proc_dir_entry *ent;
-	if (!sysemu_supported)
-		return 0;
-
-	ent = proc_create("sysemu", 0600, NULL, &sysemu_proc_ops);
-
-	if (ent == NULL)
-	{
-		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
-		return 0;
-	}
-
-	return 0;
-}
-
-late_initcall(make_proc_sysemu);
-
 int singlestepping(void)
 {
 	return test_thread_flag(TIF_SINGLESTEP);
-- 
2.34.1


