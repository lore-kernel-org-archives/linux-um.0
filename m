Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD0AC5475B
	for <linux-um@archiver.kernel.org>; Mon, 11 Mar 2024 08:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4cb4wP5R1IVWpnMMZEZbpylTIidpKGZgRpSMKZ+Rgw=; b=PAtytwTaFRV9K4FdaJZATIEn5o
	lgMP92c3vjZbAw8C3Y7It/aJFhHaF+0LxunayiUdjnQapePJj3NM8lsy9fI9O2/0wdS5OlGgW9Xi5
	iearvYBfJMKxjqLOEsoX6kUbWYhhPVxylZi0Fj6pWeTqmoQkt48HT2lvZ7DaIvsW0kuGQLvybX2eY
	yBxRYwoEGnldSUCTrAu5EdMteF8UXT5l250+pf/Q3yDQ6v3baHjdHwfylDpVIuhciJziQRExjkNFi
	NrHn/hqS7VWrKij3F6KUfNsnriM9QHGA4ZwPlYW5vCO5HcOD0spHZ6pZ6hx4D7+VIaU68GGvXGwam
	65OqXO+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjavW-00000000by7-2iRC;
	Mon, 11 Mar 2024 08:22:30 +0000
Received: from mail-yw1-f178.google.com ([209.85.128.178])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjavS-00000000bxF-2qAA
	for linux-um@lists.infradead.org;
	Mon, 11 Mar 2024 08:22:28 +0000
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0579a931so22699097b3.0
        for <linux-um@lists.infradead.org>; Mon, 11 Mar 2024 01:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710145342; x=1710750142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4cb4wP5R1IVWpnMMZEZbpylTIidpKGZgRpSMKZ+Rgw=;
        b=QnpZUgmnWw0bANXUA0hBpFoTMZ/XQPUINQW5DiwFy4A8g3kYt12R6LNyH+NXqYoU5b
         mh8/FWNYdfx8TB0SN5SUzpSUy1N4TewibZU1Zc7sNlzBy0VMSAVmPVkb84drJnvvLW8s
         6s4wEQmw+w9nP+/ICKIerVmiaKnQge5juT2L7H2NQXhBvNEzPdBXUBAZDPbqitolm5s/
         pIxuGlYuQBn/BxLgvYrNQA+t0YcmhjWCgipYWKYoVbLC3IVIPC69nb7FFDVKp66ZlK8g
         vKCAyiljF8n+oqzwekOueOwo3QA30BsrQUpSnuP7lfImjQSdnne+QkhJqgYPzgtTi194
         keSw==
X-Forwarded-Encrypted: i=1; AJvYcCUu+7NKAFxgRAEb9ysqz5I5tM/kFgYxCPWPd6FgB7hLOcSErnDTfve7twxUZeYyuupQTpUQIjJdcuGS2ivNVc7tE/XQAZbKpgOJzW4k
X-Gm-Message-State: AOJu0YxIo3qlpXMdMCs5tkRHKGY0Wkixvxb0cu6AZYb4Mgm3u4sK1SlC
	EbMUNRMlQTnWXnOgVaMqiI6tHMgDcCZ6AJZuB7M/2Qek+g9OJyE72y4D2r+pQm8=
X-Google-Smtp-Source: AGHT+IFaYhpoWFGVGUiXmQcb9U6fDQ01AxfsQjeb34uhjsThrY15/3XnxGfPxc8bjw83vZu4UFihAw==
X-Received: by 2002:a0d:c905:0:b0:609:c40e:e51b with SMTP id l5-20020a0dc905000000b00609c40ee51bmr5014624ywd.7.1710145342391;
        Mon, 11 Mar 2024 01:22:22 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id g78-20020a815251000000b006098431a49dsm1213117ywb.124.2024.03.11.01.22.21
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 01:22:22 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a068e26d8so29463877b3.3
        for <linux-um@lists.infradead.org>; Mon, 11 Mar 2024 01:22:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3m1v/uEEWZ043zV/HAch2VEo0b/uELTYTzbPy+E77gZRYMqwMEpdy7sFRsAzh8oY1TZIlfhODaXA9OS628kqB0Nsvz0o06LSsXHZr
X-Received: by 2002:a0d:c204:0:b0:60a:3e37:56a2 with SMTP id
 e4-20020a0dc204000000b0060a3e3756a2mr1417345ywd.8.1710145341818; Mon, 11 Mar
 2024 01:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1710056894.git.u.kleine-koenig@pengutronix.de> <3efc2ebba6837349765c7cbcf14ff6147e696e5b.1710056894.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <3efc2ebba6837349765c7cbcf14ff6147e696e5b.1710056894.git.u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Mar 2024 09:22:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX8LiO=vZtyLhGo2=AH5RFyBhJ_Nxp2TV3rzbvupPGksA@mail.gmail.com>
Message-ID: <CAMuHMdX8LiO=vZtyLhGo2=AH5RFyBhJ_Nxp2TV3rzbvupPGksA@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: rtc: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_012226_867585_C64E746B 
X-CRM114-Status: GOOD (  18.60  )
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

