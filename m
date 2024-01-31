Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADA5C47258
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:
	References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pn1KtJY8WhzqcFKIdxLySdjgjMooSxDwqu66EyjdgdU=; b=abR/oRtYlnlIn6CCAiZZDTggGV
	uQe2fX5SjiCfJ7wHZBUwgDz7kkzBzkGkNThVkjpTzQdmvRtJNjFV3wPMLdymVCt5o1kzcgJXFlzff
	ooC05NFWMum7eUjc7V63xe2YVC37U4sao08JIxJPkvTQxyNN1T73MCxOElityJv3L2bPdlLv/W3AB
	qOkKAYDbTU31ffe/HCWmQ0TrWcL2ET/B9rJd4EAcy6+AIZVjhdHtY4lK8hGgeVhKK2c3RnvMpjhtA
	VrxplE33zASe/DXyQmGAEhV0Sre/6PltgYZcEYW0OFnAm6YTgUOSasqIaAtr+zOaLFbHqZfpo+0nt
	S5hZF+Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJYp-00000005lYz-0D41;
	Wed, 31 Jan 2024 23:00:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJYk-00000005lVm-34z8;
	Wed, 31 Jan 2024 23:00:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E26DCE23DE;
	Wed, 31 Jan 2024 22:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BF5C433C7;
	Wed, 31 Jan 2024 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706741995;
	bh=zdzGQukzuFM99odXc1XHFwDNHwjEYQ2tT1RmuJLmutg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=M+jPDyWjW3p2BFL4c7Lq/tJLbKE0eoQKC70P1AS5REFlY4kdxkNB5cTBbAFNDw1hI
	 2jP/AbKdvUAxefuvOQh22+j7DgdGVzQ3I5QRhy0N9Upe1mX/GsYF0W6i+Dm2K8IfgK
	 aaCTibLiwPJs/QYgWz4pNrt86vq2TzlHrW3LD7GcPXNqA4xfdMx+OxZJ6gsGzi6zOq
	 cmGZ0fU6BVOtgwkZbi25gi+5Oow8v+mf8eSt9A4C6pMEL/aZOrLzK4IrofeZrybwYI
	 wWu727yJvBE5SN5Rr+8ryTsDlTV0UA0rTEGgaRgBFH3pcLi4e0ZYUxqKCbcyxmDqcE
	 ceTxausFkQgQg==
Message-ID: <efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240131205405.GA2249327-robh@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org> <20240130004508.1700335-2-sboyd@kernel.org> <20240131205405.GA2249327-robh@kernel.org>
Subject: Re: [PATCH v2 1/7] arm64: Unconditionally call unflatten_device_tree()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robh@kernel.org>
Date: Wed, 31 Jan 2024 14:59:53 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_145959_199521_42C7210E 
X-CRM114-Status: GOOD (  26.99  )
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

Quoting Rob Herring (2024-01-31 12:54:05)
> On Mon, Jan 29, 2024 at 04:45:00PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > Override 'initial_boot_params' to NULL when ACPI is in use but the
> > bootloader has loaded a DTB so that we don't allow both ACPI and DT to
> > be used during boot. If there isn't a valid initial_boot_params dtb then
> > unflatten_device_tree() returns early so this is fine.
> >=20
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  arch/arm64/kernel/setup.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 417a8a86b2db..ffb1942724ae 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char =
**cmdline_p)
> >       /* Parse the ACPI tables for possible boot-time configuration */
> >       acpi_boot_table_init();
> > =20
> > -     if (acpi_disabled)
> > -             unflatten_device_tree();
> > +     /* Don't use the FDT from boot if ACPI is in use */
> > +     if (!acpi_disabled)
> > +             initial_boot_params =3D NULL;
>=20
> I still think this is a problem for kexec. See=20
> of_kexec_alloc_and_setup_fdt(). You see it uses initial_boot_params. At=20
> first glance it looks like it would just write out everything we need.=20
> But for UEFI boot, I think we need all the chosen properties like=20
> linux,uefi-mmap-start preserved from the current boot for the next=20
> kernel we kexec.

Ok, got it.

>=20
> I think you'll have to check acpi_disabled in unflatten_device_tree()=20
> and unflatten the empty tree leaving initial_boot_params alone. That=20
> means our FDT and unflattened tree will be different DTs, but I think=20
> that's fine.

It's sort of scary given that 'initial_boot_params' is an exported
global. Maybe that should be hidden away and accessed with a function
instead so that this mismatch doesn't break something later on?

