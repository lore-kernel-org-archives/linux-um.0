Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D401C636D4
	for <linux-um@archiver.kernel.org>; Fri, 10 Feb 2023 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kXXgp9vKtF4I4d2v99JLQuXdYEo0reCQuRE0sqU0rq4=; b=4GoiXOkqq6fRz8
	Q0tWbedyEORzcp79hqsuaFYJDJaA9r23eqQlFC12Ut3mb3Zmg6ZGs+S8c0jg/d4zFQ7S2q06URh2O
	IZx2k0ADgW7FUyrOQh1WEieJVmvOZq3gOQdLl34cjqqBRgdGHGBjVPexJd+tS8BWJREnx4TcnsrlZ
	v4NZhr+lRyPdkRr0qgDmGjmj8F4lCVj1xm9JJsHmoe+rIoTMzLd6UGFv8dxE8ZYb1D1jHxuxB9XEG
	K+X1RzGxab3077VwLrvqKwyhKs8YOTpFvIigLrt3ezsIckt7DPWv6lVreWGxp1QpGs7Bl++LC0ETn
	JCmy17/S7eewnUizF1LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQcPE-007rRE-Rf; Fri, 10 Feb 2023 23:02:12 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQcPC-007rQW-8I
	for linux-um@lists.infradead.org; Fri, 10 Feb 2023 23:02:11 +0000
Received: by mail-qt1-x836.google.com with SMTP id f10so7697490qtv.1
        for <linux-um@lists.infradead.org>; Fri, 10 Feb 2023 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxy6oaVvJpFGn4QobTdjEMd2Mp4o+TBw2jtDUOlFKu8=;
        b=Yn/aS/9/W+by0hMh/vUDMoofRWfuWl/oYiWHr7UMqVWVuBvNu4+h6Net/1xlnCBxup
         X6mJoMtRT1wbBV9GZt018WP78DM8rl78wAZmy8u1cXJdjhmlcl0lEPqdxJ0eFBjrM7MH
         TGfCYafO1kX/ZfaY31EQfFGi67MEcbwjReXpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxy6oaVvJpFGn4QobTdjEMd2Mp4o+TBw2jtDUOlFKu8=;
        b=IDjZqvgCXDlDLskxK9vOFrLui7Vn96NhyRYXrhGw5uggAZPtS8+vjiwJ9Y86sg516T
         xDua23YAQV/06RJp0w/UP2XOPbGHxc9E7TWWfZgmDDi3TcwgyI32zbJu+R1vOhMUwiNR
         oczN6BaUp5V0LCx5zX8OoHyWqWt6bxcCnrrTngwQinJ47jHOeMsaoXzKDb9wSYYobmoC
         /o2I4KbaHOKhlBGqME4MbjXyBV7hRb5Gt7E6bcOYfYRhuCsHbcmuZOhbuL/IInThbzCo
         pAc3hzWimFqrkKzAejvAfcUjYPyo51lW3FoDHTtXzXcf4pUPIlVur+NlcupSPNoz1pgK
         GywA==
X-Gm-Message-State: AO0yUKWUIb9oodt4l/4qQdInByAGLzbU32Lc7CrzFTcPDK+ybNdRncD4
	apNepfmC+aI4T340ObzB17P9LA==
X-Google-Smtp-Source: AK7set9wIzegqF6GJpscWy0InX0LwQix1er7eMILF4zgP/yeabs6kDd7jhLlPczpaQAz75RAKUmejA==
X-Received: by 2002:a05:622a:589:b0:3bb:7c6b:9cb5 with SMTP id c9-20020a05622a058900b003bb7c6b9cb5mr17478028qtb.27.1676070122608;
        Fri, 10 Feb 2023 15:02:02 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id c29-20020ac8009d000000b003afbf704c7csm4217364qtg.24.2023.02.10.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:02:02 -0800 (PST)
Date: Fri, 10 Feb 2023 18:02:00 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-um <linux-um@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	helpdesk <helpdesk@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20230210230200.gmf27ywrookqoy5k@meerkat.local>
References: <20221012191142.GA3109265@bhelgaas>
 <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
 <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
 <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
 <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_150210_300692_63872C44 
X-CRM114-Status: GOOD (  11.52  )
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

On Thu, Nov 17, 2022 at 09:58:31AM +0100, Geert Uytterhoeven wrote:
> > > Thank you, I have triggered the export from Gmail. After I have received
> > > the export archive, I will merge it with my local pre-Gmail archives.
> >
> > I have just sent my merged archive for linux-um.lists.infradead.org
> > and the old user-mode-linux-devel.lists.sourceforge.net (starting
> > from 2003-09-02) to Konstantin.

Better late than never -- this is now done.

Sorry about the wait.

-K

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
