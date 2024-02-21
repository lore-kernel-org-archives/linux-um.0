Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A608C48BF6
	for <linux-um@archiver.kernel.org>; Wed, 21 Feb 2024 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4eR7fonfyW/igsEmEwEcQgIwxgmp52h31/GWeR15FLM=; b=XLZBwV0gbmetTN4Xm9sPRLKulQ
	YFwRteo/hCkwwlfePJJJpC5ZpHF6A03c3TSkCnUzYQ/xddmtVP7OeeKeUtW6hEn7h6z1U8jNzH1gx
	uZiFBGISmOEgb8Oq3Y+vXzg3TEUPQo65fe1Gu1JDyM5a4TJSBkt/pZRnA8mEYpSNf0jOgoMqGNEwA
	69OPc9cYUhBz3/Q/TuAOzov52h9xvekZvdd+fqr1uR0cZpU0p75hjdmSdzNuCvEn6wXTxK4r9DkfT
	nuWoyxCob7BUVNec+dLY2CYjQlzLRdJaj1EsTAikx7wMtC5dwTMUySnx4ks8FqEgMCaDWrNXvujsc
	Zw4UhO9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcnEx-00000001CF7-0mnq;
	Wed, 21 Feb 2024 14:06:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcnEt-00000001CDN-3mhh;
	Wed, 21 Feb 2024 14:06:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 169646151A;
	Wed, 21 Feb 2024 14:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1BFC433B2;
	Wed, 21 Feb 2024 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708524382;
	bh=SpL2kvMci3BCJiem1BIyIcsSR8wgzqXdO4GroPnsjP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=quTqlShH4LWCaBTZCyQx62hLzRwZVLko6t4suir8Ot2AOcWbSVtaZdamqaM7w58fp
	 DdbftVoCHsUCAtZrueBfz94C0QKag0ucP4UlPGWV03xB+JkTeRxT7Kq9hgc7NcsZXc
	 jdVQs71Al076uLZgmoSahZ0U4RfJj5YkVku8IV4GGdbBtx+pGpMdhZ8eAyp0Z+GWNI
	 ltQ8vrqQsV3IadYmjrgumJm2YIKXXDGjK7zP6SVgH1PoRvtuNWCUadyNVbSvnC7IKo
	 CWUmyo8zmuq8zIcdMAr4cQxUEbW3qmbUZIszTl3aXJCaXPVHDRD5aTkpo7iJrjg6vx
	 SyGzgnFgXWrrA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0bc402c8eso63077561fa.1;
        Wed, 21 Feb 2024 06:06:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmK5i0hjhZyQuy4tpdwLitsOSl/ffVTPh3RoWKZKzeSkhdDb3VETohcTBAGvzLoL4fxEJ5azgLnNgeEiz3ie3p3rfJks0qTq2eaBoiEoA1k3rxWRRPyHTryJSl2ywvBG0A/g31WrRGWj/mOiiouoSxiSI=
X-Gm-Message-State: AOJu0Yw0pnHoRiOxam1bt7aVoxnFUlNpKyF4ERjWRtLXf0mzhgOeGVcG
	Oqxw9QJmRCdIX2BoNtxStZEI8UqIMJ+cYuPVaoh9v+dFjgixH2h0R/uGpRJHwoKtX0MqtMqZc4/
	lT/TYlqJ8EnxbqsbzcOGf2vqsLQ==
X-Google-Smtp-Source: AGHT+IHOSOSP7ipJG1AW58Fmxdj1uchlXs5YgDpmVhr8XeqjnmnNtuMuC8wFe5RgRdG+Eir4Pr5TzJCIR/BeGaQpP5A=
X-Received: by 2002:a05:651c:220b:b0:2d2:42d7:7d88 with SMTP id
 y11-20020a05651c220b00b002d242d77d88mr3092656ljq.22.1708524380920; Wed, 21
 Feb 2024 06:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 21 Feb 2024 07:06:08 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
Message-ID: <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_060624_053904_9F1A6151 
X-CRM114-Status: GOOD (  21.70  )
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

On Fri, Feb 16, 2024 at 11:08=E2=80=AFPM Saurabh Singh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> On Fri, Feb 16, 2024 at 05:05:51PM -0800, Frank Rowand wrote:
> > When enabling CONFIG_OF on a platform where 'of_root' is not populated
> > by firmware, we end up without a root node. In order to apply overlays
> > and create subnodes of the root node, we need one. Create this root nod=
e
> > by unflattening an empty builtin dtb.
> >
> > If firmware provides a flattened device tree (FDT) then the FDT is
> > unflattened via setup_arch(). Otherwise, the call to
> > unflatten(_and_copy)?_device_tree() will create an empty root node.
> >
> > We make of_have_populated_dt() return true only if the DTB was loaded b=
y
> > firmware so that existing callers don't change behavior after this
> > patch. The call in the of platform code is removed because it prevents
> > overlays from creating platform devices when the empty root node is
> > used.
> >
> > [sboyd@kernel.org: Update of_have_populated_dt() to treat this empty dt=
b
> > as not populated. Drop setup_of() initcall]
> >
> > Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> > Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list@g=
mail.com
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---


> > @@ -1645,6 +1635,21 @@ static inline bool of_device_is_system_power_con=
troller(const struct device_node
> >       return of_property_read_bool(np, "system-power-controller");
> >  }
> >
> > +/**
> > + * of_have_populated_dt() - Has DT been populated by bootloader
> > + *
> > + * Return: True if a DTB has been populated by the bootloader and it i=
sn't the
> > + * empty builtin one. False otherwise.
> > + */
> > +static inline bool of_have_populated_dt(void)
> > +{
> > +#ifdef CONFIG_OF
> > +     return of_property_present(of_root, "compatible");
>
> This adds the strict check for compatible which makes compatible
> to be mandatory for root nodes. So far, DeviceTree without compatible
> property in root nodes can work. Do we want to make this documented
> somewhere ?

It already is in the DT spec and schemas.

Rob

