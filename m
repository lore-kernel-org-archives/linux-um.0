Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5BEC4828D
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mJ4uShXGXfh9Kf8BCJj+oy4yCIeGo5AwZyFiWoh8Epg=; b=EtDT0fcC4gIreS+L01w+yx3ynX
	QHXPEDNrpXCXU/vUZlXspjtEXUjCK0xhsXl6mKkDxp0bXTM+NG/lNBFFv5xtSbYQ0Pjyi9yryJtXC
	rmDH1puohE6deC9HNSZkOJUnt+VFgAIdaCNf0USaUyCGOQkOmmR0EByNIXsb/A8SaqdEFYgNGdjn4
	2UN4EUzo7XgZM4wcNm4WNLp4Q2mCul1rs+tKIEDXxBdf3By+vGKdrMl98aE02Kmg24/OFVx+iSbmp
	3KRhwHK3BcuN44ut5q4qGFR167p+0xLbmjKX50+VsyXzYAZuXkobVdmUtiNfVPEMg9kdWMpSeebAH
	GysNvDDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyNk-00000003HaS-195m;
	Mon, 05 Feb 2024 12:47:28 +0000
Received: from mail-yw1-f171.google.com ([209.85.128.171])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyNg-00000003HXL-3HG3
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 12:47:26 +0000
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60406da718aso43599227b3.1
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 04:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137241; x=1707742041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ4uShXGXfh9Kf8BCJj+oy4yCIeGo5AwZyFiWoh8Epg=;
        b=EYMHmHiR1G82fvIuKvCC1fsn6kB2t0gm0W3OM4DiHEcMha71k8YjngvYUJPT5+jssr
         pfZvVceFpS43Q0+pyrthjJYnOKIEuge4ENX6PPuhuGFhLKr9FsVPeWP8GBGZ+51YIyHd
         nX/VI905WbBajX9NSfBH83gyoXVM9wFVWSYNXGfkKsH9tE+Xpm3JQk1BD/kyBjlyci0r
         ELpO9E9GWoiEVyzRHmuFFn07aLtNRUjV5LGituejXnE8ZJVKGDdWx+G2/QRjgdIcv/eQ
         ufJZfXL3ZDPKqC9hM6ZYzQRY11CJZAto8x+RCTcaZCmThyRhAti4lXykV5djeFy7YHk2
         KgtA==
X-Gm-Message-State: AOJu0YyOt4iBE6V4NL9vL7hPqu3nrcb2drR79A8fdgHpyAoS911Q2gRu
	Nq5N768LerwsqwFSBNW2uhShpxhFos03Sb+7bJGWlglSQgN3fcyPnm2qe1G84CU=
X-Google-Smtp-Source: AGHT+IFhq7WmIAltHY50jE63ySFhIvNgJy+cRQd8EeBGL9vGnxIWXf1EjE1P72A3peRC1akB2PtylA==
X-Received: by 2002:a81:5743:0:b0:5e8:995f:6a0f with SMTP id l64-20020a815743000000b005e8995f6a0fmr9112970ywb.13.1707137241293;
        Mon, 05 Feb 2024 04:47:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXixpO2c8yQAaeCT3DUQAtxscEMw1zS77hY1GU1qkAr405rlT5b+YDFAEMOO7RlQThaiMcm83y69jJrPTHh36+5QyIwGkewhyi/0QG0
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id g68-20020a0ddd47000000b006040dfa5615sm1930410ywe.65.2024.02.05.04.47.20
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:47:20 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d5206e96so3910845276.0
        for <linux-um@lists.infradead.org>; Mon, 05 Feb 2024 04:47:20 -0800 (PST)
X-Received: by 2002:a05:6902:547:b0:dc6:c6b1:b10c with SMTP id
 z7-20020a056902054700b00dc6c6b1b10cmr8530106ybs.45.1707137240297; Mon, 05 Feb
 2024 04:47:20 -0800 (PST)
MIME-Version: 1.0
References: <20240205122916.it.909-kees@kernel.org> <20240205123525.1379299-2-keescook@chromium.org>
In-Reply-To: <20240205123525.1379299-2-keescook@chromium.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 13:47:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
Message-ID: <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240205_044724_900536_56F01CD2 
X-CRM114-Status: GOOD (  29.45  )
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

On Mon, Feb 5, 2024 at 1:37=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
> Using sizeof(dst) for the "size" argument in strscpy() is the
> overwhelmingly common case. Instead of requiring this everywhere, allow a
> 2-argument version to be used that will use the sizeof() internally. Ther=
e
> are other functions in the kernel with optional arguments[1], so this
> isn't unprecedented, and improves readability. Update and relocate the
> kern-doc for strscpy() too.
>
> Adjust ARCH=3Dum build to notice the changed export name, as it doesn't
> do full header includes for the string helpers.
>
> This could additionally let us save a few hundred lines of code:
>  1177 files changed, 2455 insertions(+), 3026 deletions(-)
> with a treewide cleanup using Coccinelle:
>
> @needless_arg@
> expression DST, SRC;
> @@
>
>         strscpy(DST, SRC
> -, sizeof(DST)
>         )
>
> Link: https://elixir.bootlin.com/linux/v6.7/source/include/linux/pci.h#L1=
517 [1]
> Reviewed-by: Justin Stitt <justinstitt@google.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for your patch!

> --- a/include/linux/string.h
> +++ b/include/linux/string.h

> +/*
> + * The 2 argument style can only be used when dst is an array with a
> + * known size.
> + */
> +#define __strscpy0(dst, src, ...)      \
> +       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> +#define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)

(dst), (src), (size) etc.


> +
> +/**
> + * strscpy - Copy a C-string into a sized buffer
> + * @dst: Where to copy the string to
> + * @src: Where to copy the string from
> + * @...: Size of destination buffer (optional)
> + *
> + * Copy the source string @src, or as much of it as fits, into the
> + * destination @dst buffer. The behavior is undefined if the string
> + * buffers overlap. The destination @dst buffer is always NUL terminated=
,
> + * unless it's zero-sized.
> + *
> + * The size argument @... is only required when @dst is not an array, or
> + * when the copy needs to be smaller than sizeof(@dst).
> + *
> + * Preferred to strncpy() since it always returns a valid string, and
> + * doesn't unnecessarily force the tail of the destination buffer to be
> + * zero padded. If padding is desired please use strscpy_pad().
> + *
> + * Returns the number of characters copied in @dst (not including the
> + * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
> + * truncated.
> + */
> +#define strscpy(dst, src, ...) \
> +       CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_AR=
GS__)

Likewise

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

