Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7BDC5475B
	for <linux-um@archiver.kernel.org>; Mon, 11 Mar 2024 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4cb4wP5R1IVWpnMMZEZbpylTIidpKGZgRpSMKZ+Rgw=; b=gG4pet38PkmmhMYOkRq2PMTGAt
	YgxLnEJiKO9zTKFRZm52LXKj2To0mUkvGqrwJV0RPMZizxKPkB9pCJQC0Et7p+TNPG2uX1ZlbbvMP
	QHsQ41TwxxPlUKu748Uh6xk3lwycPWOwGOPQfP7twmA7R9mo2pbWPcikDpjd0d6qBeJzGKp1nGVo8
	2aZlIOGcACVJekICtcrk+R2EOYeZ8T+aAiWxuU/refY+QFl6HEkbO0HcZBOq0cgNMO37ZtARVbbY8
	CeSWIEH3lutdv3Aqo1HcF0IFxrgnWsQ5l7ef60qXUGcPz5Ac4mDXNnJuOxyTXAYm6rvlBj+wpK6EI
	eF39+o3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjawE-00000000c7K-13ZK;
	Mon, 11 Mar 2024 08:23:14 +0000
Received: from mail-yw1-f178.google.com ([209.85.128.178])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjawC-00000000c6w-2AEP
	for linux-um@lists.infradead.org;
	Mon, 11 Mar 2024 08:23:13 +0000
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a15449303so11535927b3.0
        for <linux-um@lists.infradead.org>; Mon, 11 Mar 2024 01:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710145391; x=1710750191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4cb4wP5R1IVWpnMMZEZbpylTIidpKGZgRpSMKZ+Rgw=;
        b=nEpFgbUk2OBgRVqSILazb5ZKyhheTBtm3B1NeIxj9pIEsI7wxB/5lOF3/sHmWK9V6Y
         Tj79wQI9ItrFGHKYx9IWT0qTKhd10wpwF6hfA+jWK+LKP7+Sn8hWvKZSnuUwK9eb8+HO
         AR8Krnm+wPE9l32iP/uE2KG7UiawB4rtVUEvbxoZo0YCzIPGCSu3EnlNirofoNpOSaWn
         todNIO7Lrs65U6OAhT71OYUB3X90rg4J+vpbW908AJdkbxievCNIUd0gTHt7te+8RiFu
         u6/JcHcrjy1qq7BpJOXCM5ftEky9b0/qKDksFm+iNqhHeD7ZXEZhsUPu0879ovTLtii1
         /d7g==
X-Forwarded-Encrypted: i=1; AJvYcCV9qpnQ6qtKK8CwBK50aIOhljBlx2EjplqtrLLuzeJyOxEwL3jSli3kI47nS59BewQWzGXIzZIVCBf+5x+UywMSO3EEcumGi4ITJoiZ
X-Gm-Message-State: AOJu0YyZGraVaVFaqq2SzUVqTPYvy/6la2ktEKY+h+k4GKd4EaFsuQ/d
	YpfLHCH9ir7LD5MWOa9WSyqLxKyWJyojeNklQMU9iRml0gL5yH3mOdpCOEOTc8Q=
X-Google-Smtp-Source: AGHT+IGxYwl2OpZL05y+l9FWysUAHQQgNWasNAH9lrjpB9rcc/GZvxy0tWaaywPEX3XW4E5vpJrcNA==
X-Received: by 2002:a05:690c:3484:b0:60a:2140:99b3 with SMTP id fo4-20020a05690c348400b0060a214099b3mr2298514ywb.1.1710145391466;
        Mon, 11 Mar 2024 01:23:11 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id g78-20020a815251000000b006098431a49dsm1213321ywb.124.2024.03.11.01.23.11
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 01:23:11 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6099703e530so21139037b3.3
        for <linux-um@lists.infradead.org>; Mon, 11 Mar 2024 01:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFvgxiHiG2ei2y+2JVl1QobmIDAQgPHkBTNuYcB2I0PjP2ToqNCphqZ4beYexzwXZXYyFUtrubIRahWHR8lPLn7oF8HxacVCUwYDcR
X-Received: by 2002:a81:72c2:0:b0:609:fb70:2a96 with SMTP id
 n185-20020a8172c2000000b00609fb702a96mr3743518ywc.20.1710145391061; Mon, 11
 Mar 2024 01:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1710056894.git.u.kleine-koenig@pengutronix.de> <d5222e85a8557c660d26df00138001e4907605fa.1710056894.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <d5222e85a8557c660d26df00138001e4907605fa.1710056894.git.u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Mar 2024 09:22:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV67gnbdatH0O0dL0mAm0eak=6NjHCJY84gCFH9yOcBtg@mail.gmail.com>
Message-ID: <CAMuHMdV67gnbdatH0O0dL0mAm0eak=6NjHCJY84gCFH9yOcBtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] um: virtio_uml: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_012312_567782_85F36752 
X-CRM114-Status: GOOD (  18.50  )
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

On Sun, Mar 10, 2024 at 8:52=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

