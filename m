Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16861C282D2
	for <linux-um@archiver.kernel.org>; Tue,  4 Mar 2025 02:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A6T+mpuirUlxFXXDmZQp4DlzJljahRMUsKAZ4wXM54o=; b=LcYJAURQm8JHHf4PRDPOgcgxhC
	bFuzcn0JBcZ3ZcdwKFrrAwt31giQn1k1ixnOUWwfUQGlDj6HVK1dQl7AumlsoooQdA/pHO9nj0RhS
	o/SMs2ZCEgpgQc45zeJ8UEDhZJhzQJZZgMxhlv4vkcxVT29AZKmhYTnK/hAAWz4O2MNRfafEtL1P+
	ses+C1PQUj5HTdhgUXzSTUDSKR8j7v6r00HORpiUoGbSq0oZZ1pfpA1hwAWiOxa4dPm7etMUS/lb9
	DraqOslCZpaeam4MkyQ+VQDikmtvT0SV+YuKq8ZKtwQuxQp6oKbXrYxb8Wl7lAyLzETCu+LYzQjCg
	H4F2VF3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpI44-00000002uYu-1Qtw;
	Tue, 04 Mar 2025 02:31:24 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpI40-00000002uXU-2Ghu
	for linux-um@lists.infradead.org;
	Tue, 04 Mar 2025 02:31:23 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-22334203781so97092025ad.0
        for <linux-um@lists.infradead.org>; Mon, 03 Mar 2025 18:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741055478; x=1741660278; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6T+mpuirUlxFXXDmZQp4DlzJljahRMUsKAZ4wXM54o=;
        b=JJ0aNjV4mSiMoEDvnAAMEMdXn1kr4gvN8Xu+c0e7jt23e46FvIIYYHx25sPdK6sBe0
         f3KC0tqprQjnvRmpj5c9CIZqWZZrgFAbF4SIPdT+G4sUqjnhVxc6tAAK3TmdcXoNn21L
         CsOhnGkZ1HybwwoNXUvWzVpnhq10c+KSVodvGlhwGUyS/FJqVOogyWFMTGCO7whFPfiD
         XaeASHWCrvPxEgsvSTrD7MFqvCF+puHQKvI1FHUxqVpptSg/EEIu04YOzYd/4Y1xJGbo
         qRGxOhIaQiaBAjvmjf8ilPgMuEhecmV3xOncEkSMWM8nqHWDnzXOZb9cW43LBHlOFm/6
         n1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741055478; x=1741660278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A6T+mpuirUlxFXXDmZQp4DlzJljahRMUsKAZ4wXM54o=;
        b=dovYxqKBKDl9dUNH4Ol7oqmPDW5WD9tR4+1ut5B+lZu/QoKaigrfJ924VWZ1AcgZG0
         a2NyPEtb+POcwqiMcdV+ErYpumh+rC7ybr6f3BKWIDmr8N6ff1bXkvHnHyUsDpxg0pea
         d4gaO+41IfhCFsi4OBN/8B8Jq1oycBZBVq6bUJp0IMRsW9JZGP3yJfTz2L69aEuEthJ2
         M1u9Y4Pimz/P2KmTcW4j7lc9VKVdTRPByMQbLMlpbIqQMfbAunoRtyHxuGxk2vlJ79Wn
         Kgxn52JyyN6FXx7dsVuloh76ayphJpp1PCHgLyqN9/bwrxqe+rmIdFFa+XoUnKZp0JID
         FRAg==
X-Forwarded-Encrypted: i=1; AJvYcCWfE2oQML5d7ZNUZRKStcoCuyx8matwvoRc9wqrmj4b4QqmK9MA8mjH78EuF3uY5+lIQdKGBJyk8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzG+HW1E2S6yA1qoBVK6NuCiQ+a52PeQANBN8Wgjlvniva12zEw
	sZQdQyUFAlsyMwo1/vkLeujFV86VRfJot+xScD9U3N3VAUf+mRr6F4nHKkJkUZ8=
X-Gm-Gg: ASbGncv9prxTcLXlh9ZnJUmLZ9f/zpHDnu+qqJAH5ZDK/qwHawgjIaGDjCOKIj2zFIT
	KXsZW6qULn1ioRlq1STIrQPpDRRu4vSwi/QPYCdXDX8IV+jLafsTDLhgjwwqAIrk8GcSMSkFHl7
	q7arfN/C4C7FtN1+f9hI5BnYPSJdOmL+DxQUgkZpsA/pQ1PTMQVMLG80Giz9sMUWrhcuPI362Fh
	SPoQPwqRO1WWRZs8zJtWVoLRDlUbuCQkmpyKh0Lw/xxaOn1WnwccxRzcAMA6nGJXV/mTrHLE4AS
	iQBQgRMKpN6c40AdQMHQctwinmuFKNzkAs66voeU389OYVobbGMWQV1biCpGBg9xP8BO
X-Google-Smtp-Source: AGHT+IGfyVS9QzXp3fDXv9OSff0zyYBlNLrDj9vPIT6lOO0LqcIFLuDQltej9EU6VX3nefPaL9P2pQ==
X-Received: by 2002:a05:6a21:6b18:b0:1f3:383e:7739 with SMTP id adf61e73a8af0-1f3391176eamr2284458637.7.1741055478523;
        Mon, 03 Mar 2025 18:31:18 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf242bsm8911768a12.13.2025.03.03.18.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 18:31:18 -0800 (PST)
Message-ID: <c48715aa-8c1f-41bf-92a0-bacf401c2f7c@bytedance.com>
Date: Tue, 4 Mar 2025 10:31:07 +0800
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250303155331.de9b2fff9b04984a255a7bc2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_183120_936208_B9AA21A9 
X-CRM114-Status: GOOD (  17.44  )
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



On 3/4/25 7:53 AM, Andrew Morton wrote:
> On Mon,  3 Mar 2025 15:26:03 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>> tlb_remove_page()). This is the same as the implementation of
>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>> convert these architectures to use tlb_remove_ptdesc().
>>
> 
> checkpatch warns.
> 
> Do these things have to be macros?  Switching to static inline fixes
> the unused-arg warning in a nice fashion.

This can be switched to static inline. In addition, I found that alpha,
arc, microblaze, parisc, sparc32 and xtensa also have the unused-arg
issue. Do I need to add a new patch to fix all of them, or just fix the
newly added 11 warnings?

> 
> I'll fix the trailing-semicolon issue locally.

Thanks!

> 
> WARNING: Argument 'address' is not used in function-like macro
> #51: FILE: arch/csky/include/asm/pgalloc.h:64:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #66: FILE: arch/hexagon/include/asm/pgalloc.h:90:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #80: FILE: arch/loongarch/include/asm/pgalloc.h:58:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte));
> 
> WARNING: macros should not use a trailing semicolon
> #80: FILE: arch/loongarch/include/asm/pgalloc.h:58:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte));
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #95: FILE: arch/m68k/include/asm/sun3_pgalloc.h:20:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #110: FILE: arch/mips/include/asm/pgalloc.h:51:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #125: FILE: arch/nios2/include/asm/pgalloc.h:31:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #139: FILE: arch/openrisc/include/asm/pgalloc.h:67:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'addr' is not used in function-like macro
> #153: FILE: arch/sh/include/asm/pgalloc.h:35:
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #167: FILE: arch/um/include/asm/pgalloc.h:28:
> +#define __pte_free_tlb(tlb, pte, address)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #176: FILE: arch/um/include/asm/pgalloc.h:33:
> +#define __pmd_free_tlb(tlb, pmd, address)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
> 
> WARNING: Argument 'address' is not used in function-like macro
> #185: FILE: arch/um/include/asm/pgalloc.h:38:
> +#define __pud_free_tlb(tlb, pud, address)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pud))
> 
> total: 0 errors, 12 warnings, 122 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or --fix-inplace.
> 
> ./patches/mm-pgtable-convert-some-architectures-to-use-tlb_remove_ptdesc-v2.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>        them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 


