Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678E0F46110
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P5oJqHAVX7zT2HPF6s22H5/MvQLO5sXIIazXAuipXIs=; b=r6U8U+/YvHeBUYyWphV6smdeYa
	qRbFbKeOst0D2titEmSo1npPloIWgCbVgR04pLe+l5MAoylv5r3t8t/iFs/S14W/D23VnHVweVUk/
	WwP6VjDJSB4Kd3mXN+CaPQWyiOVfEWGULQUh8156531duoTF5uTqDyodWJdfOrMiEPS58w2yfsuUX
	whmX/qPdmLUUP0D67ZQAhSdFsbnxDVxcHOAIbzLa7NktMFdKH5rNMO1BaojTfC7uemOfoCywdIoz/
	rUDhvhzxxTQVAFOGabyX1tzYby5hDp2cnpozmbg/PIxtf5T6qUCUvTQqyne+GdsefM1Rc8cjewsiV
	6Cy1aEqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fR7-0000000Gpw4-2wVd;
	Mon, 23 Mar 2026 13:35:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fR6-0000000Gpv5-3GUz
	for linux-um@bombadil.infradead.org;
	Mon, 23 Mar 2026 13:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=P5oJqHAVX7zT2HPF6s22H5/MvQLO5sXIIazXAuipXIs=; b=l7FHPETBiOWc2o/hNmQcoAuXTD
	weblE5nm8sVhZvSAyRONXiahEqm+uRowRdXA2B7qW5SusX4R+ZNR55w7r+I5GtcIen4fr5RKjd10F
	OjQCymojSejJykRxivfoV8QCdRa8GLm1G+MVMlgRoyD8v+VCKwdZlzC3CcyEX+2/sPERXS1HhNSH8
	yDap/NofG2ALbrM1gjmLxG9s7buzVXEUOH86Z1rnotU8/9m25eeq5OOuCvemHSeoRV77fHOxcKPA1
	a1BjEHy+81QBgI9OOFntOYJHWJ8q4VxKHUJ2vGXAEq53myxBl4v+AQ/s3Gy43wzNMmW51WerPYp9l
	iEm4oPEA==;
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fR3-00000001cPJ-29CO
	for linux-um@lists.infradead.org;
	Mon, 23 Mar 2026 13:35:15 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-2c0c4194b2bso150636eec.2
        for <linux-um@lists.infradead.org>; Mon, 23 Mar 2026 06:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774272911; cv=none;
        d=google.com; s=arc-20240605;
        b=XTpzU1eD3lGOo/R5RCyx4YZb4hpCXEnzrm5b6kxLmWvrxv1wehP/LDm7zG4vOM1ehc
         SPJrzexMZYQ06s5rPpe2uXVTSK2x2kYCtYd+Orm2SxK9GNv1d2lDl819bQIMS8/b4lOz
         K3nq7qCxYSeEvau4PmXP5vyPMvxErr+LNGaUoGfdGYI6+g1g3wvic8Xm5EPXvHANwMB7
         +3QYo9cBLxK/4yrp3C2fwDuTXudPGVbx69jAJQiythu7EYeeuXpIIUUmN+GSM/7wzaVJ
         8WVt2J47t7CbXPB+Xyy1R/8XH1OOr9XbGHxtB553nxG5ctd5Tiv918qy3SO0MJqD9R35
         CHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P5oJqHAVX7zT2HPF6s22H5/MvQLO5sXIIazXAuipXIs=;
        fh=5iJAfrGbD4HAC+R0Ih9NA5KgOeMQLawSzdOBVz8Kjo8=;
        b=LmItFChUIAcCb6EnVpXXnChrW7JlGeLV5xtnDANqZ/YosYlgnlnDZgZAeOzVmElTr3
         ZFuMyVn7RHyhQIMOcjmRRFFUnfhNeJKnnZ2Aqb3QGFgLPD3DgQlwBk8PY9TmhXsz6cIh
         dvCn8WOT12hpyoIkxaNbRsXMCZrnFTBsBjm55oer78/iIucpEER2hNaluol6UXsCYMNP
         M/fRKaIvvyh8VUlJNj4gf2Cnau4qKqvMVbVinJAt0cBL8xHLHze6wsS5Rg2R4qxHCL44
         5bOBCTtZutr3Ol0sGG/QN6JaTYoiYAMoNy679//0/TfgUzvurkOrhui+bNPpTLaU+nPd
         emwA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774272911; x=1774877711; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5oJqHAVX7zT2HPF6s22H5/MvQLO5sXIIazXAuipXIs=;
        b=XTuAO0CFNoCjroBr7Lh5ifYNtdjmERR5DgTYP1XfcGvzX7m4wFCt6jcoK2ayI3rOee
         3fHrxmIzkcJhVKAKs29WxVbBUOA0Vxp8OU8LP8aVRyEgXrcVyYIWXri/8BqmyDdi0Nqw
         /Raq2SXoBWQX7GNihQzyZK5esVXQXvAa6TqhBzr3WZCdtZhqt+7JxNdIq7pN2PiJaDsC
         7FevuDYsMDnOuaXyLaSFUj2N5e87RDGLr+2Pgcu+ShSTLjy73FRlPuNDjM2ymBI2Kp0K
         YZSS3pLCflQ7WNfNwHlF09zkIJU/gky1jUupxuV0L6/bE2pgCxkC1gu9bmrVdYXojznC
         UkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774272911; x=1774877711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5oJqHAVX7zT2HPF6s22H5/MvQLO5sXIIazXAuipXIs=;
        b=Xg+NPRbN+Cpu1xWGIDTN5mqNKl47MMJSZ6vQYIzxqCQk74qBZq6uHogCsQwgWBVSdH
         C8wyF0JYSlz6dZFJmcv8GkXK9HCxTuF7GRok5hrDtrvG65oxGwXMAIdAGUdk8UvkubAE
         sm6hCoyN06NpSECZzvr2d8jlQzMr+tZLlW8RxuHgB5Xy0tfbxrwNqjc5BYuHRhDR2+4t
         FXlZHOcmZ5hDIrL/a7U1vma46RXx9clD+Qm9YHShkZUDymkwkS+QZE3xvpy0cATrfkL2
         lhF0CJUfXedPbNgwT4NoA9E6ADVTbcOIElV+KYrhwKOHLUyzeJHC6a6KJ3CRajblfybp
         nZyg==
X-Forwarded-Encrypted: i=1; AJvYcCVpst9u1Oh0qJfRMnR2nrjCT8BhjuiXJRGtpIokYPv6TsJ2DQphGvxkayg8e7aE7g450kP82jAVww==@lists.infradead.org
X-Gm-Message-State: AOJu0YwbROT6Pug1uSMkuyXf/IjnQBkXInpgCu7+/hV2AHny+A2qBQjl
	xlPWYCyj3hoY6Vp+CscOS99lLJKQWE9Kn0tO3k4sLtutW8hyg6ctKIpKzu9oF6Sx83nK/fyHCEa
	GvVq2zh1STSoAOCtMtMqyalC7TjQ31vc=
X-Gm-Gg: ATEYQzwMoMXBYhXJJyudCiDhE8q26dWcwN7+vxInTv4ipqaiOk4VqV3sZ01A9v5hgYx
	2LWVZlszDN64N36QloDyGMxMYV7jWRp4eN4fuRmk/1ax4dHHxj9agi+jFKFpL4SDkUiMuqlyS64
	RpqJVBnNSRKQ9DgYOftU0KvoDQM+UHi6OWGTSbRHd6iJtOwJAsN4pOydip+P3CIefeizgi1+8Re
	1FxUZewKboFnTL1I0iSFlO3ztDFxDtySZUO4k4FxwjP3V7WEUoNJqzquKfiDDZDebb1yNLASep1
	sH1AApCv7jV9CWmASRZ/uAjWgGXeB9YpKVFdFltkI1OZwt5NsM3/OGcxnG0lx8+0XLu7A0qjAcW
	b7Lx33ghPo1k6G7kJ5FSZb7+ZOYZA9DllXQ==
X-Received: by 2002:a05:7300:5711:b0:2c1:27c:75d3 with SMTP id
 5a478bee46e88-2c10956c2a3mr2435566eec.1.1774272911337; Mon, 23 Mar 2026
 06:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch> <CANiq72nwSWVDRqm0Vap5j5X5k+Q-wq8okQ9d3KUgZt6M4CpW9g@mail.gmail.com>
 <65336ad0-ac37-416f-b6ae-e691e3e375ae@lunn.ch> <DHA6SE9EMEQF.1PKVHEG18I5FS@garyguo.net>
 <b5063e7e-9245-434e-9877-5ac7b45f4bc7@lunn.ch>
In-Reply-To: <b5063e7e-9245-434e-9877-5ac7b45f4bc7@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 14:34:58 +0100
X-Gm-Features: AQROBzD7g_rNmuMWaBSXTkod6GcGExC_6-5XqRdaJnhqw3z7WBAm_JnLMPlOCtE
Message-ID: <CANiq72kD6HVrDTjQrTXDujyjA4Z5ELM6Nh8kFfVfNXrvpfU1wA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, 
	acourbot@nvidia.com, akpm@linux-foundation.org, aliceryhl@google.com, 
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net, 
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
X-CRM114-CacheID: sfid-20260323_133513_689586_B48793B2 
X-CRM114-Status: GOOD (  14.16  )
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

On Mon, Mar 23, 2026 at 2:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> So it sounds like my understanding is out of date. When the first
> Ethernet PHY driver was being merged, Rust could not access inline C
> functions. The binding had to replicate the functionality. But you are
> saying that Rust can now make use of inline C code, but not actually
> inline it? It results in a function call?
>
> What this feature does it actually allows inline C functions to be
> inline? So it is just an optimisation?

We have always been using the helpers to access the inline functions,
please see the top comment in `rust/helpers/helpers.c`:

   Non-trivial C macros cannot be used in Rust. Similarly, inlined C functi=
ons
   cannot be called either. This file explicitly creates functions ("helper=
s")
   that wrap those so that they can be called from Rust.

It doesn't duplicate the functionality, it simply forwards the call,
i.e. it is not as bad as a full copy-paste of the implementation.

This patch series aims to improve performance (cheaply in terms of
built time) because for Rust calling those helpers are not inline
anymore otherwise.

You may be referring, instead, to avoiding to have to write manually
the helper (the forwarder) -- for that, please see "Support static
inline functions in headers (by generating a wrapper)" at:

  https://github.com/Rust-for-Linux/linux/issues/353

(In fact, I had your previous mention of `skbuff.h` from Lore there :)

Assuming `--wrap-static-fns` works well etc., then it would be nice to
use it, yeah. But that is different from this patch series (and this
patch series would apply as well even if we use the automated wrappers
etc.).

I hope that clarifies.

Cheers,
Miguel

