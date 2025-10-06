Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BCFCCA470
	for <linux-um@archiver.kernel.org>; Mon,  6 Oct 2025 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SDCKn2qbtodUcRBoRw+ujzLtuCdD/rFo1KUv4Z7GG4U=; b=O/h0t22LO5tKIISPUHW4S5AUe/
	NSu2i6UtepIFAjX5lsVwgyFvsOB4nPfi56IirqmuEFi5WISGluIdJIvaPtPkUmGj1250/tlarvBUe
	zYqmXAw6I/pS9LAUuf7FciJybwCS0AGpZEDF3EC9yAur4ijPieUOSvt8t2CZFK7LLbeJqQhSxOKnO
	POgktCXxnhOed1xHYyqvBhRY/9tVfgOPynwf0l/TNOJ+JuhgSMGhkhVqXeWxRghlG5G1cH84Kmuc0
	x4Zki0ZVj5UI+0s9O1sm6EnWWnR9kpBv+GC4DMs/5mEw1kguotmzud8rVmjkWeJqxiB0hTDl7Czay
	kAaNZunw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5tAb-00000000sck-0IPf;
	Mon, 06 Oct 2025 21:55:01 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5tAY-00000000sbB-1dJ2
	for linux-um@lists.infradead.org;
	Mon, 06 Oct 2025 21:55:00 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so9936108a12.3
        for <linux-um@lists.infradead.org>; Mon, 06 Oct 2025 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759787694; x=1760392494; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDCKn2qbtodUcRBoRw+ujzLtuCdD/rFo1KUv4Z7GG4U=;
        b=Cc4UXl0fNrFk4qr0Cw8yKKc4fFQv5VbVENRLeW2in1iLC2fcdXkkSSYo5d0xVu8pDO
         PgEtfCb5wlaSx4vyexTrnxfT+4QSO+A5m+pIYTOrjdHvQcDN7T6FJVaP/der3z4PjXGl
         6wDsaZzYZlI2hH1Q0oM0LkDEimT9FLCkAd07o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787694; x=1760392494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDCKn2qbtodUcRBoRw+ujzLtuCdD/rFo1KUv4Z7GG4U=;
        b=NIyIyWozuMQ5+8BL90YtNm864QibpDSZV8CPe05dkoOVwPxCWZYWfqtriq871dySWE
         U3pB72wJc4E1McSfp53M8IvqyfDCH1VI14L4qjuo++/iOA+ejyT6txaaqyz9GPXrxOCh
         r0Dse4QRFf+lzSc6mKVVorHCqHJsjbKGsiDSxex3SlkDYJpkSnXbn5BUlz20XF3cvq8T
         /9VI3uK+WasE3e5l7okU41t01vVLOqN8UNE7CF4teOOqJ2va+ykgZdQR8z5U+BSfRmqq
         TYIGR9/a1vmTbt0dTEIs7pSv7k/bnbobppcwguJh/dneRb9K3dahOJVPMaNxRR9NIZid
         yaGw==
X-Forwarded-Encrypted: i=1; AJvYcCV3yQ00u2wveSWau0K6Dh+StQWcnIFW3zIxfpS6pTTwbz9IdnueGypsEnKAqMaUzsT/tge+F0YZqg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxzdud54uOfm8gz6UJBWyTzWTHfGbkLt9vQJSw9Y1ktegT4DQlB
	58k12WHa/LC69RPDgNpNDKjlEvI4N08aHy+yaJciaa6lxoZ/LFXvliGl8j402MvTRedWB/Hc5O6
	fHkCnuxQ=
X-Gm-Gg: ASbGncvDFxsW1BWaW4rrEgB0LGNraeeGGTq2eukKv7Gu8hwxvSetOJauTiGTwm1Mnw/
	hc6u9aKla3QKJP+fqIL3XUcXdwmkW7wEa0nsSfuiIxR1eGCfTng/qAx5saF5WrM9XdI+ropeYhI
	EYDyvA2G8FbFcOB34x+LZxuW624mOC6emtDJECSLVYuKN7tq9HXLC84jntPNEWlbpP0Malh8Wo1
	2vgk4YgKjDRdcRfURiqXS4eaAUnKAdJZwUlvzHOC8v5tzcqcCvcKfTQY3VbyQKxPACj7lk11K/6
	CxfajF1TU3W3c8BbxTm4n+irJNNFaafaOX1I4Sp7BIdq0uj9+yAHH5nR5sxDCjiScm1i8NQm2Ys
	ldzNyra/ETAAcqeNn+y6Pk9Ddnk++ZiG3lMPC7yw8t77DsKli1LUtCdAw9u6p+KZ6181gXs4oaU
	p5UcQZ2VCyxdX6nVWfs1C5
X-Google-Smtp-Source: AGHT+IHjz+PWJA1KXmCSXxWuTtmaYOM66YRMKRzg75vyHpCgtMZM5nOdcR3QsNlFsC5tSKG2KM+bxg==
X-Received: by 2002:aa7:d295:0:b0:634:a852:5104 with SMTP id 4fb4d7f45d1cf-63934fd13c1mr12084328a12.24.1759787694292;
        Mon, 06 Oct 2025 14:54:54 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b74dbsm10608386a12.11.2025.10.06.14.54.53
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 14:54:53 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso2946843a12.2
        for <linux-um@lists.infradead.org>; Mon, 06 Oct 2025 14:54:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmiaJ+T3yUmq4AdXAtglzmW93bBD3g8Yby4/nbA6COfDRkJhFHEJRsVGS0hAaIIHt/y8MqeOhYZQ==@lists.infradead.org
X-Received: by 2002:a05:6402:5191:b0:633:7017:fcbc with SMTP id
 4fb4d7f45d1cf-639348f1c5emr14975075a12.15.1759787693294; Mon, 06 Oct 2025
 14:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org> <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
 <9636431303ae3a8b24c84b885cfadcb963124232.camel@sipsolutions.net>
In-Reply-To: <9636431303ae3a8b24c84b885cfadcb963124232.camel@sipsolutions.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 14:54:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDNJjvBc3+nAH9jTd4NHwiCizaw+0ZN9VSCpzT5jRTHQ@mail.gmail.com>
X-Gm-Features: AS18NWAGZxnn0FJ50TTFvawTEJndCY266DQLf5nNwVGofZLyRQSE7F8xjpkpYFs
Message-ID: <CAHk-=wgDNJjvBc3+nAH9jTd4NHwiCizaw+0ZN9VSCpzT5jRTHQ@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Chuck Lever <cel@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_145458_717405_ADE5AB88 
X-CRM114-Status: GOOD (  17.07  )
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

On Mon, 6 Oct 2025 at 14:20, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> That doesn't mean it's between the host and guest kernels, it's just
> between code built for "userspace" and code built for "kernel", both of
> which go into the UML linux "guest" binary. IOW, it's just for
> communication between hostfs_kern.c and hostfs_user.c, which nobody else
> needs to care about.

I was worried about people having version mismatches between those two parts.

But if that can't happen then that certainly simplifies things.

> However ... it looks like hostfs_kern.c is using ATTR_* in some places,
> and hostfs_user.c is using HOSTFS_ATTR_*, so it looks like right now
> these *do* need to match. Given that, we should just generate them via
> asm-offsets.h, like we do for other constants with the property of being
> needed on both sides but defined in places that cannot be included into
> user-side code, like this:

Sounds good.

> (that passes my usual tests, if you want you can apply it as is, or I
> can resend it as a real patch, or I can also put it into uml-next for
> later...)

None of this is the least critical - the bits I actually reacted to
aren't even used by hostfs so we also don't need to synchronize these
(potential) updates with each other.

So it does look like a good idea to remove the hardcoded "these bits
must match" thing, but clearly this hasn't been causing huge problems
in the many years they've been that way.

IOW - I'll wait for a later pull request from you.

            Linus

