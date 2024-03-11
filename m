Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98718C5475B
	for <linux-um@archiver.kernel.org>; Mon, 11 Mar 2024 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWb2A9iIkGs3AmFlz53bU5Efj9ZUWJhfOe0zRp0tGRc=; b=WvvyYD9r5WYzEleh43fMXo9w9a
	4/Rq99FNuVTKZGN/oydmIRkMVRXYwlVWi+6GbfEJ9a1XBsGB2sYI7VrRUXil3s5Q2F2QVU7puBCO3
	KKVLf5hKTu637hUxLKGSjoWJrAU6V925kOm+LBG34qciYL2JGQHWhL3lebspYRm+9BekXg6JrxJF6
	mO50L6HIe7mwHfTzAL4BmcgvyGwi24c0JNvcyqeuU3vBs+cQMaojywi8azRfuGI9BpbVx5/96i3PG
	JEDFnybGSomAwo43p3U4iWYgSZFFlPzz7RzRSZF7qQD7f7D3ZzO7+IeaRCrOt2UrX1Y5SHO05/5Lb
	1DJccTsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjn5R-00000003Eyd-1whb;
	Mon, 11 Mar 2024 21:21:35 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjn5M-00000003Ew8-22E2
	for linux-um@lists.infradead.org;
	Mon, 11 Mar 2024 21:21:30 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-42ef8193ae6so20671cf.1
        for <linux-um@lists.infradead.org>; Mon, 11 Mar 2024 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710192084; x=1710796884; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWb2A9iIkGs3AmFlz53bU5Efj9ZUWJhfOe0zRp0tGRc=;
        b=NJrcwS63NEA65QqpZqMCdYx2Z3OhyD4gTv7+Sqt8QlU6VG4HnRJIrDPftlF28rbF4g
         vHnMfuSmzjqsiZO6TWT2o+GysjYQdbKO0WTO4G5Cj7wWKnDNa2geiDXBYpK4YUHVBoc9
         IC5x330VP20ERTv+SGVos/zh4fz/e1sbNhb1RwvEWCFlIBvMGTDFe0tTZLOtPKn3JES2
         LtapKbSvjUFwOwUIlBvZGZCQQ6OJD2hdmdtAtJvr+GQL8K447nxv1O8ogHo91+Q2pUzi
         Evrm0BQLygh5VyddnA1WE4Xxkh2vc/c8gVUVIHArZTL8TeUcG4WQRwFgDpTt57n5dmLN
         aHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192084; x=1710796884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWb2A9iIkGs3AmFlz53bU5Efj9ZUWJhfOe0zRp0tGRc=;
        b=sECVaaij2unCYbqreOdLsp9TzD6JT+enEZwSeQ6HfZVnHp7NG9oJTVjJe7sPX65SdD
         AwRkCyTm4EzeApway4RSpdoLXRw8zfi61faYU2lVbts4kPJBII5ahTJaH4utIqxb3Xxi
         6wsPuR1lHqB3Cq0p+6EX3PjFaC6qoO3mxGIveQzOAvpHoykdg14vJ3vtW45YToxEJvbx
         43woS7bxTDHb0W/te4Re8DFWMwH3nxInvwVtzEYrFp8pPJ8Q9OL403H+c/mYL+b0lhNb
         sYioqGOua5M9XMIImdAZpfwEhtGn/Hy2jTupn9oYa82sQ4L0s46J04s1ZE3ReWzvzUCD
         IefQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUq6/EhBisfZ2JJJp4Bt9odSt6oW0b/24A2I4MQiVJbSAu0bZqP9jbBGAvG6wVs+xdNqEw47fspinmDd+Tai6EvlSHvqj4xvdhvwqf
X-Gm-Message-State: AOJu0Yya6INi4AjBEzsbGVPtj2w+BfXK68ZhmyCzBv5KZpesllAw8o1m
	rW2cEYPTyeTnabwDNl33S48wwv03vg4FCuILKMtqZB0ZiyXrQMHqryw3tbN74hdU04KTVPGWFxv
	HAiFu1nXM7J9NW5bwXEo9uyyNvq4SJHbmEbro
X-Google-Smtp-Source: AGHT+IGiw3N/c7EMgtHBYf+GhpaM4BMFpUmbsLp7eZNB/I9uRFUCN7Phn/vKm3/rRq1HFpGOLfkrYTvw5DSVfzOksbM=
X-Received: by 2002:ac8:748f:0:b0:42f:213a:dc9b with SMTP id
 v15-20020ac8748f000000b0042f213adc9bmr36743qtq.19.1710192084473; Mon, 11 Mar
 2024 14:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-5-mic@digikod.net>
In-Reply-To: <20240301194037.532117-5-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Mon, 11 Mar 2024 17:21:11 -0400
Message-ID: <CA+GJov7in4o6bXt_JDqeGjjD08yOweiUshesS4cUWTHYfgJAwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] kunit: Handle test faults
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
X-CRM114-CacheID: sfid-20240311_142128_551823_7B01389E 
X-CRM114-Status: GOOD (  31.61  )
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
> Previously, when a kernel test thread crashed (e.g. NULL pointer
> dereference, general protection fault), the KUnit test hanged for 30
> seconds and exited with a timeout error.
>
> Fix this issue by waiting on task_struct->vfork_done instead of the
> custom kunit_try_catch.try_completion, and track the execution state by
> initially setting try_result with -EFAULT and only setting it to 0 if

Hello!

Thanks for your patch! This has been tested and seems pretty good to
me but I just have a few questions. First, do you mean here "setting
try_result with -EINTR"  instead?

But happy to add the tested-by.

Tested-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> the test passed.
>
> Fix kunit_generic_run_threadfn_adapter() signature by returning 0
> instead of calling kthread_complete_and_exit().  Because thread's exit
> code is never checked, always set it to 0 to make it clear.
>
> Fix the -EINTR error message, which couldn't be reached until now.
>
> This is tested with a following patch.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-5-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  include/kunit/try-catch.h |  3 ---
>  lib/kunit/try-catch.c     | 14 +++++++-------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
> index c507dd43119d..7c966a1adbd3 100644
> --- a/include/kunit/try-catch.h
> +++ b/include/kunit/try-catch.h
> @@ -14,13 +14,11 @@
>
>  typedef void (*kunit_try_catch_func_t)(void *);
>
> -struct completion;
>  struct kunit;
>
>  /**
>   * struct kunit_try_catch - provides a generic way to run code which mig=
ht fail.
>   * @test: The test case that is currently being executed.
> - * @try_completion: Completion that the control thread waits on while te=
st runs.
>   * @try_result: Contains any errno obtained while running test case.
>   * @try: The function, the test case, to attempt to run.
>   * @catch: The function called if @try bails out.
> @@ -46,7 +44,6 @@ struct kunit;
>  struct kunit_try_catch {
>         /* private: internal use only. */
>         struct kunit *test;
> -       struct completion *try_completion;
>         int try_result;
>         kunit_try_catch_func_t try;
>         kunit_try_catch_func_t catch;
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index cab8b24b5d5a..c6ee4db0b3bd 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -18,7 +18,7 @@
>  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
>  {
>         try_catch->try_result =3D -EFAULT;
> -       kthread_complete_and_exit(try_catch->try_completion, -EFAULT);
> +       kthread_exit(0);
>  }
>  EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
>
> @@ -26,9 +26,12 @@ static int kunit_generic_run_threadfn_adapter(void *da=
ta)
>  {
>         struct kunit_try_catch *try_catch =3D data;
>
> +       try_catch->try_result =3D -EINTR;
>         try_catch->try(try_catch->context);
> +       if (try_catch->try_result =3D=3D -EINTR)
> +               try_catch->try_result =3D 0;
>
> -       kthread_complete_and_exit(try_catch->try_completion, 0);
> +       return 0;

Really my only question is why we do not need to still do a
kthread_exit(0) here? I realize we are not checking the thread's exit
code but isn't it safer to call kthread_exit(). I'm new to kthread so
I am not too sure.

>  }
>
>  static unsigned long kunit_test_timeout(void)
> @@ -58,13 +61,11 @@ static unsigned long kunit_test_timeout(void)
>
>  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *contex=
t)
>  {
> -       DECLARE_COMPLETION_ONSTACK(try_completion);
>         struct kunit *test =3D try_catch->test;
>         struct task_struct *task_struct;
>         int exit_code, time_remaining;
>
>         try_catch->context =3D context;
> -       try_catch->try_completion =3D &try_completion;
>         try_catch->try_result =3D 0;
>         task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter=
,
>                                      try_catch, "kunit_try_catch_thread")=
;
> @@ -75,8 +76,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         }
>         get_task_struct(task_struct);
>         wake_up_process(task_struct);
> -
> -       time_remaining =3D wait_for_completion_timeout(&try_completion,
> +       time_remaining =3D wait_for_completion_timeout(task_struct->vfork=
_done,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
>                 try_catch->try_result =3D -ETIMEDOUT;
> @@ -92,7 +92,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         if (exit_code =3D=3D -EFAULT)
>                 try_catch->try_result =3D 0;
>         else if (exit_code =3D=3D -EINTR)
> -               kunit_err(test, "wake_up_process() was never called\n");
> +               kunit_err(test, "try faulted\n");
>         else if (exit_code =3D=3D -ETIMEDOUT)
>                 kunit_err(test, "try timed out\n");
>         else if (exit_code)
> --
> 2.44.0
>

