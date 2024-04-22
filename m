Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D6FC4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkBtQ14FO+0NGu2+k0AcqXPVmwhs5oyX89ZVVK1/Ay4=; b=mhiD5e9ifyi3QaXtOXLl/quXsu
	mIu4BUAoHIX+Ueyhr5G0QYZbhe2AmN7Q7MMPMM7pzht/P+bcj39ee6XJPmSPNSPLQfFGuXb7BUm4y
	6XWW3AVi6kZpuXk7ITSKNdrjYxGmHf7LEiZUNYmkdFSbj9F+FN7k/iURli0T6F/Viy1xDUEO1VMe9
	hgJCSlBPJ83o5NyNxAE5hJE4jBV57pJFOeK8b3sjMmfEfgkpfvykNU3PZxPGjvXNimcxJy3pl9P4Z
	gzC7luG2adAbU4xhdo/7CRJcwDXIiBpROalmNyza2/9RgHVserQvPGt7gJRLUsSSIv+kH3u4xQvjx
	OzIh8Mpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rytq4-0000000DlaZ-3ZR1;
	Mon, 22 Apr 2024 13:36:08 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rytq2-0000000DlZO-1AdT
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 13:36:08 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso31210125ad.2
        for <linux-um@lists.infradead.org>; Mon, 22 Apr 2024 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713792962; x=1714397762; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KkBtQ14FO+0NGu2+k0AcqXPVmwhs5oyX89ZVVK1/Ay4=;
        b=OTaHPdUkdVYVw7wiU3Xjsn04qTarRDDVQKWteXh07JsosshG7EqrQ5+1YbOnxjPmwF
         0144v0tGPcJqnWT6wStPu0xDaJ1+Ezqx4f8kqNxEUHY9CKOYWNlTig11upH/YlmfX0SY
         9W3NKsZcGGU/kRLBIVdGOoaahKjoYLizCkC73EK1rqwEL0027sddt9Lv9K1cqQ9TZQ09
         Z2S6JseKU2g89C+qUQShJv/4YnyDU/fPU7jBYgBVXHmyedH2bWL7qumE62/68D/BRv+X
         iaYKe5RbUls7+4v89ZsvPd0EuFRldcf0L4mjmg9fdlm88vvEFQul+dVpu42N92D8NFeX
         YeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792962; x=1714397762;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkBtQ14FO+0NGu2+k0AcqXPVmwhs5oyX89ZVVK1/Ay4=;
        b=LZvpMVJBO0lUJpywxDVeFW1V3uGfQuelv/gOGI7LY9N/vQAS8letSykhBg9bH5F+cC
         RpSKDDs39PUHmlmqFozDwOGUpRe7oHvVbCI1KAh1t4FD4n2ouWTCIF0KXtlJ+kty50je
         2YNvdWh148iuN/u01lHEAMJymyJpr3eS2p0aBQQu6FDvvEeh4Z8JADG4zvltQnHaUQEi
         VGLSW9pejbo8gya+T6LIYnaamSNZRjCzIMwUsU8dASnHlG2ZlYGVlXA1Z2/HkcE9o0VQ
         u7FW0wLbjd/1tIj1HJAV1TaHh2dprbhsPB3B8OMRNEmZVphu/WAs8ehHr0hR7veuMjwp
         og7A==
X-Forwarded-Encrypted: i=1; AJvYcCU4zc54t+2ecCp/rJpjIErs/BnRVp0c03OjsiZs3TaB3rYAK6JqB76PKtffWgsal3qclF8GALCxBXIKHT85Mdhj9nubgcEy8SQrjrsN
X-Gm-Message-State: AOJu0YwPPzjQYJZjt6qLrYFyHNvxCMPUvm+Rjh/N5fGmlHAbEWDwbGsA
	Rfy873HCySZ3aDuHheVKimB4hJnqFo61K0F/13BNbWhlOqgAtQZK
X-Google-Smtp-Source: AGHT+IHkfetYNQjtXgJOGuSH2tF757po7WuioKhZ1WKUmUVhuKFeVc+0OLJzUKRopydwbd5Qo+FIMw==
X-Received: by 2002:a17:902:ccc6:b0:1e2:d4da:6c72 with SMTP id z6-20020a170902ccc600b001e2d4da6c72mr14625676ple.0.1713792962514;
        Mon, 22 Apr 2024 06:36:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001e284b9b28asm8230382pln.129.2024.04.22.06.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:36:01 -0700 (PDT)
Message-ID: <a0179848-99a2-4169-b7b2-1a8cddb27615@roeck-us.net>
Date: Mon, 22 Apr 2024 06:35:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] kunit: Add tests for fault
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jamorris@linux.microsoft.com>,
 Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-um@lists.infradead.org, x86@kernel.org
References: <20240319104857.70783-1-mic@digikod.net>
 <20240319104857.70783-8-mic@digikod.net>
 <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net>
 <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
 <20240422.thesh7quoo0U@digikod.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240422.thesh7quoo0U@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_063606_452625_D06D8B94 
X-CRM114-Status: GOOD (  19.61  )
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

On 4/22/24 06:08, Mickaël Salaün wrote:
> On Fri, Apr 19, 2024 at 04:38:01PM -0700, Guenter Roeck wrote:
>> On Fri, Apr 19, 2024 at 03:33:49PM -0700, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Tue, Mar 19, 2024 at 11:48:57AM +0100, Mickaël Salaün wrote:
>>>> Add a test case to check NULL pointer dereference and make sure it would
>>>> result as a failed test.
>>>>
>>>> The full kunit_fault test suite is marked as skipped when run on UML
>>>> because it would result to a kernel panic.
>>>>
>>>> Tested with:
>>>> ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
>>>> ./tools/testing/kunit/kunit.py run --arch arm64 \
>>>>    --cross_compile=aarch64-linux-gnu- kunit_fault
>>>>
>>>
>>> What is the rationale for adding those tests unconditionally whenever
>>> CONFIG_KUNIT_TEST is enabled ? This completely messes up my test system
>>> because it concludes that it is pointless to continue testing
>>> after the "Unable to handle kernel NULL pointer dereference" backtrace.
>>> At the same time, it is all or nothing, meaning I can not disable
>>> it but still run other kunit tests.
>>>
> 
> CONFIG_KUNIT_TEST is to test KUnit itself.  Why does this messes up your
> test system, and what is your test system?  Is it related to the kernel
> warning and then the message you previously sent?

It is not a warning, it is a BUG which terminates the affected kernel thread.
NULL pointer dereferences are normally fatal, which is why I abort tests
if one is encountered. I am not going to start introducing code into my
scripts to ignore such warnings (or BUG messages) on a case by case basis;
this would be unmaintainable.

> https://lore.kernel.org/r/fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us.net
> It seems David has a solution to suppress such warning.
> 

I don't think so. My series tried to suppress warning backtraces, not BUG
messages. BUG messages can not easily be suppressed since the reaction is
architecture specific and typically fatal.

As I said below, never mind, I just disabled CONFIG_KUNIT_TEST in my testing.

Guenter

>>
>> Oh, never mind. I just disabled CONFIG_KUNIT_TEST in my test bed
>> to "solve" the problem. I'll take that as one of those "unintended
>> consequences" items: Instead of more tests, there are fewer.
>>
>> Guenter
>>


