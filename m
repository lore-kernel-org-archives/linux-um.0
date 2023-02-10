Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EF7C05027
	for <linux-um@archiver.kernel.org>; Fri, 10 Feb 2023 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date
	:From:In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jilFvTvvYCjU000eFSDvUSLDwdLMAljXeBIphSkDQNw=; b=RX829czE4e23Un
	Y2G2/oT1BtE3uXw6Uf1H9yJOF+B2rDcyySGvWov/u9dinHcm5mzk1Yt+XkwW4HQ14EPOmZlrF9OHh
	pCBv67Wh/PSMVaaPwQU6YLRHAyrbDzc0v49UWP3k9tdlno8lEZJarAoTYHtY590hNuHV3kPvuc1de
	AUCYeSJM55V+DCRotlxzJk1NZM08FVAA+GISWcs/WGAEEuvYcAyde+PHDW13378Njb/mtDDillxtE
	EvgOfSnFGLjAugRZYjIcoghJ2+725N4lEtD92SX98JR/yz5DpuEYOnGXmhpE5eq/ofkQ2X7HbIZcL
	hjdyHaKCoKVrmi9SLbgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQcQW-007rZW-O1; Fri, 10 Feb 2023 23:03:32 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQcQU-007rYa-Od
	for linux-um@lists.infradead.org; Fri, 10 Feb 2023 23:03:32 +0000
Received: by mail-lf1-x136.google.com with SMTP id h24so10616698lfv.6
        for <linux-um@lists.infradead.org>; Fri, 10 Feb 2023 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyHnnf/3a395Y6VbWgSWVCySKeHPQ91LfEys31ZaoFw=;
        b=OMeU61/9KOHwIMdT/y7NexOoz18KegR3vSNzghNfyaocwkbN2Jr/zV5igMwWwXuvaS
         Ovp0cRVCe2kZ3sXQb0e6SmnxrayydhsdOUwRj6YUf5RlWkex1UwPr7wqZbG5bE8V5SFZ
         weqQJfdjKyKFDYAbWebCDnEdvvOGsYV7liP3K/tA1r8UelChftv7cTVWeFJ91pmdViji
         8FqCztz3pNamJ5IHGWzVv+oF/Tfy18HDIfax52g5EcWQJD7f7Eqq0EW5yq/JjMa8MWzY
         v/unUW9H+eVN9QQSB/Zid+XPB+p2/9QzTrP/esalYrCnfk6oZUB805jsm0p9lCbRKYio
         Hg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyHnnf/3a395Y6VbWgSWVCySKeHPQ91LfEys31ZaoFw=;
        b=1CNBhoEpNJtQ3qbxSwbyNxlWSGoZyimfyLrZdT04NMzaa/HWTxCSZSzgAaMwM3LXzo
         0LBfJyKW3tQ8uU0+EShVHtVzJHpPnm9kov03Y8PFJveDQfbDFP+hLtm8daGOSdTRVV/D
         R6of26rz5UK1foZOIZdTAnHjIvXQZDDTV4nQMy8ceiXTIR4nIB5cHmjXqxuJGQ5nXXSu
         E+Xa10ERde/yhRlSyNXHgSxufIbF5oHFbABfziVLDkq+OcE+KpGUI6DApNeEbdkVlhzQ
         SR5Weuj1fwkrscfq25p929a4NQwYFWv8E1zcTmlKVvVGHBvxkBHmz6W0uErI8hf0mAI0
         8how==
X-Gm-Message-State: AO0yUKVnygWMSIRIQRjCGugyA43lJTKKbfy3uYN+OWx88sCyoBxtpqVs
	ym4ZQEcM03Ex9rekqKX1KuL3K821s4PTd65Ohak=
X-Google-Smtp-Source: AK7set+sdrnKwj7yoBbc10zW8S1rpPM29KZXzxJhIYAGXB6xqI02dKenLYsJ3nXtfzg0K53K/s16VOJRTXWNQaxWiNo=
X-Received: by 2002:a05:6512:910:b0:4d7:bda4:e6af with SMTP id
 e16-20020a056512091000b004d7bda4e6afmr2953379lft.184.1676070207118; Fri, 10
 Feb 2023 15:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local> <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
 <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com> <20230210230200.gmf27ywrookqoy5k@meerkat.local>
In-Reply-To: <20230210230200.gmf27ywrookqoy5k@meerkat.local>
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Fri, 10 Feb 2023 17:03:15 -0600
Message-ID: <CABhMZUVSX83+JyEqtoe1Y+mk_cNpBBs-8PxOBFK4Fem3tZyJSQ@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, helpdesk <helpdesk@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_150330_837860_2D97CF11 
X-CRM114-Status: GOOD (  11.90  )
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
Reply-To: bjorn@helgaas.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, Feb 10, 2023 at 5:02 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> On Thu, Nov 17, 2022 at 09:58:31AM +0100, Geert Uytterhoeven wrote:
> > > > Thank you, I have triggered the export from Gmail. After I have received
> > > > the export archive, I will merge it with my local pre-Gmail archives.
> > >
> > > I have just sent my merged archive for linux-um.lists.infradead.org
> > > and the old user-mode-linux-devel.lists.sourceforge.net (starting
> > > from 2003-09-02) to Konstantin.
>
> Better late than never -- this is now done.

Thank you!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
