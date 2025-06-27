Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A7EC7EE3A
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J4ZjnT6oCMq1CKTCNR3HCJ0iSz8drwLRwfHKoiq9yKA=; b=KuChXjzHcHFAVxUiydpFdP665L
	uB68p+vhvCOEI/YVQugo3OsVElP3cVe0XulGhFJBBJIwIPWTxzn0JEwJo45sPn4e/nC8IC7stssv7
	ABdG76OMhUTd4Y5W2+FRJbIwF+749S6CLeZVpLNcMFkxNu8ORBYzufdC+KEVWXcI8UiuriaaNEf95
	QcEyP1EDYNri1X8yAyPpb1fgfmoEjUbze9+6o8BYH/wXabPg3uDLgLrtfLn8oxqcTQjG57J2zfMQ4
	qT/lsJM/mbVFQSvxqrIL4YImKx+Ia/CO/HLGEAv7rpCsCYo6woW8rfJW+Y/TKyfxBMPjdZjIs9O3Q
	hiMtzPuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5KX-0000000E6vR-1Hew;
	Fri, 27 Jun 2025 09:25:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5JW-0000000E6ge-2W8a
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 09:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J4ZjnT6oCMq1CKTCNR3HCJ0iSz8drwLRwfHKoiq9yKA=;
	t=1751016246; x=1752225846; b=si3h4scR1OqQQXebBb0eGK7xh/MJHDziDyPRjVHT50ovZRX
	UUSHdYoyh+FIOAqcuv2x+ym3QohstuTj9skiouc91x73Mve9jxJHcLsYUQEJZcyDq1ETQxHRrfVZN
	xLn+wESNJfUqbhyD0BDaiATvU6pQt+J4i/IqAXcLBDLde1GVyhX1H8L4JuCYOmnK3Bf3+8YyqKJWI
	Lkz1bEJelP5YIcnh9DJnKq3lga42VkVQFh5n4xLOea2OF3DWz7BnLICYTugD4FjXvHeyRFTMq32RU
	iTb12JHO/gpZhgc0sFVHJ9CJXybybFUk0G1TUReu/uJK52bchtFwwEJk0kaxOS8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uV5JP-0000000DS2I-3RBo;
	Fri, 27 Jun 2025 11:24:00 +0200
Message-ID: <94de787f4c3ad6fc3a44c50c2a5d5311861ddd6c.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] um: virt-pci: Switch to
 msi_create_parent_irq_domain()
From: Johannes Berg <johannes@sipsolutions.net>
To: Nam Cao <namcao@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 27 Jun 2025 11:23:58 +0200
In-Reply-To: <20250627084943.nCYOI4Vp@linutronix.de>
References: <cover.1750947651.git.namcao@linutronix.de>
	 <b911c2f15c031354850eee277a773832890c3c17.1750947651.git.namcao@linutronix.de>
	 <45f44f0298259abf1862b965805307b7c01a279d.camel@sipsolutions.net>
	 <20250627084943.nCYOI4Vp@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_022406_636457_3AC9352E 
X-CRM114-Status: GOOD (  12.80  )
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

On Fri, 2025-06-27 at 10:49 +0200, Nam Cao wrote:
>=20
> Thanks for testing! The later kernel crash should be fixed with:
>=20
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index e51a9357934da..557d93aea00a1 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -407,7 +407,6 @@ static const struct irq_domain_ops um_pci_inner_domai=
n_ops =3D {
> =20
>  #define UM_PCI_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
>  				   MSI_FLAG_USE_DEF_CHIP_OPS		| \
> -				   MSI_FLAG_PCI_MSI_MASK_PARENT		| \
>  				   MSI_FLAG_NO_AFFINITY)

Can confirm that.

> I have no immediate idea about the lockdep warn, I don't see how the
> MSI_FLAG_PCI_MSI_MASK_PARENT flag can be related to that. Probably there'=
s
> another problem, let me stare at it..

Seems to go away as well, perhaps it's due to taking some wrong path
with the flag just prior to the crash?

IOW, works for me with the above change with no crash and no lockdep
warning either.

johannes

