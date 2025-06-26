Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9673C7EE30
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mMACwKQ45OFKp3dqM69V6dG6kIbJSpYqiKbZLP7Vh9g=; b=pRPfAH/EXadMwDpR07nErBdApt
	YKOuTi5WWCQ8kQUmWJolnHQaFaw4cxJ/AvTCSmsNWYNMXZGImuisM4Gu7iH6rrQwYinv9eg7+GoLZ
	t63s/GZL7QLlDi6ZouiGmKZm21Z2NOMmt8zj+rggqKnQfPYZKiNQT5YqmHfsrmyjNfP61uqqjH2KP
	CeyAMmbasbN15Y/q679DfkMoWoUeezHgkemPihRIEgaeME3oF9ct6tSBbg05wwv8iaB3i7jNmq93L
	E5ajEkXoR0BZk4Q96fQmXeXRFnvOtTDDCAt9QiCAdTcTCsH5OOppfzOi+Rm0ydcoEVl/IWPPS2kfy
	8O0LEECQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUnuC-0000000BzbC-2PJD;
	Thu, 26 Jun 2025 14:48:48 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUnsv-0000000BzC9-0yaw
	for linux-um@lists.infradead.org;
	Thu, 26 Jun 2025 14:47:30 +0000
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mMACwKQ45OFKp3dqM69V6dG6kIbJSpYqiKbZLP7Vh9g=;
	b=uT10fAhSsV9cz89bABA+WeC8KQvJ8SxMxJa20uSkA3MPkPDtQbtJUVUBo9dsyxtKDt4o2W
	b9uwOmJYazrbtXFVNDYow4MF9i3AOOxUicfRLH9+9Dq2FyJsN/Uyt+Lv04YwQ9brDXQXD9
	nYnAI67KtwE2Bzn2lfVOeaYGm6JCm4QpH6bWl/D+ZpsTTsQi5CHDqOHpmW2h/UslmKIKf9
	gapHY1a65YGxpxBDdC0OOISbGvl6auZZktvR43Sd063SM8TqNXhyYcaW6ESmkcJK/jEEg2
	96r4rZyqrGVGJowzLAEfxrZFz9/f54L+mIOoIqgmHM6QEGJKWNNFef9Mz92Rgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mMACwKQ45OFKp3dqM69V6dG6kIbJSpYqiKbZLP7Vh9g=;
	b=hQCjcwYqJJ2PyvAblYu+pT2ArzJfI6f/LcTDy9a5X68jkNrwT3LMB6pR3L/SrtWYr6xpu2
	SWiD1l4eTqEGH+Dw==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/1] um: MSI parent domain conversion
Date: Thu, 26 Jun 2025 16:47:14 +0200
Message-Id: <cover.1750947651.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_074729_408224_48B34625 
X-CRM114-Status: UNSURE (   6.71  )
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
 arch/um/drivers/virt-pci.c | 46 +++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

--=20
2.39.5


