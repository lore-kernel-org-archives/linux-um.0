Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB423C5DF9C
	for <linux-um@archiver.kernel.org>; Mon, 24 Aug 2026 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=; b=1Kz4vZs8pPAMbhzyzCvF4NUkdr
	Z7gL5Rt8bVR5c1DNGqHuGG9u+gwo4vujbohOu/C8SrMMZkY4iURpCSi+gVR/OWSiJAYWeSWUlTOiU
	a42z8hCOAKFUIU34je1pcCNcax4VWExPOw3QDz8dLbK6uldeoOpk/AQNrWHrjCMJrRb//dybXNRTT
	UQ7ef7TY3C8O7RV3npt77NCmTg56srHM6TqvKe2pvbJwZlUghO13ayD+bGI+UMF1U6ySiQ5HZguNO
	76V1NVlxRng8BKtrlBK6rdJvUpKtmBdBOrWrOS7Xjnn904MbEU7us/npzODQoLrzo7fWPuGUClIOC
	yX5Jnclw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWrN-0000000GxNk-3hM6;
	Mon, 24 Aug 2026 15:45:17 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWrL-0000000GxM6-0zAJ
	for linux-um@lists.infradead.org;
	Mon, 24 Aug 2026 15:45:16 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-38deea72eebso4186462a91.1
        for <linux-um@lists.infradead.org>; Mon, 24 Aug 2026 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787586312; x=1788191112; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=UMsHA66iW1HnPDCtvUeYqYmuc8fVDVhbQNB033xweSVcKUfo5pbbSktqcGKaSyfH3P
         L0OA5F+T+QZd4h+30DdFkU2OkKh5k6e6k70UkcyZoNRJaiG2nZ35JZfrPAdETmIMnsKC
         yiQYZBkwHBSz2a+apv6naKoi4SMWkgZHzlspPBAxPphFKchjJWOtKhSjNEN/aEbVmkYe
         x1ITH4fHNpIyOA+t17ggDvK9WpTkBPIRdPsGdznJKrUDIGMppc3tzukIvUAdvjt9f0vd
         /jrSTupgHsVKBtGE/5Za6sMHEfokl0NPBgBxW8cOMoWkVlQTVhQ7rlhkZj9oSL/CeVWW
         o5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586312; x=1788191112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=UbWCpI1q5BuNbsq0yF6Nib+Z/SqMw8SjBpN4iagiK91JQan5meMU0CmgfzCIGUlEPn
         KOjS+VYt65e7RRGg/jjXHoqpHvRrm173bOVpvNz0F4/AKUEF5TPAMN8QXGtLxVBQZvmS
         pzdERm/qUkOQ45rDAH+4lnRQl4WBGSitafHYlNAA7VuGlzaWykQJ8zke3chStPAJieuk
         e7luJINnHi1nVW9hAbE/F+0HKtnpMXuz/vQWUnJAFzVHNOGVcR6VtwNJmGEfCQX7y1u5
         iDi3DffhCAwfM6UNzUWjPHYB2IX2WWHs8o2jOP2Y16VGU16TCdc5noGtamyrVotHGFRA
         sSkA==
X-Forwarded-Encrypted: i=1; AHgh+RrVMAmww8cs0lTtXbx6HuQcRUwAibRhF0hv07/cUleQOmVCN5HJUTEzv2FBxfXcMXqOQ2vEwLZ6Mg==@lists.infradead.org
X-Gm-Message-State: AFuF++l51Q2DvuBTjO+2lOZNzd/ICpD7sw+A7uLFZZRb1WzmCHqacpPk
	gz0Jx8NxfQr4+r6uCBA4pBXkTXgbwyHBL8WccxAuXWSMvaXKj4ivSb4YRTfOQ/wKvck=
X-Gm-Gg: AR+sD11GRBaZoRF21laZHAF2tQb6NdBHsHx5Jp3nkC5LPjJa4y3IHCvcxDH9X9YboG7
	eIXv/oPbnwbLa9EpI2icSVNTSEC1/qTuoqA0UeyABKwol62vejvPZQd6XdzCD+DoubKcdQPez+A
	DF1qzpxmmoNORmDsPC9PIiCQRHY1VXz5IrittbmezkaU2FRMwLEqg8CIeNansHTjwytISxL4pRv
	Fv/hfOUofIkygqxaJmB9m8dC7TznV/QQFWqHgWay5oGpMc5G7Uy2VcZ3qi0LlFenk02/pNX4J9I
	FPC/vKk6Reu/l7kpgJRpzGkijZ0JtNP3nboys+2xZcsv+y2fynldsnaNnJzBC0qDrO+6jx50Tic
	y50U9/SLCcnNfOC8ERKMH50DTbqsqEB/AiHi3cPQZjXdM+rg60X+NKmNQWZi2j2+PRZLOwg9bAF
	JO8dyv/p1NkkN/o6TWe/LMBeFfQSkRQKSLLDhDZuXu7x2NyC2G+ZbUC3BvoKbmRXynQwz9HQeCW
	1HdIm0xPIBcPJk=
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr39252435a91.15.1787586312489;
        Mon, 24 Aug 2026 08:45:12 -0700 (PDT)
Received: from [100.64.0.1] ([165.225.242.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm23611a91.10.2026.08.24.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:45:11 -0700 (PDT)
Message-ID: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
Date: Mon, 24 Aug 2026 10:45:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_084515_291014_4737D0DE 
X-CRM114-Status: GOOD (  11.51  )
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

On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> Move ptrval_to_str() inside a header thus making the helper more generally

Typo here and in subject: ptrval -> ptval

> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/mm_types.h | 15 +++++++++++++++
>  mm/memory.c              | 16 ++--------------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..a5b514e55dd7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
> +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> +
> +#define ptval_to_str(buf, val)								\
>...

