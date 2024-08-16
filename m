Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18579C52D7D
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nrudy3y11XA7JWBXeZ+LwBKZ+ByI+KD/BZ+2ukqvBAE=; b=lkJc7HDl+bP2MneyOjiyLdapNA
	7QUxAmj9hzzqC0HPDagA75KpklJsA8W+bnIg82yu+6cI7DXFcY4ScIGTcrbCjSLaBVsHHHiKqPofF
	mumOCIdEoqQuEWEzMbJVWn8pMIha3ifqortAnkQN1UNQIBb6FMS7pblGOd4Cy1+T7vQHajaEaEju3
	R7OeQGNiIcpnEt2r3ID19MSMD2jOA/u0NY9UJcKk8J4z/gGIsGvjQQcrcCHcREcPb8kqWe5tqaqVC
	Yi4+ZJwu4nBWwUHdHLx3FeASSgYrSDS2bBinvGBotieD5sJcv3igQ5sOsaPTRVy0zevKWXkFOEKQs
	nHqpB0mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBF-0000000BWed-3a4v;
	Fri, 16 Aug 2024 01:55:05 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBC-0000000BWbS-0btk
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 01:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773297; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Nrudy3y11XA7JWBXeZ+LwBKZ+ByI+KD/BZ+2ukqvBAE=;
	b=WnKoAUTHkkU/nk4joL1SFmwvFoGPTORJ3ekKRGgWt5rsOxDMOS27mpBMxlqfsniPEICF+UzRHUel3Y0gPArCnfwOiT8kx6mqHqP46mENtQejCLY9wh/9SQX6Qi+np9b8ESXHlnZdddGD2ed07nRfq5go6jkmWBD18zIaNUGIl8I=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBojj_1723773296)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/6] um: Remove unused fields from thread_struct
Date: Fri, 16 Aug 2024 09:54:44 +0800
Message-Id: <20240816015447.320394-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_185502_599372_73B95FE4 
X-CRM114-Status: UNSURE (   7.73  )
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

These fields are no longer used since the removal of tt mode.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 5a7c05275aa7..864389ee29f6 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -28,19 +28,11 @@ struct thread_struct {
 	struct arch_thread arch;
 	jmp_buf switch_buf;
 	struct {
-		int op;
 		union {
-			struct {
-				int pid;
-			} fork, exec;
 			struct {
 				int (*proc)(void *);
 				void *arg;
 			} thread;
-			struct {
-				void (*proc)(void *);
-				void *arg;
-			} cb;
 		} u;
 	} request;
 };
@@ -51,7 +43,7 @@ struct thread_struct {
 	.fault_addr		= NULL, \
 	.prev_sched		= NULL, \
 	.arch			= INIT_ARCH_THREAD, \
-	.request		= { 0 } \
+	.request		= { } \
 }
 
 /*
-- 
2.34.1


