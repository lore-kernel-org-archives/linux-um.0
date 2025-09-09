Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98338CAC587
	for <linux-um@archiver.kernel.org>; Tue,  9 Sep 2025 06:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u00qc8KQ1fNjSOxfylahcZ76XCno456ST8BNeP1JmBk=; b=1kSl1onsaMW+r580QL8Ud9G22S
	xQA0gdxcGc30gpoGpZilG2QmyNgBBQrLTYN9+sMCwl9lXGYhBGOqhGlPpzQQmo+JRRO6DeB8a+tPa
	i3d6MKNVNVzitKlvwFwKlQttooOkogSJWLVdtQx5rqoH7URDiba03UdaTzT8zVTHc9lFXqiSJf/Vx
	/8E9BWr+u2XoAgGrJJjBMaBgoCtev4gr6FI+18BLo7ZryzUKr6hZQqraZJc0/XJDZgynkfcL/WLPx
	jM7uaH54L1v8fKIUXDT3/GjAZroivWvwgPMUbpI+Q420+K9ebbFg5w8su5FHUYfkhR7adENAKUI/R
	Yzj5QrWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsK6-00000004zuF-3meX;
	Tue, 09 Sep 2025 06:59:26 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvrIJ-00000004XGE-1LUQ
	for linux-um@lists.infradead.org;
	Tue, 09 Sep 2025 05:53:32 +0000
Date: Tue, 9 Sep 2025 07:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757397209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u00qc8KQ1fNjSOxfylahcZ76XCno456ST8BNeP1JmBk=;
	b=UKM8MK4oRVUXEfIjcDVB8+cH6+CfiI/NaIvZ4Ve2TPXRCjT1zeHfosMQu4vnyyL8R1vJx0
	pV2PPnRH98NbCI/ubyQUb/Ov7UIn46Kxd+FJrarPdwcsw60GJYhNYMcwL/sy2ay5MwnHJn
	lwUxh/fOCEIfSGuS+3anuJN0dQbyqUPXPaYEVw40OGWEsMpZNkXyyU0DM4qARccbwRjiu4
	h35DJfZhBOK0DbsYQq7Jbg3jyEd2qlagCukcP90QpgRcekKbrCvLH5BEn3R6jRRQN0lsDK
	QIkKG+ctFf6T2F9XHNee871Dl6Cci3dsca/1ilwD8roubGzVbeo8oPWi1KBq4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757397209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u00qc8KQ1fNjSOxfylahcZ76XCno456ST8BNeP1JmBk=;
	b=MiFReSeQzj5xuUjXwcvDyrcy105eFS0rlpYVpeWoy5EL4sFqX//SkSGbWku5LEOyuHvSdH
	XoaERlptfblKgLDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering
 WARN()
Message-ID: <20250909075052-54454a48-3576-4d39-ae67-a04ee4616734@linutronix.de>
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
 <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_225331_503383_658CDE09 
X-CRM114-Status: GOOD (  24.76  )
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

Hi Geert,

On Mon, Sep 08, 2025 at 06:53:30PM +0200, Geert Uytterhoeven wrote:
> On Mon, 8 Sept 2025 at 09:04, Thomas Weiﬂschuh
> <thomas.weissschuh@linutronix.de> wrote:
> > Various KUnit tests require PCI infrastructure to work. All normal
> > platforms enable PCI by default, but UML does not. Enabling PCI from
> > .kunitconfig files is problematic as it would not be portable. So in
> > commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> > PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y. However
> > CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> > CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() in
> > virtio_pcidev_init(). However there is no one correct value for
> > UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
> >
> > This warning is confusing when debugging test failures.
> >
> > On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> > used at all, given that it is completely non-functional as indicated by
> > the WARN() in question. Instead it is only used as a way to enable
> > CONFIG_UML_PCI which itself is not directly configurable.
> >
> > Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> > configuration option which enables CONFIG_UML_PCI without triggering
> > warnings or building dead code.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Thanks for your patch!
> 
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
> >           If unsure, the default timeout of 300 seconds is suitable for most
> >           cases.
> >
> > +config KUNIT_UML_PCI
> 
> Where is the consumer of this symbol?

There is none. The relevant part is that it selects UML_PCI which on its own is
not user-visible. Directly enabling UML_PCI wihtout any drivers only makes
sense in the context of KUnit.

> > +       bool "KUnit UML PCI Support"
> > +       depends on UML
> > +       select UML_PCI
> > +       help
> > +         Enables the PCI subsystem on UML for use by KUnit tests.
> > +
> >  endif # KUNIT
> > diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
> > index 54ad8972681a2cc724e6122b19407188910b9025..28edf816aa70e6f408d9486efff8898df79ee090 100644
> > --- a/tools/testing/kunit/configs/arch_uml.config
> > +++ b/tools/testing/kunit/configs/arch_uml.config
> > @@ -1,8 +1,7 @@
> >  # Config options which are added to UML builds by default
> >
> > -# Enable virtio/pci, as a lot of tests require it.
> > -CONFIG_VIRTIO_UML=y
> > -CONFIG_UML_PCI_OVER_VIRTIO=y
> > +# Enable pci, as a lot of tests require it.
> > +CONFIG_KUNIT_UML_PCI=y
> >
> >  # Enable FORTIFY_SOURCE for wider checking.
> >  CONFIG_FORTIFY_SOURCE=y

