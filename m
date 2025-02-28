Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4404C19F32
	for <linux-um@archiver.kernel.org>; Fri, 28 Feb 2025 02:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=; b=VvqQFPKeGv4i2tXuFWPdGyg8t0
	Ribk8HSne/OKnYtnN1UZ8HBr0ZUBLVxwdB5bbHY5kO10f8so41U3Ic6MXq2CpEGwjj4Ypz+g2C60z
	JquFVbmJ4WaE3TUUJkoFB67LACzWrO4+WKiyskJUox2FapwPz29RZUNOtwMRlHVHk8QS66VAfKfGM
	CzjnDRHC+pPe1zTBKnKSxA3PykO5Lt4L6Lb+CUG8ESOxa+A2QXo2rFgjid3XErccM4ukt8TD6SpTb
	TCr1nq6qmPTy0zaPhp2fSA4460zanIy8Cz4I5+e99+mA7TQfd/TBZA3ew+2NlyURKta7kN2y/stEO
	k/NdinZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnqMg-00000009WBD-0TL2;
	Fri, 28 Feb 2025 02:44:38 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnqMc-00000009W9x-24fZ
	for linux-um@lists.infradead.org;
	Fri, 28 Feb 2025 02:44:35 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2fe96dd93b4so3639683a91.0
        for <linux-um@lists.infradead.org>; Thu, 27 Feb 2025 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740710673; x=1741315473; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=SFMkUn2tP+coX5ljIHaBjr7iXerXaEH6ucIaRGNYdMeveB05kdHgBxH1ya1Qsxsvj3
         dsFgX7w3DBWhPg8nvQmwZtRnZxC69/wLdQIqBhdyWfYTynVU+lm5ymMpiPhYW5NpsBNo
         ZfbJSseUHpmfM63kZstC1bYJTGrr2/IcQA4bjAKs6jBNpQyz85bAv2XyVU++m2q0ZqkH
         ztFbCsAP64jfPe3GhY/ujXgT5UuBqVKunvLbPpoV/GeK3oDqxGSCJrRQuAMqlZdJux5/
         J6b5HY9Wr7Gs33mZFxDFvha/C2xEUrbN1Pbjdi4uUyUtskYriR1aAQ5jguv7qzIO30+/
         EflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710673; x=1741315473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=l+YA/X6R4PotJHlzKbM4x/92on2Uub45PgMuo0+8pXmWx7KSnv+el6iAjB/SPLni97
         dNlH02CwwrAOI36QSYhkwIGM3xrcEHt29Iiakk/W1HDL4x3au6ODocyg7h2QFNkGq1A8
         D/ezWxWTJt1ryT99GvcVByYsYRw6Vy/5RKhSaDNV/s4sBD5JFJtuomXEmHzv84p57jXz
         lHiVTeJ9ng3DG+DeesXa6cqHIRysD7z6cT3uP/VNp+S4BBqyi5ZacAmVU3ks5pKHZmX7
         JYLktTO0xyM0Ve5nGTBhHC7ehx0WhnCWh5bP+Yz4dzR4sVPneXAMT9UjmSQhRDoliqwY
         YH+g==
X-Forwarded-Encrypted: i=1; AJvYcCX1GBAKy+m8/urN2qeivproc33gZMHCvOZBIVZRIRiDTqqXXzHB89SUoyYAdqG/NRprhXdGSObcTg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWzEuP3BvHbh3ZB2jYEO2V45i6N6TnyWvLnNw6gTkYr26nEyzw
	jb/25RVXaZwJc0QDhi2z0O3PB715+ydDNAmQJHxPd69nBn65C+TyhdzH0+YPSic=
X-Gm-Gg: ASbGnctkLQp8slRd2quHguPj4s9CgaOY0NFlwuWpNbDeuhh+90aJ9grLbcwrEqQg5Zr
	23o3XfyJDKrn0ZHDd2zsWx7uSVA66qdY+BJ8OAHZ4jMd95dk1BiNZ2poLxg2Jc2/frfrxTIowel
	d6eDh00UiE3dqxeuYUPaaX9XZ0Pa+J6uzYkmE4Dv+dpxXkEkFKZH/N3eIkuMvgZ+iccBnERXOEa
	c+BJfaoqCOd/xhzEIJc0qo9zzyDFIDq7rTzpsqtNfyS7kjEwhrl/4jRXbKqj4INA6MlJSjTOIHE
	Rwg4Y8Os+ustvGUVK9SuIUmp6ourGL+hcMIBMlsTBmO+UXrOkQ==
X-Google-Smtp-Source: AGHT+IF4hsdZRiz/aSbemK655CZrsY9ZUuvu4Xu2ENST8y9hxHTSO7PJo35OmCgDgimYWycuvOakGg==
X-Received: by 2002:a05:6a20:1591:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1f2f3e11f86mr2902815637.19.1740710672736;
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe514besm2559832b3a.71.2025.02.27.18.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Message-ID: <e5f4e310-5bcd-4901-8ec3-757cf55dfa64@bytedance.com>
Date: Fri, 28 Feb 2025 10:44:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm: pgtable: convert some architectures to use
 tlb_remove_ptdesc()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_184434_685826_1BC3440D 
X-CRM114-Status: GOOD (  14.02  )
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



On 2/27/25 9:21 PM, Geert Uytterhoeven wrote:
> Hi Qi,
> 
> On Tue, 25 Feb 2025 at 04:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>> tlb_remove_page()). This is the same as the implementation of
>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>> convert these architectures to use tlb_remove_ptdesc().
>>
>> The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
>> or tlb_remove_table() for page table pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks for your patch!
> 
>>   arch/m68k/include/asm/sun3_pgalloc.h | 3 +--
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks for your review.

> 
>> --- a/arch/m68k/include/asm/sun3_pgalloc.h
>> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
>> @@ -19,8 +19,7 @@ extern const char bad_pmd_string[];
>>
>>   #define __pte_free_tlb(tlb, pte, addr)                         \
>>   do {                                                           \
>> -       pagetable_dtor(page_ptdesc(pte));                       \
>> -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
>> +       tlb_remove_ptdesc((tlb), page_ptdesc(pte));             \
>>   } while (0)
>>
> 
> With only a single statement remaining, you can remove the do { ... }
> while construct, too.

Ah, right. Will do in the next version.

Thanks!

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


