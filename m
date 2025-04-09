Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E3FC36002
	for <linux-um@archiver.kernel.org>; Wed,  9 Apr 2025 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oQY1o7SxIT4SK13jx8540K5lOFJCUfKlKKOAT7vzuN4=; b=v/cu20KWv+95JsjQpBj21k4y6q
	AsWwlUKcnGTHbsmWFDe3mGsmOYSVvAKwDKo5+lftdEy/6fZneGqnH8ksAynSI8yMRu8oPKi7s0px5
	b6J5xlo/lgvIdpfOIoDmbJmAu2n+tl5hV3hF8kIQNkLZI8Gxo6hDW88bC3uzncAbC/60ktnFh9rgY
	2BBNZ58nWBcddGLIh6THmRoz+VI3CjISZN7/qLp2KvoJTrmAthVWyUfm5wsnk5Dfe3uFFWyni26q8
	oJCxOhTROMrnBwwfSZ44N3xkJFW+vV6gPKj8j3cCbrx5CbfusRmlcM8YhC2GD7zdItQidA9RxsgZ3
	DM9ikbWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Yyv-000000080V7-1JKy;
	Wed, 09 Apr 2025 17:12:57 +0000
Received: from mail-qv1-f50.google.com ([209.85.219.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2YuK-00000007zXC-1uuA
	for linux-um@lists.infradead.org;
	Wed, 09 Apr 2025 17:08:14 +0000
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8ffa00555so55239526d6.0
        for <linux-um@lists.infradead.org>; Wed, 09 Apr 2025 10:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744218490; x=1744823290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQY1o7SxIT4SK13jx8540K5lOFJCUfKlKKOAT7vzuN4=;
        b=rcst9FQFqTzDITks2o0p6/3Wb4TcE2+fJy9wrlndqjQwe5jbseOjF/TCZ5zKBcZhj2
         jxV/dd90f3KBhBhTJ2oh+YxcjMt2gKlBmEDXlD4GGxITKFTq2FvaDhZe7G60Y9dRYEMn
         MR7hs43hSf6IIwm8N2kArqXxjlHBr9Q7viEViZzkCcfro8qFAqC38RDFbxvgFIbipt1R
         HM1pGAsUMVS18f55eoTnZY3Fgk+V00+wTLFoCdYZ2xYKUgepLSsK0VLTN7WvtA+i2ztQ
         Xewyd53xKfR+LDYAFaMMZx49RGNdmiZ7SJMCfElHwTgPrxjN5qewtDk6Ws5QTzxIBjkF
         cSNg==
X-Forwarded-Encrypted: i=1; AJvYcCVA7slSH7WiUanMhf6pf/y1aQE0VWA76qItJLlIfV1J0i+k/XwESyfR6tXn5c9tUcy2xodaw32Wdg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCchufeywf7Aj8uDTj1mmVR3uLB/+ttX22yZ11vfE9CZHxCIB2
	uAioDrEJX3RizVJ2/OdzwKaCPbcY7nFeFH5s8ZqEH/FonnHXbqLI+MrDV8nSrkA=
X-Gm-Gg: ASbGncsb4vNRC4LnvY8/p5eLD5eCySfXZdc+jkJbWupyBsohOlhUvXiFwZNDRXMmix1
	R0jIAI+GZzn3R0hQ7gI99R4fhM+ic47MyKncnIHzaC9F8CIs85Y8Cp9WkgjRnUSV/G43bcybYNq
	lqPUx5ki3MUN1KGcWYSLWOL3WZ7wUTeVhh3SiVaYcbmUIDqa0ydcv8EHh/2/nEr+ZHBy3O8FcHm
	FZXtcPvhmrG1QW19+o7XiOcSdYTKkFfnDp520YG8Xr/l6WOVx4WvrUmG5D9E+/c6m1swvTcomGw
	d3WhxxoYfdkCH3O9/h6Iqrmf/fUdRRDFZUE/QRo0xmYYRJgCVf53y8XnpgAUJVsz4lCSgm3P1Q7
	IiD9zEBA=
X-Google-Smtp-Source: AGHT+IGGWkOflALo8kNuVNDN6MKJ66ZR/+NqjjG1OjpB85bNwk151nNzE9mCYKSbMI9nY6yuL0tqOw==
X-Received: by 2002:a05:6214:2585:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6f0dd0ad2efmr52259576d6.25.1744218489874;
        Wed, 09 Apr 2025 10:08:09 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a11ca015sm95496185a.82.2025.04.09.10.08.09
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 10:08:09 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5e39d1e0eso669186185a.1
        for <linux-um@lists.infradead.org>; Wed, 09 Apr 2025 10:08:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0m/milzBArGRRnO6v6lwoMCPNyu8z0u/UxL6Xbcit1ho3c0YY3pGxQ4+DiSl5/eIOIJ70KreD2Q==@lists.infradead.org
X-Received: by 2002:a05:620a:298e:b0:7c5:56c0:a8 with SMTP id
 af79cd13be357-7c79dd93ccemr445711285a.1.1744218489140; Wed, 09 Apr 2025
 10:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250409061129.136788-1-fujita.tomonori@gmail.com> <CANiq72mbci8kxEx5jrq=HVc6WKuJqq8NCLzNsjH1wFcJNoHm+w@mail.gmail.com>
In-Reply-To: <CANiq72mbci8kxEx5jrq=HVc6WKuJqq8NCLzNsjH1wFcJNoHm+w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Apr 2025 19:07:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com>
X-Gm-Features: ATxdqUGA2zHq6_S5SB_qEsVdujtLoXOP8BLoi9G8SgAElmMjDh-OTkFg66-F8QM
Message-ID: <CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com>
Subject: Re: [PATCH v1] um: fix incompatible argument type in iounmap()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, 
	Stephen Bates <sbates@raithlin.com>, Danilo Krummrich <dakr@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_100812_491587_505648E9 
X-CRM114-Status: GOOD (  15.16  )
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

Hi Miguel,

CC arnd

On Wed, 9 Apr 2025 at 16:48, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Wed, Apr 9, 2025 at 8:16=E2=80=AFAM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Align iounmap() signature with other architectures.
>
> Most indeed have `volatile`, but nios2 and m68k don't -- Cc'ing them
> just in case.

Indeed. Apparently the volatile keyword has not always been there...
Why does iounmap() need the volatile keyword?
Why does pci_iounmap() not have the volatile keyword?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

