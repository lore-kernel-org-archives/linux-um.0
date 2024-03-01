Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFF1C5475B
	for <linux-um@archiver.kernel.org>; Fri,  1 Mar 2024 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MveRQUnOJzWljed8yOqB1iTmcwu1AfsyxpmPH6L9dTw=; b=MxMp3l3xesE8ky0aI0dTIX/9NI
	vCdHjfWatIhqDCmRP2jBgUYWFBP+pZZlmBWVihQTv7s5CrzZFdc4lT78yiFGIAv4S/lWuhXQV4g0y
	KhQWYUyiBQ2A1vuMmag/aO1HOmVYRO3wvbfejsN1/4BzGszxyH7K48XMSS9PevhESNBDaBQGL5ZHF
	LdZBmqSLOkH2NZUsQG6tq1J+xdZUqId/GggZ62WysO86UBv+hvgkGKGTxB2Rel/KB6laS8OYWCJoM
	L6eqvvvL4tSaJHp1OuzgtLUNTwcdaD2yizetM7ZGw5sniLhiNEIwwF090LzDxD+1+UNEO2259MK9C
	Ya1KBKvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8GP-00000001fIc-1z5s;
	Fri, 01 Mar 2024 19:09:45 +0000
Received: from smtp-42ac.mail.infomaniak.ch ([2001:1600:4:17::42ac])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8GM-00000001fGc-2dGO
	for linux-um@lists.infradead.org;
	Fri, 01 Mar 2024 19:09:44 +0000
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tmd1t6YX5zMyYJT;
	Fri,  1 Mar 2024 20:09:38 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tmd1s45G5zMpnPg;
	Fri,  1 Mar 2024 20:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709320178;
	bh=rjofMt5czWAZ/8UdgmbuNLIMUbqVfuBuDdVqP8nEB2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnzKh2OBS0YkrIYpEspkpvDAydMZFIZk4Nh0+Gbx0+8Lk3b671LXi4kdNjVmCBsTZ
	 Rm7K2WbZWudBEHrEPsAMJOJB+6kHAUx0XE/0mQzOmvZ1EZHpPA5fTAcSzByG999MpW
	 RTwlsi3ZWspSksJZHRaVH8PWKdKF1bQBjNrpiNAw=
Date: Fri, 1 Mar 2024 20:09:27 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
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
Subject: Re: [PATCH v1 5/8] kunit: Handle test faults
Message-ID: <20240301.EeyeePa2lien@digikod.net>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-6-mic@digikod.net>
 <202402291023.071AA58E3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402291023.071AA58E3@keescook>
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_110942_829189_EA512199 
X-CRM114-Status: GOOD (  18.90  )
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

On Thu, Feb 29, 2024 at 10:24:19AM -0800, Kees Cook wrote:
> On Thu, Feb 29, 2024 at 06:04:06PM +0100, Mickaël Salaün wrote:
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
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> 
> I assume we can start checking for "intentional" faults now?

Yes, but adding dedicated exception handling for such faults would
probably be cleaner.

At least we can now easily write tests as I did with the last patch. The
only potential issue is that the kernel will still print the related
warning in logs, but I think it's OK for tests (and maybe something we'd
like to test too by the way).

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook
> 

