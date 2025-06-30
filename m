Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8066BC83000
	for <linux-um@archiver.kernel.org>; Mon, 30 Jun 2025 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VOem6DFTTBYtd/vEfcGkm8LWs/7rqMWLb2YBeulRl+0=; b=OGCzKQtTpXrWTVzWZdDv4tU19O
	D+ST9FXWqJveOhth5ePIA/CuoWHFIPYTOxPycDBzgATY9cWFDqItuKQYwKpKAOYmLtiIgLRGtL7+2
	owtIUi+vgErZC0QtQSg5cWbSJ1AX+FOhJ0IF0544sgJnUAyjByjgN4T0/q8ozgAyTIkMpyRwCSdC8
	uce70C7xCMm8szlc0aYF5e7WrLp3go2y5HlKje/MhRMfkNG1Z44tHMwazkCP4ldjToBjbgqmcZ4fg
	hdtt5DnIVE63Z6Hqwl1mnrwa1BNyIPS1QwAStTJ9ZzNJ4V/3TB+h6RQaCuhrFspSEIgg01Pt1Gf9+
	ay8Us3Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8MX-00000001Nef-3Ydj;
	Mon, 30 Jun 2025 06:51:33 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8MV-00000001Ndu-0ERt
	for linux-um@lists.infradead.org;
	Mon, 30 Jun 2025 06:51:32 +0000
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751266288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VOem6DFTTBYtd/vEfcGkm8LWs/7rqMWLb2YBeulRl+0=;
	b=j1sv8PIsIWX0hpZELMY6hqQzKgDyy12A70T6BfRczuL2qJTrjiVdSTOBCPz8zpsBNjHbGQ
	wgi3atCrmjxPfMqCrS+Ydk6JNnzGAr6uD9okbDz/KwKh6K0rdpyGPZDUCp21+7S8ir7t9x
	OFMTsKliyKKdWjfchci8mOanx2YfeoO0/R/HyaTXDjCBJ7kWCnw+mYt4Ml0RguJNpkGUQ9
	pnl8mLrv/Vr8K6t20UqW2FH9NXKCfM6gkkV5gqy35DGatCO1oxPXToVkJ0ou0sUNr51pMw
	dA9EvWNohUO+NHK+e9akS/fsSmWK4iiPc/I7t04GxbIqI5jAQPpwUsNNvDiNkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751266288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VOem6DFTTBYtd/vEfcGkm8LWs/7rqMWLb2YBeulRl+0=;
	b=8BCumvic4SrldCHtcOnYKNz1vML2QeEHDqac5qxWs92gE9mT4FvcKNz7Wfl+JD+xvJ0z8o
	Kc76aanG7kIN7bDg==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/1] um: MSI parent domain conversion
Date: Mon, 30 Jun 2025 08:51:15 +0200
Message-Id: <cover.1751266049.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_235131_234424_6CFDB572 
X-CRM114-Status: UNSURE (   7.40  )
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

The initial implementation of PCI/MSI interrupt domains in the hierarchical
interrupt domain model used a shortcut by providing a global PCI/MSI
domain.

This works because the PCI/MSI[X] hardware is standardized and uniform, but
it violates the basic design principle of hierarchical interrupt domains:
Each hardware block involved in the interrupt delivery chain should have a
separate interrupt domain.

For PCI/MSI[X], the interrupt controller is per PCI device and not a global
made-up entity.

Unsurprisingly, the shortcut turned out to have downsides as it does not
allow dynamic allocation of interrupt vectors after initialization and it
prevents supporting IMS on PCI. For further details, see:

https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/

The solution is implementing per device MSI domains, this means the
entities which provide global PCI/MSI domain so far have to implement MSI
parent domain functionality instead.

This series converts the um's driver to implement MSI parent domain.

 arch/um/drivers/Kconfig    |  1 +
 arch/um/drivers/virt-pci.c | 45 +++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

--=20
2.39.5


