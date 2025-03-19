Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA2FC3DA4A
	for <linux-um@archiver.kernel.org>; Wed, 19 Mar 2025 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijBkvYaNuTQuCxovsWjSE2B1z792CEUqkR3boHR6SXA=; b=1P0cFsyU5EBaUEQEXuY+V9a5oK
	8XYY18Miy9sMJ95ZYPRn6gQ/ICupuMIzakRtvX/JlY0DBcG7YsTDc8fMatzCBWDTQ22wjf15P2q6i
	UswzamcBISSxzOXSQ/nmLPydWrfomXT+BOHe0yyRq9sPQooX4Uq9zF3qfNxXJRSPAtjiFk/aqkM1v
	lxEuzIqVV4YwYQcY2tXeaeqjl9ejGDZk6O66GjILHkbN/sHmmNMgt41OFNxFTwflHakplF1/sYdgd
	4XfUDZgdirtsqAw4wmRJy3EfGAogTkrXYLFAZRngCGk2n49ONFMuOfgMGRitcn95j5gyGdl0onT12
	w5vh6m/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttX-000000098V4-0GQf;
	Wed, 19 Mar 2025 13:55:43 +0000
Received: from out0-213.mail.aliyun.com ([140.205.0.213])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuttT-000000098Sy-1fjX
	for linux-um@lists.infradead.org;
	Wed, 19 Mar 2025 13:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742392535; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ijBkvYaNuTQuCxovsWjSE2B1z792CEUqkR3boHR6SXA=;
	b=jjKACbGbtXuLOFDVr6ZZzqInIYEBTEOTm7vPaeRaXhQfgkAQdojgZFeUAAnCYw0nJnk0EUSgdUNbWdoUuY+b3QoOpT24yD62b9Vmg7veq0zqJK3ZHdSns3eVJi55VgdrQNUFfGXfKIQ145F9NWz/BT3GVoivKodIUuvVFJ0a3lg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.byXmrkG_1742392534 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 21:55:34 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 4/4] um: Prohibit the VM_CLONE flag in run_helper_thread()
Date: Wed, 19 Mar 2025 21:55:23 +0800
Message-Id: <20250319135523.97050-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319135523.97050-1-tiwei.btw@antgroup.com>
References: <20250319135523.97050-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_065539_904997_A14E3C26 
X-CRM114-Status: UNSURE (   7.67  )
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
index df22cba24d82..89c2ad2a4e3a 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -122,6 +122,10 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
+	/* To share memory space, use os_run_helper_thread() instead. */
+	if (flags & CLONE_VM)
+		return -EINVAL;
+
 	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
-- 
2.34.1


