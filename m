Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6D4C3601E
	for <linux-um@archiver.kernel.org>; Thu, 10 Apr 2025 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9o1fBfdX3QCvvMjGP9Bb3+iIudc9m8AmMEftLcu43No=; b=YJLohgfy1Bwlky8uEmKcjNwgYQ
	AOkjFSdOfXALziEsl83wedG+EFJPQiL4FmT0KkogyR5+tiijXKVlgkLHpBGHBA77idSx7a51LT43t
	Jpe478i7Yj+k9yU8iYMYYxo3Pm2LhQ153kZeIB/0RUqOl6htOyX9/InyB+JunO4qPHJlTYOi6HNT5
	kY+dIvmx/hF/Dd7kwCM/uD4QdkxJJhVe6kAYs0FbcHftgBFaYp0Q1zMjLm0uuFQqy3dqD/8nOGl4D
	s5KFLpA/3jTtvmzP9+Baj3WsBWCHgIpZNX13RHkpicDRzr3tDwYIieC5S6WLY97pQqTHiUghaApkJ
	Lk9XVFag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mvH-00000009fiQ-0kDH;
	Thu, 10 Apr 2025 08:06:07 +0000
Received: from mail-ua1-f46.google.com ([209.85.222.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mMo-00000009YvL-3ZEq
	for linux-um@lists.infradead.org;
	Thu, 10 Apr 2025 07:30:32 +0000
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d30c329f2so595331241.0
        for <linux-um@lists.infradead.org>; Thu, 10 Apr 2025 00:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744270228; x=1744875028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o1fBfdX3QCvvMjGP9Bb3+iIudc9m8AmMEftLcu43No=;
        b=TFnTNmq8/yDPJHl+svwRi5MfT3FFtTiB1sDT7cynSwI/c2eI52ZuwAskX+DMMBW8gl
         34HTdCgoEWeG8NCr9+EH9hnc0wz2bVXywCSKql9nGWKfjqsvzOAz4ye+lSKiCP4uZlPr
         G6cruMQUC92gGQXTgcLGeHtqrDmvQXTnU/aUIn5WLOFDjTf7rXSZUjmvFaXTKZ6QokB2
         bqNONB6TnhjHZG2qDc4eqgQ4TpfuLxdl4fSsxLb54dfsWfVRuGHhcq5TsZDtjC3d6WHb
         9WlP+m1NJrlCinkPYGeUKsERZOoBYGL8U4P5zvz7Cg+g+EMtTxQppfTbQ3hncf3MhNIu
         R8ww==
X-Forwarded-Encrypted: i=1; AJvYcCWaO7a2pOgBfw5iXOZFUeenDlb5w8d+3C63q9KHeQ5trNu1IVwtRXbBMIpx7fX0XR0kv8ygwyyEqA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0ZD5z/KGPJb1j3OfauzP5FFkK8JgnUWOYp9mA3y6RPuo0/Iyr
	1w3h9e8G721kycsNNB2k5fAHv+PtMLr4tG5pWawLA1RoMcdrm/J7BbtpjXmNSPk=
X-Gm-Gg: ASbGncv/cea9ux8tNaNTYWfs97SoD4IJkw9k4qad9N1usmp00wYhv1r3gwW27HD+73L
	WLxLizHyfJeTiBDBml6JF27l2ziOSeFxKu3k7t/c+WBJhPbMlEWeyaKHjqqmrU6qio/J/dzjZUZ
	IXEVMAmOAwWe3vZkqzEOx8IiUdT2jrH3xC6quNfqfVhnEcDMUEgBB4pgh6jZr6EITXJ4yO4D22R
	2x5l2yZKWe0M8TaUrWlRj7yX3r4BjFL9QI6hSGSTywbcOVqsEhsw3fTRYwT8q23tNvp6LLQ1QXg
	Jbt7G41jAUbzPp9jij8NVunPJTIA2Hydd58JobpscuALowZhqSP/VXh77yApbaLTXQiaG0fpilt
	ktp4=
X-Google-Smtp-Source: AGHT+IGxoBv1dG3RZOy9KGn/YROYvRZ8+Rd4VVOwFDVQ8IM8W/LEzIwrlba/JNNMN4WMqV8XmXsSVw==
X-Received: by 2002:a05:6102:6:b0:4bd:39c7:804d with SMTP id ada2fe7eead31-4c9d402b251mr670637137.0.1744270228180;
        Thu, 10 Apr 2025 00:30:28 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c9738490sm503731137.1.2025.04.10.00.30.27
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:30:27 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso1581651241.0
        for <linux-um@lists.infradead.org>; Thu, 10 Apr 2025 00:30:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNUJfvjtLo/3dJGTvkC1Xl67GqU2s0IdWf/JW/W5B0D6vT/SPQKJA4bGjySBVVdhc5ErRHBGE3Yw==@lists.infradead.org
X-Received: by 2002:a67:f5c7:0:b0:4c3:b75:16e6 with SMTP id
 ada2fe7eead31-4c9d3fc4c38mr837750137.10.1744270227560; Thu, 10 Apr 2025
 00:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250409061129.136788-1-fujita.tomonori@gmail.com>
 <CANiq72mbci8kxEx5jrq=HVc6WKuJqq8NCLzNsjH1wFcJNoHm+w@mail.gmail.com>
 <CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com> <ab0490cc-ce86-4492-a088-fd2ae03f1475@app.fastmail.com>
In-Reply-To: <ab0490cc-ce86-4492-a088-fd2ae03f1475@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Apr 2025 09:30:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXk+MfwPtm_whA2nWde0t_Ft=n=4xCO9hqAm-yuS+He5w@mail.gmail.com>
X-Gm-Features: ATxdqUEn3DKP5E0KW6CdNHS_yejpIaRbcErnLPFBtAL1D8Oqr0CTfb75MAhqP40
Message-ID: <CAMuHMdXk+MfwPtm_whA2nWde0t_Ft=n=4xCO9hqAm-yuS+He5w@mail.gmail.com>
Subject: Re: [PATCH v1] um: fix incompatible argument type in iounmap()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, 
	Stephen Bates <sbates@raithlin.com>, Danilo Krummrich <dakr@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_003030_902138_B003DB03 
X-CRM114-Status: GOOD (  24.32  )
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

Hi Arnd,

On Wed, 9 Apr 2025 at 21:07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Apr 9, 2025, at 19:07, Geert Uytterhoeven wrote:
> > On Wed, 9 Apr 2025 at 16:48, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >> On Wed, Apr 9, 2025 at 8:16=E2=80=AFAM FUJITA Tomonori
> >> <fujita.tomonori@gmail.com> wrote:
> >> >
> >> > Align iounmap() signature with other architectures.
> >>
> >> Most indeed have `volatile`, but nios2 and m68k don't -- Cc'ing them
> >> just in case.
> >
> > Indeed. Apparently the volatile keyword has not always been there...
> > Why does iounmap() need the volatile keyword?
> > Why does pci_iounmap() not have the volatile keyword?
>
> In the old days, a lot of drivers marked MMIO pointers
> as 'volatile void *' rather than 'void __iomem *', so iounmap()
> and the readl() family of accessors need to be compatible
> with that type to avoid a warning.
>
> By the time we introduced pci_iomap()/pci_iounmap(), this was
> no longer common, so they never needed it.

IC.

> In theory we could go through all the old drivers and
> also remove the 'volatile' markers from struct members that
> store __iomem pointers, but there is no practical benefit to
> that.

Most drivers must have been fixed already, as m68k allmodconfig
does not complain.  Still, I guess I should update m68k to match the
others, right? (FTR, that also builds fine)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

