Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFAFC433FE
	for <linux-um@archiver.kernel.org>; Thu, 17 Nov 2022 08:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mEcjdgC6BGKRgtkU26plefJ31MTvFmpawoqCvYGxLZk=; b=Dgkg2F3+eM2eGe
	psGFdsvxnbEll90whqAyKHCESDn52RxlKYQmeXEhf9EfUzCqE7HAjlNVDv3C4NNGJ+KpQ2zxWuFO4
	pj61TcFOekX68cj0kzzZBwwoAItarxhsxrxBqoGKOM61fzmwe0kUD0W5EzuzRSe3w0vllVSJKlJEv
	Nd9Fu2jE8sy1ba5UVc+GcfSTgQCEV0ivgJqgKApwuKJ0XTQhmEKVZx6U6IsyNq3uGevVlmrCGv3/v
	PGvWhvfEFFXoYRLcsQmQ7QeaWqpedTcTv9NfsSUzz04SxrHVrCDGdQA2hWTg0BQASg9uH50/X1tqw
	w0U5zQkltpkYYjJ3Gt4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovajP-00Bufm-WC; Thu, 17 Nov 2022 08:58:48 +0000
Received: from mail-qv1-f43.google.com ([209.85.219.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovajO-00BueL-0C
	for linux-um@lists.infradead.org; Thu, 17 Nov 2022 08:58:47 +0000
Received: by mail-qv1-f43.google.com with SMTP id ml12so809603qvb.0
        for <linux-um@lists.infradead.org>; Thu, 17 Nov 2022 00:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsHL7FL7Xul8Q7EqXyeDP++KJ21Dqj5Fc5nxhWT+XH8=;
        b=wNGzDDU5VSPbT1O9ApRxgXlq3F6Tg9mQmb1H5c/hEo4G+pXpnMp8GZSvbfIjIOo8uK
         rpKVUubZ3gWd+uni7LRvRpjLAnRGt8tQiF90fb/BHkxkihXsG2xmYLM8DG5QtCr8R3MY
         6MSIeY0fBfJDNGD33P2XOkgeZlRbu/cRl25wV+G43XUJ+q1jJnzoO/IVlH/tTTq8r24+
         AYLKuR7OGmaLtKCTr5WmogvrzRQ7R/X5ftC/9oZL+SVQTXkkUlrRgdQ/ggqxjJ9BK62m
         VkHJQGryVQo3P6qSPQEOHATkHCwGxJm+mh+X2Wmaie3Mi5WvqDe7pnmRewKwyms2x5u1
         zv1g==
X-Gm-Message-State: ANoB5pmXZYYlVuUzBm4rZ+UBP6UCq31A2lM/VdzknvdOfxPqpvcLzEwk
	3q+byD7gk1ig1tRSD5QiezH0akR5m3pb0Q==
X-Google-Smtp-Source: AA0mqf7NASUqS3mU18xgXqOy3+rS4BW1pFt457kqO6cFaVbqX7+LAZej01mzeWSkIGSdGGpFfB1XLw==
X-Received: by 2002:a0c:eacd:0:b0:4bb:d68d:2744 with SMTP id y13-20020a0ceacd000000b004bbd68d2744mr1673106qvp.5.1668675523439;
        Thu, 17 Nov 2022 00:58:43 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id fa9-20020a05622a4cc900b0039cc944ebdasm74457qtb.54.2022.11.17.00.58.42
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:58:42 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 63so1114835ybq.4
        for <linux-um@lists.infradead.org>; Thu, 17 Nov 2022 00:58:42 -0800 (PST)
X-Received: by 2002:a25:4289:0:b0:6ca:e43:d9ff with SMTP id
 p131-20020a254289000000b006ca0e43d9ffmr1156718yba.543.1668675522199; Thu, 17
 Nov 2022 00:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local> <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
In-Reply-To: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Nov 2022 09:58:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
Message-ID: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Richard Weinberger <richard@nod.at>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	helpdesk <helpdesk@kernel.org>, David Woodhouse <dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_005846_076836_9E8F64A3 
X-CRM114-Status: GOOD (  25.79  )
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

Hi Konstantin,

On Fri, Oct 14, 2022 at 8:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 13, 2022 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Oct 13, 2022 at 8:29 PM Konstantin Ryabitsev
> > <konstantin@linuxfoundation.org> wrote:
> > > On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> > > > The first step is
> > > > https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> > > >
> > > > It doesn't make much sense to start collecting archives if the lore
> > > > collector hasn't been activated yet.
> > >
> > > The archiver is now subscribed to the list. Once we have the archives, we can
> > > complete the setup.
> >
> > Thank you, I have triggered the export from Gmail. After I have received
> > the export archive, I will merge it with my local pre-Gmail archives.
>
> I have just sent my merged archive for linux-um.lists.infradead.org
> and the old user-mode-linux-devel.lists.sourceforge.net (starting
> from 2003-09-02) to Konstantin.

Is there anything from us you are still waiting for?
Thanks again!

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
