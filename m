Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0787C54E60
	for <linux-um@archiver.kernel.org>; Tue, 12 Mar 2024 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bprwIAh347wxtXFxo/TC2rhDPi+D5q5YAUyuT+/KaFM=; b=k7HKUA9DOBrEG8MLRmq2o8FwU6
	Bs55WVK+RwSs6cRYQs6uPFyoRCNddRg/v/mUYnYJJtjpsxg7t3jSx036XKmxjbNLgkhE+YCwglEJY
	aEZStFBsaWi1OgS2GGHH/oYO/5ITb7CXWxB03cPZsHua+mu8XfBr/+PIjMB/H03cNZk69cDrb9ESe
	LWHx7HVQgQGMES6o45y6Ww59HXSVrH/PkVy7QqRFe+lGKAW0wbsnDzHrWCeiK5Xcdw7nsiUyO0l6G
	URkcCI0frk8gls9LdQ87WaXffng3llrOuHtB8xOr88VBQoEE7tjaZQeaTFsUHTqPfTAVngNY8Y3PH
	R9h1to2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk12f-00000005hID-2J61;
	Tue, 12 Mar 2024 12:15:37 +0000
Received: from smtp-190d.mail.infomaniak.ch ([185.125.25.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk12b-00000005hE9-1Vrw
	for linux-um@lists.infradead.org;
	Tue, 12 Mar 2024 12:15:35 +0000
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TvCJx5bG2z18J;
	Tue, 12 Mar 2024 13:15:29 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TvCJx0DYKzPVG;
	Tue, 12 Mar 2024 13:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710245729;
	bh=WX7qXSs24cTps5vDqV6KBl/rCQO0ApI2/1NKiye/aPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUnVJxRYdJnS/bDaGHsN4zHTKQQYb939oUZSg9Hnzp9TS11vnfyS8RSzxpwgGNAqb
	 ETdL/dMhVuBpsQ5F1dYlSb30lEAXXBxaf5XJsDir9Ica/YQdv1Nk/pPd545PoDvBMX
	 +YunhN+2oVgCX8Ef5ZrfP6LV2dWsbN2XHt/7TyxA=
Date: Tue, 12 Mar 2024 13:15:18 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thara Gopinath <tgopinath@microsoft.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v2 4/7] kunit: Handle test faults
Message-ID: <20240312.Ohfumeel9aes@digikod.net>
References: <20240301194037.532117-1-mic@digikod.net>
 <20240301194037.532117-5-mic@digikod.net>
 <CABVgOSnzaO7EUdSW_xTZd22oc-q_yT9uVoSwTm2jn5pw5pP8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSnzaO7EUdSW_xTZd22oc-q_yT9uVoSwTm2jn5pw5pP8Eg@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_051533_610288_E475A92E 
X-CRM114-Status: GOOD (  38.42  )
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

On Tue, Mar 12, 2024 at 01:05:37PM +0800, David Gow wrote:
> On Sat, 2 Mar 2024 at 03:40, Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Previously, when a kernel test thread crashed (e.g. NULL pointer
> > dereference, general protection fault), the KUnit test hanged for 30
> > seconds and exited with a timeout error.
> >
> > Fix this issue by waiting on task_struct->vfork_done instead of the
> > custom kunit_try_catch.try_completion, and track the execution state by
> > initially setting try_result with -EFAULT and only setting it to 0 if
> > the test passed.
> >
> > Fix kunit_generic_run_threadfn_adapter() signature by returning 0
> > instead of calling kthread_complete_and_exit().  Because thread's exit
> > code is never checked, always set it to 0 to make it clear.
> >
> > Fix the -EINTR error message, which couldn't be reached until now.
> >
> > This is tested with a following patch.
> >
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20240301194037.532117-5-mic@digikod.net
> > ---
> 
> This works fine here, and looks good.
> 
> The use of task_struct->vfork_done is a bit confusing, as there's no
> documentation (that I could find) about what vfork_done means for
> kthreads. From the code, it looks to just be a copy of
> kthread->exited, which is much more obvious a name.

Indeed

> 
> Would it make sense to either (a) replace this with a call to
> to_kthread(), and kthread->exited, or (b) add a comment explaining
> what vfork_done means here. kthread_stop() itself is using
> to_kthread() and kthread->exited -- even though task_struct is also
> there -- so I'd feel a bit more comfortable with that option.

I used vfork_done because to_kthread() and struct kthread are private.
As for a vfork(2), vfork_done is useful to wait for the end of a task.
Feel free to add a comment explaining vfork_done. Thanks

> 
> Otherwise,
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> >
> > Changes since v1:
> > * Added Kees's Reviewed-by.
> > ---
> >  include/kunit/try-catch.h |  3 ---
> >  lib/kunit/try-catch.c     | 14 +++++++-------
> >  2 files changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
> > index c507dd43119d..7c966a1adbd3 100644
> > --- a/include/kunit/try-catch.h
> > +++ b/include/kunit/try-catch.h
> > @@ -14,13 +14,11 @@
> >
> >  typedef void (*kunit_try_catch_func_t)(void *);
> >
> > -struct completion;
> >  struct kunit;
> >
> >  /**
> >   * struct kunit_try_catch - provides a generic way to run code which might fail.
> >   * @test: The test case that is currently being executed.
> > - * @try_completion: Completion that the control thread waits on while test runs.
> >   * @try_result: Contains any errno obtained while running test case.
> >   * @try: The function, the test case, to attempt to run.
> >   * @catch: The function called if @try bails out.
> > @@ -46,7 +44,6 @@ struct kunit;
> >  struct kunit_try_catch {
> >         /* private: internal use only. */
> >         struct kunit *test;
> > -       struct completion *try_completion;
> >         int try_result;
> >         kunit_try_catch_func_t try;
> >         kunit_try_catch_func_t catch;
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index cab8b24b5d5a..c6ee4db0b3bd 100644
> > --- a/lib/kunit/try-catch.c
> > +++ b/lib/kunit/try-catch.c
> > @@ -18,7 +18,7 @@
> >  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
> >  {
> >         try_catch->try_result = -EFAULT;
> > -       kthread_complete_and_exit(try_catch->try_completion, -EFAULT);
> > +       kthread_exit(0);
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
> >
> > @@ -26,9 +26,12 @@ static int kunit_generic_run_threadfn_adapter(void *data)
> >  {
> >         struct kunit_try_catch *try_catch = data;
> >
> > +       try_catch->try_result = -EINTR;
> >         try_catch->try(try_catch->context);
> > +       if (try_catch->try_result == -EINTR)
> > +               try_catch->try_result = 0;
> >
> > -       kthread_complete_and_exit(try_catch->try_completion, 0);
> > +       return 0;
> >  }
> >
> >  static unsigned long kunit_test_timeout(void)
> > @@ -58,13 +61,11 @@ static unsigned long kunit_test_timeout(void)
> >
> >  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> >  {
> > -       DECLARE_COMPLETION_ONSTACK(try_completion);
> >         struct kunit *test = try_catch->test;
> >         struct task_struct *task_struct;
> >         int exit_code, time_remaining;
> >
> >         try_catch->context = context;
> > -       try_catch->try_completion = &try_completion;
> >         try_catch->try_result = 0;
> >         task_struct = kthread_create(kunit_generic_run_threadfn_adapter,
> >                                      try_catch, "kunit_try_catch_thread");
> > @@ -75,8 +76,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> >         }
> >         get_task_struct(task_struct);
> >         wake_up_process(task_struct);
> > -
> > -       time_remaining = wait_for_completion_timeout(&try_completion,
> > +       time_remaining = wait_for_completion_timeout(task_struct->vfork_done,
> >                                                      kunit_test_timeout());
> >         if (time_remaining == 0) {
> >                 try_catch->try_result = -ETIMEDOUT;
> > @@ -92,7 +92,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> >         if (exit_code == -EFAULT)
> >                 try_catch->try_result = 0;
> >         else if (exit_code == -EINTR)
> > -               kunit_err(test, "wake_up_process() was never called\n");
> > +               kunit_err(test, "try faulted\n");
> >         else if (exit_code == -ETIMEDOUT)
> >                 kunit_err(test, "try timed out\n");
> >         else if (exit_code)
> > --
> > 2.44.0
> >



