Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78060CD128A
	for <linux-um@archiver.kernel.org>; Tue,  9 Apr 2024 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzDpECgxcv/gVK2Eh47txfcjeUm+DcSXrEiDNVslfT0=; b=IeWNX77lAROYpW9p2pEIQWh6uX
	2Mabjm6XI5C9rMCMHqpUCVXtiwRiMkRBu6SwLovYEFEO+uR+KHtMd9vp1F6sC6pG0L+RvvVSV0T7Q
	dHJwD4l8sqNb219zisjpUdgVBFbMx0TYtuuaPXpJwwKyQaUGLm8GZeulaElbH2xys7sr/eb+M2U2k
	2tew6pS3Tc6tztdlKQtMu0a3P8XtSIN8j2gGmfaT4vCp+gcCCA2dSULgwKwUw4N9ggM7D9PehYaGR
	ZePzoACMIrHuvNDpUznsKtCPy9brMuYZh8mjeoI4RM4wY/yzpLtnLRKjoJq5LsofylKWYePBftG62
	kMQAs5fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruFGY-000000039OB-18TB;
	Tue, 09 Apr 2024 17:28:14 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruFGT-000000039ME-3mTI
	for linux-um@lists.infradead.org;
	Tue, 09 Apr 2024 17:28:12 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso47333539f.1
        for <linux-um@lists.infradead.org>; Tue, 09 Apr 2024 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712683688; x=1713288488; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzDpECgxcv/gVK2Eh47txfcjeUm+DcSXrEiDNVslfT0=;
        b=HeRKowOmF+qMJjT23U/LnrxhyMt0exlofSCDAvte2LDhjJQnURHNuZUEXhvMi8q4do
         8GbFRyTYutvjl944qXScrM3Ciua5w3oSPc7X9pimaKXQW6yIQNMoM7agzmRAUF1XSeY3
         Bx31YCAkGk4ttdw/F5T/4FBK5KTNxAX8Pa3FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683688; x=1713288488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzDpECgxcv/gVK2Eh47txfcjeUm+DcSXrEiDNVslfT0=;
        b=TpnKaVldtRUD6cK6hnNjsP7KmymNYgSaSduQGuCBz61N7eCxI0Ijf5ERFyIcj33CKx
         H7DtFrVB4t4i9zti+FuKNKfrbjQ/ZmzD2fqwTG1UPsXKkfcEphQJhpZgRbcUbwW30RNX
         3t8Ky99xbIqq5tDVGZvwIzRusIJMk3PwyNbykeXEi+CB5387xWglesAZMVLohX5oCXSm
         w709gpBcT6QLfJsydLeUaa5etUk6QERqfR118dcn8SguJv+jSX9whJtSdyQDFB/S7+3g
         8DGtpE2dSQQJbB3zSgJkRU4QYRAeFKau+xy5v0rWYXmNl1K+vo03arHZ35kj20BB46v9
         VsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWESfnStT1+NeaY5ZmaabSdHt37h12TKI6BClZ8Zryi1/Ot53E8W0bgnuKXO26FPaCItN6QTZV4l2iQmbQmHGGO/KV3WdfUdq3AEa4I
X-Gm-Message-State: AOJu0YyKj42Vho73c4csxui4w68VRAt19XiDO3WzZnppRrs0qbQCcVaM
	C6QzhmNe1RXYVlKCNy7Vwg5peESFwTibGK710EF+ms6GiTk6nIW8Ve1339LaNZI=
X-Google-Smtp-Source: AGHT+IFk5z8PoAK3T9resPRUq+Mhgn4hfhcghzxIpzPidDvzpWozapI9Iaz2Vi75WE2H0KeSIVTCNQ==
X-Received: by 2002:a05:6602:3b98:b0:7d5:de5b:1ac2 with SMTP id dm24-20020a0566023b9800b007d5de5b1ac2mr468468iob.2.1712683688027;
        Tue, 09 Apr 2024 10:28:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id cn23-20020a0566383a1700b00482b4a8f07esm35302jab.61.2024.04.09.10.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:28:07 -0700 (PDT)
Message-ID: <5a04e40c-daba-4a1d-b5db-f70d2e51c403@linuxfoundation.org>
Date: Tue, 9 Apr 2024 11:28:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND 0/7] Handle faults in KUnit tests
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jamorris@linux.microsoft.com>,
 Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>,
 kunit-dev@googlegroups.com, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 x86@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240408074625.65017-1-mic@digikod.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408074625.65017-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_102810_188060_E0C38D7D 
X-CRM114-Status: GOOD (  13.21  )
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

On 4/8/24 01:46, Mickaël Salaün wrote:
> Hi,
> 
> This patch series teaches KUnit to handle kthread faults as errors, and
> it brings a few related fixes and improvements.
> 
> Shuah, everything should be OK now, could you please merge this series?
> 
> All these tests pass (on top of v6.8):
> ./tools/testing/kunit/kunit.py run --alltests
> ./tools/testing/kunit/kunit.py run --alltests --arch x86_64
> ./tools/testing/kunit/kunit.py run --alltests --arch arm64 \
>    --cross_compile=aarch64-linux-gnu-
> 
> I also built and ran KUnit tests as a kernel module.
> 
> A new test case check NULL pointer dereference, which wasn't possible
> before.
> 
> This is useful to test current kernel self-protection mechanisms or
> future ones such as Heki: https://github.com/heki-linux
> 
> Previous versions:
> v3: https://lore.kernel.org/r/20240319104857.70783-1-mic@digikod.net
> v2: https://lore.kernel.org/r/20240301194037.532117-1-mic@digikod.net
> v1: https://lore.kernel.org/r/20240229170409.365386-1-mic@digikod.net
> 
> Regards,
> 
> Mickaël Salaün (7):
>    kunit: Handle thread creation error
>    kunit: Fix kthread reference
>    kunit: Fix timeout message
>    kunit: Handle test faults
>    kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
>    kunit: Print last test location on fault
>    kunit: Add tests for fault
> 

Thank you for the resend. Applied to linux-kselftest kunit branch
for Linux 6.10-rc1.

thanks,
-- Shuah


