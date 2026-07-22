Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF0BC44536
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MKJgI/Yhov2mqhQxwPjaKpZky4aA7xI3VkkK64c8ZeY=; b=CZRmPp1/SxciZ5u37OoJ9NaYHb
	xkXV4MuH0j0t6g3ys/fiCrqvf/VwlEIjJ8sB9apiNUa3N8GT80RyuO7/VTFODUvJNas6DuMxa5I9k
	sOYa/mwUvnWZDay4OF6kb/L33bklByvF8kcoQPOobLzQaWA65w5aESXHpM8k6YErgJW+IvWs6rBLj
	nyusdMrZQLPtNKJareoQwfQb+O42/K8RAuI2Z8Mzwo+eHFmuiJAaM4ueYW8P7SavwO5jFh5CiLpPz
	BzYH+qu6DM3qLwO5o1XWqE2iGydHK9lPRphq3R9RhWjoSv0Q3FsBgE06glu1JdhtGnnVV1PzhERGj
	sCrzktQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeRO-0000000CoCW-2plT;
	Wed, 22 Jul 2026 21:25:22 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeRL-0000000CoBo-3TjC
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 21:25:21 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2caced6038eso89301415ad.0
        for <linux-um@lists.infradead.org>; Wed, 22 Jul 2026 14:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784755519; cv=none;
        d=google.com; s=arc-20260327;
        b=IQIvdd5vBKp1bC/BBlcdeOTyR6cFGIduy/Xk37iMIfHrQDEGxEhiLNKblGDeDLalhP
         IGLahMIc8QbsJBJBuqq3wDoJnm3S7KEWrjnbEyvaveDPJXTXy7o13c3k5ZmwqguMkF2U
         fAz8mb3aW+rJc4+ac02EfZ0DmQWvVWv78SWtCO1kPvU59Pe/Q//1JB2gODqMb0HgLeKg
         rsCyj/QD3e+Ib9sw00g3S3wZyY2uHPYy+FZZgeKLQBtTvDmhATxcAXWb0XCtL7ITDE6k
         m9o5LDNOt7VUV9cA7ZAJP3V9vROsTqqic/Xbk5BHy354t/9uw80jCrYzs0rfHtiTcfHB
         aAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MKJgI/Yhov2mqhQxwPjaKpZky4aA7xI3VkkK64c8ZeY=;
        fh=wZfzr+tjSxYfQglDh0u2cjZ00K9q3LzTsmJ9oHUhHjU=;
        b=C3P21y9tpyeRbhpiybOlz5JKBNF6Zz1z7nbZiAJ6k1U/KlmQK9TKd34EgzXeY7FnvP
         /G5Bzw4UYxMhzob6Ik2sG3wcLTcZR5cwGcpQksmfDdDXROTnxl6D/9nOwrmNtBzzmELv
         hs8H7l4/n7F5pT2r3Pif6gAJs9nKgkNnd3PF0dC5B4FD5pi4VP9iNGPFdegkt7qEbGNh
         b4x1a/eV60380HC2SF4Vp8UlvpF5woFVl6sAymSeoCkB5qUR15/CkIZQuEMNz0w2sazi
         RTEnDv7xl5MzqhW2DJFuYgPsPADu+Gj+rff/MHnbkeG/3anLk7hBUDD+e+NuqfZEPOnQ
         VbPA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784755519; x=1785360319; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MKJgI/Yhov2mqhQxwPjaKpZky4aA7xI3VkkK64c8ZeY=;
        b=DbuxqU+zd2sfe6eKJaTCngnL8O3+zwUE31JbrxjYzJfJUXSFxh+9b+UavHEJO2vCz3
         Xuoze/cIlRun/nY1dyF0mYQUaxuK2BQPtPPDIGZwTb2iu87d6KRYlUA6t/jDI26JNo+1
         m7kj5C1uIzGeUkDGEcyi4ky85H44ole77os0o3LbxMyL6JAmk3q5LgZwWVF6BKrMbkWP
         J+/w50N8GIV0r32HpyjeTEPJaXWCy3lUDSNh0FdWV97Th0B89Vi9nc2/vQ8AfjFvHu2V
         sGbBRLIK+AcwiKGTzHXMzgcmNKcxCBM6VVg2tv5ftY+y86Bu2AprXoWL8eKA7EDwssE0
         IYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784755519; x=1785360319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKJgI/Yhov2mqhQxwPjaKpZky4aA7xI3VkkK64c8ZeY=;
        b=AZSMQD1Fawzk+S+rNWHUWXNo5EY2m/4KKbLHXcurGL2g8f1k4pqRjzGBoMOfmeww+n
         ePolaCyauYNXqfMHe++TbK2z7m/vsU/Ps++LE24oLLwOOQc7IrHT7A+xr1aP6p5EhCa1
         Hii6cyaTr956gw6+bDUb3VaQX6/HqF+UuBat6RIMlXFbzTgP3DeJf+632bt+nptPl0hF
         J/Mj4b8eKdp1NxepKty/EPgjZORWP2iwS27hAwx8EIjG3ZkStsqXECXz1FbcZrLatiXu
         zQFoKqODTlarPhKWqMyLUIsXY6GycBgTq2cKpKQ7Kw70nr6HsRZKAFtT+bfhXBGvSJlT
         UqIw==
X-Forwarded-Encrypted: i=1; AHgh+RqZtMLdYOooGGgKW1N8QwmGRQL+jNA+tbfr47R0yg7rOH1RfkvrFOtpjaYR+AUURxGfI7xm669iXQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwM6JOMI1BgH8JMPVmM0wnOw2aKMbKeB9fBihHf9sSXeQktMlSU
	KzJ8Q4HcoVpE+eM1pH0O7QbSlDmpIbpRBcOe8BKOkIKypwINnHL0s+FzFCt9g9ob7n0u24CIWtO
	hD6iu1aVW72+roDkZ1VNe6He4ca0IJbg=
X-Gm-Gg: AR+sD106Few1aV+LNlsET/gdGYWfP+VLkpIHYrTBTEE2DY7ddbS1doUG+KkHroQVigl
	NAqo5unSgMm9gRGRwlEly6zXdUeulwsXOUoHq3Ns2gzXiJ78bgoxOVl9420GMbx6ST37+PLa9jB
	qrBQhhsW1jdu8VnyJHkJJfjj1HS6jl3ntXCZusPTu8OLof2sfydi2IE0HXig8bcMSxNhHC868cu
	pCKagrPOlyEGCVcvPEbuGTIdxvDtWLCNQyWew9CrckCXIyNvUmIwZsTUgWkeg==
X-Received: by 2002:a17:903:1590:b0:2ca:de3:15d7 with SMTP id
 d9443c01a7336-2cf8dd6e392mr56322395ad.16.1784755518845; Wed, 22 Jul 2026
 14:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260622124823.1695944-1-michael.bommarito@gmail.com>
In-Reply-To: <20260622124823.1695944-1-michael.bommarito@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 22 Jul 2026 23:25:06 +0200
X-Gm-Features: AUfX_mzqIt8YJYlyJ50VPQGiIFtIZsHYUUHiAu-HehpAJGUZfALuTrT25Mjl0Kw
Message-ID: <CAFLxGvz+e5cq6n0_juZWyU4iUpWqMkh1Dk9cu_0eSxAfRneEvw@mail.gmail.com>
Subject: Re: [PATCH] um: ubd: validate COW header fields before use
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_142519_879673_56BD6CDA 
X-CRM114-Status: GOOD (  20.38  )
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

On Mon, Jun 22, 2026 at 2:48=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> read_cow_header() copies the backing-file path and computes geometry
> from header fields without validating them, and the historical
> "XXX Need to sanity-check the values read from the header" comment was
> never addressed. Three image-controlled fields are unsafe:
>
>   - backing_file[]: not guaranteed NUL-terminated. cow_strdup() and the
>     later strlen()/printf() walk off the end of the header buffer when a
>     crafted image leaves the array unterminated (heap over-read).
>
>   - sectorsize: used as a divisor in cow_sizes()
>     (bitmap_len =3D (size + sectorsize - 1) / (8 * sectorsize)); a zero o=
r
>     negative sectorsize causes a divide-by-zero / bogus geometry.
>
>   - For the V3/V3_b layouts the existing "align =3D=3D 0" check printed a
>     warning but fell through and then computed
>     ROUND_UP(sizeof(header), 0), another divide-by-zero.
>
> Reject an unterminated backing_file for each header version, turn the
> align =3D=3D 0 warnings into hard errors (goto out), and reject a
> non-positive sectorsize before the geometry math runs.
>
> A COW image is parsed from a file the guest opens (ubdN=3Dcow,backing on
> the command line, or a cow file an unprivileged user can point ubd at),
> so a crafted header is attacker-reachable.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Reproduced on a UML KASAN build (ARCH=3Dum) off this base, driving ubd wi=
th
> crafted COW images. Stock: an unterminated v2 backing_file over-reads the
> header buffer (KASAN slab-out-of-bounds read in the strdup/strlen path); =
a
> sectorsize=3D0 image and a v3 alignment=3D0 image each hit a divide error=
 in
> the cow_sizes()/ROUND_UP geometry. Patched: each crafted image is rejecte=
d
> in read_cow_header() ('not terminated' / 'invalid sectorsize' / 'align =
=3D=3D
> 0') and the driver continues. Benign control: a valid COW image opens
> cleanly on both stock and patched. Before/after logs available on request=
.
>
>  arch/um/drivers/cow_user.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)

Reviewed-by: Richard Weinberger <richard@nod.at>

--=20
Thanks,
//richard

