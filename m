Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C98D690F3
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmM4bKfnOoN6gQRibUUEULkKDIULN2ASmDmrUwawp4w=; b=ZNxPsqa5ovfmNcWXTZsQF96H2V
	tNljgFw/wyO8bfrSCs7HYIKnmIOdM6VDTHhR7RogZxSiNM3lkUBsl9geuAgXvgm9lLx79OpCo35Ga
	D0wPjSXTZC405PsVwgcZgneTM4nX/QyVgC0GmEDYDFQ1EyMU6pobCRqVuu1M0K5mJA4mlNNVdgNon
	qN1mcwM7x8v9EunDPn6hZs+42ieQGDVnLp+ylF0qw1OQoLzaztvj57tP7Am1zzWj6UH4mhKuaIckK
	wF6r+3BQmabqimIOYWeU7asn3c9R5W1b6pR28gI2bfcRgrDTLDbi06GmEAle5hoDfnMtz8xoGj4fp
	gdt8LfDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZxG-0000000F0wY-1I9o;
	Thu, 28 Nov 2024 08:32:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwW-0000000F0pr-2kfl
	for linux-um@bombadil.infradead.org;
	Thu, 28 Nov 2024 08:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=GmM4bKfnOoN6gQRibUUEULkKDIULN2ASmDmrUwawp4w=; b=ELuKSqo/MjjseUi2G+OaORkBAP
	Ek8cNP1Q5MmDl1oLdgGIIPWFokkFo7Hd8U28jHBn9fyjBQZ0rUmZxImrs5nnekj3xp0qNO1nZce+4
	R7vzVHeAnvYcbjWX5QMPFO8et/lDUTR9w/vAREfE63Mz8tCLRvRJRAqpZ52aoC0Ov+N36A6zi4RVB
	lOFIvA2JxF3XUbojpNnyGdBy9kZ6r9nEFWPVXrzL89vzLYVwr5mhnQI7S+aCKTqPh8ell4pFzX6MU
	nP41AKNqnnN+/ewGXf6zzzFa1+/G49Kpq0aTW/7CmAiXZcmj43twvtu2mqCKRyG7h87NEWCEGNIlN
	gM6kXLhQ==;
Received: from out0-194.mail.aliyun.com ([140.205.0.194])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwQ-00000001Yhp-06xu
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782709; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GmM4bKfnOoN6gQRibUUEULkKDIULN2ASmDmrUwawp4w=;
	b=FIm8UXgGRcC//eloWBUkRthj3YSNRKoSbXOj/THAJ02F5thW2mpksW1meu26/Amxl3cEIe1L5abx3IK1ToQ0cU8udeQ9ORofgyZUWFg/tJLZEQe3YsJT94qfqKHGXC5M1ud8YVdRfDTPC+txg3iTwed/jXr3LdZG40T3g/MVe4A=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WWX_1732782708 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:48 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 8/9] um: Remove unused THREAD_NAME_LEN macro
Date: Thu, 28 Nov 2024 16:31:36 +0800
Message-Id: <20241128083137.2219830-9-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_083202_870829_544EDDD4 
X-CRM114-Status: UNSURE (   5.32  )
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

It's no longer used since commit 42fda66387da ("uml: throw out
CONFIG_MODE_TT").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 13f3bfeb6378..3c63ce19e3bf 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -20,7 +20,6 @@
 #include "internal.h"
 
 #define STACKSIZE (8 * 1024 * 1024)
-#define THREAD_NAME_LEN (256)
 
 long elf_aux_hwcap;
 
-- 
2.34.1


