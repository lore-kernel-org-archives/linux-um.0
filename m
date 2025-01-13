Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BEDC02185
	for <linux-um@archiver.kernel.org>; Mon, 13 Jan 2025 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SUfwZRc6dkr8r03Wi3v0f8RKKHN3fXK2hOXMngZMvOc=; b=ogzQXN/gbzqDVeun+0SuK/rpui
	L3KNqRTwKrCiY2cY24Ep/5ZH8JEdN6z7kyvyx1vvyprEPsQHIDib5Kf8teEx2A14LILvH/rzE37T2
	5C3TdBsJYqQhPCvbmUQ+++g4rSzoko3o88OgF4xR+EgxGnxWJSoE+5DGXd+VxdZ2Qphv7XYhhmigt
	6A5DIX4sMIfUMLMEtYFlU3y04C4RAWOLIMPKOJYWkbyHGUwtC+HF2hOQmrX/ypK+1S44DA3/D1hxj
	TzVJ8kgOhXGEAwTRYO0B25ouYNrSRw1DYbGybZKAAx84anzOwSzB3ULDyvYZZ39BA1Ri7YTT+jFay
	xJbILiFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMwK-00000005mVE-2Nux;
	Mon, 13 Jan 2025 16:05:20 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMQi-00000005enu-0VHV
	for linux-um@lists.infradead.org;
	Mon, 13 Jan 2025 15:32:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1736782354; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SUfwZRc6dkr8r03Wi3v0f8RKKHN3fXK2hOXMngZMvOc=;
	b=aTZUpxSbVSA3J9cwFOJvs8SD+hPmat/VrmexJzynKozIIaUqlMpxLtS0XlPiseqSLhaH9c0z5p5ck0ydBbtcdiIMD3WOMEzs59NL8vC/SoVT0tosmLOwyb3pECvUZKtwX311so9Cf8ZsIOEF1T1nTX3pSoY/NBZOg1WIT8x5qfs=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.b1pVbiE_1736782343 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 13 Jan 2025 23:32:30 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/2] Fixes and cleanups for fixmap removal
Date: Mon, 13 Jan 2025 23:32:16 +0800
Message-Id: <20250113153218.3331321-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_073240_335158_882DC1B5 
X-CRM114-Status: UNSURE (   3.86  )
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

Tiwei Bie (2):
  um: Include missing headers in asm/pgtable.h
  um: Remove unused asm/archparam.h header

 arch/um/include/asm/pgtable.h |  3 +++
 arch/x86/um/asm/archparam.h   | 20 --------------------
 2 files changed, 3 insertions(+), 20 deletions(-)
 delete mode 100644 arch/x86/um/asm/archparam.h

-- 
2.34.1


