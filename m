Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBCCCF3195
	for <linux-um@archiver.kernel.org>; Wed,  2 Oct 2024 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=; b=jbR4fMxazN8ddHOlARJhWoEDvK
	rXJDb5XGMZNWKm1zSYq+al2OtT6pwiteoSGO4b1++H4048DUmEo259/SWS892FmHE+3m2C2ZIeyOs
	NPQl/TcjQlkQkiMsjlmQtPqQtgVxwcOiPHtDC11NZgSBQOh1W5vCHmADvG27qU35cW3xOyfRecZ4O
	XuuQ9ODYECuAO0985gqnlApc8UkFWeEzndhOoL0sriQgpikfTEbUec7R4hYejOcnyb+tovnINhvhw
	m8zyAuobP2ijeGLapTuhzlK6jRCm40V3KnLI3d6mGpJkQFlAkyMd5ct19mZyEst8Do5hfj9Yb83AR
	LLb+8VXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svt4v-00000004xNr-1OvR;
	Wed, 02 Oct 2024 06:43:17 +0000
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svt4n-00000004xMd-1JS3
	for linux-um@lists.infradead.org;
	Wed, 02 Oct 2024 06:43:15 +0000
Received: by mail-qv1-xf44.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so8945466d6.1
        for <linux-um@lists.infradead.org>; Tue, 01 Oct 2024 23:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1727851387; x=1728456187; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
        b=uxJxeP/pK7uvcxMkq1EbsXrJBe1TML+v4HYgkAG7xEfKSl6w9oP0S6yD2Wa8fRK9E2
         hDxhl2mHTSaHLl1OJCDPU7tMjsfjI260QQXqndTLIWCAs8+vZEjOSt5sGHnXtueYCOkX
         Gxq7XORBRZgpzqN3Nht0X/MU0acwdZ2GRJJC9JuyjhubUeBZWwb+pSPWlGupaG5urz+A
         rTgZCU5wIq1r5M/bF9CtnaBDqoHWk99N3XeMYp5bjRSLg+S+j4kghghFjf1SZasc5n5s
         woKf9win7IyxtwwLmbl2t6E4EBWlXKMqPneuHPqzRTmG8XJj7nl4/nHpT+LgW4/mXHo8
         CXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727851387; x=1728456187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
        b=E8+5QQLPxBnAEfkDTYba9MAhEShQ6C94iWDPUsD18RPaRsPclzTQUNQDOXJzr58Kya
         dYaugM+83866QTrLTKB215RQhUjSzLr5dM3bXIt2HJQouMq6h00x//CbNNWQmjuIPFp5
         6Y/S3EU4KWXmfnTAOAZbsmNmo6hGZWF8lMfCNIhMF5Ajo6Z20O8K5R+w4Q82V6CpOg3t
         IK0rWu+Lb57YVnj60j1/nIYKl3nnrGq9/5Sr14Pif52/FcXfnezOsUdsiqce7AyQ0FBH
         hAssOIombd0LiWqi9OYzk2wr5AG/KmPV0jYXe9thkJDACxxV94cUydb29FJlI4v/c/Tx
         mLXw==
X-Forwarded-Encrypted: i=1; AJvYcCXYC0WskC+LO0HBAqRc10yhDBnES5/rJfcbXQxxLN7c5DEl8MtR24E3FiurkNZudhFg7xpT34OAbA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4cS6ka7/9ef/Ytq7sLAOBTVSVW8VqcRN3nb9f3UXO2FAg9MVI
	Gy735UE2RR6hSAsaWD4V0Li6mb3EXcHSH4JjtwQN9WaucDCjfbKtTKWxRT/OrQ==
X-Google-Smtp-Source: AGHT+IHrkRLceuVqxuW80Ei9nOewPBzqZcw30/kwrIYrc0giV5pzOirc+orj5fvwWApNas7yutkn3w==
X-Received: by 2002:a05:6214:3f86:b0:6cb:7fb1:2038 with SMTP id 6a1803df08f44-6cb81cc447emr31672946d6.53.1727851386930;
        Tue, 01 Oct 2024 23:43:06 -0700 (PDT)
Received: from shizuku.. ([2620:0:e00:550a:41e8:eb4:11eb:d3ce])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6008efsm57077246d6.15.2024.10.01.23.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 23:43:06 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Wed,  2 Oct 2024 01:42:52 -0500
Message-Id: <20241002064252.41999-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002045347.GE555609@thelio-3990X>
References: <20241002045347.GE555609@thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_234309_644929_DFB7C5CF 
X-CRM114-Status: GOOD (  32.37  )
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

Hi Nathan,

Thanks for all the comments!

On 2024-10-01 23:53, Nathan Chancellor wrote:
> Hi Wentao,
>
> I took this series for a spin on next-20241001 with LLVM 19.1.0 using a
> distribution configuration tailored for a local development VM using
> QEMU. You'll notice on the rebase for 6.12-rc1 but there is a small
> conflict in kernel/Makefile due to commit 0e8b67982b48 ("mm: move
> kernel/numa.c to mm/").
>
> I initially did the build on one of my test machines which has 16
> threads with 32GB of RAM and ld.lld got killed while linking vmlinux.o.
> Is your comment in the MC/DC patch "more memory is consumed if larger
> decisions are getting counted" relevant here or is that talking about
> runtime memory on the target device? I assume the latter but I figured I

Yes the build process (linking particularly) is quite memory-intensive if
the whole kernel is instrumented with source-based code coverage, no matter
it's with or without MC/DC. What you've observed is expected. (Although the
quoted message was referring to runtime overhead)

On the last slide of [8] I had some earlier data regarding full-kernel
build- and run-time overhead. In our GitHub Actions builds [9], I have
been keeping track of "/usr/bin/time -v make ..." output and the results
can be found in step => "4. Build the kernel" => "Print kernel build
resource usage". You may want to check them.

I am not aware of neat ways of alleviating this overhead fundamentally so I
would love any advice on it. And perhaps now the more recommended way of
using the proposed feature is to instrument and measure the kernel on a
per-component basis.

[8] https://lpc.events/event/18/contributions/1895/attachments/1643/3462/LPC'24%20Source%20based%20(short).pdf
[9] https://github.com/xlab-uiuc/linux-mcdc/actions

> would make sure. If not, it might be worth a comment somewhere that this
> can also require some heftier build resources possibly? If that is not

Sure.

> expected, I am happy to help look into why it is happening.
>
> I was able to successfully build that same configuration and setup with
> my primary workstation, which is much beefier. Unfortunately, the
> resulting kernel did not boot with my usual VM testing setup. I will see
> if I can narrow down a particular configuration option that causes this
> tomorrow because I did a test with defconfig +
> CONFIG_LLVM_COV_PROFILE_ALL and it booted fine. Perhaps some other
> option that is not compatible with this? I'll follow up with more
> information as I have it.

Good to hear that you've run it and thanks for reporting the booting issue.
You may send me the config if appropriate and I'll also take a look.

>
> On the integration front, I think the -mm tree, run by Andrew Morton,
> would probably be the best place to land this with Acks from the -tip
> folks for the x86 bits? Once the issue above has been understood, I
> think you can send v3 with any of the comments I made addressed and a
> potential fix for the above issue if necessary directly to him, instead
> of just on cc, so that it gets his attention. Other maintainers are free
> to argue that it should go through their trees instead but I think it
> would be good to decide on that sooner rather than later so this
> patchset is not stuck in limbo.

Yeah -mm tree sounds good to me. Let me work on v3 while we address the
booting issue and wait for others' opinions if any.

Thanks,
Wentao

>
> Cheers,
> Nathan

