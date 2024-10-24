Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15474CE8E80
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7nomrNF4UUPmRyX4jzl23OQWMT1pV1gEWGtKNbTeqs=; b=p9BV/2mvWt3ZSPR4cnXT41+Aiu
	9pP1S5bFKvaH2xTUU+DsNh4D17K5cfQzezwi+0xjo4ST7yo496/6RSPAtwdPm9gnV7YzU0BsYL/J+
	VbjjtkMv8xv7Q+pYfpzPqWPl271qgV6mJFlr0uLaPaslSs5VUR7fTQOYk2MyNWWb0Yx0+5hMJLkQd
	nB4S0IRRppA4FuBfqygssyxOfG6bySshe547gcw5FvdhgbCEBhpDdpTzDqfFFxK1/dnKGbHShpTGc
	XN9PyHlBZq2UYy2k2qAQFn/6pxrlYiAR2liaI2FLCX5MUyjG1rT8J24okJekmnh0PZ8m6EuCNTyHB
	3OB7sjBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3z1A-00000000mKK-3BqS;
	Thu, 24 Oct 2024 14:40:52 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ypO-00000000jVf-3iMQ
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 14:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780118; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=o7nomrNF4UUPmRyX4jzl23OQWMT1pV1gEWGtKNbTeqs=;
	b=o4Vnko3AJULnvRhVZjHaiYWcOaoEAROuMn51S1xO5XJIiAjpkff8GeXXKnkhctQHO09yAyCK0ORw0Ho8zvAeI6UOVg1O/m9lJhE8DXg3b7fD3GNB6HSPEcpqFp6BHOUOEFfyt5Cyu0UNfIGRNr/6TMN5tfSlZZqv/CGbH9nBLpI=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBt-G_1729780117 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/4] um: Set parent-death signal for write_sigio thread/process
Date: Thu, 24 Oct 2024 22:28:27 +0800
Message-Id: <20241024142828.2612828-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_072843_411447_C6B19002 
X-CRM114-Status: UNSURE (   6.62  )
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

The write_sigio thread is not really a traditional thread. Set
the parent-death signal for it to ensure that it will be killed
if the UML kernel dies unexpectedly without proper cleanup.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/sigio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9e71794839e8..9aac8def4d63 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -55,6 +55,7 @@ static int write_sigio_thread(void *unused)
 	int i, n, respond_fd;
 	char c;
 
+	os_set_pdeathsig();
 	os_fix_helper_signals();
 	fds = &current_poll;
 	while (1) {
-- 
2.34.1


