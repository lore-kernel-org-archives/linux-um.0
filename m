Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C591DD116EA
	for <linux-um@archiver.kernel.org>; Fri, 28 Nov 2025 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+JX3XeAoPziFMJInK2Wsnqx3380N8ZAktDPiEBHNHZM=; b=c6HuRJd2V6dntZUGZk7pLdyJSa
	RX4SRhsccnHb49O2RHdgSlYqgY3AHPedCmLcd5RJzvMFBlHDns2aOjoDES2wXPBEvZkSQuK7v0bL9
	BZUTnKThNsaN4gHpWBILT1WTA5duluu6F8c6MXsAnN8NJ92vjzxamGxQGn790YqTi0PU/L7tHICGV
	F3s4Y5EsI7a/3+wz//IFCqfulNVzC1H/ATTBf0EFUQ4Fg4TCO5mEDeINm7NhxPn79PSukgdZuBGA8
	x6lzsdOUn5nj03h8KKeUyxzmS0C9Ye+6EZUB9v1z3w1ZSUqEzEaaU7lKazPbV15hbB1JmsjobbWzu
	RgTHNijA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOv9Y-00000000Fbe-2pCw;
	Fri, 28 Nov 2025 09:52:36 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOv9R-00000000FaX-3eNh
	for linux-um@lists.infradead.org;
	Fri, 28 Nov 2025 09:52:34 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-477632b0621so9259395e9.2
        for <linux-um@lists.infradead.org>; Fri, 28 Nov 2025 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1764323547; x=1764928347; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+JX3XeAoPziFMJInK2Wsnqx3380N8ZAktDPiEBHNHZM=;
        b=fCPswDYr2DV4So4q2GxekOY4G9yFpE1GMgSnO30c68zOYNSEBNlKurQevEZ90xhsGX
         f5HUMN7XAzor8+nRKPUnHQxEbDp/AkzYdqg3ZvhJFSvu6TVEi+6KbZLPqk6fiQkwW3cl
         bo+TlwNiM0c2EwLGcmqxoG1y0g/CNWOFzDct480pvd/esr4ApCUkWbGkOFQ68RF1qFyf
         KTV8kZ23sNNgDbyV49UKWaLg73ct7clCKteN+CInUKpzLoo5nzQ8Vz5WDdKQWUnYPNOV
         c7Oo9QgnhMjvlaNyeNkQQrSntVhl6+e4wpnmJOD8QO5aYeBZOasBFsEqv5K88kwS0W22
         Cmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764323547; x=1764928347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JX3XeAoPziFMJInK2Wsnqx3380N8ZAktDPiEBHNHZM=;
        b=TIVDQGcNMFkixLXG+oydlITQyNnKd+48iwkaggp+LZDgHelsec5lqHZNOQx+e6tnK3
         SKzZfMj7ipN37LwWec69eq/YJKfwIrdXXomRHZctT2JyD+EAk6BRy1YTm8fvpuYBrlLr
         /U4faMLlz8sRQtfSrzAio3aBhAFPikOnGHYrRiV1fjbLNFcgd2X6wK5q5s2XfGx7D0Co
         7Qny05MSo9gr3oa4iIU3v/bgRY9E1YctMkrSNDrPN8+rp2Pa0b4EUUvPLlelXnT1J7LA
         a/3AfbDBA+C+iDi2TVWFcXKlv48ZxVhknN3PAdeT1kYIFP6j7sxVqbbqqkMNdzi1TDvi
         Z+3g==
X-Forwarded-Encrypted: i=1; AJvYcCWvbHLbXulZTZCsiS0xNsEWwJBsrcfycIy+PhA9zYw4h2qWRwPddzD3GFyJrjqGAUK+UylOdrL6zA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6Baswue1crYeLNHiSzDHN0T1ZEF9vF3S/qTwG87gkealu//zQ
	uOH7uaqiWa4GofPvOxopzu9QFvp/5uGofjT+H23/AVN5JeBv6AweSwriWtjHJ4Dlnto=
X-Gm-Gg: ASbGncvjxSW0LZkRg7rWZqaDOmIy5vcNZ+A5IFTW/yF6il1HU7FeGeaFipOqcgP4HTz
	9rppjRC0PqfbBD/y2nCKPFglRKNjHsh9RFw+tcQSQr+GPJm972U6zWCnmHKFOtOIULji8kZumsB
	nOgXq+c5MdY/6ID9eB06gdj8HjkugeyBmjcp2C4Cu7svvqlZYqQGMPWBSaAAiShsIGE93csH83E
	E9Vyg4kiL+CWf2gVglh+JmTzwkUXGM3HVrFXrcZhxE/BqM17zv9yi65d92yqm6VyXS4aHOx8bGy
	cyfFBpculZc60k74kHiKR/zT37vh8dXhtxmilCe9QdQWSABS4hNAY60IXwCh+V+ZMU3G3wwL/gd
	HqWPmNny647SvSYgeuWWAHIC2HuF0Gyg/yN3G1brLRCYJbay1wZwaHBa1ogKHOTZcD4NwwF/dMw
	qmyLLeG9obv09F9XluImZXBXVDHW9TRKHt+2Kj/PYfnk9ydSehpsrI2X5OdvEfKCY0qmtKVw==
X-Google-Smtp-Source: AGHT+IEou8ioIaohphRX3g14Kfa+nakRPZ5lw4pW3M17hreUZfX39G6tpJPxcg2/gDvtuPOahWfOAg==
X-Received: by 2002:a05:600c:1f0f:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-477c1131db6mr263935475e9.30.1764323547239;
        Fri, 28 Nov 2025 01:52:27 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d365sm76381955e9.12.2025.11.28.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 01:52:26 -0800 (PST)
Date: Fri, 28 Nov 2025 09:52:24 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
Message-ID: <aSlw2AHo_AWzjH-s@aspen.lan>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <aShr0DZRmpDnL0nz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aShr0DZRmpDnL0nz@pathway.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_015230_128142_4D956328 
X-CRM114-Status: GOOD (  17.59  )
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

On Thu, Nov 27, 2025 at 04:18:40PM +0100, Petr Mladek wrote:
> On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> > The first part can be found here[1]. The proposed changes do not
> > change the functionality of printk, but were suggestions made by
> > Petr Mladek. I already have more patches for a part 3 ,but I would like
> > to see these ones merged first.
> >
> > I did the testing with VMs, checking suspend and resume cycles, and it worked
> > as expected.
> >
> > Thanks for reviewing!
>
> > Marcos Paulo de Souza (4):
> >       drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
> >       arch: um: kmsg_dump: Use console_is_usable
> >       printk: Use console_is_usable on console_unblank
>
> These three patches were simple, straightforward, and ready for linux
> next.
>
> I have comitted them into printk/linux.git, branch rework/nbcon-in-kdb.
> I am going to push them for 6.19.

I pointed the kgdb test suite at this branch (as I did for the earlier
part of the patchset, although I think I forgot to post about it).

The console coverage is fairly modest (I think just 8250 and PL011
drivers, with and without earlycon) and the suite exercises features
rather than crash resilience. Nevertheless and FWIW, the tests didn't
pick up any regressions. Yay!


Daniel.

