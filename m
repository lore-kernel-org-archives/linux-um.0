Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144A8F46101
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBYCnrWUYKFuRRnPBj94PpkY2ZwRFNgR7IvcxQJbGJ4=; b=Y+k7JNVOCk5PYkeYaTMviUUoYK
	xJZoZgQfl2/l1/aFNT99Qi7sW4YJVcpfx0KIo8A9CG91wPcKiGp9f4csWF9ZxLBbKv1hFmnNDdILa
	+lKcJjeI4PGDFY/zHN87W4A/+DHd2aYNwfvwOoCe4v6iV501RauXrDgg7wCMDcwy7h+y1x8BzzI2c
	Cf8XmIm/HKxbqsFZJrPQaVSW48P6X+gzzgDusfWPHwuh/0yDYyLSH/a9ecO4nuO3s9J4R5WqNDADg
	2coFMSxxKwm9yiIOLnBfoZAXiOSSH2ecrf2g80oSgIXUjhdg7bmMEx3gqqwric1YDNTIMBDyXkImp
	Inx/R1Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4f6w-0000000GldH-1LJb;
	Mon, 23 Mar 2026 13:14:26 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4f6t-0000000GlcQ-2inx
	for linux-um@lists.infradead.org;
	Mon, 23 Mar 2026 13:14:24 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-12a70b4de9bso170107c88.3
        for <linux-um@lists.infradead.org>; Mon, 23 Mar 2026 06:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774271663; cv=none;
        d=google.com; s=arc-20240605;
        b=PITnevqPjc0Gy1NFafPf7y8+n+s6hj2BkPj6Ai2eYCKJj5zH/O6TMuxPR8A51ga/bq
         HIdBtBHtZ2/9DiRmd/QXX2GpQyEqZMUpHNGuysmpvlo0cnGdZfCwcqjM3LPlcnuNKeyc
         wsV+/4qHRHvZrlGDj5a8fF5tkgm0sHt4fRgMQiwoh4qHu2J7FAwt2jNamPewPoqjC6CX
         RlWlvIceUH52n1dioH4oLR5didmOVPEdaoE0A5WVd9x5zy/kixzxReq2cJ+FVEqI4SJd
         bL4AQ22HXX7W1vl8U/czqR8eZH91iqFXV6YOU1kjJ94OS2g/rVFgMhFIh1mcnNAYVA6G
         5ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BBYCnrWUYKFuRRnPBj94PpkY2ZwRFNgR7IvcxQJbGJ4=;
        fh=MsA3JO/FwEH838P0k3MwHBgzWOtR0dHGWiD/phwtbgU=;
        b=HTrBZdpJmJGufWKXQYNMG7HSGUUmS1kr0BCdn1KrBzrHRtC9wLUQ/Fqdjnm2SD/Kuu
         EEhk5oA4c5wzRaYhr9Eb6G7qD0DCPduCAbQeNokq/9o1mniVqxwMN66O0my9ELvqhfKf
         DimXbmsYF22eYH9jIP5Z5STJLYZ9ryUjYhcDnGMyLmAlejaaNU+OzYxzjEaDcKRkaHTJ
         Oe1RxB+h1KrN14YdAC3g8QVi1AO9IV+dRGMOPExwQMApIL0PQYCOx1IibuLwLSdeBOJ0
         zP4+TfzkUA6svLUaMQ7ryi4HXCkmhx7X8awX5Rl3TBQDOvsROuOGj8l6e5PDnV95OZ57
         AXGQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774271663; x=1774876463; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBYCnrWUYKFuRRnPBj94PpkY2ZwRFNgR7IvcxQJbGJ4=;
        b=hsYbLoo6PYF68UtZWpbuyiINJ1DyNsl3v/ib/j/F4Wwh8GMlboCazqUjFcj4jnHQNI
         RB6H1r/nhfDVTYfwUBSTk7XzanPtpaecaSX8+v9iaiq468DVr1MJrDoF2OJN+MFY5W0z
         ocUMAJk18C59Wd/5zUh0O4XngXjTpKtBRQCvSYkcw1R13yFH0zIa4tJV6Gv6O15uOVJM
         QEWR2xs0zhqpXEnzwBv7okSrbM99I2wLgjrQSUxsvDFcyC9f/S4qxvi0E9zlZ4caFsVV
         Ex2eMCOvgjWGNegM9FgZHnrc4LNsRF74swIB1KM8Y1PX1QkK52gv33Y5hE3zEJZO37+e
         uMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271663; x=1774876463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBYCnrWUYKFuRRnPBj94PpkY2ZwRFNgR7IvcxQJbGJ4=;
        b=k/+Ykn1oej8em6mVUy//6X0NT7EPbAzoMKkjLYIZ5jQmPQDX0jO+LHLbTpah/Gow8L
         kVEfFXCRODxJ0xZAOkhziq8IXOlA++BB0OEJcAVsLpXwPtv6FvsMwZ4AFfi7S3IveAyo
         zm84EuJR9J5ZoC0ZVkupqACPsmujbU71UYjS0YEd+UruQGk5QjavEQlcz8/xnSvSsNvm
         ElTtfxoRSsGwCPw1jpzohuoIWP6W2jOFXm4HDRpBRm4z+z24TSo4oBN+MjfpMiHmSx/p
         Nyw40NSgjozcmyRGlwWEhK8uyf9JRO9fOCfbDDkU5fxQnrfdLQN91Ee9IG9rtJSpJgei
         IF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVDIrLXo44Ih17zpKpZbDbOn/JsgT4zdDT5l4ul9jDTIcwpWhyNoYCcI8fHJ+nVBAxroFANQezWzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwE9zqowvT6rbDyMez0U0s7S4MR2W7kzsYKjVtFnoaYNGSLhnCR
	HxDaJ6U/YzL+RWYw12h4ZvnHSK73rG5uTQ+zbRWXjYaybiPr7Grp6i/QoPyxoDqkVHVoHBI9BtU
	lN620IoNaH++ni9wLWB6/rlv19z86Vkg=
X-Gm-Gg: ATEYQzzmhtreexDvPZtk/83zzzWhDZkxsmZWB7ZakeYbMJz7Yy3rT8PLyrN+1wb3Igf
	4QUG8duwBTwWY7vAMb4A+L2IXtucyb6q4E6IRMSCJ14zQFG1iZ8z6f8i8GmqNnWBQKYX5uJkTDz
	VUwDd76QYND/eDUpA9urBAqSNW1J7pUtPuD7DG9rgvWKJ7P/TaQqAejcrjns4y19ZsH09JvF1M6
	XyBDpC7Zm6ScLGyFIXWR5exl1rcRXoEwNU8r1vojIHsbL6cm5aT2PLfe41ORvuhErPK5uLG8BDm
	tY9uRKTPfOXJviUhBG/KetQcnvjOjRcKYVcfkdaYGGTGGusYBbAAeSikvld5iA12SZ5DH+fFeMj
	HNMraZh6MWsnrzvZWci01rLc=
X-Received: by 2002:a05:7022:f8d:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-12a726a9b6amr2560622c88.3.1774271662774; Mon, 23 Mar 2026
 06:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch> <CANiq72nwSWVDRqm0Vap5j5X5k+Q-wq8okQ9d3KUgZt6M4CpW9g@mail.gmail.com>
 <65336ad0-ac37-416f-b6ae-e691e3e375ae@lunn.ch>
In-Reply-To: <65336ad0-ac37-416f-b6ae-e691e3e375ae@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 14:14:10 +0100
X-Gm-Features: AQROBzCU6xTHp3fepOJZJySC8VZYOKbiHafZdHuv7S9AawfpKcVFscMWOGjChLE
Message-ID: <CANiq72kbp6cDnNsKb+rPHiEJzOa-EnvR2HHthM-VtT2GMukY-A@mail.gmail.com>
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com, 
	akpm@linux-foundation.org, aliceryhl@google.com, 
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net, gary@garyguo.net, 
	johannes@sipsolutions.net, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux@armlinux.org.uk, llvm@lists.linux.dev, 
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, 
	nsc@kernel.org, peterz@infradead.org, richard@nod.at, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_061423_686823_2644E563 
X-CRM114-Status: GOOD (  15.27  )
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

On Mon, Mar 23, 2026 at 1:55=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> The current proposed code for netlink needs this feature, because it
> needs access to inline C functions. Is the implication, following a
> chain of dependencies, that netlink would only build on x86_64 and
> arm64?
>
> If you want netlink on um, arm32, riscv, loongarch you would need a
> different implementation of the binding?

I still don't follow -- this new mode is opt-in, and only a couple
architectures (or whoever decides to support it) would be able to
opt-in. Nothing else changes.

> And a completely different question. Are there other work in progress
> solutions to allow the use of inline C functions? For networking, in
> particularly MAC and protocol code, anything which needs to access a
> struct sk_buf, a solution to this problem will be required. Do you see
> this "fairly exotic approach" as just a sort term bridge until some
> other "boring approach" is ready?

This series is really just a way to increase performance, i.e. it
doesn't really change what we can do.

Cheers,
Miguel

