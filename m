Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FD1C04FF6
	for <linux-um@archiver.kernel.org>; Fri, 19 Apr 2024 23:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Gwf216v3KsZJ4qYiZY7FSP0+gRY5Pp5+VIKVDcURGo=; b=AnQZI+qb8gvcsUo948LsL31dKz
	BWGmlnidXJ/L28XORic+0hi8i7JIfyTaF5FajpAcvP0ENg6s3luWmjaR9dhK5qrEwA+ZEXOhatnR0
	i0U8RtDYjde1gyBmB3uOcb3kt/TQs9SWXWLYS71vskEQggpDJ+NAEzlVqEoC3NB66TQENjOVs7XHA
	FtZovae+mJm5PYNXXYTwqd0qiZWTIaSoPEwF35I7QK8tO+C8j38KhemYzhEYSq6iH7MCCMbGqKoBW
	BxVUMA1q7qsG86rdde2v9sdj3J/5isBo4ztqWgvEJtWia7tnbKtyllpStCBX38jvXXlHTpLoeVyFI
	n7I1vesA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxxo5-00000007HEA-1prC;
	Fri, 19 Apr 2024 23:38:13 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxxo1-00000007HCz-0J19
	for linux-um@lists.infradead.org;
	Fri, 19 Apr 2024 23:38:11 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso1674887a12.2
        for <linux-um@lists.infradead.org>; Fri, 19 Apr 2024 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713569884; x=1714174684; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Gwf216v3KsZJ4qYiZY7FSP0+gRY5Pp5+VIKVDcURGo=;
        b=BDPZcDJPvo7esSdy9es1bjHAjzFeieS+F1YINX64C2BM04rd1Jpx2Rwn6Y1AP7bDdp
         iIH50pqqGh5FtuojXgf3bNbTioRmdCfQrsYINwuArjznjBllKDsCKYKgvpabxoL7AqgV
         80/OhS99qtr70n4tKAtHjrbRHFlUTyPJGKqOd6StpMLdTKiCoByH1G8fcHtfXolbB8wo
         ZzLDj/52My8Jdaduds2rBAowL2jcjqG/fE1iuLp1zP1OciOcD6WrQ9lSeNyZIzQ1Nrbe
         gRF5+ZqYFlr0H8SYbHNuvDIvifHFb5RIh5m6nueD6oyqNYIT5g6EBh3A4wtmIXDp81s3
         CUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713569884; x=1714174684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gwf216v3KsZJ4qYiZY7FSP0+gRY5Pp5+VIKVDcURGo=;
        b=IuwGocP9lRk8W26F6Qv9pJDbNIhQ8EeYmj8/Xft+q3cZIwINy/aMqAxR4l3HhcW+tU
         63wvfm6O1Hz8K49eWWt9El0PaUXvdEBdXKYiUrvAljFYYIQCms42lksXfcoJ5p1uZArK
         jPqP1NXyzfASCKkTini6AXogyYxb6T0CDaVte5W1psuBNs4J2myBUc5drCvHmKOKAggj
         SptJJ/+YLdtDvwh3QReeYHcezYXghNiWPAxi1DCJuQMTnt4ugQoQD0jCnsSnzj7ZnB72
         YShLAEy+WipwV12qsxwb6d1LDlJ/9ay4yDdfL4PapHDSrOg0NUZioN45FlpprQ+vZdVr
         a+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8OPuCeizGWzW0Wnf3FA8NFUEP3WK9rCk31MXPImteHIxAXckDZUehnG/DGwxt17nnxzX9y7HCjFEJpz5A/ZxXOC373NeiD6Kj9RmK
X-Gm-Message-State: AOJu0YzUPctkZ46mhpWu9Mz9DCQ2r/tGomH7om4sfywRXphYcrgz4+6c
	kDuYuzlydO7DbQ0hDJ+G4R7P21CEvrJr2zdFgPTzIFBDST8t3GKL
X-Google-Smtp-Source: AGHT+IEhgR3QjGKkzYQX0nCs1qVhmVHFCFFjDZfmUk9cI+PUJECL3IHXfzZjmkA8FR3ezYxS5oYc7g==
X-Received: by 2002:a05:6a20:12ce:b0:1a9:c4ca:dc74 with SMTP id v14-20020a056a2012ce00b001a9c4cadc74mr4557459pzg.5.1713569884211;
        Fri, 19 Apr 2024 16:38:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gl17-20020a17090b121100b002a2c905158asm2438010pjb.46.2024.04.19.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:38:03 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:38:01 -0700
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
Message-ID: <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
References: <20240319104857.70783-1-mic@digikod.net>
 <20240319104857.70783-8-mic@digikod.net>
 <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240419_163809_120901_CCDC74C0 
X-CRM114-Status: GOOD (  18.17  )
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

On Fri, Apr 19, 2024 at 03:33:49PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Mar 19, 2024 at 11:48:57AM +0100, Mickaël Salaün wrote:
> > Add a test case to check NULL pointer dereference and make sure it would
> > result as a failed test.
> > 
> > The full kunit_fault test suite is marked as skipped when run on UML
> > because it would result to a kernel panic.
> > 
> > Tested with:
> > ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
> > ./tools/testing/kunit/kunit.py run --arch arm64 \
> >   --cross_compile=aarch64-linux-gnu- kunit_fault
> > 
> 
> What is the rationale for adding those tests unconditionally whenever
> CONFIG_KUNIT_TEST is enabled ? This completely messes up my test system
> because it concludes that it is pointless to continue testing
> after the "Unable to handle kernel NULL pointer dereference" backtrace.
> At the same time, it is all or nothing, meaning I can not disable
> it but still run other kunit tests.
> 

Oh, never mind. I just disabled CONFIG_KUNIT_TEST in my test bed
to "solve" the problem. I'll take that as one of those "unintended
consequences" items: Instead of more tests, there are fewer.

Guenter

