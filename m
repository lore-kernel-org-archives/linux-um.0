Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A42AD58CBE
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 03:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6L7OuggG1xx/psBeZawamh6lKLmj+yBN2DAvG0qZTM4=; b=z020PdC904gjRYePd4vST60pi4
	lWczoz1DF0J3F7ByKlhxjLm/bbuJPUEbpGN94bmIAyimbtyRT37rRPGL60H1ALj1r/k9gKRfMgOoT
	oK50eBasPU6smBc8owng3NqbYr0mdJ9WGG1dY9+kBxqpHfgCU07/VuIEi0K6WfPOvA7DU5ZQME/kL
	Jx9Oa1Gzx0+JcykdNl+Zu+DjVjDkpP/K1MEdiKH1t+5CtiMZsZUSaLwZd1uYTglQwzeFUMqWnVEDA
	2LWzg0wn9TlNNm5dzfDLQaGtgzXd1+/pk10AKkwqC9oJu0EXnnlxEVwgqqeFqaH8J3P9o2noW/8uv
	LH+a9eBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Vum-0000000Fx0m-1Ej3;
	Mon, 23 Mar 2026 03:25:16 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Vuk-0000000Fx0E-1vjB
	for linux-um@lists.infradead.org;
	Mon, 23 Mar 2026 03:25:15 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1277863a912so295392c88.0
        for <linux-um@lists.infradead.org>; Sun, 22 Mar 2026 20:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774236313; cv=none;
        d=google.com; s=arc-20240605;
        b=cHIVxNKF1LKn+6P3DKT6C0HFOpKFd7eQOMdTKAlcegx5bhslBUSUMgJCJNEUPUXRsV
         XSK9djZjKo0+u2n02AxT6HDYD+83D9NMXJiOd2XB1bTne7Zn9F+TjA9IKvI7kI3X87+G
         a8MoS9m5pu+7TADJpViUzSxNJP6FEzIB3Vyjo6NzmRWtMu4M93nUTgkvB+WX3BSgXLE5
         HB5eq5NAUfYv3ApbOvcfIdyvYGYhjlNmqCvBDoKYd/UgFaCsHZp0lKRWanhdqQfXPc5f
         lqIGtMxlMcB8lqpxmpszzMqjj+xkAIB4yUwqRkgR113ocqkS8n6NiBLeg0mMnujhE9LF
         u5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6L7OuggG1xx/psBeZawamh6lKLmj+yBN2DAvG0qZTM4=;
        fh=qpTR8jC68ipZziQqVmMSDx+MEHGWEzIXMLhY5J21jqs=;
        b=JHzZmatGGxu24DcJW1uZWWea4+fZegWsTR55eP5fIgZN9hKAaTgpSlf9Ka5dLoey2a
         bAV0ZxqC5UbMIvhouwL4Ldyfcoja6SpkMX4mjMq0CFq739+ANYRVNY+80jYtqMK5l3gK
         lCRzf3PAiFugLhSUQm9h2WaYowRU0b9t3mFlb5v2dMpSzc8S2GZWY5VQTnACpILObqlT
         1Ekc77B1reIPtHfPcs+9NHXRI/Qh1piZyuRRD7WltEKNgeK0vAFDrW8G/BI0IvMJvy8M
         b8S0HZlN1UGxhXncnxO7VWvA+MfC7mu2IU6fu7yjXNdmeP9TsSIJinA0/raYKBZf/imn
         PURg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774236313; x=1774841113; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L7OuggG1xx/psBeZawamh6lKLmj+yBN2DAvG0qZTM4=;
        b=i5UyboPVogYILmaHNZjtVSBYlVRamx8heVv6zdW6G/ratSEUAreeS/6NYa6gk2r4pJ
         WYKDDGWYbWvnwSzm0i838DA4EfYm3DTc6483Tp4yVIyt+0oY1Mzl6x0TpSvQesjO9wuS
         roGapH4Ioq19xGlC95LPJj8uo67T+YP91Ae0StCy+xCQInPTxt1uOSNd7/CgZwNXL/y0
         eYiYJ9yn3O8XHDqsqfK1c/NM9EiFjzO1DaOG1Tz0tk6Z1ABAOnBIQpL2L30pRbToxuzh
         Q9rS+YjB+0ODwwacs/cnn9h1QvACefS2DIhKX14QHErgdE65oiZBHl9B8yUh+2wCULbq
         f8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774236313; x=1774841113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6L7OuggG1xx/psBeZawamh6lKLmj+yBN2DAvG0qZTM4=;
        b=S+ZulqzSZ1BM6w7hEbcUK5B+1n+Gs8NpGiX4fT4Q9dDLlnKQ/eMeD31Ex1L0SduwEC
         LJwX7aJ6078HuEfDKx4L5GLKk7wn2D+K6M8oCuFlvZywBUqBN4d+ZcLvh2rU81GfyDW1
         IyPyWoRpBFvVFG0o9H4x7aWG0MseezKMtrMXzIdIJTmO3SAjVjtRbXDqngLm5TAmCXDK
         CJEr1s+W3DMRNc9NGvg53iRdwJ0hVPH3sFcRlzCvDaYRpRjvyLpCpxSH6BJtxDXPeIFf
         4uOBo6OL1zkzN8qR/XsiLkYv+jJdyFpMBqZNGzHioqtZlFOdpxZatZesgNqt7ujKIr78
         nElw==
X-Forwarded-Encrypted: i=1; AJvYcCWtWF61eep2TvT/YIRSDnH+vHzB7IZoFEkgL49AoORCtMltzjwX+ZBnQETSfFTcmQm4v+kFTuQuqg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCd3bMDS1tkBdHk+Nv0Nlpv/ehOqVIUp3KlDizrnuppa7McfXm
	yu39SpJpKnErZWUpHu/Z/vHXpeawA0eywanRW+J2gmjme3JX4kVsKaE8g7yUWZIbYfAeYtGAEu1
	C4aFfqlVJbTgpSNAKsm7f7Wnwpwz2o/4=
X-Gm-Gg: ATEYQzwcc1MCJbqiLIYj+mtBHCS+kjTYxxhQw0jVMISZD26DZuFs28S7ZlHR4STUdGo
	ixDD+3AapCeSZDHltuCTPNlvNKGPlwt1Qf2uCGE0IO0Xn7qroeNwc/C8VMHt/5eGG6PrHcc91Ct
	ZsNnjlUpXmFMpQowX8aUDfoCBvnXrN/kdsb/hPtuSEx4rnFXo49Wtb+6iK+wKbHHwfaG8fx4ygd
	cz8QE1Va6r6U3yShz5oyALyZF7DIVeQ24XNHyWM+FaMCoeSI/L7Pwvvj6AOyJoDneTvxjbb21j9
	8wsOPFF0IhFQoKkFV68yoHzyjy171ybaAc6DYmJ2kLDpU0cbgFu/tn5GZ6K/ME5qcGm/mRg40j/
	UqJ23K9NhGKQlpPgnmsc1UJI=
X-Received: by 2002:a05:7301:100d:b0:2be:1946:858b with SMTP id
 5a478bee46e88-2c10970d302mr2034525eec.3.1774236312928; Sun, 22 Mar 2026
 20:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch>
In-Reply-To: <96287f3a-d245-47cf-b7cb-f821451493d3@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 04:24:59 +0100
X-Gm-Features: AQROBzAuhFHkGwwSKh-Ea07cCRjtb6eZEQluwHGIFmDfJPfdFW0BK0DaJf2FJhk
Message-ID: <CANiq72nwSWVDRqm0Vap5j5X5k+Q-wq8okQ9d3KUgZt6M4CpW9g@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260322_202514_505986_EBBCFA0B 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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

On Mon, Mar 23, 2026 at 4:04=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Rust is already fragmented, because it does not support all
> architectures. Do we really want to make it even more fragmented by
> having some bindings only work on a subset of the subset of
> architectures?

That is not the case. The `depends on` is not about putting them on
abstractions, but on this experimental build feature, which is gated
on `EXPERT` to begin with, because it uses a fairly exotic approach
involving LLVM bitcode, which carries potential pitfalls, like the
mismatches on the target string like one of the commit messages
mentions, and possibly others.

Cheers,
Miguel

