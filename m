Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7491F4612F
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ow2cYCMn5EXbkFbtWklLmiMt9RKP3mI6kxfKs0fin8E=; b=rvBBHkhtN1VyYmzFAAB9EkyhG2
	bzGEw+ibC3hQQOcW0kFEoeJE3Iv3iyWED0sYZQiDDWpaPG0uTXPOCnn4j1NllEpYGheo2DtdlhZ9k
	bdWjhVviYRMR1fmuX1xEh2AvL3COTzF0CDois2H5gz1wevmxGlGSoMdX1MRTvRQ2JCS2OxCke3Q9m
	4G1buE4XJjmMINBdFnrb9T0un4VT/S0YEoUVCGFDUQE1RWZqbAgbYgGL6KM9Cv8kCHBP9khUI4YCD
	9RyXKdLWQclsyDTzKXPidp4EeWBtGs7ZBQxxKxWk4ok84Q4ocUWHSTMVwYqsETsotHu2K4SqjX8IZ
	Cy9T46XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4gR7-0000000GwTQ-38tp;
	Mon, 23 Mar 2026 14:39:21 +0000
Received: from mail-wm1-f73.google.com ([209.85.128.73])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4gR4-0000000GwSZ-2egE
	for linux-um@lists.infradead.org;
	Mon, 23 Mar 2026 14:39:19 +0000
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso15847295e9.2
        for <linux-um@lists.infradead.org>; Mon, 23 Mar 2026 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774276756; x=1774881556; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ow2cYCMn5EXbkFbtWklLmiMt9RKP3mI6kxfKs0fin8E=;
        b=Y+y4rPh/0u6JCBZoY+wjYFzmBgawmmrR1zyMO7cKGIBULUtMzIVQq+aHnRJuXTWlV6
         LDD2dcJ7xJ+A1D96gMOiL6xKeI7ZEC9MB4jQ+ytlHuIrPXbZbFQY/uzyBUQ9dIwbPAXB
         qQsF3LD2sM+xS4s5gjs3OXkZvlT0CktvU98w7yVQQfJAb9GCp9bEOTUh1uQs6IFHlkgx
         xz4nn/FdHwQAI+n2wiO1t1NHqpjve04ePxcCqNZEiwXO4jUS5G7glywci5pBLX7lkk5N
         cMkQDLQPt/WujZHXySJZcginIa/8nrt+mMZimv2x6N+YWoytTvf38wdT+QAkdrpR0lPl
         0Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276756; x=1774881556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ow2cYCMn5EXbkFbtWklLmiMt9RKP3mI6kxfKs0fin8E=;
        b=Vv54Fg4MFoJyfw4bXhIxmQLJSYc8RkbYakZ5p3XIW8FVjr8RCAmy2ZA1y/y6jcuRvI
         DUVLn7JZY7RH6OiJT6X54qxuSUf/mAPJ2kPIuCNPQOYWQoauzNnYHWas8ZEfk6z5ni/S
         y99FM/ZBKzMCGwxQtakzcwrb4mMZ6O+a6qF4hblSR7ExLCkVwZE88efp6BFHvM8I8S3/
         b1UOzAuAWW9UYq8teiJLY3cdMnJdhzXSSS3MVQAuIAsJ+HMZ4DBzjGxzrrdHYMyJZ/DC
         afiC3yD5AsbkJVTMGpr0mhjN4qXtxX9jeeano/Aru76vlhYmCh37fEf+IwxxD4vIWloX
         883g==
X-Forwarded-Encrypted: i=1; AJvYcCXAMNUD0IRcqSAG7kxXJFN80KlkbsfnEbSxL8kkn8EV+tBq4iwU1xC+A1rgSjK+Q8pgcyJrOjD5Kw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1MHeKB0j/i1PNVhToufKsADWYvIcPNUruHBQZXmdatCblyRID
	mLeWAm4gb+c7YaCqepG8RzuAMsJXn7ghDluFQhfrZgDCO4aQaAtR5C573bUPB+3Uk+LqibUVNUp
	aEQeq9fLjkHwNhnRa8Q==
X-Received: from wmbej14.prod.google.com ([2002:a05:600c:3e8e:b0:486:fa53:8cfc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a43:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-486fee0d52fmr164091435e9.22.1774276755701;
 Mon, 23 Mar 2026 07:39:15 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:39:14 +0000
In-Reply-To: <b5063e7e-9245-434e-9877-5ac7b45f4bc7@lunn.ch>
Mime-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch> <CANiq72nwSWVDRqm0Vap5j5X5k+Q-wq8okQ9d3KUgZt6M4CpW9g@mail.gmail.com>
 <65336ad0-ac37-416f-b6ae-e691e3e375ae@lunn.ch> <DHA6SE9EMEQF.1PKVHEG18I5FS@garyguo.net>
 <b5063e7e-9245-434e-9877-5ac7b45f4bc7@lunn.ch>
Message-ID: <acFQkuarr6bcOFwM@google.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com, 
	akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, 
	david@davidgow.net, johannes@sipsolutions.net, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux@armlinux.org.uk, llvm@lists.linux.dev, 
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, 
	nsc@kernel.org, peterz@infradead.org, richard@nod.at, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_073918_665784_5DC6AD97 
X-CRM114-Status: GOOD (  16.74  )
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

On Mon, Mar 23, 2026 at 02:28:25PM +0100, Andrew Lunn wrote:
> > > If you want netlink on um, arm32, riscv, loongarch you would need a
> > > different implementation of the binding?
> > 
> > It doesn't need this feature to build and function. It'll just be a bit slower
> > because inlining from C to Rust won't happen.
> 
> So it sounds like my understanding is out of date. When the first
> Ethernet PHY driver was being merged, Rust could not access inline C
> functions. The binding had to replicate the functionality. But you are
> saying that Rust can now make use of inline C code, but not actually
> inline it? It results in a function call?
> 
> What this feature does it actually allows inline C functions to be
> inline? So it is just an optimisation?

That's right, this series applies cross-language inlining to the helpers
we have for calling inline functions.

Sorry if I was unclear on the netlink patch series. I mentioned this
series because you told me that inlining is important for skbuff due to
performance (not for netlink though), and this series is necessary to
make such code on par with C perf-wise. But if you accept the function
call overhead from not having cross-language inlining, this series is
not needed.

Alice

