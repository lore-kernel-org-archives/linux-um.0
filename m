Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E167D1BDC4
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tV2uoJkDQ17IEQRpui8959JZaVBs9bsNSX1xF4BZD9U=; b=xMgflKSoixviLIKAkv2qz4RA5y
	DAjXCpVjfOtfDPq3syRcD5siCcwujpKIJfwXxlE4vCELA9/x+yO3kD0BX32SuoCgIHcGA3vEjQPNp
	OQEul1DxcX9SQi6qj/3itl1ZyRm0k8GDNzfyX2cEGJWtJHVsUDNQHK8WdgOjOFkJhRo8ATCR9iZEQ
	FmELwEW9ILpBNTrgIXl+bv2Tpx9HJ9C4tFWP9xzdsLlu2d3JveFAutjxgROEruW9bqGZ0QgTC5GyZ
	sL2cgkzMFpbix9jOQg8YnzZD8/bfxx6cYs0UQIK/VnhoGXDDK90pMOoMLHGCcwdx8Xm4SJ1y55YSL
	0fXLeMGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t801h-0000000EOOY-2X3k;
	Mon, 04 Nov 2024 16:34:01 +0000
Received: from out0-219.mail.aliyun.com ([140.205.0.219])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8006-0000000EOGJ-2NhM
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 16:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730737937; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tV2uoJkDQ17IEQRpui8959JZaVBs9bsNSX1xF4BZD9U=;
	b=E91RxPGzAKuwhRuKCKKCr5wll5by5tQYXSt28JfX6QT6Vw4bg3bpCLQK53N/xmbHZ+0Kewge4iJSfPSe4aui1dsGIWAjeg5gUdDgmt2fw2UODkHgjTCj9lwaQ7fqbYTU9Lp/x/P8rcTF9LJqWxI49OOTCi1r+KByHuRpI1MLewg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bDg_1730737932 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:16 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/4] um: ubd: Initialize ubd's disk pointer in ubd_add
Date: Tue, 05 Nov 2024 00:32:00 +0800
Message-Id: <20241104163203.435515-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104163203.435515-1-tiwei.btw@antgroup.com>
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_083222_836108_BFB9B897 
X-CRM114-Status: UNSURE (   8.28  )
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

Currently, the initialization of the disk pointer in the ubd structure
is missing. It should be initialized with the allocated gendisk pointer
in ubd_add().

Fixes: 32621ad7a7ea ("ubd: remove the ubd_gendisk array")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_kern.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 2b8d04e67600..f19173da64d8 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -898,6 +898,8 @@ static int ubd_add(int n, char **error_out)
 	if (err)
 		goto out_cleanup_disk;
 
+	ubd_dev->disk = disk;
+
 	return 0;
 
 out_cleanup_disk:
-- 
2.34.1


