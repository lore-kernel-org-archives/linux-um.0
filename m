Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7385C83F1A
	for <linux-um@archiver.kernel.org>; Mon, 21 Jul 2025 23:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7uUxr86UctpR4wo5BHRFyvrfjd8nsrpfmZh9G1fUjI=; b=r9GBusX80dLtz/UhKmCU3dqydA
	kjcqGsPOS8IMEZxF8ZkUMuIBOWYXrRbGH1bHGMpvxeyb7upLo0M0bu5E3Op0fYtNhAZsCHTiRs8Gv
	2U1fEgF0CHlLQmtAp1YU7AQo9GdViSfEAeDUvF1xuarP6h3jZTDkEglN04X4W3rU0hD3NM+3REhvM
	2d+Om+80RD0DzZhSzQy9KCx7qxviXkseNJSzHuT5OtlD8LFA/359OQd/udH7bdAw+s5+7FEjQFwes
	isfMgHhT4Jp+V1C3dQOh0N1Wrk2EA1LmmWo+3XVey/HMOsP2oLDySO4+HhdW50bnNY1+wEA4rrDWv
	HdKgkylw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzmw-00000000sQS-1Ifg;
	Mon, 21 Jul 2025 23:19:18 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzmt-00000000sPu-0Ccm;
	Mon, 21 Jul 2025 23:19:16 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-ae3a4b3fa38so4562066b.1;
        Mon, 21 Jul 2025 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753139953; x=1753744753; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7uUxr86UctpR4wo5BHRFyvrfjd8nsrpfmZh9G1fUjI=;
        b=NQYgHxBQu+HNSOddWi+15JgkKyayYw4ShdZTAGsj3q3CNSBYXgwX4MIhy2kyBardRk
         ZeavT8I9miM3kwwmZQfM8ki03hKfb2deLdztqjr+uNA+jZfvxF6cGcbP1UNAc983gLGV
         qNgtobFlRQ0D0kbrEbwjMjgjwKY3oFvjyJbnzQC0WwbuKunM1thCe2D2lfeFeDBtD8f+
         QqpiAZCcZWkS9XPw86wmHf9BdMQ+vqKvbFwU7n8uv/Ccir5Cz4nMESFBV8yEDoIqSv7n
         rW8HZDfDvx7FbxaDahvoHuT+PiuibFyIdkSOjgssYV2RFj1Puu2pEf6AbrOJQbWXGgqJ
         jgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139953; x=1753744753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7uUxr86UctpR4wo5BHRFyvrfjd8nsrpfmZh9G1fUjI=;
        b=twxtl99ubLn1hUDTbuGccm5h6wJQZpUSslf8nLGK+FJTbl94QDASOoCRPI+huWrSvk
         RCDCkBfx4XDpyI5Lenvb9Lfjt/UDpyy16epzHQujUqaJ7zmgkQ6L2pPi94L8gPyMEePf
         TMnAM/gOXVqpO5atM1bMLqnWVf0URGNLPIqZvMjpFlQV96NyWBaoJXOgec162QWTXF0V
         aSHiM6ttd7wV5JvliLP0kcT5gkX6C8zNOo66Wqu2RsyOJdqnDJOEHn6tIAiKOxXu756o
         VFmlW/8pKoca+zR+FwLhCgTocgTyHp9rmI/AuWOzPlYQJFBWORQ4PRt3On+1XUXMRYms
         zi4w==
X-Forwarded-Encrypted: i=1; AJvYcCVdL/G+6/pAaCJHdMQRgD27QpVwAMWAwu8ElJcrKi1KZTZjnlCPHisdA/cTWcNKcmG9n193G7U/FkbLog==@lists.infradead.org, AJvYcCVe4q3fwFiDRJbi32BOe6QtPm+gnxq5fK2Rd2arHIUKXnNxViO4L90c/1qD0Neibjym01/7qiA5jG8=@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/U3IqEA3Fk3+RJqyY51afbHtxlPC3TyuSnEgWND2Zf8nFwB5P
	hjiftBqe3T5U3qs401jXEj5CnUUibKra+yke5uZGAyPLysXopeiZEr5j
X-Gm-Gg: ASbGncs+/ZhUb4uDN0WTOjsUrC5LQjuxHPeWnMKBLudpLbKzLiPf8seC3ZtvJ4iJLhC
	ddWhiQFainL8hn4fxytgG5/2ZcgAy3TbuEWFEjYKerS2zWB+csoB5JaEP+83KbmenUU/MIFoSAl
	kUt5wD2qsrEndrijPYY1MHxQPIxehOhJ6A7irhYbnP10AauN6NLU7/kZ0iCXIC9+8Ehmf1C+dVd
	foOFtcyc67IHLG+ISuRmJrW+G079BLrHxWtD54v65+bouYiNie/14mV/Fnjc/4af2QJc8D0PJx5
	7K9GA7d3+X8BTjsjt5klIrEIr+u+GEKH3KdnIo3tgzxPECukJx4xENwSbfBHAVWKequI4uNzcsk
	Jplz57B2f6kKopIE2V+f+dDlRAADm3hMuYHsCimixxYz7ntdeRNTQauQv/PC2g46HNgLZ
X-Google-Smtp-Source: AGHT+IEyAyDIGzGDBFvxWK+s5z/H1D9rPFTjwAnBXhww3QxIrjDEOAm8ilmaU8TjGW6AeZa6UNDATw==
X-Received: by 2002:a17:907:706:b0:ad8:8200:ecf7 with SMTP id a640c23a62f3a-ae9c99aa29fmr821747766b.4.1753139953227;
        Mon, 21 Jul 2025 16:19:13 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7ea53sm757005366b.133.2025.07.21.16.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:19:12 -0700 (PDT)
Message-ID: <a1bc7a9d-817d-49cc-b7f1-79a900090136@gmail.com>
Date: Tue, 22 Jul 2025 01:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
To: Andrew Morton <akpm@linux-foundation.org>,
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, glider@google.com, dvyukov@google.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-2-snovitoll@gmail.com>
 <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_161915_095008_B823D915 
X-CRM114-Status: GOOD (  12.27  )
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



On 7/18/25 12:10 AM, Andrew Morton wrote:
> On Thu, 17 Jul 2025 19:27:21 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:
> 
>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
>> to defer KASAN initialization until shadow memory is properly set up.
>>
>> Some architectures (like PowerPC with radix MMU) need to set up their
>> shadow memory mappings before KASAN can be safely enabled, while others
>> (like s390, x86, arm) can enable KASAN much earlier or even from the
>> beginning.
>>
>> This option allows us to:
>> 1. Use static keys only where needed (avoiding overhead)
>> 2. Use compile-time constants for arch that don't need runtime checks
>> 3. Maintain optimal performance for both scenarios
>>
>> Architectures that need deferred KASAN should select this option.
>> Architectures that can enable KASAN early will get compile-time
>> optimizations instead of runtime checks.
> 
> Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
> during -rc6, especially given the lack of formal review and ack tags.
> 
> But but but, that's what the mm-new branch is for.  I guess I'll add it
> to get some additional exposure, but whether I'll advance it into
> mm-unstable/linux-next for this cycle is unclear.
> 
> What do you (and others) think?

After looking a bit, it breaks UM and probably LoongArch too.
I'd say it needs more work and not ready even for mm-new.

