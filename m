Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08092C7EE31
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 08:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i7N/fRingZ0nASgb9h3OMYxTeVtNaki5J/VzCocS1PI=; b=c14qIrWUd+YPXsH9Hq+jwpxR1F
	cCHPOFQrR+qTvHwtZgjulTpu4AWJ2lty5M7vZOQppnaFCtb9Zt1Wvfc7Fq/C7CD1fhlLIqsUvRz6Z
	zOLP+ilj0j3Lmsr8o1F5QayKkGis1yBjzJAUoGtVcfHi3Y9H4l0WDdTfgMfG40liF5GgsibjGhphh
	IALrk6l3O1biWmSNP437w4lnl7dZaaI0FwsqO7mr5vtEvxOPGMkKNDcE2Rs1TSagdXsqTWlkTYTKz
	1ru1qZStdjXajw7oODDWbXlQrfJ32yylBNM7bg4vDycF/koctkItTSQROIl1YFhrWfEEuI4PCLx+6
	sW1Pfzkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4mO-0000000E07X-2qd5;
	Fri, 27 Jun 2025 08:49:52 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4mL-0000000E06Q-3weN
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 08:49:51 +0000
Date: Fri, 27 Jun 2025 10:49:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751014188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7N/fRingZ0nASgb9h3OMYxTeVtNaki5J/VzCocS1PI=;
	b=NGXN/xbm2bgHmL3wkRzDn+imuZsQlZtVyxnNlr0WK8Q/7WGHOCX31dp7jplzYqn1WZuhcW
	vUrXgtR4xwvBXNwOPP24vtGSnBBy3QwblBcguGCKbl5gZizLbktpP+SjcDzf4WEtgKnn86
	jYBIS2iT/w3IkHmf/I0abKzMszwAreiMTQIVE+th7yoDW6dTwpJEYGcgFINOHg1u+ZSvgs
	oDY0t0WEhkK8lpGdbnp4wGPBSfABNcBBt+5DjZG/+iD0ajr5Emqk0WkLncyPZ8PvNpD+ni
	0ujH/O5ZyWdTSeP/HPhDSMEIG+6+gr9SIKV9zCvHBArJ+rM/iSIXq6NyJgkFMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751014188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7N/fRingZ0nASgb9h3OMYxTeVtNaki5J/VzCocS1PI=;
	b=DAlzIDfnOVEXQ5IrxilGNN+9PrzqbKnb95yvYKHXhneFlYqFEc8775sJf9IJmBp5MQPMIq
	ydptbHXp58yJ+ECA==
From: Nam Cao <namcao@linutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
Message-ID: <20250627084943.nCYOI4Vp@linutronix.de>
References: <cover.1750947651.git.namcao@linutronix.de>
 <b911c2f15c031354850eee277a773832890c3c17.1750947651.git.namcao@linutronix.de>
 <45f44f0298259abf1862b965805307b7c01a279d.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f44f0298259abf1862b965805307b7c01a279d.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_014950_118782_4101FD2E 
X-CRM114-Status: GOOD (  11.50  )
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

On Fri, Jun 27, 2025 at 10:24:38AM +0200, Johannes Berg wrote:
> On Thu, 2025-06-26 at 16:47 +0200, Nam Cao wrote:
> > Move away from the legacy MSI domain setup, switch to use
> > msi_create_parent_irq_domain().
> 
> I applied this on 6.16-rc1 (plus a handful of local patches), and got a
> lockdep warning and kernel crash with this change:

Thanks for testing! The later kernel crash should be fixed with:

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index e51a9357934da..557d93aea00a1 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -407,7 +407,6 @@ static const struct irq_domain_ops um_pci_inner_domain_ops = {
 
 #define UM_PCI_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
 				   MSI_FLAG_USE_DEF_CHIP_OPS		| \
-				   MSI_FLAG_PCI_MSI_MASK_PARENT		| \
 				   MSI_FLAG_NO_AFFINITY)
 #define UM_PCI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK		| \
 				    MSI_FLAG_PCI_MSIX)


I have no immediate idea about the lockdep warn, I don't see how the
MSI_FLAG_PCI_MSI_MASK_PARENT flag can be related to that. Probably there's
another problem, let me stare at it..

Nam

