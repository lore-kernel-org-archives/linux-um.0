Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81630C25B74
	for <linux-um@archiver.kernel.org>; Mon, 27 May 2024 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98TUkS0b+gRj1ZLjZVnojSNV/GxHrgmcGS9QODi+eTo=; b=AXaMfUA6F3k3YtFURedbIqATbM
	9gsVqACfpBnV8E2x6jgqnk316d1yCNHIYxsoJRyWR/kKJfSoDYRloR8BX0ZXHEeB4ZP6T/Ev+k1Z1
	dwEIC7owXaQ+MBOqOjTUEFUM0SSeRq9TK/8nxUK4onVxlTKWxvD48hB6qkf9rSb4sh6iGYYqIpnqj
	m59rjAFXF34d3u0tTShW/ZbFA71lD0HZA1frl5x0LgBIQWaaPtyM0iCcVjPw/GupraLIgb9YSyP/w
	OdFYL51z+A1zejBzwEni24q1h+hxBEWEI3o/6Rgqp5BhN0uVvSxNT8ohhVcpUdNIAyTq4E6Woe1w4
	iqXEAg8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaaq-0000000F9MK-3txX;
	Mon, 27 May 2024 13:40:52 +0000
Received: from out0-214.mail.aliyun.com ([140.205.0.214])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBaal-0000000F9Hw-0R4y
	for linux-um@lists.infradead.org;
	Mon, 27 May 2024 13:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716817239; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=98TUkS0b+gRj1ZLjZVnojSNV/GxHrgmcGS9QODi+eTo=;
	b=N1iNNaj/6gf/zRZIOuRiuJXPRl/5QGFCPM+oIz5+MFcMyFKqWBbWNcGXOhCGx2o//h4FvkBzd8oJNAEUwE2yH5NhAuHx8wum3Vj7WMaXGQmpZ/JbgrWmD6Tvd2sa29l5Q44NXni8LRr8qh8mnUBpExpk0qdTioplxY2egcMxWdk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070043001;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XofsrHJ_1716817237;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XofsrHJ_1716817237)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 21:40:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/2] um: Remove unused ncpus variable
Date: Mon, 27 May 2024 21:40:23 +0800
Message-Id: <20240527134024.1539848-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
References: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_064047_736761_305A333E 
X-CRM114-Status: UNSURE (   6.86  )
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

It's no longer used. And uml_ncpus_setup doesn't exist anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/kern_util.h | 1 -
 arch/um/kernel/um_arch.c           | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 95521b1f5b20..d8ffd2db168e 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -13,7 +13,6 @@ struct siginfo;
 
 extern int uml_exitcode;
 
-extern int ncpus;
 extern int kmalloc_ok;
 
 #define UML_ROUND_UP(addr) \
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e95f805e5004..8e594cda6d77 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -126,9 +126,6 @@ unsigned long uml_reserved; /* Also modified in mem_init */
 unsigned long start_vm;
 unsigned long end_vm;
 
-/* Set in uml_ncpus_setup */
-int ncpus = 1;
-
 /* Set in early boot */
 static int have_root __initdata;
 static int have_console __initdata;
-- 
2.34.1


