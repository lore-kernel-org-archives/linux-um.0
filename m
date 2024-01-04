Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FDAC47074
	for <linux-um@archiver.kernel.org>; Thu,  4 Jan 2024 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/veKMHUdNJ5SX/e4HlrsaFpg5vnXvc9Zdcy7jOW3gE=; b=IyHqed9NkhqYEjKhI2xWx7NBl0
	vJ+Lq7Yzv3wQ5gmWQWqbj5Ih1QtKv+n+oKvekftfuuIUxSnxbQOa/xll3jxJT4jReNGdnE70nraYk
	AlaoKw+PjKkZDbuCU0cE4FCz4KWe4DwdVe9d9pcrQSitCZBF05XpafT3gAQ/J3ILFBigZTcBmT10G
	1MIs9ywbR/1VclFrk2B46x2c7zc9r0OkbK6YPVuNtVX1iw0QReWVKi2ec2vQveUPW9ahf+E5fi0Ki
	0ZjlyC3D1B0SsLrzbGBELesRrPtedsLZJJCBeHxBJpI90t//YVGjh9aMw1nJv8Mxhq+svJuHy2N0n
	Khqx5MVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLUur-00FETn-22;
	Thu, 04 Jan 2024 21:06:13 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLUul-00FESb-1Z
	for linux-um@lists.infradead.org;
	Thu, 04 Jan 2024 21:06:13 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50e80d14404so1799849e87.1
        for <linux-um@lists.infradead.org>; Thu, 04 Jan 2024 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704402363; x=1705007163; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/veKMHUdNJ5SX/e4HlrsaFpg5vnXvc9Zdcy7jOW3gE=;
        b=N0Qm6sRzQPddAg/v5lnCCYto4Ug2M15ElQk8lpAL3uDpeILAG+m6YVz8Bu5wsFdwkX
         bFnRyd+cUOtba8B2tm57AFYx4Q9xJD/oTIIZJH98WPUia5M7YnO+egByd+oZXpWv/OOV
         DlhT1gianpmo4Lf+912MdwWjkXoFpWcUXKO0rLo0rKpoKUvzV5q3zM2/YH1nMidqqge2
         /COs9aC8D4trK7ko8IrKJ7i5vTwlEj9QFF+8HfGVA4Di0nT6JR3UCYTeepGs+OxT3AQd
         CrYcgcynpmEEppN9QAZE7aSdovXZ1cx0mTRCqsp+CmipaQzgtQigDPe5TQRKck7k/liB
         O3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704402363; x=1705007163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/veKMHUdNJ5SX/e4HlrsaFpg5vnXvc9Zdcy7jOW3gE=;
        b=D4/8l4wzUU52kt8ppyjqnoqxeimxlSUxZVzQj9a8IBp3xxiOnTIejQXWidUWDZkH/H
         d9QxebGQwaGNTGSkNO6t0vfN2ZWafKMv+o0SAopMEFH+wk7enHziKKh8rLFzjHkx7eRy
         TW6u610R1KAHTqsYvHdMz+94qJhhBZQo57YKAFn2IYzT65YMAgxHNYw02cGMYj3cAz+k
         agRDCbn+gYOX+pjJRUCVy9jZy0wG+aYpIgvcn8mJsiyz2ENccANaxQFvRaRwBk3NSpbw
         xZmwz97YuxCOJaV+k0ZpetFjFhQvVIRltlYZTvkWmFgfQsn9/rcLV2MO0HUDRKQ1T9fi
         WYOA==
X-Gm-Message-State: AOJu0YykJetv9L9H1bYz68F7fHhFOxEJV9V76wJau2q55WFK1HwxNnGY
	1k9gBi/3ALarG7A95fL8GRUVndh77ykOAeTfGUY=
X-Google-Smtp-Source: AGHT+IGmditBjxbHlfhLEurFcCQuX7DE//CxVN1uI+y5wR1YnHpg/cnI2Ro+FI+M2ClOMEKW4sFwMMrogmX9GUc8bfc=
X-Received: by 2002:a19:2d5c:0:b0:50e:b219:44f with SMTP id
 t28-20020a192d5c000000b0050eb219044fmr82025lft.1.1704402362938; Thu, 04 Jan
 2024 13:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20231006122717.3984017-1-make_ruc2021@163.com>
In-Reply-To: <20231006122717.3984017-1-make_ruc2021@163.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 4 Jan 2024 22:05:50 +0100
Message-ID: <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
Subject: Re: [PATCH] um: vector: fix return value check in vector_legacy_rx
To: Ma Ke <make_ruc2021@163.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	xiangyang3@huawei.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_130607_551434_71027EB6 
X-CRM114-Status: GOOD (  15.10  )
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

On Fri, Oct 6, 2023 at 2:28=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> In vector_legacy_rx, to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  arch/um/drivers/vector_kern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.=
c
> index 131b7cb29576..822a8c0cdcc1 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *vp=
)
>                                         skb->ip_summed =3D CHECKSUM_UNNEC=
ESSARY;
>                                 }
>                         }
> -                       pskb_trim(skb, pkt_len - vp->rx_header_size);
> +                       if (pskb_trim(skb, pkt_len - vp->rx_header_size))
> +                               return 0;

I think this adds a memory leak. Also, can pskb_trim() really fail in
this scenario?
The function controls skb creation and knows all lengths.

