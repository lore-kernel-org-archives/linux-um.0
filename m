Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A302D690E8
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TRl3bYa75n9c7n8bleAcp+zOh+k0CHRLO2tyS+NHN7A=; b=ZUyu5LbuAUul9lItXf3DK+BQg5
	NjOrVFuDoRXK2FYX4Q0A1QfTQ85zL70i90mtwHPTDGpdnOUYKPevz/h9hRe5pgLVHboWpqat08m/s
	jPWWGV85nBhFJgIVK53YYnnHtEDFl0S4ORPcjXCBryx/rGxNKe2I5R2RdsClTGKp4t5Dm0/S7770o
	GogJMb+cm1rQ4vOgpDyhtnTofUWLvTKaEJC8S+4xJx3m0Q+1q0idiyYYzQM5Skh6TpVm74GnZFUT8
	ULgrGqMyi1D/ZCzrNeR6OqV13Y9dflDSmKy0Gc7qgsDPOVf4jVfddkQBMFS0cxa2vr7mI1h6tjxqX
	noIF172A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwH-0000000F0lL-0E51;
	Thu, 28 Nov 2024 08:31:53 +0000
Received: from out0-196.mail.aliyun.com ([140.205.0.196])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwE-0000000F0jN-07YS
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:31:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782707; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TRl3bYa75n9c7n8bleAcp+zOh+k0CHRLO2tyS+NHN7A=;
	b=K8/mjUJD7SkoJ8fryFdF6ECMOe7R8T4AKuNXY8zSF3PNzdK9cqhq1Bq0LFiTbaJ2v5yIoUixVbrCnbT6X66ajkU4Oa+0cvfux2jkrmxC45chFnreAcCDkboIsRXBzbfHUVP8UNcuRKvWVeRhjgH4EW5iUjkr2bGp5s7ZgzRy7tY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WUh_1732782707 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:47 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/9] um: Mark get_top_address as __init
Date: Thu, 28 Nov 2024 16:31:31 +0800
Message-Id: <20241128083137.2219830-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_003150_243129_B883C674 
X-CRM114-Status: UNSURE (   7.18  )
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

It's only invoked during boot from linux_main().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 852267542a06..3e03a716c6ec 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -289,7 +289,7 @@ static void __init parse_cache_line(char *line)
 	}
 }
 
-static unsigned long get_top_address(char **envp)
+static unsigned long __init get_top_address(char **envp)
 {
 	unsigned long top_addr = (unsigned long) &top_addr;
 	int i;
-- 
2.34.1


