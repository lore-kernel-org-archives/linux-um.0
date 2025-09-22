Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7081FCAC5A7
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 06:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCx+9yjjowpPnPkXHgBr6oVC5xhComuV9u3ACqyOGsw=; b=w4irO2wtgFnOtYzuT5NOLqNn98
	zlupuZm4zGB4phJcyR2NgOtyYCMNbvrXu8baZdCW16TaXGwrJnA9mAX9CZoRXpJwG9MnrqHq6UA2t
	Qe8x06t2KHTWFjyVcLuO9R1vcvvs78g6SO/hT6ZbXseI54L512ZNjKnkh4eufR0jdCancm3jg+/8H
	OfhdOyISZ3Zdm0mb0iMrXoQaxcUa0uY5lC+Zl7ZWLzjPsGxibKS7E9rk/FCJWwn0IFd3eT4J7Tslv
	HJ/0CGxqGR5R+yMIvX8EKeVRgjb2virke2XckIP+4lJ7PtLJG1Ct9Xe/fg2xDqgetNe9iuP9f6Xyr
	jvBJsqsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0a6B-00000008zB9-0ZG2;
	Mon, 22 Sep 2025 06:32:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0a68-00000008zAQ-45sn
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 06:32:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cCx+9yjjowpPnPkXHgBr6oVC5xhComuV9u3ACqyOGsw=;
	t=1758522748; x=1759732348; b=dht+P83isLI4gTMLw/wCcruOEHFSuLHyICNHexoiH3zDOEH
	PmLZjLVr2PdC6rjeyz1vcyGVK8593u/23u3NJQ8yKjUyob4xO6WmAf4J4OsNz71qfeFBuB8nPHiwX
	PI7JtEQFDUWrzWoAftBAQbHu+Or6y11a8lV7Oc4kjL75Qopuw4eNO8sqQUgpOaqpqfMj7K6LjmGlz
	frJkIlnwvnKECMOP8wdNoD7W2UD8pf1Hdi6QpoGJVWw6upGVKbVvL7Crp+ILcXihDTJwjgeC2FS7+
	n0oMfgKZK4euGTQVCV1Id7lKb1LTiLIpSxgX5mA4fZoEZdO8GydoV/LjYG0E0jgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0a63-0000000489S-2JdX;
	Mon, 22 Sep 2025 08:32:23 +0200
Message-ID: <39692eca904137ce7d51fccdc948ae0b94b4fe4f.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 08:32:22 +0200
In-Reply-To: <m25xde80qh.wl-thehajime@gmail.com> (sfid-20250920_014621_763283_43F42C24)
References: <cover.1758181109.git.thehajime@gmail.com>
		<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
		<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
		<m28qib8g1r.wl-thehajime@gmail.com>
		<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
		<m27bxu949d.wl-thehajime@gmail.com>
		<da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
	 <m25xde80qh.wl-thehajime@gmail.com> (sfid-20250920_014621_763283_43F42C24)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_233229_044692_4FBCD578 
X-CRM114-Status: GOOD (  21.36  )
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

On Sat, 2025-09-20 at 08:46 +0900, Hajime Tazaki wrote:
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 6a0354ca032f..04025207a077 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -159,6 +159,7 @@ config UML_RTC
> =20
>  config UML_PCI
>         bool
> +       depends on MMU

That won't do anything since you elsewhere have "select UML_PCI"
independent of MMU.

> @@ -170,6 +171,7 @@ config UML_PCI_OVER_VIRTIO
>         bool "Enable PCI over VIRTIO device simulation"
>         # in theory, just VIRTIO is enough, but that causes recursion
>         depends on VIRTIO_UML
> +       depends on MMU
>         select UML_PCI

Right, but you also need that for UML_PCI_OVER_VFIO.

> and do
>   ./tools/testing/kunit/kunit.py config  --kconfig_add CONFIG_MMU=3Dn
>=20
> the validation currently gives the following error:
>=20
>  ERROR:root:Not all Kconfig options selected in kunitconfig were in the g=
enerated .config.
>  This is probably due to unsatisfied dependencies.
>  Missing: CONFIG_UML_PCI_OVER_VIRTIO=3Dy

Well, OK, but that's fair - you did specifically override MMU=3Dn, and
virtio-over-pci needs it.

> 1) use --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dn when using kunit w/
>   !MMU, and drop this patch from the series (no modification to the tree)
> 2) prepare a different file for !MMU & ARCH=3Dum testing (e.g.,
>   arch_uml_nommu.config), and add an option to kunit.py to switch MMU
>   or !MMU
> 3) implement virtio-pci for !MMU and propose to remove the restriction
>   of CONFIG_PCI depends on CONFIG_MMU.
>=20
> 2) will be removed when 3) is done so, I'm hesitating to propose a
> patch used by whole tree.
>=20
> so, I think 1) is (not the best but) a reasonable solution, with a
> note in nommu-uml specific document (i.e., [PATCH 12/13]).

I don't think (3) makes any sense at all, we should just _never_ do
that. !MMU is really here in UML for testing to support other
architectures that are !MMU, and since by today's definitions no other
architecture can have PCI without MMU, it makes no sense for UML to have
that (and complicate the PCI code unnecessarily, etc.)

I think it's entirely reasonable to have overriding CONFIG_MMU=3Dn to also
necessitate overriding CONFIG_UML_PCI_OVER_VIRTIO, i.e. (1).

As to whether or not to add a specific config file, honestly I don't
really know or even care - you'd have to ask the people who actually
want to test !MMU.

johannes

