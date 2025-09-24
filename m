Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A3ECAC5A5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xG/1vYGs3+fuqywYG6UuJwna6J76UW6FbhxCIwoVdYk=; b=ZmcNNzoKlbdVMyaqPC1/S1mpqw
	R8DMX7g9/QvWaM77jdG9O4KfK2Qd43kIf0wjBCy/3Oc8s95z98ff925nMytHna4vLcfItvVV6jtjY
	Kn+8kGpk9pMsj5z+THLpteCHOSW99bf8zLaFeTxNoyFMo/Ch8QFkDSMV+lAuRS/p+kz52JoYVgr2v
	aL0zHkv68F62of18el8hK2t7evp1NtmKAs38uT5SmHPU81msXWfqgmyBEH5zACVLIXU/oX2Mu79nu
	Uq7w7tw/hUeF4C1OiDhWc4o+sm2T6lAWvy0ESbN4Sb1uY2ryGKnJjpKOmgUzE6UufOx8aodaS5b2y
	/URJSuaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KT1-0000000FoYx-2u6A;
	Wed, 24 Sep 2025 08:03:11 +0000
Received: from mail-vs1-f51.google.com ([209.85.217.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KSz-0000000FoYG-0LlT
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 08:03:10 +0000
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-59d576379b9so1507962137.1
        for <linux-um@lists.infradead.org>; Wed, 24 Sep 2025 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700987; x=1759305787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG/1vYGs3+fuqywYG6UuJwna6J76UW6FbhxCIwoVdYk=;
        b=rMs2Eh79m/HnGVRBEtPzsHbC5wrP3j+d6L3eyIsShjwtDnyooOYx70YrhhSBK/A9CQ
         203PG7CKSykIvtJhd/WC0bV6G5Wt8YEXvkscN+GvYZgeV1aMn5UWUO0IXWhhSDM34k5/
         HOmgcILQZU1jXXaviNrGKD/b8fhs0UUIY1xkQrRp0lziMAb8ZCY19Id7Tz/h2w8vhdYy
         V15i6bMon+jaiSRPr3V8xxzdbM67etBBvcm4QBsWMWt2a7F9qUKBB20q/Cu1hkFd/SGv
         9Vo2GecGXWUQqMjzb+6lMilBtRReejin6bgujfp7R6rSRFNhLfJEOxd8+uY+08c1vEoQ
         TPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTUlImkLvzHiHKdk5nZZMFZ1lyqBzsSrieIpWHnV9wkDKPEp0tbvH8v4ABZ/XpHKuDGh0ME1DkwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwIhqU+83wFpc0QCFQrH5u+groxj+YNmkB/LZefmFNQcYJoNG0S
	EKqEWh1dA8+ssxtAuMfpOSdNGXUmmdQlCgela48eEgD4rSKiDFkLH/zye8vHQgAR
X-Gm-Gg: ASbGnctIFHtQ9Mw3jXsN42suQuWCH0SzOtxhtnbjgiOvxQZoKsDBye4Nex7PR6txM21
	vTXkaxAbB6Dnm2mAgXyBziaA8SyVekyGBl2J1m3r6ORc2eFu9+Uy0ukjOYgYa07OiD1RBYUKrLz
	QeBD51dH3xVc5F7UljvZOuNP97Occm61vv3foTTArpHfTKXgFjqpQrtiKk7vDfRq2yFpHrlsXSi
	sTa9edrqFPLFn/EsYNSJIqVAXT+kWMraH5cpHCTnXMCbbc7DdAE+BQ8QoottbKuaOkF05WRNY1F
	QDOjCCu1u+SH1rVEP4CL/TnoVi3qBa1nZG4AmV/wjwhyimNDMv4wqzNh9xg7uzNpebRNdc2b/Q0
	9IhYZLeSx8vEjt7JD0Bous4muvkObgSfKhebbu19cUoXp589rr18oPB1MS9Wu
X-Google-Smtp-Source: AGHT+IEZHY5sQZ4iAuQM0X1y9Vh6PCYKkxy+NmDjuIGBzq/3wCapKslCiYgvHDYJhfMBYvyuJnpqIQ==
X-Received: by 2002:a05:6102:6a83:b0:523:863d:ece1 with SMTP id ada2fe7eead31-5a5787a5a60mr2256449137.17.1758700987046;
        Wed, 24 Sep 2025 01:03:07 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8f25b3cf97dsm1931430241.18.2025.09.24.01.03.06
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 01:03:06 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8e2702252b0so2883335241.3
        for <linux-um@lists.infradead.org>; Wed, 24 Sep 2025 01:03:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyBQBqtPio8Y6r1QKjNMsamWyv6pk9qOzz735gYxkPxAewG6N+AwBkBBFg//eRqxbq8STiYlSi3w==@lists.infradead.org
X-Received: by 2002:a05:6102:6890:b0:52a:ef9a:cbef with SMTP id
 ada2fe7eead31-5a57a2e5015mr1830757137.35.1758700986150; Wed, 24 Sep 2025
 01:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1758181109.git.thehajime@gmail.com> <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
 <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
 <m28qib8g1r.wl-thehajime@gmail.com> <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
 <m27bxu949d.wl-thehajime@gmail.com> <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
 <23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net> <m2zfak7mnd.wl-thehajime@gmail.com>
In-Reply-To: <m2zfak7mnd.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 10:02:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-417mPdhx8VzD5HK+OBzR6wOwgve7TQVaDB=B1ACQhQ@mail.gmail.com>
X-Gm-Features: AS18NWDjzUUYN1IH_NRSUgt7ztz7YMlPE3cxQjph-t1F9aMXgPt3FYPP6cpRC98
Message-ID: <CAMuHMdW-417mPdhx8VzD5HK+OBzR6wOwgve7TQVaDB=B1ACQhQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, 
	ricarkol@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, 
	arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_010309_132389_A4449D8F 
X-CRM114-Status: GOOD (  28.48  )
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

Hi Hajime,

On Wed, 24 Sept 2025 at 01:51, Hajime Tazaki <thehajime@gmail.com> wrote:
> On Wed, 24 Sep 2025 02:13:47 +0900,
> Johannes Berg wrote:
> > On Tue, 2025-09-23 at 17:42 +0200, Geert Uytterhoeven wrote:
> > > > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> > > > so we cannot select it when CONFIG_MMU=n.
> > >
> > > That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
> > > Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
> > > dependency, perhaps it should be reverted, iff you are willing to take
> > > care of the casual breakage?
> >
> > Why though? UML with PCI can't really be a functional thing, only a
> > testing thing, and testing PCI on !MMU when that is actually impossible
> > in non-simulation is pointless?
>
> currently nommu UML doesn't come with using PCI except building under
> kunit (ARCH=um), but I have in my mind to use it under !MMU
> environment, so would be an option in the future.
>
> and this series doesn't include PCI w/ !MMU.
>
> so, I would propose the modification to revert the MMU dependency when
> time has come.
>
> btw, what do you mean by "hard" dependency in this context, Geert ?

I mean the PCI core does not really require an MMU, and PCI in-se
should work without it (e.g. on Coldfire MCF54xx).  Arnd added the
dependency to avoid having to deal with future build regressions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

