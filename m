Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C3CC52D7C
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 01:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djYu62jVoool1PS6r9/4jk3+WjmBSJsC3CBExq2h60g=; b=F/oP1VWE74Nm2E9Q9+yG1phZ8k
	KgNjKhi/TrBlmJYs39j+YsxwbJvY67y71eplSa/RWWj9NpbUa6ZB0c9mnNZBmNxJEx159kjBrMfer
	C8JO1AqupYNqWIi0qTXyGZSdQOWXKiCILhpNYLFhf6cDIEgsDoYqVX+5IgM9mgoCIJ1xvWKwUq4lv
	DJvQkJyZ4BsF+2qFCn4+ux8qE/CQT942PmkEwnXYyCadZGj66U2hodaH2hDN74QIH4lqdWqmUW9x4
	AJ/4QBpIZnraQJbdPBDZXXtFEH4E+HC2GxJC9ZMnL5nB79a2RRxy6Uliq/PjcGhpxK9wZreRaaoRH
	52/ucAtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBI-0000000BWfn-1aRD;
	Fri, 16 Aug 2024 01:55:08 +0000
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBC-0000000BWbV-1IQD
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 01:55:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773297; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=djYu62jVoool1PS6r9/4jk3+WjmBSJsC3CBExq2h60g=;
	b=AxKPMijLprTjJKqQdpntoOlDvMFGSb+jrwDil2PJteLTUQE1kkx89VbVXJB44yCunqIWFAv0GiiITWLkMN6lNJgRKDTUM4qoneVsoctmJpwlFr8P8pANtRBB/s/ZKIvRlLBxRld4khjrSpx1oFJ/nMxStlSysMreToAFwnZ0UIY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBok._1723773296)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/6] um: Remove unused mm_fd field from mm_id
Date: Fri, 16 Aug 2024 09:54:45 +0800
Message-Id: <20240816015447.320394-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_185502_585807_234C4596 
X-CRM114-Status: UNSURE (   6.06  )
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

It's no longer used since the removal of the SKAS3/4 support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/mm_id.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 1e76ba40feba..b3571a8afec9 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -8,7 +8,6 @@
 
 struct mm_id {
 	union {
-		int mm_fd;
 		int pid;
 	} u;
 	unsigned long stack;
-- 
2.34.1


