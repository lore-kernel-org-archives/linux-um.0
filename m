Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF81C4332F
	for <linux-um@archiver.kernel.org>; Thu, 13 Oct 2022 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G2JxNj7fJytTiwBj09dcBdUyPixzSlHRPDyes4/qNv8=; b=exNttR+sQlqd48
	ZpnX203i3hz2AwJMoCuvU6AY9JFC+C8a/qizx5PAmBC0sPe4409KZjiItx4PebZs8qcw3Ocxxm0za
	WMBAHc/iJ2GYRSuy9wnixtiQs3thi4jM367aLQ8R19569964vmyTn2k2VbKXodoYdd9gM/7jmav3n
	ZbMy8q9vbQp6/GO60ie2f1KQKTD96BEnJe/1MDY4boKdQOzYw3zbODhT1PJe5XYsXs/sGWwBoUKwK
	v5wYKAOdPrB8LyLEZTPegGyTaGQe3uZZlrjWjoZvqdrQ/aSd3PR8kHcuEWNQNUfBjKTN5EkVMSON2
	j/PCWrl94bvz7ACDZftA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oj3Fu-00CkQc-R6; Thu, 13 Oct 2022 18:48:30 +0000
Received: from mail-qk1-f176.google.com ([209.85.222.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oj3Fs-00CkP5-Kj
	for linux-um@lists.infradead.org; Thu, 13 Oct 2022 18:48:30 +0000
Received: by mail-qk1-f176.google.com with SMTP id x13so1020517qkg.11
        for <linux-um@lists.infradead.org>; Thu, 13 Oct 2022 11:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqw3Xc1RI1aNzc3i+VnzEPkUPQWCL6Lh8uyt8Pd5dJw=;
        b=A1qLmI8R2fl/2zJokcwD1G6d/SKHrQe/TJCReMjVefHWxJVn3SJZM+ilP1NXcUmfGo
         NRp29W055byZ5D1jbsXhIis22uYd3nqqtY6vS2xFdi6XX4rKDI3P2jKc2UQcX1ZzsnIf
         i1gq/TvH7oWD1s9AgRvFn+nvXWC/iAFzrLO++PJik7ya29ejIQQ0iz6AeRuoXDHxE7N4
         KUoH2omuec/03EVZ1SpnVGApGfsvDiPJh7s1vkKL2Dz4cZJTMGYXr1/2XL9Qh6R6+BSu
         q7t/rzx7jPxpPBIC265s5s2xcgUisPdtCpbXYC3WbWMnRuO6eHwaAjg1TtsWEkbyebX2
         J4tg==
X-Gm-Message-State: ACrzQf3Hzdo5+auZKpG9sxUjwDy5evxxSVZepTBxt7zKHKdWXKgdgPvb
	LakZhCZxJV2XDvnElXiyUluVyWY2S+hIqg==
X-Google-Smtp-Source: AMsMyM5ohssTBJ0h1PSrUx2DA+NxmXhvvx5t3XOHFshrXgkEjlu6A/dbblRkaGbFAzHVjLEuVD2E0w==
X-Received: by 2002:a05:620a:41c:b0:6ec:53b5:6eca with SMTP id 28-20020a05620a041c00b006ec53b56ecamr980853qkp.767.1665686905246;
        Thu, 13 Oct 2022 11:48:25 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id l11-20020a05620a28cb00b006e702033b15sm416621qkp.66.2022.10.13.11.48.23
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 11:48:24 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-35711e5a5ceso25679547b3.13
        for <linux-um@lists.infradead.org>; Thu, 13 Oct 2022 11:48:23 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr1243832ywe.283.1665686903595; Thu, 13
 Oct 2022 11:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com> <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
In-Reply-To: <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Oct 2022 20:48:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
Message-ID: <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Richard Weinberger <richard@nod.at>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	helpdesk <helpdesk@kernel.org>, David Woodhouse <dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_114828_684986_F9471CCB 
X-CRM114-Status: GOOD (  19.85  )
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
Message-ID: <20221013184811.B5Z2rG4MyiEL_yscad-XbzfJhRfYzDENFs-LZahopaw@z>

Hi Konstantin,

On Thu, Oct 13, 2022 at 8:29 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> > The first step is
> > https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> >
> > It doesn't make much sense to start collecting archives if the lore
> > collector hasn't been activated yet.
>
> The archiver is now subscribed to the list. Once we have the archives, we can
> complete the setup.

Thank you, I have triggered the export from Gmail. After I have received
the export archive, I will merge it with my local pre-Gmail archives.

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
