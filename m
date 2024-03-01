Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75052C5475B
	for <linux-um@archiver.kernel.org>; Fri,  1 Mar 2024 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+NnesQ9cTDdJNQMHWQNTCgjmvn+eX+eTheBcFVBpUoI=; b=R3YjbIgTIIwFZEP0vs3dFJwFFN
	WwksuWaWXOQnJx0S5o8Wh1Ywx2dGOOEiSL07QFubT4n4ELopKWyjVaDR2ovYEOgE7Q5B68Oael8sv
	WEqVv3CdvTNoEEXq8WrLqpI0O4GpU2fvvOs0xg8tdnQ1sXXQ3lZaxr73fsSoppDmseQ6tON6SubXF
	HWRddnUW8AU+UauTwhnQJTuDnZ5iPpPSjnWFlA9R4QfF25e38UOLhXxsrJ63Rn69Ze6XRjzIZQNYl
	y5cUcFN/LFKu+zNszkU5jMqWtl8JxoqATjO+kBL+ovmQpKwcbbsLoym5Fnv//7a5aBnk8RDSgzwis
	HODR5dMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8Mo-00000001gYY-3Sp5;
	Fri, 01 Mar 2024 19:16:22 +0000
Received: from smtp-bc0f.mail.infomaniak.ch ([45.157.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8Mm-00000001gWz-0H9h
	for linux-um@lists.infradead.org;
	Fri, 01 Mar 2024 19:16:21 +0000
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tmd9Y1VK2zXyj;
	Fri,  1 Mar 2024 20:16:17 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tmd9W6JqCzpmw;
	Fri,  1 Mar 2024 20:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709320577;
	bh=Q7fU6Ub3q+6YxoCBFaoEp7a/GqkOwDsLuYbxuGhGrJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekdE8C1Ycehc5cU0FFdPBLOQIWYuuwCoAVIcd6blq2ECeRFY83hIegduUPkzETJSJ
	 1aED213nnnjEoQbHieGvuKeSAmm8UB1bPBZPlrobr+nQOfkOfTvxMUACoi0q1XEtyO
	 1h134Jafh7/zywAVozq8HQY0K0a+ZnyoDROUVHAo=
Date: Fri, 1 Mar 2024 20:16:05 +0100
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
Subject: Re: [PATCH v1 8/8] kunit: Add tests for faults
Message-ID: <20240301.aekiung2aL7K@digikod.net>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-9-mic@digikod.net>
 <202402291027.6F0E4994@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402291027.6F0E4994@keescook>
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_111620_271340_B040EAB0 
X-CRM114-Status: GOOD (  24.55  )
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

On Thu, Feb 29, 2024 at 10:28:18AM -0800, Kees Cook wrote:
> On Thu, Feb 29, 2024 at 06:04:09PM +0100, Mickaël Salaün wrote:
> > The first test checks NULL pointer dereference and make sure it would
> > result as a failed test.
> > 
> > The second and third tests check that read-only data is indeed read-only
> > and trying to modify it would result as a failed test.
> > 
> > This kunit_x86_fault test suite is marked as skipped when run on a
> > non-x86 native architecture.  It is then skipped on UML because such
> > test would result to a kernel panic.
> > 
> > Tested with:
> > ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_x86_fault
> > 
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> 
> If we can add some way to collect WARN/BUG output for examination, I
> could rewrite most of LKDTM in KUnit! I really like this!

Thanks!  About the WARN/BUG examination, I guess the easier way would be
to do in in user space by extending kunit_parser.py.

> 
> > ---
> >  lib/kunit/kunit-test.c | 115 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 114 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> > index f7980ef236a3..57d8eff00c66 100644
> > --- a/lib/kunit/kunit-test.c
> > +++ b/lib/kunit/kunit-test.c
> > @@ -10,6 +10,7 @@
> >  #include <kunit/test-bug.h>
> >  
> >  #include <linux/device.h>
> > +#include <linux/init.h>
> >  #include <kunit/device.h>
> >  
> >  #include "string-stream.h"
> > @@ -109,6 +110,117 @@ static struct kunit_suite kunit_try_catch_test_suite = {
> >  	.test_cases = kunit_try_catch_test_cases,
> >  };
> >  
> > +#ifdef CONFIG_X86
> 
> Why is this x86 specific?

Because I didn't test on other architecture, and it looks it crashed on
arm64. :)

I'll test on arm64 and change this condition with !CONFIG_UML.

> 
> -- 
> Kees Cook
> 

