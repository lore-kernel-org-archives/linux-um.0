Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB436C54E49
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VN88PcUqVASGP6tiSAjiF8M3G9GaUhFEX/YdxyWeGGA=; b=vELVzEs2fdQRkHz9IEiB4f35nl
	0P6J2qabYa6j0jWWB0WbMi3RVWgzY98H2+SL47bmheKa16F6S8otDo/IQ90MQwvF1uHYMY09VwPv0
	NrgZh0aPsjLy8QYuSY7M0OWbXxxyCCuehNsaXIqKIo8iTBStq3mopYtl0gFITp7VbekZYMwX8Kxxg
	Dxs+Fn3Pj3NrWLRAQuxQTs5ue03PIVUYIraMEVNGmnOiABX7RuCctfyWjxTJ3K3Z2oN+PORym5rZ5
	Cl3iByzenfiWdiGY30Mo6QADMFfhLtRnAaKymkpJ5nESZlSpoTy69LCzhpGO/U1214uTLZqLK6hDF
	scaWLZ8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNS-0000000HNM0-3Ecw;
	Wed, 06 Mar 2024 10:19:58 +0000
Received: from out0-212.mail.aliyun.com ([140.205.0.212])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNG-0000000HN8y-3qEu
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 10:19:50 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-K1_1709720384;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-K1_1709720384)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:44 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 8/9] um: Fix -Wmissing-prototypes warnings for text_poke*
Date: Wed, 06 Mar 2024 18:19:24 +0800
Message-Id: <20240306101925.1088870-9-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_021947_151460_93537A0C 
X-CRM114-Status: UNSURE (   6.51  )
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

The prototypes for text_poke* are declared in asm/text-patching.h
under arch/x86/include/. It's safe to include this header, as it's
UML-aware (by checking CONFIG_UML_X86).

This will address below -Wmissing-prototypes warnings:

arch/um/kernel/um_arch.c:461:7: warning: no previous prototype for ‘text_poke’ [-Wmissing-prototypes]
arch/um/kernel/um_arch.c:473:6: warning: no previous prototype for ‘text_poke_sync’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 7a9820797eae..e95f805e5004 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -23,6 +23,7 @@
 #include <asm/cpufeature.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
+#include <asm/text-patching.h>
 #include <as-layout.h>
 #include <arch.h>
 #include <init.h>
-- 
2.34.1


