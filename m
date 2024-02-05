Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A54C4828D
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k4l7mcaaxoys3/2icFPJqDxqSgWMH+oMeBEXylz/8J8=; b=Zcw5VdCCBMerr4juN1eASBgr7M
	8Gy40YPv6mSjwmyq5ifAeTgcB+YkbR4w1bIgSJIRBKOmso45lQSLLaa8+HsISkIR2umtPP5FaDFF2
	5PIf73eiGaA+55ZILYYNGYfFk2ClE2ypz6TImTsCECAImrjRw6OFJ32cyXiP7GHo6QnLSFPqmQOue
	ICFaOFFUg5Mf+B9fRHhZxk8DAuUSExf2ZWH/pYN0gqI/f0RbfMn6Wql3oQxDC2BDPuGo87sUvA/Hz
	Y87oO3/ZZuXku07ow3ECGqnA3cjVP3ctBriVktmVHLhf6e1AMhKn+IH3/X96cT+OIgAOhzsDua7Ww
	/lqlbX/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyhq-00000003MKx-0jmY;
	Mon, 05 Feb 2024 13:08:14 +0000
Received: from mail-oi1-f174.google.com ([209.85.167.174])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyhn-00000003MJo-3KGJ
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 13:08:12 +0000
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bfd27d5d1aso735068b6e.1
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 05:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138489; x=1707743289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4l7mcaaxoys3/2icFPJqDxqSgWMH+oMeBEXylz/8J8=;
        b=uuzDK0A2SnJTKQS0hdZaZaQ4JdNqrwAxf8qKzCJ3bo1l16NJ123xTZ97K2s/ajmz++
         8ia10PXvjfC9v0fL+Bjc0wok74cNxRmIb7CRdI1Uq++rdKcSgG+iS0PB5DPovzwc8nbS
         iBB515UZArF8kO4MQUKkqWm2fJ79E0xmB1oKhBwBZ8e8W4ILbGKYJKxuitgPKWFr2pJJ
         R2K1Wf2LfUkFTu+p8MqZQDL19PrQp1oub9iUhzXkSYMFuH3METBxPSHP+/JbYPPaCJ99
         pvwbLu90LhVNEp7xj2vCIpIl/xpz3tShBMKEziunpEFL6W8yDHATEeG6/BkgeS1NQlEn
         esbQ==
X-Gm-Message-State: AOJu0YyAzjbRrluVKNovCe3csrwWbkTkqlAnb6Wjx3gpU6UGRRJYj1hq
	iqfXKgdMPzugH2J8+Wq1nMIpHXHD/MT1h++tGzmCHyrRwc09NvLWxBAIumqNsOY=
X-Google-Smtp-Source: AGHT+IFmmVfoUdMT1ngZBdUs1YQZxQeOI/T4t79xqVkHIdyD6JciO97CmOymvCZNGTTX1mOnrI/kwA==
X-Received: by 2002:a05:6808:24b:b0:3be:905e:47aa with SMTP id m11-20020a056808024b00b003be905e47aamr15576839oie.18.1707138488985;
        Mon, 05 Feb 2024 05:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4B9tvg4YmLAMYGPJG+zwzKecj+HSM5IgDvLWoGBGxMRtlkka+3OiUc9De+IozPsHn/b0Byl17+8lSYwqr+cpV3gKg/US6nOtwNCYr
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id bz1-20020a056808344100b003be3b1286d4sm1458470oib.23.2024.02.05.05.08.08
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 05:08:08 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a87156cb8so1900877eaf.2
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 05:08:08 -0800 (PST)
X-Received: by 2002:a05:6358:1901:b0:178:a295:996 with SMTP id
 w1-20020a056358190100b00178a2950996mr18933522rwm.22.1707138488274; Mon, 05
 Feb 2024 05:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-2-keescook@chromium.org>
 <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com> <202402050459.892907C59C@keescook>
In-Reply-To: <202402050459.892907C59C@keescook>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 14:07:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYri0tkVDORL468hc7_AXx4qnrT6wjKO69FpujbEehUQ@mail.gmail.com>
Message-ID: <CAMuHMdXYri0tkVDORL468hc7_AXx4qnrT6wjKO69FpujbEehUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] string: Allow 2-argument strscpy()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_050811_851434_9849A4DD 
X-CRM114-Status: GOOD (  21.51  )
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

Hi Kees,

On Mon, Feb 5, 2024 at 2:01=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> On Mon, Feb 05, 2024 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
> > > +/*
> > > + * The 2 argument style can only be used when dst is an array with a
> > > + * known size.
> > > + */
> > > +#define __strscpy0(dst, src, ...)      \
> > > +       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> > > +#define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
> >
> > (dst), (src), (size) etc.
>
> I normally don't do this when macro args are being expanded into
> function arguments. I've only done it for when macro args are used in
> expressions. Am I missing a side-effect here, or is this more about
> stylistic consistency?

I'm not 100% sure it is needed, but I'm always wary when using macro
parameters without parentheses, except in the most simple use-cases.

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

