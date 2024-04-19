Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5B1C4345F
	for <linux-um@archiver.kernel.org>; Fri, 19 Apr 2024 22:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TO5By6VnNS1IaJWTkgMBtokxedo0r6Z5DxfCvgc5tPg=; b=CIoJT/PrU0Pc8G/tVQjtM8bxPQ
	zgOcPG7e4xHL8WRVDXA3GP7hieICeUoJOB1PS0uKzhgxJqs7lG1YMHdpHAiN2XFnMJAzp3m5D3mH/
	zdcBwVpCmlEYdFA489Msim0l50uh7SeEM5fA+7ux1FOJvBDRX7z3aLd1XqvDRdv+ximctLseO1COr
	FyEB/kcXDz7O5xktn9wrHhN67cxEOZlVyfnAbzHqAuQYhcsqjTHGHBdWFoHEX4H1SoqjaTnRZFRWa
	GeJRHq2z7XXxn1oTu+DKUpSAHa2iMtrbKCWUxbsMRnKOZKTPcvaIcNtW/C5ynvWd7B0YPvcrw4+UA
	SNHYoBMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxwnq-000000079db-3qYU;
	Fri, 19 Apr 2024 22:33:54 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxwnn-000000079cK-31jv
	for linux-um@lists.infradead.org;
	Fri, 19 Apr 2024 22:33:53 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1e834159f40so20788755ad.2
        for <linux-um@lists.infradead.org>; Fri, 19 Apr 2024 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713566029; x=1714170829; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TO5By6VnNS1IaJWTkgMBtokxedo0r6Z5DxfCvgc5tPg=;
        b=eFC/GfrQfUikOebeWHyBUZQG4QcEdlMk88GXB6dZKLsS3vfYWUbICnUQe6mW3avfhn
         l1cToWgJMTRcd9nU4bYuDY+GgymHeeW8S1L3hfoYiMG9uCSopk8g2vLt9YUP4EorENuV
         hEpC4QTosEcpXxLSFTGMiMtbA1kUEx0+UFsJw568NFtUrWoSOHtLvm3eu5lRWlRH4H4V
         O91IyKKHzOUYEkQhp6TFtRyb5PJlgFkRLQGprgXkIzJZ5hJajKy64ozONDDDQ3HnGrZc
         icgDEbN4LsLgKZrLCUzzGDgaGfrqSUCo3Nyz6Lw+e4nWJ5vp9YM6k+O2p1kZZ+Ihgk8z
         ADWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713566029; x=1714170829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TO5By6VnNS1IaJWTkgMBtokxedo0r6Z5DxfCvgc5tPg=;
        b=LdY5h4pAvVSAsvVlXti4ZjBvju/zQT4Ml6vNqLPEMULCwnXF+O83DFHxRRsBl26V/z
         nZ5lH91BMny/WcKjeFKB8rUKrK5NxUqJXa84nqNQsORMUluH+uDXa1StePRB6ombQtEn
         CSbWrWBxb81Z9NCuLZEWPDM7h1nb2wEHiY3NpfOLdfltjD9IitSTmQU6HEjqS4+bSoK2
         /pG9EVDmJQRhuHI6LS3AZplG39GHj6290NAbQYNHpF6jI+7AKMld0weY/EzFnjYfLCX8
         uGd4PvVLb/NB6YtBIi9AAzXTO3dpVDtBPN8hBMGDYFWBrxeiK7ix5UeNzjuUs1IYswTf
         z3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXht7En+Ysf9FD84AY1bOtZkiPYopmiqll0ip+Kjab12RuSuvlvwjvjVeHRgup1D6zPByCS/MQ/UJ/XngmuED/tnFmL+D9pEXXDFSkm
X-Gm-Message-State: AOJu0YyJH9O0B4n7x8S+Jj3rGPpuwYz+M9TSSJ4mFz+cd3iJaamIRvS9
	nY5oUeyU8Wync6cO5CzlBO7K5sHUCG5WG63xG5aZOvMqscdp2o2+
X-Google-Smtp-Source: AGHT+IG3CF+k9p5pj5EbJuozYcjKdiyPH05OIZbYUOjlkQ2/OvmQOXy9/eTRwDRZ+3SD1f2/CoqXMQ==
X-Received: by 2002:a17:902:ea05:b0:1e8:9054:1019 with SMTP id s5-20020a170902ea0500b001e890541019mr4551953plg.54.1713566029186;
        Fri, 19 Apr 2024 15:33:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ba5-20020a170902720500b001e2b4f513e1sm3867179plb.106.2024.04.19.15.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:33:48 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:33:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 7/7] kunit: Add tests for fault
Message-ID: <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net>
References: <20240319104857.70783-1-mic@digikod.net>
 <20240319104857.70783-8-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319104857.70783-8-mic@digikod.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240419_153351_783149_53905139 
X-CRM114-Status: GOOD (  12.88  )
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

Hi,

On Tue, Mar 19, 2024 at 11:48:57AM +0100, Mickaël Salaün wrote:
> Add a test case to check NULL pointer dereference and make sure it would
> result as a failed test.
> 
> The full kunit_fault test suite is marked as skipped when run on UML
> because it would result to a kernel panic.
> 
> Tested with:
> ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
> ./tools/testing/kunit/kunit.py run --arch arm64 \
>   --cross_compile=aarch64-linux-gnu- kunit_fault
> 

What is the rationale for adding those tests unconditionally whenever
CONFIG_KUNIT_TEST is enabled ? This completely messes up my test system
because it concludes that it is pointless to continue testing
after the "Unable to handle kernel NULL pointer dereference" backtrace.
At the same time, it is all or nothing, meaning I can not disable
it but still run other kunit tests.

Guenter

