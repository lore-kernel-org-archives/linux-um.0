Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48849C54798
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NM9bu0HcRSpvQ/lk6AsEXTNfL1CGnBbQK/LGwtIb+y4=; b=175SnSLC9Gbi4IrQ9S9h067TRF
	QUyx0+CB9PQ4DcZc+0EmbMofLnw0Wig8GIl5iMR9eDEW10/weRujFvT64poSo7/dDju84ZV7z35IE
	o0XD9PMncrAy853cBCGApWZUHYAXcite0iUAUEy/1aJzIDwHbMthQmw+IxaQc19mKd6wq5w+rmz8y
	3x/IpnManAupRZCEGyNpQWIGpW3otHBOWQxgyQ4LiYn8GJyNwNuZaJl+F3HpFQDeCfGWkllCGVgzg
	l/SESA0zH0YbQ2/rRam7kIc7ZAOttpfm72MCtBoDHQgMN0DVi6L/0Hn1AG/8rcKRzyrCtVsC/nFkQ
	zZ+kLrMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhbrg-0000000FFjF-3u3Z;
	Tue, 05 Mar 2024 20:58:20 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhbre-0000000FFiK-1DP5
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 20:58:19 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-428405a0205so75861cf.1
        for <linux-um@lists.infradead.org>; Tue, 05 Mar 2024 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672297; x=1710277097; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM9bu0HcRSpvQ/lk6AsEXTNfL1CGnBbQK/LGwtIb+y4=;
        b=T0cQlMwpfch+PyXbdZRR5fB+19OeviRKHElfyNn9SG8PO/dp0dDKxYiKKuEBQiOzDV
         ELGTEZA4qSv7BFwBRip0RmOfDEFwq2ap5NXLXt06aWLMOYsGrY2WtQ4xv3fJpizYoElh
         pb1cshRIHV3Id2lRF3odM3WJ2btxuJgp2nYvBoFJbpPMte9rTArdkxD/M8rUAHSGpVEp
         7YbmajbN99odoPlfvOeC/ToK/4cimKLSRDakg95cOdCa5c/xPIYt3eRdVj9vmQbovcCo
         N6XORuQITXwCP5ulfCsl3fiYCgkqrE3+mNdxYMEfUjFpVTHX8k4bB9sIXSz8q+fbRnPb
         phPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672297; x=1710277097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NM9bu0HcRSpvQ/lk6AsEXTNfL1CGnBbQK/LGwtIb+y4=;
        b=aI1aIPNcnga6siSzY4SqejrIXIZ3M1ADi5/rthmEJ3c7bRnKMj9zBTLB4mg73hVEei
         5vvTRRdBsovmXSAQW7jg2DQ8ljq8agah8ERDff3r097FlEOglXT3hmc4XQIZQLs9qcyA
         5NW2x37iaE5VFNYm4ngvmuo+9R1PZoOY7DnjI6IZsUYzo7u5y5WLe692KIgPxLsCmWbE
         ICuf9TwjflTKp5tedTFzdvyu/kJXkt+/sobKOuDa1i85r9q+QlVneQy6j7sT1Vq8sF3x
         Lz09GLkYIDlNKFOfR2ltBknZLKB9p+vvgqwiuj/ovRm/3seIttX/l7KQbXIl52TwVpyB
         h90A==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ji8WJ3olOyxmsFW3FUFvOYsbTHS/ma670/EtuGkhnej2mn6pp14iDHw93gxGBaaRgATjIR2RvLJFDWpFrdMv97MdcLVyGLPWPWpf
X-Gm-Message-State: AOJu0YyCKVk5oI5a4wAB5c7uxLevetRHRgOP7P0nJdtZD+fWbSpO2srJ
	blpRxwdlSWAiYGu8vLw+2yuRbCkP3vh6DnmYkkGlz2dk0Akui9CYZmMGlYxii3IHVgwkoOAZsDR
	E6YxhGgyA5l6E0kHkG6OqzNknjms4YAFWr3Gz
X-Google-Smtp-Source: AGHT+IGJuhFV2CSZhTpphuYInlBxp0BhTfrnQUeh2OvKsSqzEL4tX1NuAVfzJjBoxId+yPuVZh+Ut8IQpuDDq6mQdxI=
X-Received: by 2002:ac8:59d5:0:b0:42f:a3c:2d4c with SMTP id
 f21-20020ac859d5000000b0042f0a3c2d4cmr72229qtf.13.1709672297226; Tue, 05 Mar
 2024 12:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-4-mic@digikod.net>
In-Reply-To: <20240301194037.532117-4-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:58:05 -0500
Message-ID: <CA+GJov4BPGuuu+oivgX3Z0J8sb1bYLhrNRrex7qza45WNMtBcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: Fix timeout message
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
X-CRM114-CacheID: sfid-20240305_125818_436546_0B02958F 
X-CRM114-Status: GOOD (  16.56  )
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
> The exit code is always checked, so let's properly handle the -ETIMEDOUT
> error code.

Hello!

This change looks good to me. Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>


>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-4-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 73f5007f20ea..cab8b24b5d5a 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -79,7 +79,6 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         time_remaining =3D wait_for_completion_timeout(&try_completion,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
> -               kunit_err(test, "try timed out\n");
>                 try_catch->try_result =3D -ETIMEDOUT;
>                 kthread_stop(task_struct);
>         }
> @@ -94,6 +93,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                 try_catch->try_result =3D 0;
>         else if (exit_code =3D=3D -EINTR)
>                 kunit_err(test, "wake_up_process() was never called\n");
> +       else if (exit_code =3D=3D -ETIMEDOUT)
> +               kunit_err(test, "try timed out\n");
>         else if (exit_code)
>                 kunit_err(test, "Unknown error: %d\n", exit_code);
>
> --
> 2.44.0
>

