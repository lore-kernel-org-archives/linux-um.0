Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D2910A62D2
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3oU1ZaWY15KqHTdXghcWSWByFzglfTk9rdjKl+Mk/PM=; b=lpRj2NuETk/7Bu2uWkPeJLkfss
	4eMo40HIz3Cf66OdAqKo/hdsaoJUYtb0qmG+cSh4UNsHg6onSMRXu5wyAlVBTc6lgiXBAS/FzoS9j
	DYaJC7Gwtm8m701RxjLqGdywiG7qZLE7X1tnDw9+ElkfVXo8DVvn5WQeyuwlfi/zfUXMxE5+zTOar
	gGOybrmfLKWqYhcEhrqM7zYpfpcIOyIzW7EV+yLggnVbYKevDX+eQwtrVixwQE3gN+iCneZinzi4x
	UKmEPT3hQ2SBy1xB7GWB9rfsp2ge/VrFk1+6b5EL8Wb3uX/JNEu7rfu9I0UfOFpZ0pDWn5nPU3i2N
	5kYlOBlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5l40-00000005Zp5-06Uq;
	Thu, 26 Mar 2026 13:47:56 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5l3y-00000005ZoP-0p4U
	for linux-um@lists.infradead.org;
	Thu, 26 Mar 2026 13:47:55 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-2bda3b4318dso102093eec.1
        for <linux-um@lists.infradead.org>; Thu, 26 Mar 2026 06:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532873; cv=none;
        d=google.com; s=arc-20240605;
        b=O/KKzGV+zg2ZGYr55EDpO3iLw9yE/K04DV93JE4UdxWUUT+30UdDSj2T26cfhSBSEw
         pWwcw/POsyb/GDIliSh3s0AmpfU/VdQzwoUS/h4/XVIj5MrVRVBeUUrD1Jgnrxgxvz5p
         TXs0fRtzHh/Qfof+F23Ek3Z3mv8fIpKJzwVTz42YZpqEC7qb3Rz3NoUFs13APLTuKMZZ
         JisVkP9f7kzyWAymZko2KHrLdpQg6nLSvltrYLW+IwMj++pPW0MHU1tw2/YXktpHBVCz
         C6FhGb8k55SxvIxkWivOzSDgEV67TgVc42dUtlQNpE8ERfCgAwvosuycRj3MFy8I5Mij
         RcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3oU1ZaWY15KqHTdXghcWSWByFzglfTk9rdjKl+Mk/PM=;
        fh=KSbMaS4AE7RMN8G4eA7bR7DyGP75PnK1Bi0sJelSMyU=;
        b=FsrzepEyOBVICFNHEwCw9Mrvo3Pz9A7o/ew8ZV447SFtqzrfq8PbxggilvkVQllZhu
         XzX1ObnxxhN/J3Ii9gx9HzYAgspf1QnW0aUEY+OKqawOJlcBAssephW6Cc8X+YmkKyhz
         ddpKyFixSwKkVYJ/4gj7WvnigTZowojxID6JpLqy377JtADabwUiwx6lDaT5Tn9WvdAz
         He8Y+v1LfBWdZPM2vyJvBKN4HbjwYASyL8eK7mRTCq5z6CRTcGfohu2jPGs30D89PvgA
         mwZb3cWWwrVURUdhoUYiCri1cNETmU3aZn+/QF5g+fHc4wx7FVMqrz5znEzW99TuWxxe
         7caw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774532873; x=1775137673; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oU1ZaWY15KqHTdXghcWSWByFzglfTk9rdjKl+Mk/PM=;
        b=q7maX3FMPaZWuzz6ZpkFRjzb9BUPaVFolBYOxjQVSL+RNweT+3eBH+IYCzqM6f41zU
         t7cgVTXjkW2C4/MIJ0QMTSb+bGn9CkhNVtMPtLyA0LxUXTY36FNnQNizwUaSaBgl1Ht1
         T8du4AzlsV218cUYJApkpm0lMb2J7S7PTBiYtAAm9gSwCJX9XCNNRKsBmGPoIwkHGbUD
         I8JKIjmsR1uy01Du9rIkLPrSD6wQqmjbvmC3KzLnsvsbPCO9L80Tg41gqHoyaceJ13bB
         4cihRPwrC33t9fHg0p5LojZl4ZezMszfKABPQnlQW4GKYoqdUmuv7mTaI4sihYEFZXZ1
         pLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774532873; x=1775137673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3oU1ZaWY15KqHTdXghcWSWByFzglfTk9rdjKl+Mk/PM=;
        b=ZD082kBnxAsvnNXvKcTx1OPDw1nuHO5w4/LHugUWt8gduBi3ql89tCSDIIXggDmsRr
         fFIULN878k/HIXw1t60GniM8eYa7AY+SjFOqP5SmI9BdXkTITv4n6+MCZ4xOfitUuSwW
         MaZ08wURGc62d7kiF1iRqOIf4R1GHcX8X6j7UFkwutjvbtokh1bnHPjfwUJNQLUFvkEm
         6ZBqI8PuCd1tIiSwhk2vmuGmCPe6FrwbHJo8V/HFLPzAGXgySIidxsBQ2XkEBmpni/Lz
         4tlV42iGImQITD/tW2Vmbnou8uepnPPHiF3vcHOi0I0X6/z/UK4ZJNo5dxbZL6exK23t
         LbZw==
X-Forwarded-Encrypted: i=1; AJvYcCXbaTxZshCy1Jn2d+olWpGrPMDv83UkUOtB1IuLOOoDAqOJv+oZbkAJNWNMbIOIKfvqbf3jNohD8A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEns9IL3qal01qvSDkxP8Iqs7qqPE3udeiOw3RvYXQxoMLEDCj
	vMXQIw2FFmUxJf9AOzlc/VsYdEp4C24z0nx7JADc8vJmoIcVr4k+tHIUyeyKzm5Y1OqWiGP9NTe
	ntSomItYzJyMjCpZLvko42FxDVWRL0xk=
X-Gm-Gg: ATEYQzyrdy763AVXd1fOBOXHBgdKt9xfHOOpDSeFERCtBjpxZuQXPSal5fXjpqcP8j0
	oM97t0iLNiP3XDDNlufKwUlC4oTs874PiE0Jhow4hAEkH5WHZYWIqFzBY0w0mGZ87hGHLce6/sn
	fb4+5JnfHvwGl1H4td+WkHCJF8gZ2R04C/3RVeH1Ma4zOwU1hNEWanrCwpFDcYiVJb6ieHmFzBA
	wGjObMIy+XbMhuB71yJ8NLZC0hVdVhsetBimvAe7/cxQW1r6DGRwgyUuA45axwwVWmvH0X6c3Oq
	0BYxdXLIQKp9XFz3zqxIvJuN08xtPkAVYg5RGgNNAUP5Txu0AyeCfV9RbjKpGStXHWBHntxB9Dh
	WsmMi1jXkobxhQarkpVPBUD8=
X-Received: by 2002:a05:7301:5f8a:b0:2be:140c:bc2b with SMTP id
 5a478bee46e88-2c15d282067mr2176054eec.2.1774532872905; Thu, 26 Mar 2026
 06:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
In-Reply-To: <acUGAsjYvNvTEO92@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Mar 2026 14:47:40 +0100
X-Gm-Features: AQROBzCEnROF6sNSCO8peAhuS8KhaF6UHZKXXIBMm9aT2zIjtnika7P390Hajek
Message-ID: <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Alice Ryhl <aliceryhl@google.com>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, 
	acourbot@nvidia.com, akpm@linux-foundation.org, 
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net, gary@garyguo.net, 
	johannes@sipsolutions.net, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, lossin@kernel.org, 
	mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, nsc@kernel.org, 
	peterz@infradead.org, richard@nod.at, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_064754_226671_B202703D 
X-CRM114-Status: GOOD (  11.64  )
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

On Thu, Mar 26, 2026 at 11:10=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I noticed that the Makefile currently uses the arm-unknown-linux-gnueabi
> target. It should probably not be -linux target to avoid this? Probably
> it should just be armv7a-none-eabi, right? We gate HAVE_RUST on
> CPU_32v7, so we should not need to consider the other variants.

I think Christian tried several targets back then and eventually
picked that one.

Christian: what was the reason to pick the `-linux-` one? e.g. was
there something you wanted to rely on that target spec that you
couldn't enable or disable via `rustc` flags or similar?

Cc'ing a few folks.

Thanks!

Cheers,
Miguel

