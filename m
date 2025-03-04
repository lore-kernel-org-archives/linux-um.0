Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87818C282D2
	for <linux-um@archiver.kernel.org>; Tue,  4 Mar 2025 06:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4FvNFViwfp2APOt2jux8SKthZ9o17Z2NZrToAsK4eao=; b=hfo0K7Na8HZ6WpqsqlRQ+VZ7nM
	aFuUtB+oOiPa8eJ2L3dp7Ijo3Jmt4k6AbSzKj0+Wwh3g5ZYzOBFPCU0RrvxTSZ0N5BhouFMGU7dGF
	9zEUPe0qx0Sq/Ame/K+HvRYC+o593MNfITWQx9CfVtsqaxWUi5QMphy9quHhjU6Z757UyQc6Sof0C
	drwdjtJN+iW+vIaRf6OvCxaZKv+tX9RCHyIfmwTL1BDFWHEKUZC+Gn41etu/mgQ46EW87NlldXbp+
	wSNtIwQQBLBqkBCYWKaKVg2YRnNVUC2JtIQaqQCUQwflEdPm5D/M6tMXip/puYTn7XRSOGNoQH8cu
	yfS8qOVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpLVF-00000003Cko-0dB9;
	Tue, 04 Mar 2025 06:11:41 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpLVB-00000003Cju-2cv1
	for linux-um@lists.infradead.org;
	Tue, 04 Mar 2025 06:11:40 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2fe82414cf7so10301130a91.0
        for <linux-um@lists.infradead.org>; Mon, 03 Mar 2025 22:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741068696; x=1741673496; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FvNFViwfp2APOt2jux8SKthZ9o17Z2NZrToAsK4eao=;
        b=HIqHOn/A0j1VXWenqGAt4oTnyqDrsu0W9WOeyiZVJ5nFdl6plVzf5paMLXaSxdmbt/
         2eeKv0EmH/Vu+HJ5KMIMLqLXSE53FjDsPUvYYh11pfkFRyzgue0KuNG9SbAqys1PMm5E
         mUQ5GB3uCEk3idBwZVn/rQmWQB4IoRvSUvEy3wsLyLV2MuNz924OTdosJCvWYgiL+QpU
         +m+jT6Ux4VnplNhhfoOm3M7kEVzFu0oSP9YHTU4miAQcdHmrqjJksNZx4wMgkP/wVJwI
         Ga9oxP07ecBcmM8F7ZCPxB8S+YmnIt2c4cfl9t0tQOBreB03LEOMAWFgAMsj4f3h5REx
         R/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068696; x=1741673496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FvNFViwfp2APOt2jux8SKthZ9o17Z2NZrToAsK4eao=;
        b=ktKmRnIstpcyW1FbcUAz1wIBD6wUC4jSrGYWM9uyfOZevWozJJHMUd016H5shK45gY
         0zeIlfzQGPlYJwPbFtgAueu2BSf9DqzhsxCNFyc00wQos8q3VoymLrTonp78DBRduZiz
         xuE7KtOv701J2emW3ISTOIB66s/SLs1A74/t8I8VtJ9g4w7agck+6K+5fYUDWz75xkeU
         vw8jcKHRQoIjiFoIYQqWI19fDQAAGTcGIxWDWiIWXfLpyC7LBqV95h9BPc9czjxFSl6Z
         9zg6voazYxS55w4jqeHLDH6t2VcHLDYqNPaU+GbVnO2Kc7DwWw7kCq+zVcqH3vGEeafo
         hduA==
X-Forwarded-Encrypted: i=1; AJvYcCXKG+ji4unuZWXYsiUNaDSPVPEkWvtOm5AKktQRLjebeXRKeQ6foPV7SaOAMSJFw3ElpQJPjMG5BQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3vjC60AnEv/+EY0kXnLosfJgsO6RncGFek7oyNoGhhTNEpZyw
	6dK3R8YoMLxwQa4e5fdehlUW6mFLwSNdozoEQlWq4HnCfhEkq5MnlPN47ym32y0=
X-Gm-Gg: ASbGncsdFvm0KtTmy3LMGS6dGNx/6jt+bkaP0bQ+m4SKH4ocr3t1X9Z35IAt03yW3Qx
	UvLAe1/bslgmbZBVOOrTO4uDqfC/L+yNv83DjWdxiVuUWiNyPoEDzAtoxm5tVIDqgXTRP5BvyOy
	A2I5lj/cWlnYm3vNQNoZFCz8LRFbNRLJQLTpGHJ1l5wZv4OHffDnP6wkG2NtnkgE1HAvDIKb+Lp
	cij/qCyDc5vr64P/nvis6CmxuBX2VNL1O+YZO2+VNLeNHTSVfLAQnlsAka/HXRuhiUeEWn+Ajss
	+mNrJvagmBLLFg9/S2XqRB+8nta8/S/Ei05AYb3OKIjuud+gUFBaWDv/07BTBYbSHQGf
X-Google-Smtp-Source: AGHT+IEXDQyCMQ8sBrL+0HeKoJpZdetEfwPwd6LYj+c4cbVY5/CTPcBDN/0v1nn1xNdV90cajxorag==
X-Received: by 2002:a05:6a20:db0a:b0:1f3:40d3:67d4 with SMTP id adf61e73a8af0-1f340d369d8mr504424637.30.1741068695820;
        Mon, 03 Mar 2025 22:11:35 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf23b6sm9305805a12.15.2025.03.03.22.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:11:35 -0800 (PST)
Message-ID: <7d1c834d-bc65-4979-9b72-0d1d91019501@bytedance.com>
Date: Tue, 4 Mar 2025 14:11:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6 update] mm: pgtable: convert some architectures to
 use tlb_remove_ptdesc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <20250303072603.45423-1-zhengqi.arch@bytedance.com>
 <20250303155331.de9b2fff9b04984a255a7bc2@linux-foundation.org>
 <c48715aa-8c1f-41bf-92a0-bacf401c2f7c@bytedance.com>
 <20250303200815.53007fb79e5049a99f24c999@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250303200815.53007fb79e5049a99f24c999@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_221137_816790_FD7A3041 
X-CRM114-Status: GOOD (  13.38  )
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



On 3/4/25 12:08 PM, Andrew Morton wrote:
> On Tue, 4 Mar 2025 10:31:07 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>
>>
>> On 3/4/25 7:53 AM, Andrew Morton wrote:
>>> On Mon,  3 Mar 2025 15:26:03 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>>>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>>>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>>>> tlb_remove_page()). This is the same as the implementation of
>>>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>>>> convert these architectures to use tlb_remove_ptdesc().
>>>>
>>>
>>> checkpatch warns.
>>>
>>> Do these things have to be macros?  Switching to static inline fixes
>>> the unused-arg warning in a nice fashion.
>>
>> This can be switched to static inline. In addition, I found that alpha,
>> arc, microblaze, parisc, sparc32 and xtensa also have the unused-arg
>> issue. Do I need to add a new patch to fix all of them, or just fix the
>> newly added 11 warnings?
> 
> I guess leave things as they are now.  Switching all these to C
> functions can be addressed at a later time?

Okay, let's leave it for later.




