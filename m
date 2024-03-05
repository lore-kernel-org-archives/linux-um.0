Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FC4C54798
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 20:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DMppHw7KV/r56VUSnIREU2O979JxXuHNtcifN4Olhis=; b=NCVi6BN3Spbz4RU4P3IpliYE9i
	728wG9VsanCXjPc7bdqMXXwG8mDZtl308/qLm8s/3j+EK29VaAcsKkyHEd5cPm8B7LAk24T3XpqcR
	1TSesyelOBnU8oG9RndRqtC333GcAG7U01f+UFB8NnnrtjN9rHq2vKP9yUyTgCwurR07i92QpZM6l
	TEd39piz+ujo0I8z60lUf2a8qfqLq8HzIXfe3Zg4/XUaykJCsHtzJwgwOe19lRdYK9emO2BoCfDZq
	cy72BBJr5+H09PJZARmmtxIwSEtqHZ/bLUVlOR2Y+lc4K+mD+m6DSwF9D2tVSgJXDttVQkjFkJ76C
	g3quoN1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhbrF-0000000FFaT-0D9n;
	Tue, 05 Mar 2024 20:57:53 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhbrC-0000000FFZl-1lyX
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 20:57:52 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-42ef8193ae6so81811cf.1
        for <linux-um@lists.infradead.org>; Tue, 05 Mar 2024 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672268; x=1710277068; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMppHw7KV/r56VUSnIREU2O979JxXuHNtcifN4Olhis=;
        b=QAYxEXG0VTL7VEeOoecEuBxdG+6C2qMvL42zsUuBhzwrC4Rq8BqroxmNQ+61lsAo4U
         4WPQa43TD/dc/8Y9WyOkRyrB3KR0y9FwNjICAyLtuQ4TNAfdyfKV+pH6Edw86gd172g3
         bqSmNCE+u/uJkpvP8rej2WcOZ0AFpfNJjlHNmCBGMZn9ckilYdkAhoA/azf42aJ8TJ/y
         RVa3/t2NcvdndwLbZoiKrtZJAA3rGcJI2+AjoFmYtmI9wveIdALwTmxfZaEn1Z96Th/I
         ogJG1/FwvAPPcXH/oGh9wnTXcJgEXthAQXezVQSOx8drrE/s9ha7J/3CfXRGDwvq5joX
         hZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672268; x=1710277068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMppHw7KV/r56VUSnIREU2O979JxXuHNtcifN4Olhis=;
        b=vHIerHhHa6Aktww/whewPlQhfqUdenhC1v5P+zbTkiJ8OlwX2ZeiC07/1GRh5C7EFm
         bcJ9ZUF27H4SC2PTuLYvYxWAlOa/7LsoSlxmGGzyMYfOzv/cnBHrwVqzqx+jEJHUe/kq
         TE3f69dAk+kb5qzqtmtXj6+9IgREBH4BkHb5kNVtFoZRf/0KiuWt1T3U9SuoVeo7Tysg
         zRSsjYFoWa5YjS9PE9kTvjWrUafeQ6QAcP5c54pauQMzKgeoYEhUWUMrLECjx+TRnNnh
         4s82sgJXYMQ40fHIHdC37qieDXBGsYH/BM2V6c0L6Gd9zZYn1DjuZrkDyJ8E8GouqlUX
         zYQA==
X-Forwarded-Encrypted: i=1; AJvYcCW0q6lDdD45Ku58S8vPRnK8r67Sr5WqVPqXqVs45WcNc9iT84m/A3DBw+YE+3RhKzJJ/j6m4ViSZsjrQB0I+j3/R0lYZb/tEa7Y9J/l
X-Gm-Message-State: AOJu0Yxh+GG6oOcCFYg9hYoLZItLkQDPKGxogzabYNKdHetWLlQE//Bv
	EIbXhLvsW3K4ZkjqDEowiqFxLICepDgj1Jrn834SeHAr+EJqCDibLSgiZEyMRXQ2L1fgjXxEgqZ
	6mE1rT+ZLiiBOnGMnrwslIVDLEnqlH+VP0HN2
X-Google-Smtp-Source: AGHT+IHUUnMvT3jqlx4mYU0Zq3/oVljYM3tgXS+x8Lb6hAUG4wgFseZ7U1lT7XFjP+BusQQ9kBXfhI9r5cdZ6lf7hXM=
X-Received: by 2002:a05:622a:28c:b0:42e:6de9:cd13 with SMTP id
 z12-20020a05622a028c00b0042e6de9cd13mr258781qtw.3.1709672267992; Tue, 05 Mar
 2024 12:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-2-mic@digikod.net>
In-Reply-To: <20240301194037.532117-2-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:57:35 -0500
Message-ID: <CA+GJov4U+bXK3Q2cmXtsdnrNNiwuDmxsU4-ghVM_8M1vjyMVWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kunit: Handle thread creation error
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_125750_486980_8BFE965A 
X-CRM114-Status: GOOD (  16.16  )
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

On Fri, Mar 1, 2024 at 2:40=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> Previously, if a thread creation failed (e.g. -ENOMEM), the function was
> called (kunit_catch_run_case or kunit_catch_run_case_cleanup) without
> marking the test as failed.  Instead, fill try_result with the error
> code returned by kthread_run(), which will mark the test as failed and
> print "internal error occurred...".

Hello!

I have tested this and this fix looks good to me. Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>


>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-2-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index f7825991d576..a5cb2ef70a25 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -69,6 +69,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                                   try_catch,
>                                   "kunit_try_catch_thread");
>         if (IS_ERR(task_struct)) {
> +               try_catch->try_result =3D PTR_ERR(task_struct);
>                 try_catch->catch(try_catch->context);
>                 return;
>         }
> --
> 2.44.0
>

