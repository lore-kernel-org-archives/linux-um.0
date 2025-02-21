Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99D8C021B5
	for <linux-um@archiver.kernel.org>; Fri, 21 Feb 2025 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EMSZ8NZ5reJuwU6NglLbtI5AglFyDveXhcsa1Gtvl38=; b=pAhkAlDTYv3kYQgMShE/If/PTO
	D50v5yhIbeZZLITpHpSUnG1Pni6QAl4yoe8gNkbrpEIo4VAyjUCdeHuAj/ZTmFKoi8BBrb2LRc81t
	JV/fV/gQ1JhTu0kO+zADKDMScsa9HmuOIOisZ6nOVqfWhla5MLxi0mOK6aJLgGDPsmyu+FQ3NHWqN
	9nQW8Ub8Ryhy3wFYE4g4HyCJG/MvLdOS+ErI6aHAbW8QOeoP9bF1r0QMQfLqWmDMatCqPWg0RqB3L
	YNZHSvdtUlxzWktdiTyWTezfN9ENxXCbCin0X6Yijore7gU/AT0yH9I56/QUdIKbZGnnmgmPJy5jG
	YAaiKW7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOao-00000004kYj-1o2f;
	Fri, 21 Feb 2025 08:41:06 +0000
Received: from out0-205.mail.aliyun.com ([140.205.0.205])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlOal-00000004kVs-3Odg
	for linux-um@lists.infradead.org;
	Fri, 21 Feb 2025 08:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1740127261; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EMSZ8NZ5reJuwU6NglLbtI5AglFyDveXhcsa1Gtvl38=;
	b=sUA/Bm8ZrI0jcHS0tmnuuBoysftGk+tBHr8w3aFaj0xTsfZbCYdKho4SaiyEPg1+uPjpvxR+tmBXvmVBCqxGdJN+FJpGTcbGo6M/U6q0HOTKLqg0CvAQ0hqdlJVO1DNdOzoS1T8WkIFm6FUfwK64oVCXdc6xHLto9dnjwCef5X4=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bYJdX6k_1740127258 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 16:40:58 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/4] um: Prohibit the VM_CLONE flag in run_helper_thread()
Date: Fri, 21 Feb 2025 16:40:49 +0800
Message-Id: <20250221084049.1332318-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
References: <20250221084049.1332318-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_004104_009017_41560D18 
X-CRM114-Status: UNSURE (   7.19  )
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

Directly creating helper threads with VM_CLONE using clone can
compromise the thread safety of errno. Since all these helper
threads have been converted to use os_run_helper_thread(), let's
prevent using this flag in run_helper_thread().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index c6a0ef8beb29..5c157f2f75e1 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -122,6 +122,10 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
+	/* To share memory address space, use os_run_helper_thread() instead. */
+	if (flags & CLONE_VM)
+		return -EINVAL;
+
 	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
-- 
2.34.1


