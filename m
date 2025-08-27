Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67B0CA0FF7
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 00:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VKXxLRMEzZALbsNCYC4ggVRa4CCnjGww0i3eOSiDHxY=; b=ndcWJkEBYpG3khPvPWyFzW7Sbl
	YKvesqzD3jXa/qvhj97R6/rJoN4oJ6/FRM4WPDh5sY/MpA8HEnvecVJi+rZ+UOa14Iu8c3L/kTKWK
	9KanG4lfoclFoC18dnhj7odm3lBzTV+RYox7IQM9IXADQ7YAT84xPJz07SKmQEANvHqg3K1Ob9Wdz
	CKlWmDBNLyf6Lo5SUlsVFZp+LtU0wzcpkFb1v1eMUC3xqvlg9D2mN9Mfuw6lzXf601dLlvyLBwe/X
	Jc/8jQZPLL+iPa3bfeQ34OqBRNca+KbHRbgjWEUDxQm3Wxk3nafHY2+L6PE8nNsMj3wq3Lp7ZW8Zl
	NLFzbXlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tq-0000000DTPA-1FMx;
	Wed, 27 Aug 2025 00:57:38 +0000
Received: from out-182.mta1.migadu.com ([2001:41d0:203:375::b6])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tn-0000000DTNh-07ge
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 00:57:36 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756256252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKXxLRMEzZALbsNCYC4ggVRa4CCnjGww0i3eOSiDHxY=;
	b=g8n9X67ZuveDa4xnxLdTZnY1ps86k4vjloxPhUXKnH/ipTVmRgK3cG7zPLqai5igmph3DO
	t5jSr5Oe+yCpA6sqNnC4+zcoQ7cP8x3TIE6dmLhqHCn3C3DG/+IjqM7wSZwRHh0qmkde4+
	f8ycF48xmdkfv7zDmVgIBtuI6HR4Oxw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 3/7] um: Fix help message for ssl-non-raw
Date: Wed, 27 Aug 2025 08:56:59 +0800
Message-Id: <20250827005703.3847636-4-tiwei.bie@linux.dev>
In-Reply-To: <20250827005703.3847636-1-tiwei.bie@linux.dev>
References: <20250827005703.3847636-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_175735_209479_DD7F6A5B 
X-CRM114-Status: UNSURE (   8.21  )
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

Add the missing option name in the help message. Additionally,
switch to __uml_help(), because this is a global option rather
than a per-channel option.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ssl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 277cea3d30eb..8006a5bd578c 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -199,4 +199,7 @@ static int ssl_non_raw_setup(char *str)
 	return 1;
 }
 __setup("ssl-non-raw", ssl_non_raw_setup);
-__channel_help(ssl_non_raw_setup, "set serial lines to non-raw mode");
+__uml_help(ssl_non_raw_setup,
+"ssl-non-raw\n"
+"    Set serial lines to non-raw mode.\n\n"
+);
-- 
2.34.1


