Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8537BC3DA7D
	for <linux-um@archiver.kernel.org>; Tue,  3 Jan 2023 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=67hYx/ld0LIGAbScF+ebRdeNTQd6t/zKiwsVCK5CLm0=; b=cgmql8RzBJCqpf
	UhpoGCTLJnXB6dl+fxIUtehaEHGK31rsvBPZ2qlQIilcI+ZERtVJCIIHdloMHzFOiUlbbxDPcgDkl
	LJkAnWpdbMk5Wp6AwaV2aJyixkxtXMWblaR3FLh6TRz1uFuVaA290Ny2U+olmNK+b3U11At3CGziM
	dmfNR7inZ98eEczy73saA77JYSXZLsOi+iZXpZlJAaZX5RtFOnbpp/GYW3Bwb+hcyMH011+YebZMa
	LZSs+8+U7OsIRIdR2ZJ0+v1o+42Kv2QW9n21yb0HwHLcjeNXb/7SWihtK0zcxiMXm+JtZACFIkufm
	gmsMP5V1XclG9fO0YJpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCcGp-0003Lt-Tt; Tue, 03 Jan 2023 08:03:40 +0000
Received: from mail-qt1-f178.google.com ([209.85.160.178])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCcE7-00029A-Na
	for linux-um@lists.infradead.org; Tue, 03 Jan 2023 08:00:54 +0000
Received: by mail-qt1-f178.google.com with SMTP id x11so23990971qtv.13
        for <linux-um@lists.infradead.org>; Tue, 03 Jan 2023 00:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZUg7BSCdLfb7gu4C1vCLOOqdWzDawUGvWzZumrI/zw=;
        b=uOtlUAtHdKT4+6RttPDggN1eniXbUOFsgpjLoeW6YTMfvnA4Z3esslbCMFZwyS6GB8
         duXjpeeXqCrqqVbCsBqkmfI49fIU3Z31rpdVIV1u6msx9Xx0nwMiGhR8bZUBCHfrj/tU
         cbts8jeqhcLP1CyAbAt/z9cE9VBoFMi9xAnxjSS8aqRyAVZXV12vgXWgwoAazFsi1lAu
         vvGo3tTL/jhmVh+2nOJB/xcSNAhCtnTJOeNFUnQ4a2Xx19pmm/++KNDMOLSTtVr1KD/A
         1JWAOi8p1GEm8HLArG++ptbE7mIthG401+ob3Rl/Fn0P8HZNfjRwKcRoGF+eTJjlQql4
         LenQ==
X-Gm-Message-State: AFqh2kqmjnPsFb8ns8z3OXEpaB2mRuFSRGuDa2Jc38kjublOLXY5DDB6
	WoL917n33tpvFeu8FH87Gm5E/bJOuZr4oA==
X-Google-Smtp-Source: AMrXdXtj3ttYAHli1KUgzO1gkQp6rPstOsPLartkwbc6NI4GRrBM5wzcnxHuk3SDQslTu83vnxuDTQ==
X-Received: by 2002:a05:622a:244a:b0:3a8:27b9:5e18 with SMTP id bl10-20020a05622a244a00b003a827b95e18mr69145627qtb.67.1672732848788;
        Tue, 03 Jan 2023 00:00:48 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a455600b006fb112f512csm21959835qkp.74.2023.01.03.00.00.48
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:00:48 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-48641a481dfso252869207b3.11
        for <linux-um@lists.infradead.org>; Tue, 03 Jan 2023 00:00:48 -0800 (PST)
X-Received: by 2002:a81:17ca:0:b0:46f:bd6:957d with SMTP id
 193-20020a8117ca000000b0046f0bd6957dmr3032644ywx.383.1672732847900; Tue, 03
 Jan 2023 00:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20221229075323.1394010-1-linmq006@gmail.com>
In-Reply-To: <20221229075323.1394010-1-linmq006@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Jan 2023 09:00:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
Message-ID: <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_000051_855970_093DEC5B 
X-CRM114-Status: GOOD (  21.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Miaoqian,

On Thu, Dec 29, 2022 at 8:53 AM Miaoqian Lin <linmq006@gmail.com> wrote:
> kstrdup() return newly allocated copy of the string.
> Call kfree() to release the memory when after use.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for your patch!

> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
>
>         parsed = uml_parse_vector_ifspec(params);
>
> +       kfree(params);

Are you sure the memory pointed to by "params" is no longer used?
"parsed" seems to contain pointers pointing to (parts of) the string
pointed to by "params", so it cannot be freed.

>         if (parsed == NULL) {
>                 *error_out = "vector_config failed to parse parameters";
>                 return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
