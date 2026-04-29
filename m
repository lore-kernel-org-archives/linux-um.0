Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3B6FF8867
	for <linux-um@archiver.kernel.org>; Wed, 29 Apr 2026 06:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=V4Ref7cckp8HVgY+nmNpxRpI7jAdARIWG9TLdwkFWnA=; b=pHhsk1CD2JKnTjLcdbYp20JFrK
	HyPLtOc82t9u52j49N3PauGFB/GWupkEXvgKLZHjMqXLuV7tbUnKO1AAho6u+dZe3aXARvYTCKfKc
	uW1/2IgB3Oo0hSCXQR0mhabHdoxKU6XuPQ8mrdzTvAZKIQyuNigDp25tjpGHhWdVwACam7FdjwgEF
	jLYt50HeE6lscp2csYqfrzs/VqwBwTtuCqJsz7r9SOD1BmNrftMFWDE+m2eNw5tqL5eMQaqy4wgaq
	p1UbmOVi6iulbGRs6EleYIh621McOz7WXzFhtYoyoXAmJiV4xDKD0PAVQ4PTpvFlRVH7gVqvdowVv
	+HMqdE3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHy5y-00000002zZe-0YgZ;
	Wed, 29 Apr 2026 06:08:26 +0000
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHy5q-00000002zYj-48yf
	for linux-um@lists.infradead.org;
	Wed, 29 Apr 2026 06:08:24 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260429060811epoutp0181ebb005339358b0ee8593013c856de5~qvuSK8C8K2307123071epoutp015
	for <linux-um@lists.infradead.org>; Wed, 29 Apr 2026 06:08:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260429060811epoutp0181ebb005339358b0ee8593013c856de5~qvuSK8C8K2307123071epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777442891;
	bh=V4Ref7cckp8HVgY+nmNpxRpI7jAdARIWG9TLdwkFWnA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=cLxHjRyZBU40tVq8YfTbAq8eWvMKBTfrCgq5lNiXRU18qi0YlASIzNXlhKWV1KMQc
	 d+PDZBCyWMt91lbmpWfUWgIcsUf0lwkMXiBqkdN1cuc0Q1NRHYKHHKSLlseS0hLwXN
	 t8awL4jru7P1/0A7TjqdsVt/EVtalonCfz9+DYM4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260429060811epcas5p3eb8f4678c252b0aedc3649e851e24943~qvuRueMto0573905739epcas5p3b;
	Wed, 29 Apr 2026 06:08:11 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4g56L31gM7z6B9mL; Wed, 29 Apr
	2026 06:08:11 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260429060811epcas5p443e048eaa98bba794300c801730978b7~qvuRku08Y2140021400epcas5p41;
	Wed, 29 Apr 2026 06:08:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.97.243.203]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260429060809epsmtip1466fd91e973e52c790c62ea12bc9803a~qvuP6GRxT1378513785epsmtip1k;
	Wed, 29 Apr 2026 06:08:09 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, tiwei.btw@antgroup.com, hehajime@gmail.com,
	benjamin.berg@intel.com, geert@linux-m68k.org
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Maninder
	Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] um: take reference of stack before using it in
 get_wchan
Date: Wed, 29 Apr 2026 11:37:55 +0530
Message-Id: <20260429060755.1541742-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260429060811epcas5p443e048eaa98bba794300c801730978b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260429060811epcas5p443e048eaa98bba794300c801730978b7
References: <CGME20260429060811epcas5p443e048eaa98bba794300c801730978b7@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_230819_727275_9444F66E 
X-CRM114-Status: GOOD (  14.98  )
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

Stack of task can be freed earlier than task in case of
THREAD_INFO_IN_TASK. So separate reference of stack should be there.

Help of THREAD_INFO_IN_TASK config also suggests to take this
reference before calling get_wchan.

KASAN also reports it in case of manual race reproduction:
[   18.400000] BUG: KASAN: vmalloc-out-of-bounds in __get_wchan+0x91/0xd9
[   18.400000] Read of size 8 at addr 00000000648bfad0 by task cat/25
..

Adding try_get_task_stack() to make sure stack's sanity.

Fixes: 2f681ba4b352 ("um: move thread info into task")
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/um/kernel/process.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 63b38a3f73f7..dfca9e0aeec9 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -276,16 +276,12 @@ unsigned long arch_align_stack(unsigned long sp)
 }
 #endif
 
-unsigned long __get_wchan(struct task_struct *p)
+static unsigned long ___get_wchan(struct task_struct *p)
 {
 	unsigned long stack_page, sp, ip;
 	bool seen_sched = 0;
 
 	stack_page = (unsigned long) task_stack_page(p);
-	/* Bail if the process has no kernel stack for some reason */
-	if (stack_page == 0)
-		return 0;
-
 	sp = p->thread.switch_buf->JB_SP;
 	/*
 	 * Bail if the stack pointer is below the bottom of the kernel
@@ -306,4 +302,21 @@ unsigned long __get_wchan(struct task_struct *p)
 	}
 
 	return 0;
+
+}
+
+unsigned long __get_wchan(struct task_struct *p)
+{
+	unsigned long ret;
+
+	/* Bail if the process has no kernel stack for some reason */
+	if (!try_get_task_stack(p))
+		return 0;
+
+	ret = ___get_wchan(p);
+
+	put_task_stack(p);
+
+	return ret;
+
 }
-- 
2.34.1


