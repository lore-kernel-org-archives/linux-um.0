Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C339CDB474
	for <linux-um@archiver.kernel.org>; Tue, 17 Oct 2023 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dOgGCifcsQmwuNwlfcKfg8z9bmytcENwqaQJXUcSs+4=; b=Pv6JqzfSP08VhM
	4R0rFDKcQ3FYwspm1k6i1KbFv+sh5OuNFthcjXIt1F1k3quJbBK2rwJvymkACP44l0JOGnn8GyXzp
	zY+5ulY0R/fYr3xTHhY/W4YosffzitmkLYGI88gCvSQCXCEPHzpNEGGgEh5Lou4f/43eX9chiMd1v
	yK4yiyfkV8PJZVg3o1lNiSd7z1sE3r1ArvXbCrNfKFbFQNyupUur/wfVcab2SWjybXJvIN7EeVPmX
	cVulhqYMDXjIT7pcGxbPmzm/ekW/YhlICiBQa5VQ7aAOAb9f+xQsga/HJxqld8oooVe5386qCrbMn
	GXFCCtf0T3Wc2hUz8GWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsfmg-00BjVM-0S;
	Tue, 17 Oct 2023 08:50:38 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsfmc-00BjUT-2l
	for linux-um@lists.infradead.org;
	Tue, 17 Oct 2023 08:50:36 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qsfV0-004DMj-TM; Tue, 17 Oct 2023 08:32:23 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qsfUx-009Kuo-39;
	Tue, 17 Oct 2023 09:32:21 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org,
	johannes@sipsolutions.net
Cc: richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: document arch_futex_atomic_op_inuser
Date: Tue, 17 Oct 2023 09:32:01 +0100
Message-Id: <20231017083201.399828-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202310151047.a07DrQNV-lkp@intel.com>
References: <202310151047.a07DrQNV-lkp@intel.com>
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_015034_889238_55CF6C77 
X-CRM114-Status: UNSURE (   7.43  )
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

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

arch_futex_atomic_op_inuser was not documented correctly
resulting in build time warnings.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/skas/uaccess.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index aaee96f07172..198269e384c4 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -236,7 +236,9 @@ EXPORT_SYMBOL(strnlen_user);
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
- * @encoded_op:	encoded operation to execute
+ * @op:		operation to execute
+ * @oparg:	argument to operation
+ * @oval:	old value at uaddr
  * @uaddr:	pointer to user space address
  *
  * Return:
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
