Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7283CC54798
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 20:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxiO4n45vzilrBo9kDMmtmLfT3QtdcOwiJ3TQqHhtUU=; b=IYnifTfI/733A8KBnUlu8FHEhm
	ZB2zTgMKCM3Bz+zmf2S+hF+QKYJJNXMl7MKB8VFHvmyChiyiLtE8r5/vC/mB3BktE5ngX4yFtXGm8
	Kv8lEkRlDMeLotT9qYIGIII28Gln4tGGbTSF2iXHoMPrFUSd13p6oQFe4s7EiGxF8L3tJV+stPG4c
	ONYG1WnzAGwdaiiPla3ww4iuEsBbLl9Tt+ecWWSixQstp3RIQ2LBQuOTT1QWvUgvdgaq80UbmB3VV
	bKz9S5awRXhXOyuwv9eECHEMTIoppFUx8H5CwyQMKF7LLz1TL6ZFSA9ETgH4AeAKJ3gXnGuOlNAl5
	zP1ko6MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhbrU-0000000FFe4-0CIv;
	Tue, 05 Mar 2024 20:58:08 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhbrR-0000000FFc7-0NkR
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 20:58:06 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-42f024b809cso69831cf.0
        for <linux-um@lists.infradead.org>; Tue, 05 Mar 2024 12:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672283; x=1710277083; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxiO4n45vzilrBo9kDMmtmLfT3QtdcOwiJ3TQqHhtUU=;
        b=VySa7G5VkT50mkJBGo186jHOVwN1/Bf90F1n/dbNFDsfgGWuhupOvuvgqEzQ9elL5q
         65tOwbJ5qaP/YxhABL3nyFMgfW2ftxgGFuDg86a/yntLrqhFMgcff3c/rp0iALyFrkAI
         HoNTWfA4bcqLJ4sRdqYrs+AJDLnqNVbKK8nORV7BrHdjLcg7Wzv80oySbcIqyq1tbz2N
         jAukdPED3vbTXLZnGuf/tYGUW9ntp/vWErY7b/934Bk58VJoM7SeA2fspdFa9GQefxCP
         3aGU5K1dPaK/oNSv2ZpTgEt0E87VjBasZOW9k2AE3ImS4s3R2b7gQ4oJ4ol1orrbHF5A
         8cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672283; x=1710277083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxiO4n45vzilrBo9kDMmtmLfT3QtdcOwiJ3TQqHhtUU=;
        b=uPC9sFMUCs9B1/9Y94V2wPsHMhaWsO8OlaM4eF9M39PZ76rU9SJOfbijB2n1eDUNK1
         ncKPOcM7TvpcLhcIaUX5jXOTlTjiqOTjOjdf2CIy4/dV1RNaWUmt2RFxWUsu5Wr1BE4d
         JYOT+dtr723+Qwc9ZfY1V2dpLsBhpehhlicnWGPpPWJ3nIo2GGphyqIOlEzNPL7uLZ2G
         PGfCbmk5um43NMLlxNtsqqoi7+h2/ojjHHML7McbDXYYbQL5OINK2zNmXfo7ItyeRaW4
         4hwXLQMdLMEVtzDX4saa/WWxQgA+2Kbxi9O9N+StT/oyaEOSg5NShG+hf6tULxAFbyLP
         aX5A==
X-Forwarded-Encrypted: i=1; AJvYcCURfO2Mvh7DCSashDWt7WtjuXUgsqxHbkOhaozQQ193pwW3KoJYQyc1F9yGICnsMJrD28U7dP1d1i7PgUdfq0VODttk7LluFbmIOUD0
X-Gm-Message-State: AOJu0Yy4qeHfwj5zqPsg7WA+mMO7g9oCne/9PNGPQT2Yv1xNy1UYPIAq
	+6W91iWNYgJ9ewzyCvGrXs1PPqh26UvGHzq6wp5KMC/+5ZKV3DqAx66+JkQXq1EdAZzV2sqF4r3
	Wae+uG1ZsWqQdjzGLnnvoCIdjLKF/+B9KBeF1
X-Google-Smtp-Source: AGHT+IHGajjUdBLk7kb5aU5IzN9BFfXaz7kyHr0r9Hfw9dnJJ6/Mro4cDB9qMZ+LQnnYDduac+wAa+5vLvNmFAFMPZ8=
X-Received: by 2002:a05:622a:489:b0:42e:ef12:8025 with SMTP id
 p9-20020a05622a048900b0042eef128025mr263015qtx.25.1709672283186; Tue, 05 Mar
 2024 12:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-3-mic@digikod.net>
In-Reply-To: <20240301194037.532117-3-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:57:51 -0500
Message-ID: <CA+GJov46__vOS9m7Jz9tw+nxd1LFh_a=g1SR=BjUzR9HT65Vew@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kunit: Fix kthread reference
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
X-CRM114-CacheID: sfid-20240305_125805_156157_83DB368E 
X-CRM114-Status: GOOD (  17.84  )
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
> There is a race condition when a kthread finishes after the deadline and
> before the call to kthread_stop(), which may lead to use after free.

Hello!

I have tested this patch and it looks good to me.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>




>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-3-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index a5cb2ef70a25..73f5007f20ea 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -11,6 +11,7 @@
>  #include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> +#include <linux/sched/task.h>
>
>  #include "try-catch-impl.h"
>
> @@ -65,14 +66,15 @@ void kunit_try_catch_run(struct kunit_try_catch *try_=
catch, void *context)
>         try_catch->context =3D context;
>         try_catch->try_completion =3D &try_completion;
>         try_catch->try_result =3D 0;
> -       task_struct =3D kthread_run(kunit_generic_run_threadfn_adapter,
> -                                 try_catch,
> -                                 "kunit_try_catch_thread");
> +       task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter=
,
> +                                    try_catch, "kunit_try_catch_thread")=
;
>         if (IS_ERR(task_struct)) {
>                 try_catch->try_result =3D PTR_ERR(task_struct);
>                 try_catch->catch(try_catch->context);
>                 return;
>         }
> +       get_task_struct(task_struct);
> +       wake_up_process(task_struct);
>
>         time_remaining =3D wait_for_completion_timeout(&try_completion,
>                                                      kunit_test_timeout()=
);
> @@ -82,6 +84,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                 kthread_stop(task_struct);
>         }
>
> +       put_task_struct(task_struct);
>         exit_code =3D try_catch->try_result;
>
>         if (!exit_code)
> --
> 2.44.0
>

