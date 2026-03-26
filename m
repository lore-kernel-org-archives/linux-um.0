Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2BE10A88EC
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEHEk0yDT5R/njghDq/hVwJN3s1AoJzI3r+2gD7Cnqg=; b=SJ65WWyJ5b4pcA5XQhBt7reDhy
	vVZfWC6Y9Imex/Ga1jTcPfGLIeBu/h0CTTeJezXq9mrl3/uXjK36SADVHxsX/vJnGJwAAMNWZQ33d
	y+xQxSC68wVroJwRptqO4o9C0fzdq85C8VL4z69ClwBvmBSjSOWDmYE96UVKdvX/Rug/l26U0fs3U
	Vinpn1GdGxqFNJr8caaOXUKkejSIXJPHKJ9aYalaPS8pVj6hASIPbdHq3XTJ8crC/9aAVSEB5sA1W
	TIt1RyicDaDyzuVGlvRDmBelePNQnrgXHjyPWkitO8w4SMP3NwcEJfwSqYW6htjOY3+Jx1pT+a688
	h438HMXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5oXO-00000005wwK-1SFa;
	Thu, 26 Mar 2026 17:30:30 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5oXK-00000005wut-0PlR
	for linux-um@lists.infradead.org;
	Thu, 26 Mar 2026 17:30:29 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2c1650402cbso49365eec.2
        for <linux-um@lists.infradead.org>; Thu, 26 Mar 2026 10:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774546225; cv=none;
        d=google.com; s=arc-20240605;
        b=CFEjlt51mObY0VevUvFeI5xnFMcTR4K+lurUd7N4K8OYUa5r+/0Fj5ynQ9JN11e5rQ
         a4Yy1ZtNSIkzhXpjC/iMBY7InwFlqy6kWKZSebyAxtQqV31R2XUbMYltxwctwpYDWe67
         Jp3pO6Zj21PtUyM9wodZInCU/wCurPJ55id9jqSALrx6T7DATT60r1KtqXa7omUnyXNT
         eSbFdQU59AXOdRTBnQkntPE+Myoy4hPvMRmHi/wvjPfKIsJc5GmEAybxcNR3zV7OhABe
         Tp7npv0JSVW6vwcUsm1QYmfqRvqWb+wICvPoBVxEKyoWzf1m4CmFuskUQFw3eLfR5T9B
         lGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEHEk0yDT5R/njghDq/hVwJN3s1AoJzI3r+2gD7Cnqg=;
        fh=2YnHbQb+1CxPA/lfeo+SNm38GxK5Nxs8rmiBsVD14j4=;
        b=PcANw6D6Lx8QIbpcisRBdPmPNr5xhslNYKSKPFqhvKZyUsvpki4KDZvR+ViYDdATQW
         8douTDK+DbOuG7eIw18wiCXOmYn93sbjoVjToK08SLV5YQJ5LmoCFEshR9Hz1lU5d41O
         uFzrPJpj9+U37WhggBdwpGqZ/1Li7VLoq2qVcUNExQGovCwbZAG3QBtQT85zJMLvXwlg
         AtQBGeqI95hEmRjCgplx7+oqJRBZIoxr4Pr1JzVHqz48HCycj44Nj0KOidz7+EhTPTR9
         ZNwyAQSgCYdukINbf7DFEuPdOuHOOxTUWjzKebmTUxeXlKBRuLBOZtyDZapE4f7IoNJC
         WmHg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774546225; x=1775151025; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEHEk0yDT5R/njghDq/hVwJN3s1AoJzI3r+2gD7Cnqg=;
        b=M+UQ5ERWQ5g6bo+vymD6XmOkQ3zXgZn4HaE6gEesSShHQhR73f9la3AGq1A8haVxX3
         Q4lscoS9qvNykNh7mgr0pFCB/dayiT0E6W0e2Yf5xFAlq436mDnt124hMnKMPHppCBJP
         Csg+Xm7DAES8k3lz1vBcLsosjNynWl75GTJ8RklvHnavpQ4EGlVL1FK2rnffqTixfB1+
         pfLGMLtpY5quyoL5vMsG3OFfdUFVyAUulA+sxiNGQBn8QBKnCSlnA5MrpjfGJV/Vyq5H
         HFN/PbzlGtr7vpC7NhCONh2TlEUmcepBpJM56Mg5l0p4/6Ra8t1Fh5ETRodHlAcneCEB
         jRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546225; x=1775151025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEHEk0yDT5R/njghDq/hVwJN3s1AoJzI3r+2gD7Cnqg=;
        b=mLh8VI875ZuWWN58FJJEVzqSnGzuXNlkXyYq6ENYfwd+Ai3JIwUB/WJuFu4zacS4aF
         ONxipJ4xTnIThfkw8WuhNgWAKDd1TOkBXYOgxzkAFhhMY5CtZQ3ZxbMFZJo3ZaDOh8Qc
         U1Vi2KVJbftyHuHHLiaNex3M/7xlu0HTRszHvdPWAe6T0UpJyyYT9RbZ7WcA8LUwRD6I
         W3R71bIgIz1uwX+Dvv1fySMecQxX659vdxswJb2msWLoGQw/CGVHLZeckohJIXjMEuxZ
         6feqUIkJeIJweUeZPbv0tWIpqEp7vfVGlEGWoXA5tH2ei4aa7lyrVID/RQmXYRS4lYXu
         Qh8w==
X-Forwarded-Encrypted: i=1; AJvYcCUl9hvpC55Ym0aNmZEOJ6ZdvwXRbyOD/RRewrdyfGsXQbHkVzFVNLQJTD4YZJ1gSX0pfjRoS+9Q/A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyVXBuv/N838lZaADR+BIXKnN8Dpxo7YvDvoqZ+PUPR7orJSXEq
	xTPDrm0y23JX44v53jBoIqn746l3KBiuD/Z1DXMAD7yl5sbiaJI+2al+RIcbEpBi99yo03aJE+a
	bbn/hr57+L/11iNios5Ivm+AIlYKdfKY=
X-Gm-Gg: ATEYQzzdtYpn8js7wjdOpwW2u/eoQgMCA37yzAk05h/jeVQTAPZMcWPXraqUC8UFBI4
	0xi7Zs7PHzgyVify1B2Swcp7A5QxIc40LxZQpWpBE9Rz9Wu04ESFDbCNkwaX3Sy9RJa11OSfbcr
	Y9QDQhBr16G65OGsJYlwMxhEl9JVyPdeY7om1cATwD6DCgZGAg0ZSpjJmnuv2CcwdEfdmxPYL4e
	AJ/ZdzSIT+LhYyXgnzP5f3V2TgauaNQXU+8onavM+o0WK0huUiuiiUKf17efGyfLoAifj341c9g
	/ZFGb+TgfeAuDh+xzZvYisB+uHV1PfLqooyN3k3zMVYZbMfShLjFmOp/dx3D3pK8btEgG6Zrb6+
	/tFAqQEU+JSLA9g+4qbeNMM0=
X-Received: by 2002:a05:7300:d50c:b0:2c1:6416:2a07 with SMTP id
 5a478bee46e88-2c164162eaemr1927580eec.4.1774546224910; Thu, 26 Mar 2026
 10:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com> <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
In-Reply-To: <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Mar 2026 18:30:12 +0100
X-Gm-Features: AQROBzD8mk75r53XPOqmRDfmWXx9t0jf0bYbL_Ww497XzqV4mLKwGQ6QIr12vEg
Message-ID: <CANiq72=b+cr7Stxph_hXQTmD5crCvwWTqdaGKOJ7W1-66v4i_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, 
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
X-CRM114-CacheID: sfid-20260326_103026_386729_B21FD7EB 
X-CRM114-Status: GOOD (  11.01  )
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

On Thu, Mar 26, 2026 at 4:18=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> I'm not sure if this is still true, but I believe it used to be the case
> that the -linux-gnueabi target has one behaviour for enums (fixed size)
> whereas -none-eabi, the size of the type depends on the range of values
> included in the enum.
>
> Certianly, when Arm Ltd were proposing EABI, EABI had the latter
> behaviour, and I think there were cases where Linux used "enum" in
> its UAPI.

Short enums? I see `c-enum-min-bits` in the armv7a-none-eabi built-in
`rustc` target, and indeed:

    #![no_std]

    #[repr(C)]
    enum T {
        A,
        B,
    }

    pub static S: usize =3D core::mem::size_of::<T>();

is 1 for that one, and 4 for the other.

Thanks!

Cheers,
Miguel

