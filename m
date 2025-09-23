Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59D5CAC5AC
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 23:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ljeySVlhO9O2RzXIms8aAw71D6omm7wNApUjDETNmPM=; b=wSygoOTt5X/5COFnrPLkkanbCz
	xVqR1NyKiTlsLv/ItE7tUZ/9cfNxPh/uG13raxPT6RUZSaSz3gBm0YKU6PR96Vw/csbwjijRS0O2T
	WmOMo1Y0rDFXbNYu4aGn53A060GUfooIKeb+umEskP8+/Lfw4IsS3nbSRG1QbVeoNBRurgHu6EN/+
	Jk7rHC56lTgQqNwJI9kM6XkZRRzRpc9U/T5ZmFf/Y/CY24IpGrHgmmiVYHlX4EPofkJmPeZ4Vn7pn
	Jk/8cpqqE57tUtIxljUZbnMCXfTyGlU416Ez+4HN5TYiWlWHTEorFxL6/wW7Y1bgvjrdBAS7SBtsX
	zybZ4LBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Cgh-0000000FAVc-3yrm;
	Tue, 23 Sep 2025 23:44:47 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Cgf-0000000FAUt-0hyE
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 23:44:46 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-330469eb750so6874508a91.2
        for <linux-um@lists.infradead.org>; Tue, 23 Sep 2025 16:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758671084; x=1759275884; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljeySVlhO9O2RzXIms8aAw71D6omm7wNApUjDETNmPM=;
        b=P+g1jFxqvuhNiBDhYbFh4biYWVj/+sjsj0gfpbXBtVAuigfYFld/m0pUmdYg0H7aOu
         8K4RluhoGPgBmzRb4M7SJMcmEXzi6XGz2A2iygzkcEpr/49WLoldgfRlQBUXogF5bo4S
         YVQpmkA3gA409x0LwmI5JeCmxUerx6FM2N+S96pZVdLckyAc7qhx7WNbwth6qy/6LBEk
         al7hdzy1tKrSyX5lupxACn2ERJIJfpN3LW7RnJEtScxfRZvbH1h1JrhK8LBsys0QFlN2
         s327fAFSSGHB3naXPhhQY3WqRMp/ijMoA8eKvcPDT6WDCX2rzZIytE42zcay5hqNqDMO
         xgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758671084; x=1759275884;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljeySVlhO9O2RzXIms8aAw71D6omm7wNApUjDETNmPM=;
        b=WV6biUtZlVIR1dbxFlK0T1rw/EFd20DqC6nAMntSMuyyWMd2ePRVgbJ/c5gJJmf6ck
         yJ7fkG6f5gG9pwDKZmeF6OT6zQ/IKajYHfKe7b+VUxMuaLf8vnJLt2t9z0RLYu86qT9t
         WEG6xJzY9tAFM9qqghRz4dL2kllMmDbjv/40/k+y1Zl+Kc97hSSOG7AZexLag7xmBANI
         FlZZgovOyMBGHYpDNLzA7IIGuu9SVP7nKWdmb6XSJ/dklqNvP5hAGSyqsI+W205tQf14
         0iuD2APFd307rvUTaJBa5iTtMaL9ZW5LShPLQAZfW/kT54RW0Y2Y2QDK6UYfU4rwQ/Q/
         1pLQ==
X-Gm-Message-State: AOJu0YxnBNVOk2X6yqFnj6HCAMruWhXn2n/9LiwsEQi/dNhuWOiCR+TO
	0NSfJ+msno5M36MdRS/bQMWEMur9NwLThqOvfZ5OkPCnwqJ9FTeOAw0q
X-Gm-Gg: ASbGnctkdc+PnN5gNOVYruo8zINq0cpBdaM80/H8k62vhEureyx+AhKAQvZjV2Bsrnr
	QSqDYHhOELl40zqDK5r/HjO5Gz/Is9viNMyl0DSZPVTefVFHKFsCpdKF6sXPnrIblgqYs4vaIoZ
	IVKqt7mtMnUOZJn1cGIRqHzd9GQkXmikvsal8a91OFWFfRD46j8pnrehXtzjiFjNGcDi7gW6zMf
	ZEGF6iKlDxVamfPwOzb9a6qLyy+Ms9uugP5vJ5xcaK7rQDAfFio3QXyzui5P47+MK5ns6SgsdwD
	raV8qR9X6OqVgL4yiqvzdARdm+TDbk17ILgW5mPT6tIiZxYii+bXMvh2PeHMsICZrKa+YuYUw7G
	lFQzwww/V301q+4nV3PodYMif9NkHVp3Tb1j+RJs5dTCNCsnRN0eOfC1vCtmjXOIW2d6o1oTYsm
	BM3/jjiJdQ
X-Google-Smtp-Source: AGHT+IEVnZIbbqf2p9wMdtt8M+QLyi1YtUEPt/5HLeZ9i7P3juMXg/cqIvjxJL7ve5wKBdQZvEgNpg==
X-Received: by 2002:a17:90b:38c3:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-332a94df134mr5552161a91.8.1758671083824;
        Tue, 23 Sep 2025 16:44:43 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdc1bd2sm311257a91.21.2025.09.23.16.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:44:42 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:44:39 +0900
Message-ID: <m21pnw91js.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <39692eca904137ce7d51fccdc948ae0b94b4fe4f.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
	<m25xde80qh.wl-thehajime@gmail.com>
	<39692eca904137ce7d51fccdc948ae0b94b4fe4f.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_164445_210048_E9629E85 
X-CRM114-Status: GOOD (  32.40  )
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


On Mon, 22 Sep 2025 15:32:22 +0900,
Johannes Berg wrote:
> 
> On Sat, 2025-09-20 at 08:46 +0900, Hajime Tazaki wrote:
> > diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> > index 6a0354ca032f..04025207a077 100644
> > --- a/arch/um/drivers/Kconfig
> > +++ b/arch/um/drivers/Kconfig
> > @@ -159,6 +159,7 @@ config UML_RTC
> >  
> >  config UML_PCI
> >         bool
> > +       depends on MMU
> 
> That won't do anything since you elsewhere have "select UML_PCI"
> independent of MMU.

i see.

> > @@ -170,6 +171,7 @@ config UML_PCI_OVER_VIRTIO
> >         bool "Enable PCI over VIRTIO device simulation"
> >         # in theory, just VIRTIO is enough, but that causes recursion
> >         depends on VIRTIO_UML
> > +       depends on MMU
> >         select UML_PCI
> 
> Right, but you also need that for UML_PCI_OVER_VFIO.

thanks, I understand too.

> > and do
> >   ./tools/testing/kunit/kunit.py config  --kconfig_add CONFIG_MMU=n
> > 
> > the validation currently gives the following error:
> > 
> >  ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> >  This is probably due to unsatisfied dependencies.
> >  Missing: CONFIG_UML_PCI_OVER_VIRTIO=y
> 
> Well, OK, but that's fair - you did specifically override MMU=n, and
> virtio-over-pci needs it.
> 
> > 1) use --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n when using kunit w/
> >   !MMU, and drop this patch from the series (no modification to the tree)
> > 2) prepare a different file for !MMU & ARCH=um testing (e.g.,
> >   arch_uml_nommu.config), and add an option to kunit.py to switch MMU
> >   or !MMU
> > 3) implement virtio-pci for !MMU and propose to remove the restriction
> >   of CONFIG_PCI depends on CONFIG_MMU.
> > 
> > 2) will be removed when 3) is done so, I'm hesitating to propose a
> > patch used by whole tree.
> > 
> > so, I think 1) is (not the best but) a reasonable solution, with a
> > note in nommu-uml specific document (i.e., [PATCH 12/13]).
> 
> I don't think (3) makes any sense at all, we should just _never_ do
> that. !MMU is really here in UML for testing to support other
> architectures that are !MMU, and since by today's definitions no other
> architecture can have PCI without MMU, it makes no sense for UML to have
> that (and complicate the PCI code unnecessarily, etc.)
> 
> I think it's entirely reasonable to have overriding CONFIG_MMU=n to also
> necessitate overriding CONFIG_UML_PCI_OVER_VIRTIO, i.e. (1).

okay, I'll go for this direction in the next series.

> As to whether or not to add a specific config file, honestly I don't
> really know or even care - you'd have to ask the people who actually
> want to test !MMU.

indeed, this will be the out of this series if needed.

-- Hajime

