Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F00EC83000
	for <linux-um@archiver.kernel.org>; Mon, 30 Jun 2025 06:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9k4TDCp1s1sw9Eu4SIhTH14EyDKmYapBGy/5BhYSTlk=; b=dR1LYU049wGzvQNGWbAdgT7OMy
	Ss4j7AxL0jY/WxlN/v3Fdquyfc8W9Y1XPAdHGeJvMQ4hzsvSChRns6qFiQPyAub8WRphcUxxwkRmq
	T1FIsWH3tsMJj9ZNXds8g6XCVZrc89q0whLt6XuDChDePjb7oqiFUQD3GbsqZE+yWNsHYkqSf4Ouq
	85RJyboMIqQdG2aH423w0Sn1EeJ9XyjBb+23DhdyIbCFdzmJwB5ORPpoUs9UO1haozpESyNlbsyAA
	FcRi3TlUx36T4nznW8klruCp96e0uL3Ce3/KnEuX0WspnU/ohdmz0xYMS546JzcSgc8xCYcgM3QbY
	mtha0org==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8R9-00000001O5Z-1vCe;
	Mon, 30 Jun 2025 06:56:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW8R6-00000001O5D-3CV0
	for linux-um@lists.infradead.org;
	Mon, 30 Jun 2025 06:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9k4TDCp1s1sw9Eu4SIhTH14EyDKmYapBGy/5BhYSTlk=;
	t=1751266574; x=1752476174; b=LCg30eWBaKvcNKLszA297+b7cRlYfTBbq/VbvvfSLPO7pHM
	9TGbfC78J55sjhzxd2kW8ZDnzS1JLIFF57j5qM4eJrDuma4Ak3UJ66n6IZVPezEVRK48F+GY7Its+
	q5X+PjJM2X4B/5LbzQ/lZI7ucOmq43ScPPl7AeEUQJxLuRNzA+PZTEPNHmZ/z2Xu3BH7iq7/BrIWu
	fmToxrxiziI11jgO6bTPc7DuiJ3uz/ge9CUdIiI1DLw6YBpubEW5EU8feSzqZkh8TvMwXZ6gVlotp
	j7+8RhJhs31yiE70Er1bysdfmA6Y212y7H5rix+oOW5UcGeeQ0M/zmsvfy9q9zxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uW8Qm-00000000avX-2lH3;
	Mon, 30 Jun 2025 08:55:58 +0200
Message-ID: <e64a4c40b0234fc265a74cb60633117dc6911518.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
From: Johannes Berg <johannes@sipsolutions.net>
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 30 Jun 2025 08:55:54 +0200
In-Reply-To: <5f0bd8e877e7bfdfb1a7e99d6b126caf6a7eea48.1751266049.git.namcao@linutronix.de> (sfid-20250630_085140_752354_0F18E422)
References: <cover.1751266049.git.namcao@linutronix.de>
	 <5f0bd8e877e7bfdfb1a7e99d6b126caf6a7eea48.1751266049.git.namcao@linutronix.de>
	 (sfid-20250630_085140_752354_0F18E422)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_235616_824025_FFCDAC02 
X-CRM114-Status: UNSURE (   5.83  )
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

On Mon, 2025-06-30 at 08:51 +0200, Nam Cao wrote:
> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
>=20

Do you want this to go through the UML tree, or is it a dependency
somewhere else? In the latter case, I suppose you can add

Acked-by: Johannes Berg <johannes@sipsolutions.net>
Tested-by: Johannes Berg <johannes@sipsolutions.net>

johannes

