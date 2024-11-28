Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806D8D690F0
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bv8FwBsBESaCcP/PEqFLrYzx577vyZ9w8ROySyPTmvs=; b=xImRko3/xfQz/Sb1gUDzMkGs5v
	yYPRY+M06etsgY3LF4om4RLu72/rY/35neCowdMHjRVnR2pLtxPmcrs5KS5Es9I76hDtNA2qnahpj
	TJvG+BTR1TsgBosSmsHSYSTR80LTT5kgR3zirxen1cjYKzmSgXGM/59uHk5CpJcGlZrMrGw5YP8cA
	o9ud6R/Kmc4V8nBi0/k/tmrqkbuJqrL7dpdaA9pdRwq32dwHIoJnWNR/ogflHPjawSf0cqTyu0RKK
	whSEAG2e0H0u/LVkGU1YGFkd8nGwo7dnUs0lNig/dD84ILYc3Jh21w++pa6G6IHqC1HsyNxgwskXo
	YRR8hPFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZxF-0000000F0uj-12k6;
	Thu, 28 Nov 2024 08:32:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwW-0000000F0po-2fb0
	for linux-um@bombadil.infradead.org;
	Thu, 28 Nov 2024 08:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Bv8FwBsBESaCcP/PEqFLrYzx577vyZ9w8ROySyPTmvs=; b=F8/5qQQs/NsoZVyTtbw+jM5C0W
	x9GfzopE1uhFX4vverx4JmJUmDYKzVO0llTMZsPNycF0WujloHO9w36KJXFUeahZ2VhZbjODrTyay
	hX4GFdoe0+9NHlECYIVYYw+KBGYJ3Or1dzVXmmPZCfiSCRRt1RaJLGTQN3u+dM4XFHWRqFTGyA8fl
	95WttHe3MjpirCymGqHNJCK38F/R9MflgoRMlgJHcl+6I6OsWeZAOe9FPdx7OVEw0gEybrcndBgdi
	aMO7W3x2U8DgI3DAcTEfrHkbQWkSckwgbccnMX5jvNc9hMaAYpkQfr6kViLA4AZAO8zyr3hDEqS7e
	HsS3p8gg==;
Received: from out0-222.mail.aliyun.com ([140.205.0.222])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwQ-00000001Yhm-0Mi6
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782708; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Bv8FwBsBESaCcP/PEqFLrYzx577vyZ9w8ROySyPTmvs=;
	b=mWhjexMqFjTlJ/AAzOw707hAgvorScimr31FNtMF4fIWaR+ZWbXYmqiZmDm6NBLG4H7YThRMuTtY35gu+XXtwdQmwHzYseul+IW8itf7NJOCu7RZbWGKhYUTrCOqRQNDxJzk4IytnOFp2d4Z9sMXWkre6mHszhorc62etMSCixQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WVS_1732782707 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:47 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 5/9] um: Mark install_fatal_handler as __init
Date: Thu, 28 Nov 2024 16:31:33 +0800
Message-Id: <20241128083137.2219830-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_083202_870829_266E3867 
X-CRM114-Status: UNSURE (   7.45  )
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
index cf9697aa17f3..3f394f25e059 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -48,7 +48,7 @@ static void last_ditch_exit(int sig)
 	exit(1);
 }
 
-static void install_fatal_handler(int sig)
+static void __init install_fatal_handler(int sig)
 {
 	struct sigaction action;
 
-- 
2.34.1


