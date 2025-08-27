Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E801CA0FED
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OcF76ThxDzseiSVRi9ITwryzKooFVtGhEDdOZb1GMK4=; b=5FnnO3kQ6ZrICj7IVhyG9dmuGg
	LH2ewsGJf0l9VkLTrHujaupF2jtUmf8p7rvVL/c4qNvSioeXCxMTWMo2P6rgUvg9okzPSHMYYORFA
	uBkxEIGpiRO1yt11tjLApCeCK2jhW/0FYpY4rYfciY3FKuxp1ryjIqPqRW7o1+C6pC2WdZ7HRJyOk
	dmzmCY9mv0ZR6v/eThQmTq+j3d2zZAu5as60GtzByebdzTU7QPn0fj2+hYQheeAxnwmiZT3ro4Ema
	LDVE/GrAEn4grClTCPrTpzE9Tgb3qw4lOs7LHa/aC8eIeQoEpllCPMyFz4CKLMrJy9ZmgBM2wJmmT
	oA+uqp2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urMh7-0000000GkDQ-0cv1;
	Wed, 27 Aug 2025 20:24:33 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urM1U-0000000GeFb-0V25
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 19:41:33 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2460757107bso1927905ad.2
        for <linux-um@lists.infradead.org>; Wed, 27 Aug 2025 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756323691; x=1756928491; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcF76ThxDzseiSVRi9ITwryzKooFVtGhEDdOZb1GMK4=;
        b=N95NzEgQy2XYQ+ORrgzcgL3EEmKqj8mi8sax8eSB+P0JDOy7Cruj4wN1kROJYCMtDV
         d40XmA5pxqG9AYq19/7L2gMPe9FNmr54QJqio0JTYUywqYNmT8mdUHia+ZbHjIX26JI2
         amfXub5F4L3m7mQqx1i/ZWPOuIKznZK+4jajE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323691; x=1756928491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcF76ThxDzseiSVRi9ITwryzKooFVtGhEDdOZb1GMK4=;
        b=HbuZHhC6xd/3sODNi2zKwWvbI4c1HPvkjhdHwQGkyOT7rPP1NsP+uUzS7J/Zg74ULO
         QX/OfFAOg5SJxOMMy8AJEKiWXsbN6DeeazwFr9us+EkqneRegnUS02ZXjUH74n4PneSv
         qnweyjYeOaXR6/fWOfRgbbql8080GO/82z7vKcmyZK6ZEOqldHSUIrBRvAiKz4vAvXoE
         UhDUnZ1WN4xc89B2XqsDQr/QrO9f125xeTEC+fDNnDwYTvNoukCoarcPPBQtUKV/JYSD
         SLGW26kQ2NIH0U/utNMJpoMd65iEKyVbz7zXya88voJdDZUy6JwgbueBsZ0gA2zCzyqa
         F8mw==
X-Forwarded-Encrypted: i=1; AJvYcCUd0exO5AKVLKU1QsJiCF7u0/sGoH8HfW0AWfazSOdh1PipgWJ9rebZHCZ9IHLi0pLgRV20ldG6IA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzlqS0a14eo2sITCKnkU9lGy/oaagWsiJXECRx2wtqReXPIg1N6
	Dqb5o1j85vBH+Qgtsl8SRf0mmSbClUC20wr6d6UuKW46BoxImnLyOZBMWK9E0tT81g==
X-Gm-Gg: ASbGnctR/CBb/mZhrF1A3RTccGcIlY8jg1GLkM50tWayO0/nnyTTLka1lnnK5yjgznH
	OGMF2t1nHQXFZ4ICbh7bZtROTAtb2bonyqm0ryeK/heqGWZIa67WkhNLbtBrEqF2oMuE2YyOA3w
	inKni3Cm38whFB1TMTJiJOiRHutXaiMpLdi1rLl6s2N6QtRZmjflJ7n9dJvf5UVt00Ia6x13uYI
	0HNU61/LVnYnCgOBJ0oMn2heLSBNt8xy3H0t39uL3d4rpekdV9YoqyBKrbKaLQ2y6gQzlQB97d+
	Ck1EsHiOlpGJilt2UMgGki0/+etzdPgr0p1ZBNznegDS86hhqH0kpy2QFk7iqD02IDw4a+wkyGS
	vqTStQ06ZjBbccaGUgvqfO/Yzd6rI0HsDOAnHEJ2UO2VPsrOIqP9pAqXsyks/
X-Google-Smtp-Source: AGHT+IFZiE4r45aDuqweIbhvj5Uvc3wABlr9GNax9UlaNDtrOMl0n6Aq3+PixqrRUWTKPTqBfnW1tA==
X-Received: by 2002:a17:902:d4d2:b0:248:9964:3796 with SMTP id d9443c01a7336-24899643b24mr48265415ad.43.1756323691105;
        Wed, 27 Aug 2025 12:41:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:36f6:f0a2:9401:263d])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466889e11csm128094265ad.155.2025.08.27.12.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 12:41:30 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:41:28 -0700
From: Brian Norris <briannorris@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Gow <davidgow@google.com>, Sinan Nalkaya <sardok@gmail.com>
Subject: Re: [PATCH] um: Support SPARSE_IRQ
Message-ID: <aK9faES_JZYCgyip@google.com>
References: <20250825212031.111027-1-briannorris@chromium.org>
 <155ce30d5fad5a444f72b681eb096418384542b3.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155ce30d5fad5a444f72b681eb096418384542b3.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_124132_188932_5BAA61AD 
X-CRM114-Status: GOOD (  14.37  )
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

On Wed, Aug 27, 2025 at 09:38:17PM +0200, Johannes Berg wrote:
> On Mon, 2025-08-25 at 14:19 -0700, Brian Norris wrote:
> > 
> > +#ifdef CONFIG_SPARSE_IRQ
> > +int __init arch_probe_nr_irqs(void)
> > 
> 
> Is there much point in the ifdef if it's anyway always going to be
> enabled due to the 'select'?

Oh, good question. No, I don't see much point. I think I was waffling
about the MAY_HAVE_SPARSE_IRQ question, but if we go with 'select
SPARSE_IRQ' as proposed, I should probably drop the #ifdef.

Will send v2 if that's the only question/request.

Brian

