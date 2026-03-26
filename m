Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504110A88D4
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9olrJwKlMERMQc61vOT8vZB7QpsPZJixmRhhkJf9iI=; b=C34oLxVnzR8pOz27C3aCfkmXZg
	kMfYplF+7ahegYWmHisko6cJUb1Z1LXFzOdnUoPeCYFcry0eep/5KAOCkE0dHZ1pnLY6WILqmXqXJ
	5ijQr7YMCAiuL8iS3dYiskFb91mIwooaHXM0YcmYF74zlleC5gJQ387sv/xxVwpOnhW3Ek9/VTy8+
	QlMl9uEenJqwXatgtp7GNSjWzB96r3EIpOqtLFei3D0uGOrdJYknGZ0iNSSh3/4z/37X7BNbg7qQn
	fMy2dG7eZhgJWPGPRgxdwXTeJget1j4olxvsn0N1FwD2Mw4U4rvxhe1+KLPsxVHonuPeQJRoS1o2c
	KbbNtFZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5oHQ-00000005vI2-2hLo;
	Thu, 26 Mar 2026 17:14:00 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5oHM-00000005vH3-1kJj
	for linux-um@lists.infradead.org;
	Thu, 26 Mar 2026 17:13:58 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-2c153272250so152312eec.2
        for <linux-um@lists.infradead.org>; Thu, 26 Mar 2026 10:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774545236; cv=none;
        d=google.com; s=arc-20240605;
        b=eJavcKwk5D8HkY59RJ1ERdZHTfj2z8LswFRmMhGZUfB4PvKssu8tKDwuK88ug8xnVC
         f4KIKmVpR+sYiksxI+xizR5JEns+Fsk+Xl40Hbjq+QJw8+x/tT9joKbldrKcZMGIYqaw
         vPZknPl8ZNSJuxpGLsmn916KyvCqlgYlcQb161y0gcAs7Y3n4lP1qjVhBIllzMRTU3+L
         1mbBTYZz5DQ2VVKtrRPXcafAy0r2L2qkvobsa+dxXsinD7XlU3GKg1GM0z6LHwM9hLSE
         W2BrjbTf5lngZwoSN+AEK+bHBbPIuFPJdQZvDCggqMOU+gv6hG24xr+VHBSUcFRckr5i
         17Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9olrJwKlMERMQc61vOT8vZB7QpsPZJixmRhhkJf9iI=;
        fh=c0AHui4BpMA6X84ddQzQIlCixcsNMGsYHALciUt99Og=;
        b=TbFtS17hZM34iGudzzoXbwrp6wuBsfHZURWHjgV9ShcVQv3Z12aRa7Zs1K1soBSaiT
         Zn3ihvXWTOWlsMcjgRsHvsYScGpn4nJTkVRenLCuSbSsrDAmyBOnHCc/jMT7a6sPAKzi
         3d7A/prtbI3KNhJ//Dpcn/O8+QXQPi3MJcuez2ROd8nN1VMptKWjbJlsLFnTQrRI8rKN
         HjhgzBSTYjvfocVleI4cvxoXpSLwWoIUqQp/jA9efOcjppbQsR8YjAiXT32KNtenexu8
         4tKHpx9OnS89X9d87mmtppljYEpu+wdbHpPFQKQzVjB13RhiBvsdfLJpjMfeAgv26RaV
         8lKQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774545236; x=1775150036; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9olrJwKlMERMQc61vOT8vZB7QpsPZJixmRhhkJf9iI=;
        b=SIPCsbssMFgP7ugk68TbRsw5fX+PMhwz18UDM9KrjVTZR/O4OXc0HZHynbNSPlOQ0i
         xWK13yQtSi0DJUaFFFggGWkjVIPq9BWDaWXkY2Kx2qY6TZ7tdUgR9fRY6eJOtsh4nV6b
         GTWZLg9+f5WR6QOWoLlXcSsP2r2i+OHlciU5RidYrXTfjSM8XEez7KBLJrTxtNnDTTRK
         a2KxCQp6lBli+zyDTJslb24P52lAqhePxAvMEfm+i/I3+eBx+3tNBAXOIDkZi42YkEp7
         0ioVaEkhNUKDZi1EBue6AAiOd8pXehcLsjrP0UvpVTTSBv4EiLRutlSALzA1rdpaOvNw
         ulvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545236; x=1775150036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9olrJwKlMERMQc61vOT8vZB7QpsPZJixmRhhkJf9iI=;
        b=BbIOIZZbPGs7PBNOYPNSrmoQeNH2XWEaXGYNrK/fi14qXWXNEelSqgQbEfWBLH63QH
         YECRNHls+USCjJ0qtvb4gjRY7STaxcSi/tYmkTqc/pN7bwTUv9uhABsrLlOpIiVGxUT0
         3x5uuM3PVb/zbSIdxgfSJktoTyOUrC23L4Y47z8zq+WfXrJkApg3yUeZMf7ef+iy0hqt
         dO58knZAAcOZzGWQqULOjNA4AuSLVqKRkRjarXi/I9Jmxcrku7UOlNfdvgqCrtiQ+4dD
         aUcDXU+M0CEc1poYjZG4Tn2lg/DTzdDzXpwvUQDswdd9rM7CnFw6erpNO+kabJzMxTu5
         dtAg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Mqaj8wXh96FOF54cScPNPAenVqXJJTDsCzlxhZmxRedbnAVgWc/Xdp/XsHpnP2fVgm7qIFRcaw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/Roaskz8KRSxIQv+r+nwrje/RquZ2tSfEb6BkcwuQn3kLixLa
	V0ZZnLmX4uH+9nljFSpBWxKPJPFTZ5EJNHIx2Gmsdrjdz8CPA5g//Pn8CLvFeWS4RpAxmDUbAlj
	LHTdMd/947OhdhQLjHMVbA2lyHtuFQZI=
X-Gm-Gg: ATEYQzws4phmGwl3R/qc90Rw9ZonNgwIzFfbLjpFlXYAWqIuMP5XIvGKx5egqyRI9mZ
	2wNqgqx1kN0OeAS6p+ap/cD3QxLq2Ry4Rds3VCsDDZx2DMtv08BZ9raTQz0xsPpTqdRWkJMheIo
	x5VxvwLmCY2rJBjaHBTs1EtUFxOeo8/tQahx7ojIyEZpbMjRabdxYQHGZDm967FV2IZ8ydeD6wi
	ogATmM9Ed298ysrcaGCLLI5Gopcz2ax2cHD/YN9/EWZaZTQ6cnfeiarnpXppfoN14anfA4Dy/az
	7Vzo1aukfn3pICOE7cDiYB2ZN/ERq2xwvyCmPTttknsedutLtImvmcTMSkTU/KHvE3jSjBsP1GQ
	VQYZQSPpGvk+l2b5lV34Nz9Q=
X-Received: by 2002:a05:7301:5f8a:b0:2be:140c:bc2b with SMTP id
 5a478bee46e88-2c15d282067mr2407895eec.2.1774545235402; Thu, 26 Mar 2026
 10:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260203-inline-helpers-v2-0-beb8547a03c9@google.com>
 <20260322192159.88138-1-ojeda@kernel.org> <20260326024226.GB2302780@ax162>
In-Reply-To: <20260326024226.GB2302780@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Mar 2026 18:13:41 +0100
X-Gm-Features: AQROBzCjsVmkmyxhYBQlcnjNfjk1drusXCGXl2NpoBVYAfyx4urVLgdrjE0kdQk
Message-ID: <CANiq72kyFu4StTPbobkPBSMYxNa5T0uErkLj-6mRvwOquEsgSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, soc@lists.linux.dev, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, David Gow <david@davidgow.net>, 
	Russell King <linux@armlinux.org.uk>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	aliceryhl@google.com, linux-um@lists.infradead.org, llvm@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	akpm@linux-foundation.org, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, gary@garyguo.net, linux-mm@kvack.org, lossin@kernel.org, 
	mark.rutland@arm.com, mmaurer@google.com, nicolas.schier@linux.dev, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	urezki@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_101356_469242_48068AF1 
X-CRM114-Status: GOOD (  22.12  )
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

On Thu, Mar 26, 2026 at 3:42=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> I do agree with some of the concerns that adding an architecure
> dimension to this is a little complicated. I would rather try to flush
> out those build problems with patches and keep it enabled for all
> architectures. At the same time though, I understand that enabling it
> for the "tier 1" architectures is a low barrier of entry for getting the
> feature upstream, validated, and distributed to the majority of people
> that would actually use and depend on it, so I ultimately leave that
> call up to you.

Thanks! I agree that it would be ideal to get it clean everywhere, but
given it is experimental and that arch maintainers should likely known
about this, I think it is best to start simple first.

In fact, let me Cc the x86 and arm64 maintainers so that they are aware.

My current thinking is that I will add:

  depends on ARM64 || X86_64

and try to land it this cycle.

My understanding is that this will be used at least by Google, mostly
for Android (and mostly arm64, but possibly x86_64 too), so I think at
least arm64 will see some actual users on an ongoing basis, i.e. apart
from the "synthetic" testing I was doing.

> No real concern on that front but .gitignore has a command to run when
> modifying it, which will require a !timeconst.bc in a
> kernel/time/.gitignore file.

Yeah, that is the exception I mentioned. Initially I thought about
putting it in a local `.gitignore`, because local is best. But another
option, with a different kind of locality, is keeping the exception
close to the rule, i.e. in the global one, which has the advantage of
showing us all the exceptions easily (and being able to write a
comment for all of them at once).

I am not sure what is best clearer, but I am happy to do either:

    diff --git a/.gitignore b/.gitignore
    index 3a7241c941f5..3044b9590f05 100644
    --- a/.gitignore
    +++ b/.gitignore
    @@ -13,6 +13,7 @@
     .*
     *.a
     *.asn1.[ch]
    +*.bc
     *.bin
     *.bz2
     *.c.[012]*.*
    @@ -184,3 +185,6 @@ sphinx_*/

     # Rust analyzer configuration
     /rust-project.json
    +
    +# bc language scripts (not LLVM bitcode)
    +!kernel/time/timeconst.bc

Thanks again!

Cheers,
Miguel

