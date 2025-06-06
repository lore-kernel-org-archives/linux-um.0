Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C04C61DB8
	for <linux-um@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sJeeupsnO+nVYU6tWBglDOOGaNDHh0QRf3xquZdMhzw=; b=A4Ag4ynZpxWJ4jeKAeaSpfm6aB
	LOVKMcctZZoc9SQO8yY+8m3QhRv+7m5DBC8MEJbDXgw+fKbN76pTOpM9vzf1btTKBY+Mb93ugeKZi
	5Hgo9xtw5STeAiBJSXVSB8Z3iWtMonluGGnW5rYjFPiKYs4FJTAV4PM9FO1kmwpuvn2LthTGnIXLl
	A7okcqDqR4Z39bts8wD+rceGPhbEcCdMuyn8vQ2GybWrZYwSCviqm/lCNyZKI/mZXKPf1/QVCAtlm
	JohoLCqFDz26JfCP7N+/qFYPjUn9ek0/AKRV9MIhle/GyAnLPtLXK0SikrXb4rBIjiZ4skEXen7mn
	qtGGKhsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRN-00000000GzZ-3adq;
	Fri, 06 Jun 2025 12:44:57 +0000
Received: from out0-209.mail.aliyun.com ([140.205.0.209])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRK-00000000Gnv-00aX
	for linux-um@lists.infradead.org;
	Fri, 06 Jun 2025 12:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1749213886; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sJeeupsnO+nVYU6tWBglDOOGaNDHh0QRf3xquZdMhzw=;
	b=KkghcqdQtUCoByM81NkLenBj9mhwZkZyKTBNNWX3GLO5VqsytDTaTijb8MUhC5jlbaqqCr1QdmVfTmHIR8prONer0z4Roc1edHMgON1XOXtatlrZMrTyI7m3WpWZ8UkQ2hmYNTJmZBfmXSaVHKFCcgKhNsoNas+S6icK1yE1kKY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dD3Yx11_1749213884 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Jun 2025 20:44:44 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/4] um: Use correct data source in fpregs_legacy_set()
Date: Fri, 06 Jun 2025 20:44:28 +0800
Message-Id: <20250606124428.148164-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606124428.148164-1-tiwei.btw@antgroup.com>
References: <20250606124428.148164-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_054454_478582_D4F04D4F 
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

Read from the buffer pointed to by 'from' instead of '&buf', as
'buf' contains no valid data when 'ubuf' is NULL.

Fixes: b1e1bd2e6943 ("um: Add helper functions to get/set state for SECCOMP")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/ptrace.c b/arch/x86/um/ptrace.c
index 3275870330fe..fae8aabad10f 100644
--- a/arch/x86/um/ptrace.c
+++ b/arch/x86/um/ptrace.c
@@ -161,7 +161,7 @@ static int fpregs_legacy_set(struct task_struct *target,
 		from = kbuf;
 	}
 
-	return um_fxsr_from_i387(fxsave, &buf);
+	return um_fxsr_from_i387(fxsave, from);
 }
 #endif
 
-- 
2.34.1


