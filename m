Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B03EC07C79
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pv8Vpl/p6hWBRbxpbdndSCYNMCjzk/damkKcPWlghIY=; b=OUe1mINsI7a7xDObjYMgODT2gG
	yNQ/sWlwL4Hzqe7dfPK7w2nRUs5Z4XsV1d/TaWkX4k16/K/e0boN32QS06Tv54Xov9/GjzJaCWplc
	HJYsfwoAUNopkqjGdw+GLofrNgLWL7VUR5ne5rV9jGj24L7grbX3H9PYi7hwGpvymQgaU3F3QJhGV
	YqEn5jip98JwC9UpocFLKn5MuVJQjUkryLeudHrpbF+vqVATVNQk4Y1P+YyOwsX8AafQ/wFzpR2D6
	YM8rFMYbIlZtDV4aj5ANJ9pVLfRA4+itssoSahea5VyFKl8jtqVqp+zQ0ODzFqBR88uuVe7eSs4UL
	DjNhIOsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rytQ1-0000000DgGj-3VVs;
	Mon, 22 Apr 2024 13:09:13 +0000
Received: from smtp-8fa9.mail.infomaniak.ch ([2001:1600:7:10::8fa9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rytPs-0000000Dg1V-3wtW
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 13:09:10 +0000
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VNQYc6JShz3q7;
	Mon, 22 Apr 2024 15:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1713791332;
	bh=GjhTJjoSiC3IDIVXzgKQ4P+qNveHUQ6lI+EgnHlfUqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaC5f4gjQmTg7HWgvo8OaBYgvZVVaUnv+Y6B/jdsg0Q4f2OLDr4AYla0dAr871yUg
	 SXigC7/aA4mp4zabDYUfQYwz/kj2V8GznfSGfeIslpVajiSP9OYd5T8+9TTpiL7YOt
	 axM86vO0S3TpXTEvr00XTnMRotQwMoJZqzDgMjqE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VNQYb16q2zrw3;
	Mon, 22 Apr 2024 15:08:50 +0200 (CEST)
Date: Mon, 22 Apr 2024 15:08:50 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Guenter Roeck <linux@roeck-us.net>, David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thara Gopinath <tgopinath@microsoft.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 7/7] kunit: Add tests for fault
Message-ID: <20240422.thesh7quoo0U@digikod.net>
References: <20240319104857.70783-1-mic@digikod.net>
 <20240319104857.70783-8-mic@digikod.net>
 <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net>
 <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_060905_482724_1DF1C689 
X-CRM114-Status: GOOD (  21.35  )
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

On Fri, Apr 19, 2024 at 04:38:01PM -0700, Guenter Roeck wrote:
> On Fri, Apr 19, 2024 at 03:33:49PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Tue, Mar 19, 2024 at 11:48:57AM +0100, Mickaël Salaün wrote:
> > > Add a test case to check NULL pointer dereference and make sure it would
> > > result as a failed test.
> > > 
> > > The full kunit_fault test suite is marked as skipped when run on UML
> > > because it would result to a kernel panic.
> > > 
> > > Tested with:
> > > ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
> > > ./tools/testing/kunit/kunit.py run --arch arm64 \
> > >   --cross_compile=aarch64-linux-gnu- kunit_fault
> > > 
> > 
> > What is the rationale for adding those tests unconditionally whenever
> > CONFIG_KUNIT_TEST is enabled ? This completely messes up my test system
> > because it concludes that it is pointless to continue testing
> > after the "Unable to handle kernel NULL pointer dereference" backtrace.
> > At the same time, it is all or nothing, meaning I can not disable
> > it but still run other kunit tests.
> > 

CONFIG_KUNIT_TEST is to test KUnit itself.  Why does this messes up your
test system, and what is your test system?  Is it related to the kernel
warning and then the message you previously sent?
https://lore.kernel.org/r/fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us.net
It seems David has a solution to suppress such warning.

> 
> Oh, never mind. I just disabled CONFIG_KUNIT_TEST in my test bed
> to "solve" the problem. I'll take that as one of those "unintended
> consequences" items: Instead of more tests, there are fewer.
> 
> Guenter
> 

