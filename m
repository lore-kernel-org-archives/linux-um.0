Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06C0F4610D
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8yk/BaeTksLn5Ogx8FpbgVk4TSQec7gWJcIZVnJOpI=; b=wG2e3OVKQHzfN+aSnddEs8R04t
	4/EgwcwUODwc8M9es6W4hMBxA5fc1phTL0L241MPhkHNfhRWOfNvarPpDwEcA9/Pdghv51Szf8qny
	OnJOXHNlqgjHDeTWyHFNT3j1ddY4yThixRXM6OWDcyNGTs5bv8yg8gDuAQYRvYC2XnWbPSgats/Wl
	w3hqLyo9d9iRMZcJKi2Ixp28HnImfwQQaCCUfx5Ea9cdKrvMe2tYC45xlALTwYn+c21gFMII9HDeh
	sF1caMHBViCkkEaIdLmLwtXaoS9wAzSENJeJGc3txDx54IXqSDMfgif5e+9uwtiqypXqv9gKyKhYe
	62uvVaPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fIR-0000000Gopf-0qK5;
	Mon, 23 Mar 2026 13:26:19 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fIP-0000000Gooc-0MML
	for linux-um@lists.infradead.org;
	Mon, 23 Mar 2026 13:26:18 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1273c690e5bso384421c88.2
        for <linux-um@lists.infradead.org>; Mon, 23 Mar 2026 06:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774272376; cv=none;
        d=google.com; s=arc-20240605;
        b=FgbH8JjxeV+52AfncpRMWaISI92L56D0MNTxCe4D7qHdo8t4+xiP0wChf7OY7VxB0q
         Xlokmm/Dazez9BsWJjcOrkhkxYiwti7fd6fLnqI4khZurBq2u7iHpenEyj3x4QICiei/
         IIUmzD3m1T7HlmB4k9m7ZuNUaw9Zxg8nMK7kD09AdaNMX7jUvIh0d3uIO9SbX0QZJd2f
         InFUWyUO2yZkNhzRNV8/n/dFF4gnnr11pitjvCbLwRQCxAzdEZeIHNdx/W0iTbEBSqm5
         HABuFR2CyHSwEq83JI2nduJuoAQSv5+UUL400vSNCca3RkH6bNbUMhU/NGSiCIHkRhSC
         v3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b8yk/BaeTksLn5Ogx8FpbgVk4TSQec7gWJcIZVnJOpI=;
        fh=TjeveNipzbs4OfZ+v0AYdsBz9G5b6aaxRCBg4bWqV3E=;
        b=Goh88tkHrKp7LU3nH/fqbfHTfvctvSI7vkr3xsxU2Zolh7YIlux69v+Rk0ikYeE0n9
         u65WqGmHk59+iuv0stg+14kmG8NUU62vxaeUKCCClSM66+qHZoztbfwcGcHYVKPlM1qr
         OlqDzUZU7qlC6CJ74hHWzt8qUzVLnfSMUMHroKfSWbDtERAlpdUUAn1/r5QG/m8GCnUr
         S5B9xem8xZOLagxFP9Fi06XYhGYQBpoO6UeOkmRcRpg7cJ794euibKcvAcvKu4taEmD9
         mvqgEg+e7LZqY+5VMPOZXsxZ+9N/VPCWerNxttd/y6zvzwpzaPbb5nZQzfKTFOuNzJow
         3ZSg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774272376; x=1774877176; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8yk/BaeTksLn5Ogx8FpbgVk4TSQec7gWJcIZVnJOpI=;
        b=J9iWb/1oMl3pB0nskBq/pKJ5qezuYcWMARHx3S8Sx6kxN7iNiN+Eb6XX5chKk8DZyv
         5sBvvcKSshNlmnMJScWk2pqoCos5Oee7tEHeM5+eeTOQj6CCZ8ES/c++9lu4EKlKxRQh
         RDWkTf4grslA7vTdSo3UA91zlS31VXAwvo4H7fbEeXHcpbYsSJe7NiuhG/LBjrqT55x4
         V/yFFLEzJYuaMw6Dgz7lj5ks9VvNfydUw7wwRqWLAkKlUxutuwH1AonoG0VXVt/1DwRR
         xuGC7XLy0qgFS34740UlVOErbvsJ9NaRaz5tnjqvcGn5M+DQim5oN6vePeJaDp6DuJFc
         hChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774272376; x=1774877176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8yk/BaeTksLn5Ogx8FpbgVk4TSQec7gWJcIZVnJOpI=;
        b=nrWsYKZJUzdLYx/fy/p/FksluOQKdt5bws6CLPHjw5Vxq9D+9VCZX6LDq5brCeSCrr
         XB6oVla1y/ATZTveoRQij2g3EBTHsNtjKhWsjkIDDQ4V/zNAy3vHl2uyXNWwyP4bucdI
         UszZ5SEd27Y/RiVt+hnRI1CAMVtW5J6CqFpew/TEMaT9jDhTZMbHjt9FG36OxanPRL82
         i4yLHBvWmVyC5RZz1KpDGxHfImrfLHWzSB3BMsv41GrdIPN7IuL7+5lgcOlx4HNZX/1M
         t5QaWYf7HMwuk9ykLhRDUPDwOyxR87zG0cx0UHgf7jBEV6iZK1iQojLM+O5bADrKf7OR
         jZMA==
X-Forwarded-Encrypted: i=1; AJvYcCXLEufq62YHZvtMyuMCzqSp6TSu8P9CDBITHXGQ2cLB7Wb1CJ/TUHIc46XYbm8xlUVA3YC4C/Z1pA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyIPQHOHwsLwf34Nly8u73aTNAOOGiNo1KrvqaPNk0brXtqjQ39
	N9WGF3jgs/R1rNU9CBmpl8syIFWE9kewX8zKf5s7jnIqv3IBpSQj19AAHb71BZTsYrPu0amzxq+
	lA+Y54sXr+S8EQuFfLPrbejYOrtBI5zY=
X-Gm-Gg: ATEYQzzBpPj4S/i2JlE3/j6MfSnPsOiM3Dtjnzpfgfo6tIuSGHHfv1apQ1XkjFbzIjQ
	vyw4Hke+VmrR6m25mH+Gd7NLtI0AWsrhVkSRBCQEcSEwS3QpwW7FVEqYhx10TkVgEKflVh9Ae6C
	fTYGqvd/+kjNVlPelulVlQVaJ5enQFtmjJz/mG1agP69EnO0Lkbc1KRG5M4Bqrj6VxUhLoPDzJZ
	B4C/qpwrExv85Ztxwbk880u9J7NPlWc7sfaiFz02P8o9v8b7NQjWD6wMxW5f24njn2L6kehmfGo
	76H+05GgFJeJIVv1kRwJhiMratGtrZg1+VLq7rXuCS85opkWajJbr2Gh8r99vFNWlcMcg7x0oZP
	QmhExsrO+cnTozE36ny93hZz++CltPvNkWA==
X-Received: by 2002:a05:7300:3215:b0:2c1:27c:758c with SMTP id
 5a478bee46e88-2c109938d44mr2298180eec.8.1774272376046; Mon, 23 Mar 2026
 06:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk>
In-Reply-To: <acEP7tl8pqFA3tK8@shell.armlinux.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 14:26:02 +0100
X-Gm-Features: AQROBzD3BkPQaIE4qxn0GaZ9qpo8tZ7H6ULFyxikznbiRv24VDJjkNXoA95umyo
Message-ID: <CANiq72=dh=jTORtmHfv3Z56qJoK4K-0Bpzew7CTYn1qO+sR9_w@mail.gmail.com>
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com, 
	akpm@linux-foundation.org, aliceryhl@google.com, 
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net, gary@garyguo.net, 
	johannes@sipsolutions.net, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, lossin@kernel.org, 
	mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, nsc@kernel.org, 
	peterz@infradead.org, richard@nod.at, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, urezki@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_062617_129770_A3585ABB 
X-CRM114-Status: GOOD (  11.03  )
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

On Mon, Mar 23, 2026 at 11:03=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Why is Rust generating code for userspace thread accessors for kernel
> space, where userspace threads are meaningless. This is totally wrong.
> The kernel must not reference __aeabi_read_tp().
>
> Note: I know nothing about Rust, but I know enough to say the above is
> pointing to a fundamental issue in Rust for 32-bit ARM.

If it happens outside this patch series (i.e. the new opt-in mode),
then yeah, something is broken.

That is why I proposed to gate this new mode to the
architectures/configs where it is known to be OK (and where
maintainers may be OK with it etc.).

Cheers,
Miguel

