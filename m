Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86095C61DA4
	for <linux-um@archiver.kernel.org>; Tue,  7 Mar 2023 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y0OMQhUJobssaiNXSwtAc9AD0teLHSfiNXOSfSF+9dw=; b=ZXvU8hGYpWGhYr
	M5N2+W7fg7nwiHILMH8w3RZjwwoN0aA5Rokk2qO7ORwdGkFQlhPsPgiMcM3/b3SMjUYd3c7nhCZWG
	zP6DxH8FfI4a1cbxdxF7t/QrnJ73rHNebG96UaGqfqykh3T5FZxsk4w/XU/L5bShaVDs4PkwGHUX9
	WJD0UHKSbQlPoH/qMvxnRXNO5h01Cd8jCT8gB7diIQ7gj0P0LuIV6X3xOu6Nuq4HFewSWwWy02sB5
	yQ0S1MB5PdzH63vr7XasjZr3WB+tMLC38637nGl5NwUPVvtkx1FV9mlrjiwEQKjb25K7+UnwI6Ses
	s4NGieGXW6aViluvd3aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZLEy-00FcpP-KH; Tue, 07 Mar 2023 00:31:40 +0000
Received: from mail-qt1-f181.google.com ([209.85.160.181])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZLEw-00FcnG-9U
	for linux-um@lists.infradead.org; Tue, 07 Mar 2023 00:31:39 +0000
Received: by mail-qt1-f181.google.com with SMTP id r16so11150243qtx.9
        for <linux-um@lists.infradead.org>; Mon, 06 Mar 2023 16:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678149094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OcxBWi+fVPcj6LdXeac5WEwf/t01OSULuob77wgPfk=;
        b=kVwJx7hBAdhNief4txUcVbNzOhE4bVADyk4uMjNf9dn3aOpQDA1hvYIT3SNzM4hqw+
         025Zd1Ek1rktgy51upRRbaf69UPQzhNYd81S0bAW273lNbujWlyXoqGnWVBPQD2qIdA0
         vWmxiPNdKkdIZhAB4nlaMyGacQJmRh6yxgop3blLZ2NgsVwYC7zp8Rm6+rE1srCbiK3j
         M+pbt82h0IdI0Lhcryroaun3EQQn1utWEFqRtpxYw8KYkeqeryNx3tOehfkvSTuew25a
         y4FsPpIvH/emBSOLJkWK7b10mkIalIBw4OBlndRAuduTV/S+TplE8SkZNykb6HyyGUuK
         BCUw==
X-Gm-Message-State: AO0yUKXsPN8USP37zvr5ZJbqcRKCRrf26c/BrtHrzWgq3S+pt0hBnp5E
	nG7NetgKyfgvV0oo3FaVAA7L4qR4eYVb
X-Google-Smtp-Source: AK7set8fUnjreVZQ0144g6g2i5wEN0n+GrJKJ96YTx91SjVQkoi4tSAg2pTObyRW7ccAlKfX+Zxpdw==
X-Received: by 2002:ac8:5c08:0:b0:3b9:bc8c:c1f9 with SMTP id i8-20020ac85c08000000b003b9bc8cc1f9mr29744892qti.4.1678149094187;
        Mon, 06 Mar 2023 16:31:34 -0800 (PST)
Received: from robh_at_kernel.org (adsl-72-50-3-187.prtc.net. [72.50.3.187])
        by smtp.gmail.com with ESMTPSA id a4-20020a379804000000b007417affecdcsm8643332qke.69.2023.03.06.16.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:31:33 -0800 (PST)
Received: (nullmailer pid 6585 invoked by uid 1000);
	Tue, 07 Mar 2023 00:31:32 -0000
Date: Mon, 6 Mar 2023 18:31:32 -0600
From: Rob Herring <robh@kernel.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, devicetree@vger.kernel.org, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>
Subject: Re: [PATCH] virt-pci: add platform bus support
Message-ID: <20230307003132.GA6366-robh@kernel.org>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
 <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
 <Y+t6qXBxLqf/+eQM@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+t6qXBxLqf/+eQM@axis.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_163138_348545_B871730E 
X-CRM114-Status: GOOD (  17.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Feb 14, 2023 at 01:12:25PM +0100, Vincent Whitchurch wrote:
> On Mon, Feb 13, 2023 at 06:54:49PM +0100, Johannes Berg wrote:
> > On Fri, 2023-01-27 at 15:30 +0100, Vincent Whitchurch wrote:
> > > My first approach to getting platform drivers working on UML was by
> > > adding a minimal PCI-to-platform bridge driver, which worked without
> > > modifications to virt-pci, but that got shot down:
> > > 
> > >  https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/
> > 
> > Reading through that ... OK that isn't fun either :-)
> > 
> > Sounds like there's a use case for something else though, but the PCI
> > IDs issue also makes that thorny.
> 
> Yes, Greg was initially totally opposed to the idea of putting platform
> devices under PCI devices, but in his latest email he seemed to
> allow it in some cases.  It's still unclear if he'd be OK with a
> "virtual PCI-to-platform bridge" though.  And yes, adding platform
> devices support like in this patch removes one layer and also eliminates
> the disadvantage of having to wait for user space to specify a PCI ID
> for the bridge device.

Like I said in that thread, we have multiple usecases needing something 
similar for non-discoverable MMIO devices behind a PCI device. And I 
convinced Greg a platform device was okay, so please continue that path.

I'm adding you to the thread of other usecases.

Rob

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
