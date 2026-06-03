Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34168CD6E55
	for <linux-um@archiver.kernel.org>; Wed,  3 Jun 2026 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z41S8+z7tMVQT79W2tTc4PHUQQH3DeExM0pq8V9Ucqw=; b=PxuLmiF6bn5v6Nzn48lc9rYkoi
	h6BGIoNgfGpJxUR4PPwHTrl1pkpVuovzWDNgA/uiKXJdQzVvayW2ygTDKCCz/ceJQEV3EgjTzOOGg
	GgKlEmZK+L4Uk29DI0KLUn7EbyVq6kCPFgQOtbH3OFGdrH5yMYmN4ocAEO7+UFtfvn5pJuztwDrKi
	griyDveW6CVuAdBbUeLTRqVy93GmnNOnBCOCa27RZIqIsMgErpgSW98KFcE2Id9HYGgElMLtm3geq
	8VEuXAibAdSJuoMBpTsmc+sW/+TBtHksNr/Zh2joXUo+l6InPn7YF8VEoLdk9EHD4r+jPfKfn4/pj
	xYSLckew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUg3D-0000000EUBz-0ZZZ;
	Wed, 03 Jun 2026 07:30:07 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUg3A-0000000EUBK-3j2E
	for linux-um@lists.infradead.org;
	Wed, 03 Jun 2026 07:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780471805; x=1812007805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zrmvg0xl0ahWyx8U34nWAZMsa1U8QvmdbZvc6silBEw=;
  b=k5mmWwF2Igr8xcqJq04ttVlVq/3fKGHzQ0txBMUHmMVbWKppiyH2AJpo
   Cxf1XXIIu99y4y3z5ze+Mxtw6xuTV+39jXM4K/ng41wf/oKzEHtXcQeSr
   lNCuDfQBC7IVG+wd17DRiewl3XZKT2/lvyxso31CO4BwtaAc4bQ/XUGWt
   txCMZ+UH/qqn0W39MHhRxbhyXpQRYNc5DRM1FCL8Kg1mnOMASftUzbujS
   m0k2jfnuD7DbZHhj0BBdK2pro6xqzbth7JgBuzM4CQTHEJoiBTkUGyJ89
   +N3dFu8d10xGuXLOZfIATDFQp3W0PCfHZK7iZQpJPgq4QldDnaUS82vt5
   w==;
X-CSE-ConnectionGUID: QE5BuWRTTtyVRrf9C31P+A==
X-CSE-MsgGUID: dyGoxj1jSoO84/Ga65ys4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92753834"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92753834"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 00:30:02 -0700
X-CSE-ConnectionGUID: XQxMBrbgTpOOP34y20aS9w==
X-CSE-MsgGUID: ntrASwMFTC6tTNQ45jv1qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="245960521"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 00:30:00 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8BE0A95; Wed, 03 Jun 2026 09:29:59 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] um: vector: Use %pM format specifier for MAC addresses
Date: Wed,  3 Jun 2026 09:29:58 +0200
Message-ID: <20260603072958.107215-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_003004_970318_4D1C97D4 
X-CRM114-Status: GOOD (  10.19  )
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

Convert to %pM instead of using custom code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/um/drivers/vector_kern.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 2cc90055499a..e09c9db4f4a7 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1557,13 +1557,16 @@ static void vector_setup_etheraddr(struct net_device *dev, char *str)
 			"Attempt to assign an invalid ethernet address to a device disallowed\n");
 		goto random;
 	}
+
+	eth_hw_addr_set(dev, addr);
+
 	if (!is_local_ether_addr(addr)) {
+		addr[0] |= 0x02;
 		netdev_warn(dev, "Warning: Assigning a globally valid ethernet address to a device\n");
 		netdev_warn(dev, "You should set the 2nd rightmost bit in the first byte of the MAC,\n");
-		netdev_warn(dev, "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
-			addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4], addr[5]);
+		netdev_warn(dev, "i.e. %pM\n", addr);
 	}
-	eth_hw_addr_set(dev, addr);
+
 	return;
 
 random:
-- 
2.50.1


