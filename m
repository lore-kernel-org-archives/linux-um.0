Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A494C982D0
	for <linux-um@archiver.kernel.org>; Thu, 17 Sep 2026 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zeUanOFQMGLva+Wv/HlVlWxsHp1h2Rik1mRUDrRwu58=; b=RPv+ax7K6P2hY0DnjkyCQzFuJg
	Q7lJdDh5aKl0edX6nIYrN6HF2mhumxwA2JqFKo0fjjifKxLP/3r9BMqoCygqdM2fcsTJneLGyo0I9
	gjP4cJQ294ZLbbvNEH1DtQUXd0z4BRGcBU2NiWkQHR3lZJ7GzCfbBi0vx4fzowY+UcdL9w+IiG0H1
	DslHBIDtTjkh9IBkOXfpJ1VE4cWwZqu3NSTDWkvXLk/Kfv4CT5sq9t44cvMIRpYDgEsZi2vRUt7TN
	POLAQBqFWIUknxcXJxH9trKSJKBJ/vqVME17SCREMRCALRWGMS1tElPBYD6WcgUwVlm+yGSWbzt8o
	+aIvRTzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7GjM-0000000CDPn-1elt;
	Thu, 17 Sep 2026 18:21:08 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7GjK-0000000CDOK-13zt
	for linux-um@lists.infradead.org;
	Thu, 17 Sep 2026 18:21:07 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49e620fa473so7048615e9.1
        for <linux-um@lists.infradead.org>; Thu, 17 Sep 2026 11:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789669263; cv=none;
        d=google.com; s=arc-20260327;
        b=eYH1U3pfu+PHvuzxTmNBUFkkc9rIJ7wXoo+4woqanCibmekQdnZwEcqChE0Ff3IIVj
         5vNRa61WQ56aVbz+DFo98icteYmLzdMmkNHVVrM698J0IGVeSMvYyn85SO5p7M9G9gNw
         xh7vqHwCWWFmdKMqtJjV7+wrw2pLo/+7BAvRxEn6YuaYjpiT3zWiYoFtjvqnP7sQc0gP
         g+cK0JwiOu9OSh1evyDYa0OpnwXk3fBI/2Jbn6VpOpiky/M1MA58LQNDb7jaOScnSP0z
         SQdky2IMwzVb9oQipge3XVexHYSj6w5MgdDcx0WbkNUkEH06pYmST3ncLARyWWgqfyHh
         HpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zeUanOFQMGLva+Wv/HlVlWxsHp1h2Rik1mRUDrRwu58=;
        fh=er4tOpLl+FfEHTafjhdJJyuhEC46atcKmeUfjcmtOvg=;
        b=EfT+4aRjdCRfbnPEAQEwqL5PKg3CjxqQnZQYIjahFBx/0elnZ20NuNwUKulNz+FsTM
         I4uCHvuzh+2Y03TXz3YP8YwEtDDWvviLEfli5blAcxoeNv54U+WjPtz/iOlAu/uDLlvj
         OfHT9SMOqDcaxYQX/lnUz3/oMmJrs/b3sUkODGgX7OPLR4M5C5REs3KqoBpUzs+ttGN9
         +OXCXqOIwc6eFyiLWqzDg7w7GuyZ2cYxGuWrKaiXkKjRkqDw/H+8H34k3xAL4ZfMUJGA
         u17jbN1v/8/jqP4QtJN21AKh/DWYUTP9jyRcheLvdH3PQqh0NbkaCm9kNe6r0uvGnYTZ
         D62Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789669263; x=1790274063; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zeUanOFQMGLva+Wv/HlVlWxsHp1h2Rik1mRUDrRwu58=;
        b=bgy/2SaX4DmaRUzugDPUWRVcqO8XT4H7MfPMig2miqAcgTluZbvcZX3Z6s74Vulrc/
         GhQKy8IxvOoAbnAuJeL7a5Du8uw4yhO7t37tT3DI8wMkRbjPn8iCEmyN3c13qhTPXEw5
         hnAS+YM8wrPnhldVEasHKJ018b7BW5YvCfVuM7AtWZcueT4JingE9y9B9pPrW9xWyVff
         k0zJOWToj/lVpvUQoaY4gaM/Hs/zvyZtQMrCor7ZsIVIO/iKyBt/SRStmggd/B+Nj0NG
         vb80QJJ2VX1lrvxz2SaOt1C+efb/t6JCoaV7VtsjRWgsWel7FcgDraHcRk6AKxYnvgKD
         WZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789669263; x=1790274063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zeUanOFQMGLva+Wv/HlVlWxsHp1h2Rik1mRUDrRwu58=;
        b=Ct1hxrsZg3kDSRLwYI8IXcdFBsO1H8ORULuUFqUxseEF0eDoFRnsoGs09MB6mNDNEo
         lSqoJECWZMCgyXKFKmflMGuI62j3AgEIbv3R0BwlDtumER5wi55EdARI+SCbdriX6lPi
         ZzBoyJsf8Fe1xLerxG9xFbNrBxMz70MezfTik6MsZhWghEfwdBydfPKTiK+/Q3yv5AnK
         KwoJbJudW90uaypdWkPRCB9/VvSow1jNHo4PEA1u2sveCPA/Qc2RY9QU2xhL4yYRDXxF
         DS9Ee/dYKAg1JBVzoRSDHz2in6m57W+MQe7PxRX2YmNri46VBCQM5cOLsbViLsCShNUH
         n5mw==
X-Forwarded-Encrypted: i=1; AKwUvBxGxhGrkxFaHZ+zBj9zxDvyS9cFWBX6DfhHcQDl+Mn18A1pR7OkSNQJcj2RmyptFBKPj6YCK7mnwQ==@lists.infradead.org
X-Gm-Message-State: AFuF++l6PJkbETeIBR0B1LSH/fvY//2weP2glPuyV7kL4m8Chg3uttU3
	biLwAnApLKRdPmU+ZkQZYdbX11FDcw5uHdtSWm3qQpic60FuAMPy62lqELiTsB0ZZ2N0TfAZqu/
	2w/McOuvZO3udqH+sDuu1LQC2fuHpgwCXcD6A/GK2
X-Gm-Gg: AYBFou2/bkn9omsemvZDl31iZ8oG+/sSX6v0qrGzF9Hjl9kJZdNbdpAJP4NbGXW76QQ
	PrtuVyPR0IbUfS747WYJfQrwt0rO1q0pqEt63b+k4yOP94kp5qG71S9tfdTuGJ3bOJADvY7126x
	oYsrWBLN+39ihxXsjiRxIZaRhFtyvO0hq1tGuAUiNc9CIJwyMrAjUy/dYRfPwF3aGF4FZa0bUgD
	0cnf+7lvHu5gJU6PGOkFKGtdkF+sxHgjCIOwOfA4gb0uAQhPbQ5DpX5N2bxVjuk4LcYs/hpy5Z9
	Dl8cUxGsw+W/uRk8k4SFs7Ksuwn9kxv1vYbhgbRimwAlBX+AjyWMtzwV15z6uspR8O4uT2XlB0d
	uV+COIhuD5aGLTbhuYQQAF3vWO2drUSkKafGCyjGxxqj4xtbwi7dnBySgzCk9W7sN77weAg==
X-Received: by 2002:a05:600c:4708:b0:49d:93c:d903 with SMTP id
 5b1f17b1804b1-49eb7322de3mr97138325e9.20.1789669263065; Thu, 17 Sep 2026
 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
 <CAKwvOdkCGEYWnyJtWT=jArXkA47X==G0PU4UNV=s8htpA3Dg6g@mail.gmail.com> <aphc5Xf0HU0SWcTI@redhat.com>
In-Reply-To: <aphc5Xf0HU0SWcTI@redhat.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 17 Sep 2026 11:20:50 -0700
X-Gm-Features: AcwNN1Wnnc2Ja2BVU5SbTKTHMtdnYNybRfE_8sC9RSapHxQS6CIO6M07Qcg-v4o
Message-ID: <CAKwvOdkQ1OL8Uu+wBO-RtVr_sPTWJBYpM9PEDcec8CvLF64FdQ@mail.gmail.com>
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
To: Oleg Nesterov <oleg@redhat.com>
Cc: Elliott Hughes <enh@google.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_112106_322275_813CB1C7 
X-CRM114-Status: GOOD (  23.04  )
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

On Wed, Sep 2, 2026 at 10:29=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 09/01, Nick Desaulniers wrote:
> >
> > On Fri, Aug 21, 2026 at 3:46=E2=80=AFPM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > The register offset macros in <asm/ptrace-abi.h> are guarded by
> > > `defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)` for 64-bit, but
> > > were left unguarded for 32-bit. This causes havoc for userspace that
> > > happens to use identifiers colliding with these short macro names
> > > (e.g., EBX, ECX, EAX, DS, ES, FS, GS, CS, SS). Without this guard,
> > > userspace is forced to be super extra careful with include ordering t=
o
> > > minimize the chance of collision.
> > >
> > > Wrap both the 32-bit and 64-bit register definitions under
> > > `#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)`, and ensure
> > > User-Mode Linux (UML) defines `__FRAME_OFFSETS` for 32-bit as well.
> > >
> > > Assisted-by: Gemini
> > > Link: https://github.com/llvm/llvm-project/issues/217413
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > + enh (who pulled this into android for testing)
> >
> > Oleg, can I get an ack/nack here?
>
> Oh... there is a little problem, I don't understand the usage of
> (magic to me) __FRAME_OFFSETS ;)

Yeah, my Assisted by tag is from asking Gemini to triple check my
patch before posting, and it pointing out to me from a local review:
"did you intend to break the arch/x86/um/ C uses of these macro
defines?"  So I'm just matching an existing pattern in arch/x86/um/
for 64b with the __FRAME_OFFSETS parts of this patch.

The patch started off as "why are the 64b macros behind the
__ASSEMBLER__ preprocessor guards, but not the 32b ones?"  I went back
through the pre-git history tree, and FWICT, those macros have always
been guarded for 64b, since the introduction of x86_64 support itself.
Dunno if anyone remembers anymore _why_ the 32b macro defines don't
have that guard (chesterton's fence?), but to me, IMO, it looks like a
mistake.

Hence this patch.  PTAL

>
> > Or someone who knows better the
> > history of UAPI headers?
>
> Certainly not me....
>
> OK. I'll try to read this patch tomorrow with the clear head after sleep.

Thanks for taking a look.
--=20
Thanks,
~Nick Desaulniers

