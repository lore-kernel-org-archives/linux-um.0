Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4381D6ACC3
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1izSNhs/MtpbUL+pU2QDmnwxbUA62z5JZKZpfJgnol0=; b=mv2Yrj1Wq1OTPImv5yWIAXOMcZ
	lkVNX9mpiykLf/NWnVVMFAeroFuyr3pljOJPChe9gEARHgDCKUyXfPMJHnvwrGujKdjMiT54kLW7b
	McVp+3i3dwcJ/ymZ8htZ/JnJRlXvM5BfaaJNy5joaTl4tJUoIQEMy51SpY9bccE8mWlGeq+Cjm0+8
	TeKSkaqRMaLUl0FTLYr49OEqq2RgIgOlrGjAZ3WPwf4y3+uFvj2Av/RpIWRFuP4cT9N5FSYfFPwUV
	THeDvhWEp3py0SsRExNadJljRvySIAe+tbwgjvlU0ReaF0Gwe1RgHNWlfqOt94lGZEvRpkOhVZrVm
	kGJaIPpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGGym-0000000D7Gt-27Cg;
	Wed, 27 Nov 2024 12:17:12 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGGyO-0000000D7EZ-1sZ8
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 12:16:49 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53df3078a4dso315697e87.3
        for <linux-um@lists.infradead.org>; Wed, 27 Nov 2024 04:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709804; x=1733314604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1izSNhs/MtpbUL+pU2QDmnwxbUA62z5JZKZpfJgnol0=;
        b=nr9Xq/9zY54OInJaId1Z2dfcjUlvvqpfF12YQdwUAVr8kbygxLuaEJCGE/72yhYPXT
         z6+e3/CeB54Wxoud2KzLEfBloAaMpBdZQyyNsxIoCQmiXyWwKKsxh4LbnptcqvMG4gaw
         IcVvHwu5/SdC1pxRxxzqYsnaaIpWRrwqaI7rbnLxiKEfb7lzPYO/NYUEIvQ12ciZSQSv
         JU6CQqPyBmAc49IMmvhpPgWEES4zq+hSB5Lw5C+R9glN86/d9+/nzXEfVI2h7VDKGBkN
         vrP2hqrUAYZyu6EMAwuU2G9GltXccDif2gqzNBV7dXFF4pqaJCUkTJH/pbcPVTfjk0Mo
         w16Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHWV8PWqvWlKNDCgUzKBjEoS8YE1KK76HVkc+6uQvEuHOI8hnEGtg+aCWQzwyduYkrtcc/ag829w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxg1RKgh/w3W3ZD3+d4gpE4tAFsOP5VW8RwzlL9hk/eEZxkCTjN
	6Un9KKMx55DY1LC1rKRDW9PfA8Qvv7iI+FG9eg5v70jtSEh6eBr/zVqso/lDmJ8=
X-Gm-Gg: ASbGncuQa60CVOc1tcd0XQ21QsrXM1Yep0OR8ixnQPWexCmukImj+3BqTmxEDcLESCq
	WJX1c9DqnvaGW0Du4XaKyJhiGdyEHINYKQA1EoPFk+kqfuU6eWX4eZLYSKmB0eIAtg/rSW/Hv4u
	zPfrZPJNWfg6HNU2atqN7WWQ//rf6lAHIMeFQ/F4Li8j90gCn83K/x6ucJqFEcpLCBpYMNW1pZP
	A3jNwe6lk2MUSOP6cFVOsfoDRR+IsRwDQCrE/HKVkEjmrLOghvyJfpH47jf8onJYfV12GuPmqnV
	s6AHTk1uWnsf
X-Google-Smtp-Source: AGHT+IGPaQa1m4veg48KE4sp8JwsbRbLX9YTnmLuqMqIP7Jvql0e0CNGxL740qMnKsxMlBIReqN9BQ==
X-Received: by 2002:a05:6512:3988:b0:539:f496:aa88 with SMTP id 2adb3069b0e04-53df0112692mr1383148e87.53.1732709803616;
        Wed, 27 Nov 2024 04:16:43 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa55015cdd0sm381068166b.112.2024.11.27.04.16.42
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 04:16:43 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec267b879so961370466b.2
        for <linux-um@lists.infradead.org>; Wed, 27 Nov 2024 04:16:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2q/WxInWg8qKsJI32ojerWZrO+vrFIvkBxIUS9OMds0BckOxp7uRLRQ7QlOYOOr+MCcJLl5gtJg==@lists.infradead.org
X-Received: by 2002:a17:907:c0d:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa58106648cmr241990766b.51.1732709802220; Wed, 27 Nov 2024
 04:16:42 -0800 (PST)
MIME-Version: 1.0
References: <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com> <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com> <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com> <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net> <dywzjfeburew25fitcwspay7i4ckynhehpuvtmsi2k6b4ip7wd@xfcbztze47q6>
In-Reply-To: <dywzjfeburew25fitcwspay7i4ckynhehpuvtmsi2k6b4ip7wd@xfcbztze47q6>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Nov 2024 13:16:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUU7+HeeY3Rf+QG-x+4A=tk=y14byZJ6HUfzNBb6Num3A@mail.gmail.com>
Message-ID: <CAMuHMdUU7+HeeY3Rf+QG-x+4A=tk=y14byZJ6HUfzNBb6Num3A@mail.gmail.com>
Subject: Re: UML mount failure with Linux 6.11
To: Karel Zak <kzak@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Hongbo Li <lihongbo22@huawei.com>, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_041648_483464_F827CB4F 
X-CRM114-Status: GOOD (  25.07  )
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

Hi Karel,

On Wed, Nov 27, 2024 at 12:56=E2=80=AFPM Karel Zak <kzak@redhat.com> wrote:
> On Tue, Nov 26, 2024 at 02:50:38PM GMT, Johannes Berg wrote:
> > On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
> > > The long-term solution would be to clean up hostfs and use named
> > > variables, such as "mount -t hostfs none -o 'path=3D"/home/hostfs"'.
> >
> > That's what Hongbo's commit *did*, afaict, but it is a regression.
> >
> > Now most of the regression is that with fsconfig() call it was no longe=
r
> > possible to specify a bare folder, and then we got discussing what
> > happens if the folder name actually contains a comma...
> >
> > But this is still a regression, so we need to figure out what to do
> > short term?
>
> I will add support for quotes for unnamed options, so that
> "/home/hostfs,dir" will be treated as a single option for libmount.
>
> I am unsure how to resolve this issue without using quotes, as we need
> a method to distinguish between a path with a comma and other options.

Escape the comma using a backslash?

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

