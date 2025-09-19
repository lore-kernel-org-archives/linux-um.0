Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E4BCAC59A
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 23:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XM6G+Tnflz7sZdGSI4xVWIr0TRe/kf+B7MZhs/o8MZU=; b=L0PWDAHI9H3XpO2IuKWyraESCd
	9IWcQQKy21Hjf8RAYkojnCcpEsXaNXej996CYvOhSy/mmnudqMZHNV/FdBepNoL+anUSt/LKRWWCT
	NYo86HLGWVKTr3eOtF7jliUVnLrSe/Wg4qJf8GGu1omUqByocImbt6BJVAXQqusaC/Qgg4s7wcFrE
	uNFPpNmWzDTWlPHsqCv23O+HYO+wE6AfOZDehTTlHK1ufCbiCifRfcvDTiESAnI8d0H7RpiGy4wJ+
	eTdUugXosDse540hz15ga+em9dyR7A08/e4pCcAOxCn9lQAcbYapaTHQewyHDbZbfCzz8yesUsb/F
	U5j0CK/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzko1-00000004LMI-2xlB;
	Fri, 19 Sep 2025 23:46:21 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzknz-00000004LLp-3O6n
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 23:46:21 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7761bca481dso2243245b3a.1
        for <linux-um@lists.infradead.org>; Fri, 19 Sep 2025 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758325579; x=1758930379; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XM6G+Tnflz7sZdGSI4xVWIr0TRe/kf+B7MZhs/o8MZU=;
        b=QKNel5TC3g5nlhoUnEkB+/OuTnEOXm16lGkKxdRZKSjD4CypDlqCx+hwUERbUixIGa
         95m4H0M9dnEYgBZqzdS247iFPaf1OoJAkC4f7ygMco9enZ8ZI0yWpskK6kLsUPjfhP1j
         srTOyn874RWQSrq9UOyy3MEUci0A3XrgyWAa3NJJQniFLOGCGPLj+hm7D9lB4wBG6Wjr
         +wGi1gj9+IPBeJ1drtTxVHSeezS715s5WfvRnt7j3cdAyjDxEv7yoxRQog6vt07NxhhL
         lccjhCd+I7xXtRbQ90ptgiqN2cjxck9dUhjeqMb2mR+zo84Io9u0F/15Ieer5/1kSMHd
         kKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758325579; x=1758930379;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM6G+Tnflz7sZdGSI4xVWIr0TRe/kf+B7MZhs/o8MZU=;
        b=u/ogiQx23znb52aWxephTS3hknhEz0HGzX+onzzH75Ooc0NLTZGLBni6UYL1Jsbhip
         T0PboEQyGw3ifQXq8EUhTEm/4YbERgz5NNKNefoBqkogr887VZL47MBn46A4YA0fQj4z
         DpAUNBss+OxNdpEIAI1t9qlRfnWwRPWhuc+EHbOH7P2gNsTyBU42B4JR4qOcFRDLni0K
         /UKoCoUvGNPHox1Y5vev1dKZl+Iy4w/0PqSgA1mmD74lFSgMI44+YgsY0OswBXqUgG8w
         sfpechqarklGInxRurJVGabh9DGgxuIE1a/asKyDJciRuzLznDR4TnPRocLBdwoTkojG
         NIhg==
X-Gm-Message-State: AOJu0Yx6v322IX0QdyGW1lpMG+01RKnuIil6BbSXFJEaSlOLXBaF3WN8
	fpL55vFvzrz8P3quNaiH6/7Pq/GkRB38gQxAnOhZQzcCoo5VmfWyoyGp
X-Gm-Gg: ASbGnctyae1++IbVBlSZWGPq68WJbCr1YhUIej8kI9nnM9gFFYBC2ANZ+6ykQhkedBt
	Q483JkQxh7kZgTyJ/tEoBlXU+u7H4NE0qFb1FJtAyqfHn0zyuhYWejKkpkbVSVMpDF2k2TEvsfS
	4ETSqgMugT5uH7LSgw5sbaZ/gfBr0IJsvATS85227eHk/0fS2TngbFT9sMorrJVK/iCf0vcZHgt
	82e8KMrbq7tf3G1dzXH/qoJTbsONOktCocZoXTiI+8iuRi/mY2b0qENO1qjZzUMHrMr6odl8Z+3
	gRUeWPrYqplBYm/Wcg/03l5SIWjYWcwtaica26ulSkXhY0nfT5vk0Ga90ewr7yVfEDQX4DHfwOx
	YXAVRYs8QQJ6UKn/baTRTVKu/au08Qe9xNYgm7CURYN6KHu0MHQZdachDwxwxbuH9FKmdSHW4U9
	13JSfMNIBL
X-Google-Smtp-Source: AGHT+IHTGzVIJIJcoTXCreng0sRNp1AId04yLbL+ZcNgHnLi02tUhTStytUkT5LQWEaFUur4vICTog==
X-Received: by 2002:a05:6a00:3e1f:b0:772:101f:5e46 with SMTP id d2e1a72fcca58-77e4d223acbmr6416198b3a.12.1758325578758;
        Fri, 19 Sep 2025 16:46:18 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0ef2db80sm1846205b3a.24.2025.09.19.16.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:46:17 -0700 (PDT)
Date: Sat, 20 Sep 2025 08:46:14 +0900
Message-ID: <m25xde80qh.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_164619_853579_229F1209 
X-CRM114-Status: GOOD (  38.95  )
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


thanks Johannes, I think I got a clearer view than before.

I guess Kconfig does the right thing.
And Kunit does the right too but an additional job which Kunit does
prevents run tests w/ !MMU.

> >  CONIFG_MMU=n
> > 
> > via --kconfig_add CONFIG_MMU=n.
> 
> Sure. But that should disable CONFIG_UML_PCI_OVER_VIRTIO, and it doesn't
> now.

Kconfig (via kunit.py config) disables CONFIG_UML_PCI_OVER_VIRTIO
correctly.

But after that, Kunit does the additional job, validate_config() (in
kunit_kernel.py), which checks the configs (arch_uml.config +
--kconfig_add) is a subset of the final result of .config.

When I applied a patch below:

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 6a0354ca032f..04025207a077 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -159,6 +159,7 @@ config UML_RTC
 
 config UML_PCI
        bool
+       depends on MMU
        select FORCE_PCI
        select IRQ_MSI_LIB
        select UML_IOMEM_EMULATION
@@ -170,6 +171,7 @@ config UML_PCI_OVER_VIRTIO
        bool "Enable PCI over VIRTIO device simulation"
        # in theory, just VIRTIO is enough, but that causes recursion
        depends on VIRTIO_UML
+       depends on MMU
        select UML_PCI

and do
  ./tools/testing/kunit/kunit.py config  --kconfig_add CONFIG_MMU=n

the validation currently gives the following error:

 ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
 This is probably due to unsatisfied dependencies.
 Missing: CONFIG_UML_PCI_OVER_VIRTIO=y
 Note: many Kconfig options aren't available on UML. You can try
 running on a different architecture with something like
 "--arch=x86_64".

so, if I give an additional --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n
to the command line, the validation passes, because the configs
(arch_uml.config + --kconfig_add) becomes the subset of the final
result.

what I can handle this would be either of them:

1) use --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n when using kunit w/
  !MMU, and drop this patch from the series (no modification to the tree)
2) prepare a different file for !MMU & ARCH=um testing (e.g.,
  arch_uml_nommu.config), and add an option to kunit.py to switch MMU
  or !MMU
3) implement virtio-pci for !MMU and propose to remove the restriction
  of CONFIG_PCI depends on CONFIG_MMU.

2) will be removed when 3) is done so, I'm hesitating to propose a
patch used by whole tree.

so, I think 1) is (not the best but) a reasonable solution, with a
note in nommu-uml specific document (i.e., [PATCH 12/13]).

Let me know what you think.

-- Hajime

On Fri, 19 Sep 2025 18:38:03 +0900,
Johannes Berg wrote:
> 
> On Fri, 2025-09-19 at 18:32 +0900, Hajime Tazaki wrote:
> > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> 
> Right.
> 
> > so we cannot select it when CONFIG_MMU=n.
> 
> Actually, I believe that's not true, I think it *can* select something
> even if you override the 'depends on' it has, it just causes a warning
> in Kconfig.
> 
> But I don't think PCI is even selected, UML_PCI is selected, and then
> that selects PCI_MSI which should really only be reachable when PCI is
> enabled, so this perhaps does nothing? Not sure ...
> 
> > but it's different with kunit when using them via kunit.py config,
> 
> It really isn't, you just don't see everything because kunit.py hides
> the build from you.
> 
> > it first adds
> > 
> >  CONFIG_VIRTIO_UML=y
> >  CONFIG_UML_PCI_OVER_VIRTIO=y
> > 
> > via tools/testing/kunit/configs/arch_uml.config, and then add
> > 
> >  CONIFG_MMU=n
> > 
> > via --kconfig_add CONFIG_MMU=n.
> 
> Sure. But that should disable CONFIG_UML_PCI_OVER_VIRTIO, and it doesn't
> now.
> 
> > and then execute make ARCH=um olddefconfig, which in turn enables
> > CONFIG_UML_PCI_OVER_VIRTIO.
> 
> Keeps it, let's say.
> 
> > if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n" to kunit.py,
> > it will overwrite the arch_uml.config.
> 
> Yeah but that being required doesn't make sense - the Kconfig should
> express the correct dependencies.
> 
> > # I don't know how kunit handles those appended CONFIG entries, though..
> 
> It just puts them into the file and runs oldconfig, I guess?
> 
> > my goal is simple; to test !MMU code via kunit.
> 
> Sure.
> 
> > my original patch or the additional kconfig argument (--kconfig_add)
> > satisfies this goal.
> 
> Sure. But both are the wrong solution, as I said, the Kconfig should
> express the correct dependencies.
> 
> > > The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> > > various PCI code, but nothing depends on PCI in the first place. Which
> > > it should, then?
> > 
> > I don't understand the 'nothing depends on PCI...' part.  care to
> > elaborate ?
> 
> See above, I think?
> 
> My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
> don't know if that then doesn't end up in some kind of circular
> dependency.
> 
> johannes

