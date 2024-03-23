Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA77C54E58
	for <linux-um@archiver.kernel.org>; Sat, 23 Mar 2024 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/ldEO+n1bBDG05t+5FSx1BqkhYCaDri73vSlnPxHKik=; b=smmj1RlrVrqJLnWTW7Ajexqy+d
	d5XSMx11bgv6bsuTR+o+KiczuxzX8wcyK/4wq3NzN0gZTflUcV/SheDatugIxp6IJWuKfA/KFAMd0
	R/eZv1A94GMtXr0wp/6SGR4Yn5QXAJpkMAgx55EKDaPT4AFt0n17Hyxx4qcht09ND+HFl/g6aV3Ed
	nCwG6QNOeUA4MZYqEYcaDWj8LYqapZrMtoK4+PTwqa71JHMk6+T07lLdRIo0KjImfDtvIm1//PbTV
	PMslq8h8+7EDZb3tRL7eJJver2TYKVm8Et12h+etAWDtqKbxGu83dgJoU8Lmft0O9uh62OrG4OWLT
	ReauopWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro5Qs-0000000Aqjy-2Afa;
	Sat, 23 Mar 2024 17:45:26 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro5Qo-0000000Aqiy-1iZB
	for linux-um@lists.infradead.org;
	Sat, 23 Mar 2024 17:45:24 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 9948D240105
	for <linux-um@lists.infradead.org>; Sat, 23 Mar 2024 18:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1711215915; bh=mAKeHSlYlC/WNK86vCepUm6fXPa8vRXSPBcHY+AH2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=H+9BUtGkmp4iY3MVqwcV17UUsFPV0Xmb/I74X3EoRIYMrFXXpPsDbICjakUOv+SFg
	 qBT/U5qrgxYId/m5vNljIxp5gsCyYVFRBWodBRQ04o8cGQW1G5cPw5vNHpGQPlnguS
	 FAQKBbesL6p4hkYu/hz6D38zK/O3DhyLbfenigxX1XyoSKykDlIvTht6ecK4IHgmb1
	 I7vucXnyprPnMxkriX7Li6XVTP8BQyHRY4UDRJbg47LUAindU78S7P0+T69SpInoy6
	 NPgEvmes5kHsCL9lQxvr7CEZutI5tIpKkmZ9L8qR3iPTMN+GLxw5w0CfQRKQATv3FP
	 dikMPp8tcDWyA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4V266H52Wwz9rxB;
	Sat, 23 Mar 2024 18:45:11 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] um: Makefile: use bash from the environment
Date: Sat, 23 Mar 2024 17:44:25 +0000
Message-ID: <20240323174450.18376-1-shamrocklee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_104522_622740_3A6A5E3E 
X-CRM114-Status: UNSURE (   9.29  )
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

Set Makefile SHELL to bash instead of /bin/bash for better portability.

Some systems do not install binaries to /bin, and therefore do not
provide /bin/bash. This includes Linux distros which intentionally avoid
implementing the Filesystem Hierarchy Standard (FHS), such as NixOS and
Guix System.

The recipies inside arch/um/Makefile don't require top-level Bash to
build, and setting "SHELL" to "bash" makes Make pick the Bash executable
from the environment, hence this patch.

Changes since last roll:
- Rebase onto a more recent commit on the master branch.
- Remove a dangling in-text citation from the change log.
- Reword the change log.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 34957dcb88b9..00b63bac5eff 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -20,7 +20,7 @@ endif
 ARCH_DIR := arch/um
 # We require bash because the vmlinux link and loader script cpp use bash
 # features.
-SHELL := /bin/bash
+SHELL := bash
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
-- 
2.42.0


