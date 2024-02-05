Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15508C4828D
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RVwKzZH65GNl+QMR7mj3Tovr3dTIgpY6fWgtghHpZI=; b=eFr+/rJ8CeBjzwUZBRytRy8xJy
	uKpy/jaKobPsWsKdMghem0Y95KSCSHYXs7vM8vsIN6k/3xcDw/Ou1LpA3rtn/a2AMrxKVlwnUyu5e
	60K6sFj8PSzzOeYVdnwRQt4NQTlKtqn2IYtsmd1ZFlafTA2tY3qHV/H+33bP48meiwMxtH431pnTN
	/IObxIsgds3A0/C4a5nhgSKWQ/jsV+uWyWi+Whciz78DZWAYsezASXO40C6eYr0ccTyEax90ly6a4
	3BFHXqEpug4yQKNyQBBzQRKZ9zNWVLV2fTIrVAs5PhzsgWl87FN5WRDFksxuMozjtG9Wr1dBnjKw7
	/OkAOm3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyPO-00000003I7A-0LCL;
	Mon, 05 Feb 2024 12:49:10 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyPM-00000003I6E-1elk
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 12:49:09 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60453b52ae1so9452547b3.0
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 04:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137345; x=1707742145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RVwKzZH65GNl+QMR7mj3Tovr3dTIgpY6fWgtghHpZI=;
        b=AJ6vYmCvxVC1Mrzf+6rM+fEHvJ4zd7MJEEEfOXfg1xELFKB1L1y1jk3O/1VCZL41JS
         1BqahBgbtbi2Oc0Xr80BBxG5ZC9e4AZB6cD9xGFk3ya6uKgMJOk7hA33Z7aJLJlpoJXZ
         Cmo2fPcuag6HVuIvm4n6lESnDzL/xBrchWckcR6MC/4I/rwPIIAgnyq3Lqiu8qOQzghO
         OwyXzolgTybPaTCjujTjdnLjXnUXcaBp/MCsgwjNhTVZrtxGyc1MLX9lXwcIWX/1WRZI
         eJF4alto7x85M/xPg5uen/nIyMwLRQkUpM9gws93vMrgEwwjzzHg41MsxW8ySuK+H93O
         YbCA==
X-Gm-Message-State: AOJu0Yw4v3se9zvD8oEToqRHmYDIHLXEHBSeYKDtmUJ0L8jXorTBmwNF
	awzaY/ZZcNYRMMfxs7D0p4F9fCXrYpmgup5PWijjDDG9W/cdVIhnqAJBLdUlTG8=
X-Google-Smtp-Source: AGHT+IE2qsQMbuEebRDK3R17LTHBbhdtjAMY+1S7d01Bj/v1yNt/Dx0SYNcak3e169auSnJB83NETQ==
X-Received: by 2002:a25:b18d:0:b0:dbd:120e:f337 with SMTP id h13-20020a25b18d000000b00dbd120ef337mr11613412ybj.30.1707137344788;
        Mon, 05 Feb 2024 04:49:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtm1ubwUSgG48k/U6I2IZx7Hx/vvAPx96lYl3yPLaBnR3ClJCs/yJ5hL6T7HkAhcaBJQyHXjn9g+8AzVHOFeWtUyycs4UBoJzztS+h
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id j15-20020a25ec0f000000b00dc6e1cc7f9bsm1861295ybh.53.2024.02.05.04.49.03
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:49:04 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-604059403e9so42820617b3.3
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 04:49:03 -0800 (PST)
X-Received: by 2002:a0d:ea85:0:b0:5ff:7cdc:404b with SMTP id
 t127-20020a0dea85000000b005ff7cdc404bmr10903850ywe.52.1707137343380; Mon, 05
 Feb 2024 04:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-3-keescook@chromium.org>
In-Reply-To: <20240205123525.1379299-3-keescook@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 13:48:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
Message-ID: <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] string: Allow 2-argument strscpy_pad()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Justin Stitt <justinstitt@google.com>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_044908_462672_E2889B64 
X-CRM114-Status: GOOD (  18.27  )
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
> Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> optional when the destination is a compile-time known size array.
>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -78,6 +78,10 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>         sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
>  #define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
>
> +#define __strscpy_pad0(dst, src, ...)  \
> +       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
> +#define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, src, size)

(dst) etc.

> @@ -123,17 +139,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>   * * The number of characters copied (not including the trailing %NULs)
>   * * -E2BIG if count is 0 or @src was truncated.
>   */
> -#define strscpy_pad(dest, src, count)  ({                      \
> -       char *__dst =3D (dest);                                          =
 \
> -       const char *__src =3D (src);                                     =
 \
> -       const size_t __count =3D (count);                                =
 \
> -       ssize_t __wrote;                                                \
> -                                                                       \
> -       __wrote =3D strscpy(__dst, __src, __count);                      =
 \
> -       if (__wrote >=3D 0 && __wrote < __count)                         =
 \
> -               memset(__dst + __wrote + 1, 0, __count - __wrote - 1);  \
> -       __wrote;                                                        \
> -})
> +#define strscpy_pad(dst, src, ...)     \
> +       CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __V=
A_ARGS__)

Likewise,

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

