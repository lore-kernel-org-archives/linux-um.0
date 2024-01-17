Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BB8C47258
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3KIr93cXzFGXG0CIR3UTFsNxAvmBzln1Yix1gFoIcI=; b=UP8jKnSG0KVZmQmF2ffIKVb+SJ
	wAEi/va20yAcsz/zGi2jMGPhTq+r9sdaFBpRJJiYHo9ZzYM3xa80VZr5mxdHRlw2Hvt+11Ua6I4J9
	2qRsW84QuAdxwcwytIcmocvBrrrOW0rjIabmSK17MZA+SmY4vZUY8VGiYg4DTXZm0busULhIHQ9Px
	8TYp7m5GpezRmCD/9R5k0xswuEHJJXrSPu9dZRfRqNgm5136hfqy/1m6xpdDXIc3bP1HWYkCXU10I
	tcsiwx5bHK4Mm29pRb4xc4fHXLfJMCjOpxkqE+h715KLAmEqle7xZyBA3HOav/DhsAA07WjbGqkjM
	r6l7iS7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9uk-000Fy8-3C;
	Wed, 17 Jan 2024 17:41:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9ug-000Fwb-2v;
	Wed, 17 Jan 2024 17:41:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3C419CE1CE7;
	Wed, 17 Jan 2024 17:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42424C433F1;
	Wed, 17 Jan 2024 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705513276;
	bh=oMyiDD+Iv9PCZrZI/1gZAt5oqiBycCP8w9pHbV1lWu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBevjfMZJTsk0Z3N2eXC9xsiFZfpBm+jywM0ZqHd+H8ixc7g1WKJjwuH6xtzFfBD2
	 J/2kI0FLLvGFJZN4w8D6tmXCEt4L5wRmZio7hi+UHK1KJfw/mRDpDl7HjqPpnf4RU8
	 rqMCyz93kzjJHrIZ6uBDtVnNNvb5d0THqQ/RUACMVD+C0WgEmm8rYEyfKMeGoVowR8
	 p1/w87TVGdRe5AEc1BSDEQn6sv5oXKeQeodwLxz0UzRKhdNjjCtXYfuLpL1qjXbRLk
	 xD1bt4pTdG61tolFQUqZjEDIqew5YSFbsSGrjl2HSQMbWLPWwKsm4WGRqvZoskDOwi
	 /d5zpsGQIe1hQ==
Date: Wed, 17 Jan 2024 11:41:14 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
Message-ID: <20240117174114.GA2779523-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-5-sboyd@kernel.org>
 <20240115203230.GA1439771-robh@kernel.org>
 <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_094119_301913_BA426407 
X-CRM114-Status: GOOD (  33.47  )
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

On Tue, Jan 16, 2024 at 05:18:15PM -0800, Stephen Boyd wrote:
> Quoting Rob Herring (2024-01-15 12:32:30)
> > On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > index da9826accb1b..9628e48baa15 100644
> > > --- a/drivers/of/Kconfig
> > > +++ b/drivers/of/Kconfig
> > > @@ -54,9 +54,14 @@ config OF_FLATTREE
> > >       select CRC32
> > >  
> > >  config OF_EARLY_FLATTREE
> > > -     bool
> > > +     bool "Functions for accessing Flat Devicetree (FDT) early in boot"
> > 
> > I think we could instead just get rid of this kconfig option. Or 
> > always enable with CONFIG_OF (except on Sparc). The only cost of 
> > enabling it is init section functions which get freed anyways.
> 
> Getting rid of it is a more massive change. It can be the default and
> kept hidden instead? If it can't be selected on Sparc then it should be
> hidden there anyway.

The easier option is certainly fine for this series. I just don't want 
it visible.

> > >       select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
> > >       select OF_FLATTREE
> > > +     help
> > > +       Normally selected by platforms that process an FDT that has been
> > > +       passed to the kernel by the bootloader.  If the bootloader does not
> > > +       pass an FDT to the kernel and you need an empty devicetree that
> > > +       contains only a root node to exist, then say Y here.
> > >  
> > >  config OF_PROMTREE
> > >       bool
> [...]
> > > @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const struct device_node *n, unsigned long
> > >       return test_bit(flag, &n->_flags);
> > >  }
> > >  
> > > +/**
> > > + * of_have_populated_dt() - Has DT been populated by bootloader
> > > + *
> > > + * Return: True if a DTB has been populated by the bootloader and it isn't the
> > > + * empty builtin one. False otherwise.
> > > + */
> > > +static inline bool of_have_populated_dt(void)
> > > +{
> > > +     return of_root != NULL && !of_node_check_flag(of_root, OF_EMPTY_ROOT);
> > 
> > Just a side comment, but I think many/all callers of this function could 
> > just be removed.
> > 
> > I don't love new flags. Another possible way to handle this would be 
> > checking for "compatible" being present in the root node. I guess this 
> > is fine as-is for now at least.
> 
> Ok. I can add a check for a compatible property. That's probably better
> anyway. Should there be a compatible property there to signal that this
> DT isn't compatible with anything? I worry about DT overlays injecting a
> compatible string into the root node, but maybe that is already
> prevented.

I worry about DT overlays injecting anything...

I don't think it is explicitly forbidden, but I have asked that any 
general purpose interface to apply overlays be restricted to nodes 
explicitly allowed (e.g. downstream of a connector node). For now, the 
places (i.e. drivers) overlays are applied are limited.

We could probably restrict the root node to new nodes only and no new 
or changed properties.

Rob

