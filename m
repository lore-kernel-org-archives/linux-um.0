Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB54AD690ED
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ynwTOlASH6FPENs5xoSdmZ6m8k8ZcE0LflEyQfoYoPw=; b=Au3XCyc2cjNQ1Llphz4kKXvvgw
	9rXKXVZ2TvsT/2EheX+MPhayUl9TD+YmTzBOgOF24fJGZbVy6/10kBPYmsMNY9JWuojuEsIwpibES
	dYZsXX+5P2YuVIwSpjURzrW7X4b5Oszwe1ulFo7/Zj3dO2pO/fsHrVrR/ETOi5UleVK0n4mK6EJrZ
	UuuL7utgpf2Zuj510m7d/mVlIs7ZX4AuWPF8HlziwWc1/mMB4alW3RMciIJGncO1Y+tBRbw9og/JQ
	WedPMzBldDsO+tivL4fAkUqvtK1co9il5pwobm7LkwWFPnwRLOxdytPdsRWY0irQydF1ntlC3e1Cg
	hao6BAZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZxE-0000000F0to-2cti;
	Thu, 28 Nov 2024 08:32:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwU-0000000F0pW-2fG7
	for linux-um@bombadil.infradead.org;
	Thu, 28 Nov 2024 08:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ynwTOlASH6FPENs5xoSdmZ6m8k8ZcE0LflEyQfoYoPw=; b=FHLlZgXZbkKHvTJUQczFFw0G5x
	amlo/BXWenLFhjUC9jbmMvoiHN9JlWwDDoi7auG8suq/xZLeO58BZEKtL9RAmWVqRGx2Q7OO/VYx+
	Wis6xwx/3+j0W7/D+PnhekywJllGoqDdJO/Km1svWRbmYUc4Cix/EZbS+XXNGWTTBIKxQDzMOuFVk
	8gC0G9zjy+qKY8spHAIC/npNW6tlIfMu4dtCey8sNEkTY86WsGDYM4ZzqRK3Vlqrg+8nAkyjM8Qek
	DK2LQ6Y5u2pCI+8HpF8yP4X3p6fm/fVIS0uXiiBTnr+C0lWkPpn2K0h/QOerYib0ubOz9ZFN25lsh
	D6+AY5OA==;
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwQ-00000001Yhn-0O1C
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782709; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ynwTOlASH6FPENs5xoSdmZ6m8k8ZcE0LflEyQfoYoPw=;
	b=021QHERfOkzxXxMEDjJdBKJX11ZTdHYNB8cmK/OK5DwC63YxZpUlyEVX/PFPG9g0iATrkDXoDnEfXL5o5MhgmEXzRxBH08v2Sd6OStRSnx8OMRNpJfupiV32xfH50Ej1ygn9+vi/BngQ8RpCsqw5lQsG+YKAKqe13DlWF8atCLg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WW._1732782708 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:48 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 6/9] um: Mark setup_env_path as __init
Date: Thu, 28 Nov 2024 16:31:34 +0800
Message-Id: <20241128083137.2219830-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_083202_869405_273D70F6 
X-CRM114-Status: UNSURE (   7.40  )
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

It's only invoked during boot from main().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 3f394f25e059..3f0be24b3633 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -73,7 +73,7 @@ static void __init install_fatal_handler(int sig)
 
 #define UML_LIB_PATH	":" OS_LIB_PATH "/uml"
 
-static void setup_env_path(void)
+static void __init setup_env_path(void)
 {
 	char *new_path = NULL;
 	char *old_path = NULL;
-- 
2.34.1


