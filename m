Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65DC48297
	for <linux-um@archiver.kernel.org>; Tue,  6 Feb 2024 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5SVGM65Du1cHuuQt3q8TxAhLq+zBG9N+zkQfXQrkH+g=; b=c0kS+noADAMlhzKegaOQL9GdoJ
	Ss6FObgW7ZUuUZlp2/Xg09BzbOttpwOhvvcfopurmpHrE5KsIXqwvSTf29IVS1lDOZQmJCAFnwsgH
	KzCWvY77Yy+vHGmb36TfQfQfQR810m+C377cnbBpy2R7yCfuvw8t93ueCVPleI1EdMEewfAuy4dZk
	q31t6HUqHmWPQSSQPfSdHU7g5HDQzCP026QAs/x3E+K6MnGih2aUuDlnEqUK+VNcu8RcEkrcoeSfb
	wfcEP3U9IURnW+eMY/uoFk/U/q8pKPi56hX1PX++snedfbgy1hHJwwFq/5FV1QQ+YoZtHws66ikcR
	5BjkjQ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXMyQ-00000007yyx-0GD4;
	Tue, 06 Feb 2024 15:02:58 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXMyN-00000007yy4-0pYd
	for linux-um@lists.infradead.org;
	Tue, 06 Feb 2024 15:02:56 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a359e6fde44so109650266b.3
        for <linux-um@lists.infradead.org>; Tue, 06 Feb 2024 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707231773; x=1707836573; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SVGM65Du1cHuuQt3q8TxAhLq+zBG9N+zkQfXQrkH+g=;
        b=TUT5tMKeOP+liOGDRWzsDnEbj3bfsKPH4JWBYVH1aXlVly2bmHlCvjc4wLVFiHELpx
         ShCFSRIkujd7KrnxZ+jB0lmxenVW2+1+0HBkIqgJ+EFcgvZ7uE1JOl1deGa8u0P+fDCh
         AkFPL6VSdYZJFAtD5zOiUWp20cD1LP+yQYRr6h6rO4z31UaVtmxdxg2fB4+XjuZwkpIk
         RazABDeaBfsd6KyDcw2idHbwTsGbXkPUHnA/USF8omCRwiMmtIcR0vF9bwM+kJLmVRqJ
         DW8rpXu2GvnhYwoJUf8H03xr63a+8mLBhi35g+jXv90haA3FFP8MBSYFt0n51yOkH0fL
         jb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231773; x=1707836573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SVGM65Du1cHuuQt3q8TxAhLq+zBG9N+zkQfXQrkH+g=;
        b=rkTzy/OenJUtkgUXLwdXMPu5xx/+uFV020EV9j64dslwTk0eshyphnFmZx/0qsHbXb
         BiA6QXgEL7+lC/slMQJmIHXvw5FqrK7fOxXS05ypeTBj8FLO02Ql3G2oxy8o4fkDTAPY
         /wVI2Dv/XGGQfVwDPOeI156+fEdtRJfNX89AOI7jNXE1Goo1BYnuP+k5nFAyq+y2xwFF
         BMf9hLWae+oNO9haVuxqhwiACT8W6gSXb07fsp98S3q4r/OPzzVpEO/dGxxLWLN+VV3u
         NgNnUIMKgJqcDs2Bb8fxF2iOFmfa0J2WQsZKkinf0C+lx1GHxF15td5rNGsuYwGj7FM/
         83Zg==
X-Gm-Message-State: AOJu0YxCGhHzMu4W28aBergNjpu6mtHNb5DhowliOwXRH1FiLjDFmHgO
	4Nsa8ePnvCu6SlGsw4rzmfonRZnKFkM4gV5hqnKxpLn9pq7SzNFuyNKCKDfxdPpZ9pSO13HnFHQ
	uuoD5Cv3F74GwEwjgVbEXhICpI8Y=
X-Google-Smtp-Source: AGHT+IHU9T6LL01GUecm+IvzzB70+L0tc5CbaFWmtFcZruG258wvuzAvviNNQid60Zhs0yhkTvn78d8ZDVK1MeAd5HM=
X-Received: by 2002:a17:906:b28c:b0:a37:b1df:30ad with SMTP id
 q12-20020a170906b28c00b00a37b1df30admr2400439ejz.46.1707231773299; Tue, 06
 Feb 2024 07:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20240206142027.make.107-kees@kernel.org> <20240206142221.2208763-4-keescook@chromium.org>
In-Reply-To: <20240206142221.2208763-4-keescook@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2024 17:02:16 +0200
Message-ID: <CAHp75Vf3c0Q7tV8ih5fRL6Bsjr6dhspFe+mxV7xUN=vZ1JdTKQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] um: Convert strscpy() usage to 2-argument style
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
X-CRM114-CacheID: sfid-20240206_070255_255186_26D7D95A 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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

On Tue, Feb 6, 2024 at 4:22=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> The ARCH=3Dum build has its own idea about strscpy()'s definition. Adjust
> the callers to remove the redundant sizeof() arguments ahead of treewide
> changes, since it needs a manual adjustment for the newly named
> sized_strscpy() export.

...

> -               strscpy(dir, home, sizeof(dir));
> +               strscpy(dir, home);
>                 uml_dir++;
>         }
>         strlcat(dir, uml_dir, sizeof(dir));

An (unrelated) side note: are we going to get rid of strlcat() as well
(after strlcpy() is gone)?

...

>         if (*umid =3D=3D '\0') {
> -               strscpy(tmp, uml_dir, sizeof(tmp));
> +               strscpy(tmp, uml_dir);
>                 strlcat(tmp, "XXXXXX", sizeof(tmp));

This code is interesting... (Esp. taking into account making a
temporary folder out of this...)

--=20
With Best Regards,
Andy Shevchenko

