Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2AAC47077
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 01:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:
	References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8s/fnjNoM/VvtwZBv/fyfh8M1BTq6L7YGx9QNARuGxo=; b=eUX9bnAEhxcBidxHbQQ9q5yCsu
	ddHptT1rZR6nqWReOl5Wrl5sly7JfJjKzjntQ5NiDNYmA43UA16x7HyFv+Ql6r4GLyTMYJ3QIQbTY
	t5glQzahe6ZXJfYURKknF23k4cQt9Ib9Iv7pspJ2U/7uLy+C88y9WqkSd248BcP5KDiOlnV3lJG+V
	/YmWWaf6EJLwwBupnaSju67mzQKt4+wCRMLRy/5N4bUPtwMyogazlNQX8142ApefBJ0aipuD0TSgh
	vgIDTdDcLrNzuumYJKTzA4W7BnZM2ZzPICOO7wHHIbBTnJodrrJgoSC/INaDVGeUHOsEP2gsrT5Fc
	sLeduA8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuZc-00E8rt-2v;
	Wed, 17 Jan 2024 01:18:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuZY-00E8py-2X;
	Wed, 17 Jan 2024 01:18:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 314CF614C1;
	Wed, 17 Jan 2024 01:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE289C433C7;
	Wed, 17 Jan 2024 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705454297;
	bh=p9Rh3dyRs/5GUJfFv0bThfhcOx9k3Z/O3iFRLNLB+9Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UufWcQ3zY5TXWZ9yO2rkxrBig+h80cgpqDs9jkj0hrKE5Zmv3LGgrQJYivFsPDX+1
	 JvpxG/EPiS70zVWhzBCsttd6P9KdHSTlHviGAuCzmt3MtSzpNEOrQGx9PKhfj/O7oK
	 2q1xpb5tJBIv6ovLlxzcfOxzIlBdoMnJIxdQOFOrYDtnXoyo1E3VLcMLZP4LLB8FAm
	 MIKw+D75L3kAOtUuOFQ6hNyub/u/JTwhltThkfnalFe08AnrrnBBW0ug6CabnNhs16
	 EXaHb9DeFDkkRgTIqjjlkgPIfDO6zCXuJO28H4TDnWXBpBL/1G+um75K/Op2/cH/12
	 5Ez9RKJe0ODOg==
Message-ID: <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240115203230.GA1439771-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-5-sboyd@kernel.org> <20240115203230.GA1439771-robh@kernel.org>
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
From: Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Date: Tue, 16 Jan 2024 17:18:15 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_171828_931159_562E7F0C 
X-CRM114-Status: GOOD (  25.64  )
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

Quoting Rob Herring (2024-01-15 12:32:30)
> On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index da9826accb1b..9628e48baa15 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -54,9 +54,14 @@ config OF_FLATTREE
> >       select CRC32
> > =20
> >  config OF_EARLY_FLATTREE
> > -     bool
> > +     bool "Functions for accessing Flat Devicetree (FDT) early in boot"
>=20
> I think we could instead just get rid of this kconfig option. Or=20
> always enable with CONFIG_OF (except on Sparc). The only cost of=20
> enabling it is init section functions which get freed anyways.

Getting rid of it is a more massive change. It can be the default and
kept hidden instead? If it can't be selected on Sparc then it should be
hidden there anyway.

>=20
> >       select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
> >       select OF_FLATTREE
> > +     help
> > +       Normally selected by platforms that process an FDT that has been
> > +       passed to the kernel by the bootloader.  If the bootloader does=
 not
> > +       pass an FDT to the kernel and you need an empty devicetree that
> > +       contains only a root node to exist, then say Y here.
> > =20
> >  config OF_PROMTREE
> >       bool
[...]
> > @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const struct =
device_node *n, unsigned long
> >       return test_bit(flag, &n->_flags);
> >  }
> > =20
> > +/**
> > + * of_have_populated_dt() - Has DT been populated by bootloader
> > + *
> > + * Return: True if a DTB has been populated by the bootloader and it i=
sn't the
> > + * empty builtin one. False otherwise.
> > + */
> > +static inline bool of_have_populated_dt(void)
> > +{
> > +     return of_root !=3D NULL && !of_node_check_flag(of_root, OF_EMPTY=
_ROOT);
>=20
> Just a side comment, but I think many/all callers of this function could =

> just be removed.
>=20
> I don't love new flags. Another possible way to handle this would be=20
> checking for "compatible" being present in the root node. I guess this=20
> is fine as-is for now at least.

Ok. I can add a check for a compatible property. That's probably better
anyway. Should there be a compatible property there to signal that this
DT isn't compatible with anything? I worry about DT overlays injecting a
compatible string into the root node, but maybe that is already
prevented.

