Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978BDCD4F59
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 07:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=; b=p8aVdn4fzs3PTI8q0aUs5Y0oGZ
	Y8NmYFy/oT8munzKRROHINDxjxt5AIB7P3Z2L1IImrDFih1p0NEsGEGY4vtBOzuPmOmB0exTWjYKd
	KHNKvFS+zQFqvmvEeiBxP8iJZt4aUqhGvfk/Yg4dqa09Hb0E39H+FWbyHNZdOGu7uZB5Hq7znEFxw
	5TbEQBG6KiJquPnwak7O3xIAMCQ78FK1+PpYJUhyGT91+yre3yHd1YxYQeNAyo772Gp/+Ad6JyR2K
	ebRtFv/mkw4jUGluQ+E8wTg9RqamCf6ukEI7gTzCXVAsDyC6GR7uk+SSZfY/tNMpCwzQqqm8kSLea
	Y4c3tXXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm7L1-00000007Rbv-2VS6;
	Thu, 05 Sep 2024 07:55:31 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm7IM-00000007R22-2FZI
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 07:52:48 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-374bd059b12so225461f8f.1
        for <linux-um@lists.infradead.org>; Thu, 05 Sep 2024 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725522760; x=1726127560; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
        b=bo4hHL+DaKSOFXdYtjOQo4qXa+U87l2aTW3li2PeDdOSrQ7H+qdhVs2E+f+Y1/yqU0
         CE0BHCotx0N+FxrlohT+0DZza0Zuv9/sPQyXa5jvt0Vk5T4M9EeTw9g/brCe0WKDDNAK
         ezyB0e1uVoQ3dq8+4y8zzg0w8ARIaYnkln9sN+EXVFBjl+XdWOJYGJAGyoOz/Z8KuKkl
         5QNENIg0p9QJw5wR6rhEcLxWi5n4ezMH7dpQpZ4mUmN4jBMs2eWf7OWrX2z+g/uOZUQU
         jUr/99Tuz7Md9IELzhuOWg3eyD49k7WvyoW2KXf2sILQ7tM/5UZO7GfJHanpKepIbU9f
         22PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725522760; x=1726127560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edlhfocYTBb5RSXGKhxyCJoY2mjSJV4yCAz+HGPdhB4=;
        b=NFrjsuOyrdbnAKfXlqyqtQ4ig1PhHEMprvJJDCuuBxnhNqcPQKIGZg1jCm3VN0ZBZV
         11YowAGSVl7lEfRKAO0QDf/h2W4zyCeWs0mm7zhf3mJ/WuVonxHUB/jqOtYv99+SNZc/
         R6b5C+upZTTIBUNdD42khHYKKpP8h8naD+WHAJ84ffw3js9Zjn7Tv27VJXwAZ3rRAZ4y
         vDA/X9cdnsCjuUWj7o9+hZIgqvdwYjcThY1wv0z1UESxp0oyNsfjUMOAlKprJf+usToz
         Gj8fof/nD002DYe8h4pmSsA9pEmp5nWFOeFCKaZhwmGa3IkE+j9aqquUeyII92jin/Oa
         rNBg==
X-Forwarded-Encrypted: i=1; AJvYcCUd5OGdn1YvRaKEEcykgm4oeH6tckOyQTskNg19CT0jIfnnOGKeimauNbXdY8tDfbO0jgGJxUPreg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzYDYD/NznL7h3CHJc83TkHQfX2R3MnZWiLuQAfmLWA3LIwXMwO
	QAfr70dmJsyhyFozENzYdV3r9+sQLd8uIArdnD+y7QGi5YhciePr0hikAKdgiBbttUrjvFbA7yY
	MtkhmNJw4JpJFpzf0TIgIgI3VqFLWLzHLabUS
X-Google-Smtp-Source: AGHT+IFK43pFnPLGUXRCs6+/ppb+2QpfbK6ADGGjBpmf0Lo7PhrrA57wrAnEXXwtIovQ4N0HLObZaRzV3HTp0jsNSrg=
X-Received: by 2002:adf:a351:0:b0:374:baeb:2fb with SMTP id
 ffacd0b85a97d-374baeb0c2amr10826925f8f.35.1725522759687; Thu, 05 Sep 2024
 00:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240905061214.3954271-1-davidgow@google.com>
In-Reply-To: <20240905061214.3954271-1-davidgow@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 09:52:27 +0200
Message-ID: <CAH5fLgjqdchRvVGTMLYPTZ6erakKg3sNhbSA4dLq0kLAXLWxQA@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: block: Use 32-bit atomics
To: David Gow <davidgow@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_005246_598669_3F210165 
X-CRM114-Status: GOOD (  16.92  )
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

On Thu, Sep 5, 2024 at 8:12=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> Not all architectures have core::sync::atomic::AtomicU64 available. In
> particular, 32-bit x86 doesn't support it. AtomicU32 is available
> everywhere, so use that instead.
>
> Hopefully we can add AtomicU64 to Rust-for-Linux more broadly, so this
> won't be an issue, but it's not supported in core from upstream Rust:
> https://doc.rust-lang.org/std/sync/atomic/#portability
>
> This can be tested on 32-bit x86 UML via:
> ./tools/testing/kunit/kunit.py run --make_options LLVM=3D1 --kconfig_add =
CONFIG_RUST=3Dy --kconfig_add CONFIG_64BIT=3Dn --kconfig_add CONFIG_FORTIFY=
_SOURCE=3Dn
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Hi all,
>
> I encountered this build error with Rust/UML since the kernel::block::mq
> stuff landed. I'm not 100% sure just swapping AtomicU64 with AtomicU32
> is correct -- please correct me if not -- but this does at least get the
> Rust/UML/x86-32 builds here compiling and running again.
>
> (And gives me more encouragement to go to the Rust atomics talk at
> Plumbers.)

I would probably go with AtomicUsize over AtomicU32 in this case.

Alice

