Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C3BCAC5AC
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r122gbb6KUA5XSddGivsEIWOLIrHYjHok4r9kMcR3qk=; b=fHxL+EjO9c2Y+MzXDEiO5R6CAn
	NSqYm+J2iZhCDjbvrRdM63EXH48MZo5434+T58zrPJlKBKQHdt4eZ8JO/8VXcMTtpv3fZPtK6w857
	SF6qlMrM1TUx5QEFOJahObJ12UiDHhlGSuCPz2AK2bKuFPqo+MWs56g2NK0F/RSSkhgDHHvuJqUND
	Wr70I1sOFb7XWXwGCXExFtSWnvHCfCoqRpGEPe+b1PIr7OSP1APdzZWxwwErfrKRSeu5MPQCEe7VH
	TX6WNmiKc4HAXs37FK74RX4n1KVQQbjyKu72+/JFakquLbx8g8F8hZ6P4E4Slv6Yvi1XdOcoJEjIM
	oyXarx0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v15Ae-0000000E7Do-33VM;
	Tue, 23 Sep 2025 15:43:12 +0000
Received: from mail-vs1-f52.google.com ([209.85.217.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v15Ac-0000000E7Cy-1f71
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 15:43:11 +0000
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-557a2ba1e65so5211673137.2
        for <linux-um@lists.infradead.org>; Tue, 23 Sep 2025 08:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642188; x=1759246988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r122gbb6KUA5XSddGivsEIWOLIrHYjHok4r9kMcR3qk=;
        b=scoiMi8N+nv8/1+amrVlCW/uQUwpbgO7JDm9rR4wozs1HmpTjcB0gvAwmGLFD4b9oD
         k+2apjgY4nRgaFXATICwFr/lmGIAsycxTXVvg++QW+6iWC93WZiGSpCKGlS6TIU97CgD
         NWL7PjUq+nV+e1K8LdzH2gjuMtoJjANMHgxzneYnQDeVtl66ZvbYVroMXyNfrLVslOVt
         7JaqUjzccBQFLCwmX2xisc9dzkLAnptoKDgUf2WrGIKO/GwsvgFJAs6gRN2fhnd/FKwz
         S+517Kq5zoKI14ENRBOJQSzgUsl/AFpkA2gWsbDdBV/xvZ2b0QGwydJfR9m8oRq2cn1C
         RY+g==
X-Forwarded-Encrypted: i=1; AJvYcCXEJTCRmMzJe6NwviexLuwQsBE7gP3E2KVT9SAvnp4PcWyZJCd/aALEWwpEwJIcTeJzX5bKFR7IGw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHArfshgSJAbk3gfgv/5cpI57kbwVvDOt2F7mB2fuvC5hvaeNM
	P6WH1iXbqcgkz/0nsNUXY/cExZoGESEEq9VZpMFn07z+AdCQJMZV85jm11nhkR7o
X-Gm-Gg: ASbGnctmGP401qPJIg8g8wJHJgNO66xzUbhw4iGbvf7k9KKlS1C+KVPEy+YzJGN+VCU
	hNeeM3vmpXcHozCNkp9Vc8No7PsIppF4ynqeH654+uocV6J8FQNIi8gn9VqYH+9AuP0laOnLIAT
	GrIdqLm/HKuAaIkjvEbYtdraEGPKUdVfeBghKkryb0FpiJd6c69TbN5FfjxmvL8uLUo/aMDqfgV
	xuzbUC74bq6xwfAnWHHehVuz+Ea2bJhq7nPEfDF5YVsRBCIQUh0FrOJ4LE9XJfKHWCUyhUCT/FL
	IgvKxJG79rU2ZuqWN1AL8kYXdOTyQh3bsBqJ5mkZ0qXe/LVx5smjd2tHHO0qWa82/n2Hk6EzKd8
	4EZVukkmfwpTGsLfj0LJFjz54iJ7MnIM9qXN8/U2SwC8ew3khoHbuSqgCoNaF
X-Google-Smtp-Source: AGHT+IGt6UZLmKTDLci0Z03+zoiZeG3KuXtHbFx2ubIu7hyWv1u3iZWLBewMcb/FiQZwyfeECtSqjw==
X-Received: by 2002:a05:6102:2ace:b0:526:db01:5fb2 with SMTP id ada2fe7eead31-5a57c453befmr1193819137.30.1758642187660;
        Tue, 23 Sep 2025 08:43:07 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-592500edcd3sm2955556137.15.2025.09.23.08.43.07
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:43:07 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-55ae619545fso3670457137.0
        for <linux-um@lists.infradead.org>; Tue, 23 Sep 2025 08:43:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo7szjYdEa6JXts4mgZOme7Hdza+Hm8QsE2AUP86k6y7F8AmDd+UMFbo59KaZScB1wrb6YDov9RA==@lists.infradead.org
X-Received: by 2002:a05:6102:32c1:b0:5a3:eb34:6105 with SMTP id
 ada2fe7eead31-5a57b993f3fmr1081977137.26.1758642186984; Tue, 23 Sep 2025
 08:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1758181109.git.thehajime@gmail.com> <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
 <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
 <m28qib8g1r.wl-thehajime@gmail.com> <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
 <m27bxu949d.wl-thehajime@gmail.com>
In-Reply-To: <m27bxu949d.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Sep 2025 17:42:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
X-Gm-Features: AS18NWDvUQG0XS9HQf9KIlOsuvRaqQEDSSkgXS1FNduECZbOVkvTaW7-DLJb-WQ
Message-ID: <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, 
	ricarkol@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_084310_443180_D584801D 
X-CRM114-Status: GOOD (  34.46  )
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

Hi Tazaki-san,

CC arnd

On Fri, 19 Sept 2025 at 11:32, Hajime Tazaki <thehajime@gmail.com> wrote:
> On Fri, 19 Sep 2025 16:24:07 +0900,
> Johannes Berg wrote:
> > On Fri, 2025-09-19 at 09:03 +0900, Hajime Tazaki wrote:
> > > > This doesn't make a lot of sense to me. Why would we even want to build
> > > > PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> > > >
> > > > It's not like ARCH=um with PCI and NOMMU has any value even for testing
> > > > if such a configuration cannot exist in reality?
> > >
> > > totally understand your point.
> > >
> > > now I see that we don't have to have this work around by using
> > > --kconfig_add option to kunit.py.
> > >
> > > # like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n (in addition to
> > >   --kconfig_add CONFIG_MMU=n).
> >
> > That's not what I mean. I think it should be made impossible to build
> > the broken code.
>
> okay.
> # I think now I lost the point...
>
> currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> so we cannot select it when CONFIG_MMU=n.

That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
dependency, perhaps it should be reverted, iff you are willing to take
care of the casual breakage?

>
> but it's different with kunit when using them via kunit.py config,
>
> it first adds
>
>  CONFIG_VIRTIO_UML=y
>  CONFIG_UML_PCI_OVER_VIRTIO=y
>
> via tools/testing/kunit/configs/arch_uml.config, and then add
>
>  CONIFG_MMU=n
>
> via --kconfig_add CONFIG_MMU=n.
>
> and then execute make ARCH=um olddefconfig, which in turn enables
> CONFIG_UML_PCI_OVER_VIRTIO.
>
> if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n" to kunit.py,
> it will overwrite the arch_uml.config.
>
> # I don't know how kunit handles those appended CONFIG entries, though..
>
> my goal is simple; to test !MMU code via kunit.
> my original patch or the additional kconfig argument (--kconfig_add)
> satisfies this goal.
>
> > The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> > various PCI code, but nothing depends on PCI in the first place. Which
> > it should, then?
>
> I don't understand the 'nothing depends on PCI...' part.  care to
> elaborate ?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

