Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF80AC27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=67iEUNjiy7HOBuGoqBAJEp5jlBOCrSiBVzovVrhf8kQ=; b=iP40mrTBSa0J9O5rAqUV7re8pX
	m5BHd2M1o5lg/BfpUdiKXLHKCvRHpTnWLrH8em57vrtBRSOjQPJZLiPyryPLOqv4bWVCHBJexoT1l
	f/5Z+0jE7IzRVu/exEe6/+pIJa5p84sRHZj51jmIVWaUKWcqd/EvGdZRYelCEyOoIWKVVpWCezQ7u
	thPaAhlQD4i7jRjV47t5Ffaf4pI7gPm+oKyGzs1b4S+Ko0O3M89nmQRE5QjBV0LHcsJgi2P1/dR1X
	G1hi+9+Gu02EFsdq6o2POXHORA7RQoWOFlj/BghCxgcQyLYC7memrU3P9cB99aVIiJOQ/MqChDPHq
	6RCeblOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnG-00000003eBU-1z4B;
	Fri, 14 Jun 2024 17:32:54 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnB-00000003e6x-2o5n
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:52 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 6CE52FF805;
	Fri, 14 Jun 2024 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=67iEUNjiy7HOBuGoqBAJEp5jlBOCrSiBVzovVrhf8kQ=;
	b=YL+iy83jqq9bl02hakJXSOJ8KfKOOy8vAED2NEWLHenMZYkURWV2Ti2k1eK1UpGEgUB56k
	eUwzeRyIWpqAsfRuuYnkGXcMzkqByjT7TGLPBeMqm9tDIKbEDFQW3fffkzZxxUzeCEm45S
	Go4DxkW+5egokQSkV6e29gOj54hKh80CIopS5TDttW5TsaXgGl5mlskYN5HDqM/xapM4kz
	Ziy7Y4EJo4GJVn3VZdFPL5b3Qicvbfe18QZSY/B87DvHQk5kpXUKqkaj+1BxOAipVqb7Fh
	28V2ITL5/G64cE5dY7IDu4JuSnKx6wCwSu/NdS6of2guL6k/bLE1nVEeLcoHiQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 00/23] Introduce irq_domain_instanciate()
Date: Fri, 14 Jun 2024 19:32:01 +0200
Message-ID: <20240614173232.1184015-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103250_023161_206FFDF9 
X-CRM114-Status: GOOD (  15.90  )
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

Hi,

Previously, I sent a series related the support for the LAN966x PCI
device [1] and in particular several patches related irq domain
modifications and the introduction of the Microchip LAN966x OIC driver.

During the review, it was asked to rework the irq domain modification in
order to avoid more wrappers and a new irq_domain_instanciate() function
was proposed [2].

Also a patch [3] sent by Maitti Vaittinen can benefit of this new
irq_domain_instanciate() function. Even if Maitti's use case is not
handle yet in this series, it should not be a big deal add support for
it on top of this current series.

So, this current series introduces this new irq_domain_instanciate()
function and migrate existing wrappers and functions to this new
function (patches 1 to 20).

It then introduces the first driver that uses directly this new function
with the init()/exit() hooks set: the Microchip LAN966x OIC driver
(patches 21 to 23).

Existing irqchip drivers are not converted yet to use this new API
function in the same way as the LAN966x OIC driver does.
I prefer to have this series accepted first to avoid doing and re-doing
several times the same modifications on existing drivers depending on
changes requested on this current series review.

[1] https://lore.kernel.org/lkml/20240527161450.326615-1-herve.codina@bootlin.com/
[2] https://lore.kernel.org/lkml/8734pr5yq1.ffs@tglx/
[3] https://lore.kernel.org/lkml/bbd219c95f4fe88752aee5f21232480fe9b949fb.1717486682.git.mazziesaccount@gmail.com/

Best regards,
Hervé

Herve Codina (23):
  irqdomain: Introduce irq_domain_free()
  irqdomain: Introduce irq_domain_instantiate()
  irqdomain: Fixed unbalanced fwnode get and put
  irqdomain: Constify parameter in is_fwnode_irqchip()
  irqdomain: Use a dedicated function to set the domain name
  irqdomain: Convert __irq_domain_create() to use struct irq_domain_info
  irqdomain: Handle additional domain flags in irq_domain_instantiate()
  irqdomain: Handle domain hierarchy parent in irq_domain_instantiate()
  irqdomain: Use irq_domain_instantiate() for hierarchy domain creation
  irqdomain: Make __irq_domain_create() return an error code
  irqdomain: Handle domain bus token in irq_domain_create()
  irqdomain: Introduce init() and exit() hooks
  genirq/generic_chip: Introduce
    irq_domain_{alloc,remove}_generic_chips()
  genirq/generic_chip: Introduce init() and exit() hooks
  irqdomain: Add support for generic irq chips creation before
    publishing a domain
  irqdomain: Add a resource managed version of irq_domain_instantiate()
  irqdomain: Convert __irq_domain_add() wrappers to
    irq_domain_instantiate()
  irqdomain: Convert domain creation functions to
    irq_domain_instantiate()
  um: virt-pci: Use irq_domain_instantiate()
  irqdomain: Remove __irq_domain_add()
  dt-bindings: interrupt-controller: Add support for Microchip LAN966x
    OIC
  irqchip: Add support for LAN966x OIC
  MAINTAINERS: Add the Microchip LAN966x OIC driver entry

 .../microchip,lan966x-oic.yaml                |  55 ++++
 MAINTAINERS                                   |   6 +
 arch/um/drivers/virt-pci.c                    |  16 +-
 drivers/irqchip/Kconfig                       |  12 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-lan966x-oic.c             | 278 ++++++++++++++++++
 include/linux/irq.h                           |  33 +++
 include/linux/irqdomain.h                     | 116 +++++++-
 kernel/irq/devres.c                           |  41 +++
 kernel/irq/generic-chip.c                     | 111 +++++--
 kernel/irq/irqdomain.c                        | 243 +++++++++------
 11 files changed, 782 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c

-- 
2.45.0


