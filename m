Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94902C83F0F
	for <linux-um@archiver.kernel.org>; Tue,  8 Jul 2025 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qp2oJdPPgdJeYOhHz/EpHzcek3DZO9u1QR6yxIB/tuc=; b=nWRvXsPNRuT9qgQY7l/nw2FoCw
	WDq9ocDWWb6hZtOcO+XRaRZRBLNNuIKODPmLh3yKDDC9mYqjYkTd9SM+29nwlMrsmMG4y25j0XC1U
	EGOxvJtEs9/peAt6mgvnC39n4zt6BAkSMIe/sbQooXVNZeLgaqhtyNlcELPz5+ftyibt35/57ko5K
	VjDFvqItgfCl6Iq/f1NAHyHBuGyqT44pfMdDoClpg0DVV47gGlWDE0GuqQN5lHqSF0Hu/iHNCUTHz
	riZbvgwacB/dY6gHrCDvLXuzEb+4G783v3dX0kWClHIC5FP0w+QuKhQzo4Plhl3ZkiogXmrio388b
	m1L1dR8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4xJ-00000004xEB-13N2;
	Tue, 08 Jul 2025 09:49:41 +0000
Received: from out-186.mta1.migadu.com ([95.215.58.186])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4HZ-00000004qM1-3QbF
	for linux-um@lists.infradead.org;
	Tue, 08 Jul 2025 09:06:35 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751965468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qp2oJdPPgdJeYOhHz/EpHzcek3DZO9u1QR6yxIB/tuc=;
	b=KnKQtHZWcyMMzxKu6eL/gmYE4eJzzDBz/RGYyRPmZGxoDr4HfVSt4dZ3Zq9zQ+Ax13IcAL
	oTGRfy894w187krGLORWAc2p1+BO4YY8RCDzrqQB1yQTrPR6azh0iUsbKGX3gh6PtipYS9
	6oii8HOYIcTAhG5EnDuvo9VvApmumBI=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 0/4] um: Minor fixes and cleanups
Date: Tue,  8 Jul 2025 17:03:59 +0800
Message-Id: <20250708090403.1067440-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_020633_999960_70989F63 
X-CRM114-Status: UNSURE (   5.01  )
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

Tiwei Bie (4):
  um: Make unscheduled_userspace_iterations static
  um: Make mm_list and mm_list_lock static
  um: Avoid redefining ARCH_HAS_CACHE_LINE_SIZE
  um: rtc: Avoid shadowing err in uml_rtc_start()

 arch/um/Kconfig                 | 4 +---
 arch/um/drivers/rtc_user.c      | 2 +-
 arch/um/kernel/skas/mmu.c       | 4 ++--
 arch/um/os-Linux/skas/process.c | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.34.1


