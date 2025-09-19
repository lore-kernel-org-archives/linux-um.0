Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C698CAC592
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CV5IehE1Tn53nX+JiK34yeLAu07RSWt3CuophQO1BE=; b=3axBiRR0zKDHvLlJ63zmUE/b87
	divZDGZ5kec4sXH7U9B9weB3y1n3SBwli94zZs4UkAVQptci6wwHuILzJdhYC3ILXYOEIeYSQb5X+
	jZLmXQm9jTLahruyHc+ZJLYjf87yeAJFtsBHiqUd6dqUDjv3dvGVIXbst6S57Gc7EO3XFPV1Y9TO0
	LNhLPcgRQCfdbzopP9hb0avBbs3nyLzoUD/3Qp5LNqheD7p93uCEH/4goKIx/InO55OQfYlXiO4Qt
	m8pguMBtlCU1kBQxn+5JB8lDiItgaVUWYaIPTpq1BQ0orsTsv9cAi5hHqHXsW/hB18w79X+rJ9rcr
	qqItGrDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXTp-00000002NyW-3rM8;
	Fri, 19 Sep 2025 09:32:37 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXTn-00000002Ny4-22B0
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 09:32:36 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-77ee6e252e5so283058b3a.2
        for <linux-um@lists.infradead.org>; Fri, 19 Sep 2025 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758274354; x=1758879154; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+CV5IehE1Tn53nX+JiK34yeLAu07RSWt3CuophQO1BE=;
        b=LBlEfS76TK+qUlg944n2Vic2xzsPDQFkv1MGWj5nCoqH5NlV2pkt+C/GW52A2D4ZjN
         RVcQl/LfcFy/Wvs2/I1jsjuL49ptqSf97zVa9LKlkmCdwg7kmQ7lQhunINP0eZG0R0E4
         eHUaekhSBrS+bI8NDMfMbMIkdczF97pHd6ed2e8LsIRgL9LJMdhKU3bGmLgnz7p+E8GS
         FrYINaCko6dQmi5gQUUufPV7EeJIDMebBLs9PD6WxEakSCTbDAOXdtM0W2vpKxyQ9640
         LBTfP7ckiz7qTXuVxqbH4zSHldq3WvHTjbLKB2xevSybMR6gDgUV53GaDumA9t/XQENV
         /wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758274354; x=1758879154;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CV5IehE1Tn53nX+JiK34yeLAu07RSWt3CuophQO1BE=;
        b=UpW63guzfJCVlisTSc2sB8m8NxiJXwnZZnUmgBJJ1NDKAfEpFPTJi0n3PyiOfR5iJq
         pZh0mZ8wMDU6hZmvAH6GDWPFsgZ4EFi9yDB4brW1IqoEgw4aUrq4GPC1lBt7SLHPcABQ
         rzSSYYa1X04RbARkjkmwdsmTIqSIEiWtFlEIA0NjfBtVPZXIlq1OQ8e0DNolodfewXZ7
         RyfY6c7A5mC7LmHP7grYWUP5+TShRgy/3JgZ5i36mHsQif8m0v6HX8h0qTkJMSdyItGe
         8rTSaD47YGSvISkkD+kfIsvsPqxdSXL09VcwDCMIo5cS/UWoayZw38qFPjOQ6MxIQ0mZ
         Nh+Q==
X-Gm-Message-State: AOJu0YzBGSSD2UpAhMfQtOe5rbEXjGMOWhTR+IjVGB3+rqf7FDIAyLAP
	TZ7R/b28wuhJLK18qXHMfdYjOHGESKXYorQ7qGZOsDj4oLltaJpfm5yg
X-Gm-Gg: ASbGncujLodB/I1Nz0qddhdXl7ICFOFaMgwMk8SiVY9TTiMZqU8GKr4z9TnGtLCPuhH
	qT/9mA/Z40uFqFJD/7goPTBKwffjqyaXRsiK8nSEquysB2x8p9BjMHyhETkvB1DF94EiID7iGJJ
	KCx/geYijqyCtYOp3rbh7QOJggAMqxhjNERW6tOgH2W9NHJ942CRn1e+2jtQuxgPyGAbnXcCqzA
	GbnXf5A2BibwEYKJKGs288RZsWIsPo+NFHU0fYaMiY/SEvigEY5wyyk9U9CAMINngCJ0OwzFIGu
	KuBkDLmE0BJHzqe9CBtAXb743msLE2GcllHAzOJWTz92JJB3GlQevr11OjugD4SpMsDuTXA7MLT
	FQvONF+un4mJqTDdXg6NPQ2OyuiYaiXv0tl6gPxEPaODPd11qv3oMKlPphTWSnenC16o0fkO4dX
	GuzdeK/6TR
X-Google-Smtp-Source: AGHT+IGAtV3xKWu/RSfZaRRvZO9qgcxXvW6souPS+g60+Hps7w3owsEq6q+LE1rVNe0azOw7xoT+Vw==
X-Received: by 2002:a05:6a20:7284:b0:248:1d25:28b3 with SMTP id adf61e73a8af0-2925f5746d0mr3945266637.17.1758274354122;
        Fri, 19 Sep 2025 02:32:34 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55268e73f6sm530156a12.21.2025.09.19.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:32:33 -0700 (PDT)
Date: Fri, 19 Sep 2025 18:32:30 +0900
Message-ID: <m27bxu949d.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_023235_524216_2D62495C 
X-CRM114-Status: GOOD (  21.86  )
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


On Fri, 19 Sep 2025 16:24:07 +0900,
Johannes Berg wrote:
> 
> On Fri, 2025-09-19 at 09:03 +0900, Hajime Tazaki wrote:
> > > This doesn't make a lot of sense to me. Why would we even want to build
> > > PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> > > 
> > > It's not like ARCH=um with PCI and NOMMU has any value even for testing
> > > if such a configuration cannot exist in reality?
> > 
> > totally understand your point.
> > 
> > now I see that we don't have to have this work around by using
> > --kconfig_add option to kunit.py.
> > 
> > # like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n (in addition to
> >   --kconfig_add CONFIG_MMU=n).
> 
> That's not what I mean. I think it should be made impossible to build
> the broken code.

okay.
# I think now I lost the point...

currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
so we cannot select it when CONFIG_MMU=n.

but it's different with kunit when using them via kunit.py config,

it first adds

 CONFIG_VIRTIO_UML=y
 CONFIG_UML_PCI_OVER_VIRTIO=y

via tools/testing/kunit/configs/arch_uml.config, and then add

 CONIFG_MMU=n

via --kconfig_add CONFIG_MMU=n.

and then execute make ARCH=um olddefconfig, which in turn enables
CONFIG_UML_PCI_OVER_VIRTIO.

if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n" to kunit.py,
it will overwrite the arch_uml.config.

# I don't know how kunit handles those appended CONFIG entries, though..

my goal is simple; to test !MMU code via kunit.
my original patch or the additional kconfig argument (--kconfig_add)
satisfies this goal.

> The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> various PCI code, but nothing depends on PCI in the first place. Which
> it should, then?

I don't understand the 'nothing depends on PCI...' part.  care to
elaborate ?

thanks,

-- Hajime

