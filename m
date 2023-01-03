Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6722CC46467
	for <linux-um@archiver.kernel.org>; Tue,  3 Jan 2023 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lwqz4S8TYqjwqzdz5XpzzyOjJu8waUG4esGVQNBQ38I=; b=coVnwd/hLiTaap
	CGWRFUDa/S+dcPH5tUSLLGQeRI4k/0zaiNinFCdN1KEtvIO+5YFGE+cDXuxVWZzg1SDk3/slQpbzi
	CncNnvQSCVu63B/Pbh/VzKpQ+ZEg65QTkkfGG3HmY/pQDw+thrSrlxAh4HMImu789A0w4366+4RcV
	+rB1l+Y1gBora34AnSwdp3u3vo0/n8abUEu8exnYRQRob41JDppfB/9L8V69Pf+Yn6tubZwE6YYFA
	LGR0rENwCzVoSaFYINdzhvoR/ZUg39/Et1VwGkl124iBDUt+7pICr1MoCtggUENYXNzSZMSqsCnhx
	UotN0FjiS0B6DHXjHtSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCjrB-002mmQ-NG; Tue, 03 Jan 2023 16:09:41 +0000
Received: from mail-yw1-f175.google.com ([209.85.128.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCh0F-001Oae-BC
	for linux-um@lists.infradead.org; Tue, 03 Jan 2023 13:06:53 +0000
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3e45d25de97so434798237b3.6
        for <linux-um@lists.infradead.org>; Tue, 03 Jan 2023 05:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cg9NBeuSYbmn+DA79/KjX0RMB03P0+uV8JtF3hf3uM8=;
        b=fs4VXbDKjb72Jpeg4PnAbzen6j0Ncb22fe4hLTF5NeW+MmMZGCE6DxpzNaAD30V8L7
         CcYYq5XdeT9po8vFOUSsMl+Q4fzH9//fcSL3OEMoXh2uyOtHMCgxCAt8mesWgACrKCOp
         qUzpPqUdMLDKaQDMCfC1DyPJbVpJ0qdBRh3dB64Sy9XTs5SPeikED+cZ9jm1kxJ/iUIi
         kB22ftqi/dIYmBIe6B3Yh2egLLspRcCu4uZFTbj2n2pE384AfH+Os3cugkmN/TkVxsLU
         S3tpDm9hZxAlqNY0wZ4IXXybDkRA7phM1wSVgWbODvIsDk3fV6rMVDUx/wVlLvKBj4O/
         fO3w==
X-Gm-Message-State: AFqh2kpTbd9l9uru2Mv7Bm8YdGrM7auoq3odukAa84JCxdux3B3H0U0t
	Q8V3TahUqfElSPQg8MzWW+guoLub+biIiA==
X-Google-Smtp-Source: AMrXdXsQ38D5XUbYDKizCBvzyDNxe339t28aZEls3KHiqVPoFMAYOPZjS+yG/ClAZB/vIGCf0Ie2iA==
X-Received: by 2002:a05:7500:4205:b0:ef:b144:e90a with SMTP id cs5-20020a057500420500b000efb144e90amr1256381gab.68.1672751208377;
        Tue, 03 Jan 2023 05:06:48 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id bj4-20020a05620a190400b006fa2cc1b0fbsm19660275qkb.11.2023.01.03.05.06.47
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:06:48 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id o127so32990728yba.5
        for <linux-um@lists.infradead.org>; Tue, 03 Jan 2023 05:06:47 -0800 (PST)
X-Received: by 2002:a25:3143:0:b0:77a:b5f3:d0ac with SMTP id
 x64-20020a253143000000b0077ab5f3d0acmr2508697ybx.202.1672751207466; Tue, 03
 Jan 2023 05:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20221229075323.1394010-1-linmq006@gmail.com> <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
 <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com> <a098244c-fe15-2c88-5c02-59aaa6cc3c6d@gmail.com>
In-Reply-To: <a098244c-fe15-2c88-5c02-59aaa6cc3c6d@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Jan 2023 14:06:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYCsGDGeub8-mduNw45qX_tMr0sZ5oMNfJ_eqFnPgs4g@mail.gmail.com>
Message-ID: <CAMuHMdVYCsGDGeub8-mduNw45qX_tMr0sZ5oMNfJ_eqFnPgs4g@mail.gmail.com>
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_050651_450646_95E44926 
X-CRM114-Status: GOOD (  25.41  )
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

On Tue, Jan 3, 2023 at 1:17 PM Miaoqian Lin <linmq006@gmail.com> wrote:
> On 2023/1/3 18:28, Anton Ivanov wrote:
> > On 03/01/2023 08:00, Geert Uytterhoeven wrote:
> >> On Thu, Dec 29, 2022 at 8:53 AM Miaoqian Lin <linmq006@gmail.com> wrote:
> >>> kstrdup() return newly allocated copy of the string.
> >>> Call kfree() to release the memory when after use.
> >>>
> >>> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> >>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >> Thanks for your patch!
> >>
> >>> --- a/arch/um/drivers/vector_kern.c
> >>> +++ b/arch/um/drivers/vector_kern.c
> >>> @@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
> >>>
> >>>          parsed = uml_parse_vector_ifspec(params);
> >>>
> >>> +       kfree(params);
> >> Are you sure the memory pointed to by "params" is no longer used?
> >> "parsed" seems to contain pointers pointing to (parts of) the string
> >> pointed to by "params", so it cannot be freed.
> >
> > +1.
> >
> > I was just about to send the same comment.
> >
> Oh yes, thanks for spotting this. We should only perform release when uml_parse_vector_ifspec() fails (returns NULL). In this situation, 'params' is no longer used. Do you agree?

Yes, that sounds fine to me.

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
