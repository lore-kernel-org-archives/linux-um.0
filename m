Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E78CCD1A5
	for <linux-um@archiver.kernel.org>; Mon, 27 Oct 2025 05:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q822U025jgr2n1OaMQqGOiPQ2cAPVzR8OtB9r2ruwMY=; b=IsMO45Pg1is8AxNstzrx3kDVzZ
	8Ca81xGG6EBrl7RpRTkFQ9p987j3oH0rBXGZQu/AZKqXKoZMQCOGpTgyE7st6L5WxLqXaixMzUcQG
	UzCYiyhcdjy3Fm5oYrZu6P4eoW9g6fNsZIu7TKDd9tJXjbDnJF+jRYrV8L/SAzQQ9LvKoYJvKAPct
	Af92h7t4vY22y1pdCGoAbRRsnwrdoTVLrw4JYC3pJmXEX/j+KdJhVdBrS+ftD20dAMikvg0qT9AY2
	upLfrDfDCzSALr6X6uRqQcu0y+o1JbwtF5OyxzXgcW9482SXTQbPGgudD8tnxMMGqELI28PMz7r9f
	n+/wQnZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDG3Q-0000000D8kz-2Kum;
	Mon, 27 Oct 2025 05:46:04 +0000
Received: from out-186.mta1.migadu.com ([95.215.58.186])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDG3L-0000000D8k3-29b5
	for linux-um@lists.infradead.org;
	Mon, 27 Oct 2025 05:46:00 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761543957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q822U025jgr2n1OaMQqGOiPQ2cAPVzR8OtB9r2ruwMY=;
	b=NbtVvv3E05lAbi3UgNg/DizSw3NBnRYzj3bQ6pl4BuoRUI3owmyx71IJMDG3FkQAm8ZjXq
	oKvpIIULgjshOSRS+p7f+iFYZ09i44CsHsLGK5PhDQnNdYCoSa5kY7L2V1/OscB0Cl9jpW
	uHmh85hjTwnOF+ZwNj2aafhXDYOqCLs=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 1/4] um: Make host_task_size a local variable
Date: Mon, 27 Oct 2025 13:45:16 +0800
Message-Id: <20251027054519.1996090-2-tiwei.bie@linux.dev>
In-Reply-To: <20251027054519.1996090-1-tiwei.bie@linux.dev>
References: <20251027054519.1996090-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_224559_700914_12A912B3 
X-CRM114-Status: UNSURE (   8.77  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

Currently, host_task_size is a global variable, but it is only used
in linux_main() to compute stub_start and task_size. Make it a local
variable to limit its scope to where it is actually needed.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/as-layout.h | 1 -
 arch/um/kernel/um_arch.c           | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 7c7e17bce403..02ef258e3395 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -44,7 +44,6 @@ extern unsigned long start_vm;
 
 extern unsigned long brk_start;
 
-extern unsigned long host_task_size;
 extern unsigned long stub_start;
 
 extern int linux_main(int argc, char **argv, char **envp);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index cfbbbf8500c3..5b982031e5ae 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -254,8 +254,6 @@ unsigned long stub_start;
 unsigned long task_size;
 EXPORT_SYMBOL(task_size);
 
-unsigned long host_task_size;
-
 unsigned long brk_start;
 unsigned long end_iomem;
 EXPORT_SYMBOL(end_iomem);
@@ -308,6 +306,7 @@ int __init linux_main(int argc, char **argv, char **envp)
 {
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
+	unsigned long host_task_size;
 	unsigned long stack;
 	unsigned int i;
 	int add;
-- 
2.34.1


