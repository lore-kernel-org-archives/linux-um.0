Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6004C4332F
	for <linux-um@archiver.kernel.org>; Fri, 14 Oct 2022 18:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O7PF3GNZhAl6llgr54Ur7Ioe2A+r0P531qTrCuuyJZ4=; b=sn8uduHvOZwFcY
	9k0NFKPr4FP5josmczdf5TxzUmZ7XDF+vRDn5xjsPyi1Yhj5+ZSQ7sROhKueupg88TCBmIy6KioTZ
	G8hU/q804oUqtUfqR1TLlHyewfP8/IvibF/2b3MtOqA0Us6MqxFkrDGk9K/MKJKSBpHKWQvUTn9iT
	9AgRlKtWwjmk93yYWTrCs4rR6hj0PDL/xecfcSH5HcgImCWtWg/m5lYPYpyK5MsrE5OZhnoQKX7TN
	vVqMMWBX5/fg0PF9D/ORBakPaV2XX/ubzE9457KpZx4QTy3C9ahRZhuCLdrc1Ufru4ZAWyUs6LRVw
	xBnLuxXOTdh5RCAU565A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojP5V-00FbFA-Oc; Fri, 14 Oct 2022 18:07:13 +0000
Received: from mail-qt1-f175.google.com ([209.85.160.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojP5Q-00FbDB-Un
	for linux-um@lists.infradead.org; Fri, 14 Oct 2022 18:07:12 +0000
Received: by mail-qt1-f175.google.com with SMTP id c23so4172204qtw.8
        for <linux-um@lists.infradead.org>; Fri, 14 Oct 2022 11:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ch6qXOBT3Q0ocySQGQG2KLhZbSalwxj2bTbWL/3dxw4=;
        b=f4vHwSvm3jDZMBSfBqjrkRoC5uokHWV3+VTe2EIfPwjcaUxpk+xX3Bhweks83IALGL
         RqAlBb3Hdfib2GlQmaX6c0+LyI42bNevLagDX0wPbaDDFMbUO/kkik3d3UBP+7IA9OKM
         Yn9NtGH+IXM6Gj53wD/avAjDDgRnHqtOARaoVlTDQ06cncr6a7grZ95nhk5rsbwh/Ktm
         KIIysw2EK8nlM8z0d0nk8fUjodcV8375nV6bYkg7jLt9OALY7BrD+LT+LvTEtYcD2itz
         iBIP37x+BVPXB7/F+XWSeKF0PjSz/muDV1HIXI7gsu7JqRo5kO5DG//uAdpZ+4vXb4gc
         rQAw==
X-Gm-Message-State: ACrzQf3XUhRhibC3hpBcZ2n33DbZeXtPK6Ju2wm8bjayzVAcCn0BcTHJ
	H3S+L0PJGi5g2bwdXBea9+5HrFQP4N9kAg==
X-Google-Smtp-Source: AMsMyM7U/sWR9Ji6/eCFu0hwoNO73wEDPyHvg4YsHh7l4VnfK3GHh9ZGWBqpirRKkCac4lGQdcDlww==
X-Received: by 2002:ac8:6f19:0:b0:39c:c921:9ce with SMTP id bs25-20020ac86f19000000b0039cc92109cemr5307947qtb.584.1665770816978;
        Fri, 14 Oct 2022 11:06:56 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t4-20020ac865c4000000b0039ccbf75f92sm2423305qto.11.2022.10.14.11.06.56
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 11:06:56 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id k3so6492659ybk.9
        for <linux-um@lists.infradead.org>; Fri, 14 Oct 2022 11:06:56 -0700 (PDT)
X-Received: by 2002:a25:cd01:0:b0:6c2:6f0d:f4ce with SMTP id
 d1-20020a25cd01000000b006c26f0df4cemr5234242ybf.365.1665770815994; Fri, 14
 Oct 2022 11:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local> <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Oct 2022 20:06:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
Message-ID: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Richard Weinberger <richard@nod.at>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	helpdesk <helpdesk@kernel.org>, David Woodhouse <dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_110709_013731_1B0D3B94 
X-CRM114-Status: GOOD (  25.21  )
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

On Thu, Oct 13, 2022 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 13, 2022 at 8:29 PM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> > On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> > > The first step is
> > > https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> > >
> > > It doesn't make much sense to start collecting archives if the lore
> > > collector hasn't been activated yet.
> >
> > The archiver is now subscribed to the list. Once we have the archives, we can
> > complete the setup.
>
> Thank you, I have triggered the export from Gmail. After I have received
> the export archive, I will merge it with my local pre-Gmail archives.

I have just sent my merged archive for linux-um.lists.infradead.org
and the old user-mode-linux-devel.lists.sourceforge.net (starting
from 2003-09-02) to Konstantin.

If you you have older archives, or want to fill in the possible gaps,
you can follow the procedure [1] starting from my
linux-um-known-ids.txt.xz[2], and share the new emails with Konstantin.

Konstantin: I believe there is a bug in the sending procedure [3]:

    tar cf full-archives.tar dir-with-mbox-files

I guess that should be

    tar cf full-archives.tar ~/linux-kernel-announce

instead?

Thanks!

[1] https://korg.docs.kernel.org/lore.html#merging-multiple-archives-into-one
[2] https://drive.google.com/file/d/1d68UBC4pOCgQicz_a3vIsJAhDy9CTQnH/view?usp=sharing
[3] https://korg.docs.kernel.org/lore.html#send-the-archive-to-helpdesk

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
