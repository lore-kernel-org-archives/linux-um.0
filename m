Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D6AC48295
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U77xr3ZrDFcspY+RoHrYoDiB+2qyXayQOG7MFvZlIZo=; b=qnqPvMGWvwrQ2R/QnI9rXGiZ87
	e2Fw/QA4CFZbaFR4H33uamKZcMRQCk00uhYrno+wpFRpNlAnqkFDMwM5yT6iSEIsuMF/b0IZr6gw8
	04PkCvj+Xr9tiA8L5IjSf5VjipMrBhwOZy3h8xKwfbthOSb5R0v+Wsbx8zYCpRLHqMU34JO3/mX8b
	z+sDXkGTTDyKtD61FlmtQlzAIOUqjbeP9XXbY3Oj9GhaKYux14hDMzy0J3jMGJcbm5iBftRE+6n8s
	Ez2WqhvmohcWMF6hhZEqytZLu9viJWdQLZeNxKLy9UA0zBGDxIjheJr6rJig6tBenFDu3FI3IhDIB
	D2ecVn8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyQk-00000003IVa-1Plg;
	Mon, 05 Feb 2024 12:50:34 +0000
Received: from mail-yw1-f169.google.com ([209.85.128.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyQh-00000003IUD-2xZu
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 12:50:32 +0000
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60425a9a3d1so30588127b3.0
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 04:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137428; x=1707742228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U77xr3ZrDFcspY+RoHrYoDiB+2qyXayQOG7MFvZlIZo=;
        b=U0rwWMOm6Xyse6bNlc/23/Hu6hvsfn2RSg02XzZ4Up4L+O4tm8jjzw+FYHnJ26WdXS
         f/LtftW0WdOCRZX0TPTsnFa/RVo/1BagxLWKC62bbwQJctqyKJOeHQGMagJUSxq1TFf9
         l3REpy7yvsDRbOYTB2VJTO3nueDSJ53meK/I1UVP5Y5aJcMkIl5yXaqwiKFVmc5g9pGs
         ijuP2NoiN6jHeaCVKYFezR60V8sKU+9CYVCVe35P2fTQSK50/WTCgso/5PAPqQlaoPTl
         QTJzm/dpB/yIz2NAqCIn+Lb8iQhFciSnnoPVWFcNn0gqVrsII4hbrRvk2jUKYva0Ojxe
         kiZA==
X-Gm-Message-State: AOJu0YxEQBrcENUN9hUw36CVZhPmcccOCfrc0nhdeNqUE0m64by8tmEc
	fNrNCxBEFNnomnAyvIZ+oqa9cOTU7TFxlbGhTIJ/j7xrFqleHZfdp0q06EwR6V8=
X-Google-Smtp-Source: AGHT+IFm8FCqBkYShxNpRW+GhkyVLgDHPgELUrXtsco0DJy7kqpI9+abDmwZSj04U6ruKyeyL71dpg==
X-Received: by 2002:a81:4852:0:b0:5ff:86cb:ea77 with SMTP id v79-20020a814852000000b005ff86cbea77mr14623320ywa.10.1707137427102;
        Mon, 05 Feb 2024 04:50:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXn4bg+9MS22LlgDd7Bj80EkTjpVfn8bxwtFeIUfC4oL8oL2w6f1V6uXdB0vs0JlsFboloxrzqhTUNf3NPHDnVia1sro7ZWz8oGepFt
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id cp6-20020a05690c0e0600b005ffaaf886ecsm1648729ywb.57.2024.02.05.04.50.26
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:50:26 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6e0fe3195so3529068276.0
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 04:50:26 -0800 (PST)
X-Received: by 2002:a05:6902:34e:b0:dc6:b9f4:a4c2 with SMTP id
 e14-20020a056902034e00b00dc6b9f4a4c2mr14515950ybs.57.1707137426212; Mon, 05
 Feb 2024 04:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-4-keescook@chromium.org>
In-Reply-To: <20240205123525.1379299-4-keescook@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 13:50:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWOKEYvGKRUmii5CqtaM-RAM_4SZC5gds=00+KUYyu+MA@mail.gmail.com>
Message-ID: <CAMuHMdWOKEYvGKRUmii5CqtaM-RAM_4SZC5gds=00+KUYyu+MA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] um: Convert strscpy() usage to 2-argument style
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, 
	Justin Stitt <justinstitt@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_045031_762402_DAAEEAB5 
X-CRM114-Status: GOOD (  16.86  )
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

On Mon, Feb 5, 2024 at 1:36=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> The ARCH=3Dum build has its own idea about strscpy()'s definition. Adjust
> the callers to remove the redundant sizeof() arguments ahead of treewide
> changes, since it needs a manual adjustment for the newly named
> sized_strscpy() export.
>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-um@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/arch/um/include/shared/user.h
> +++ b/arch/um/include/shared/user.h
> @@ -52,7 +52,7 @@ static inline int printk(const char *fmt, ...)
>  extern int in_aton(char *str);
>  extern size_t strlcat(char *, const char *, size_t);
>  extern size_t sized_strscpy(char *, const char *, size_t);
> -#define strscpy(dst, src, size)        sized_strscpy(dst, src, size)
> +#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))

(dst), (src)

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

