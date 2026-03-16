Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF23F013FA
	for <linux-um@archiver.kernel.org>; Mon, 16 Mar 2026 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=; b=CXpSmV+jV2ys2BSyl99MG35nTC
	pceODDpCqE4hxmaZe/RiQItuqvNgBr7m36VuP9vZbO8ZydDrjwE1KxQrkvOqdrhTbUq3iNa/jBnG9
	bHur83AXDWQJIqQ7w3iiPvVgfb28u7qYCuitP8J/daOS+PCdNyOL+UE+1xOidxllqn60UwD2RFKUV
	63DbHLk4LRjYJSC6MbAap2bvKStBJ/9GTzasCSWAeYFuFfuYukoPhFr4IR9FTemAyeOORmahG8gsn
	r+Sx/jOoX/yb7LR+HUalmLKBHY5yg79kpY3XY8zr2Hy2LXk7gwFAdzrU3EP0xsa4ojD9zFQftLR+6
	Jlj3yTPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GBF-00000004zBX-3YFO;
	Mon, 16 Mar 2026 22:12:57 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GBC-00000004zAQ-3fTp
	for linux-um@lists.infradead.org;
	Mon, 16 Mar 2026 22:12:55 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-b97905516faso336716666b.1
        for <linux-um@lists.infradead.org>; Mon, 16 Mar 2026 15:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773699172; cv=none;
        d=google.com; s=arc-20240605;
        b=L6s5zHGGVJqIzRcweXbioCqV7L7NKIXiAR8GXT11312+8VnOb29NtPp5NMopcbftxa
         ha+4dDfITVDHDNHW8lAuKnWhnSOMT0V1qvjg4wqxBQZinhwdyYUt4BCyy/NxthmsD1Fm
         v8CdG3gI2fGEl9kpwZiznOnAyrqrPZXJ9T7F3JrqDGRvbV5qeB5cDy5skrG6oyBk39vk
         V1WbAJlxyNlyhlSJKF+dxahxmnOsg499vHRE6MMni0QTSVBDhtCRhaPyxIrB8sSjpue3
         mjkAdcxmoP1JFFqj+iJRX4hYciKjlzTVrMYvGMKBQ0qL7QK/1IQmz9LcBWB/zEimwihh
         8p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        fh=jwmoqsQVy8OtQmgiuW1V8wpzMCoTyl/jvlGQ8tpP3EQ=;
        b=LhFar4Vd8TTqdbFi29JWQWKbZRGemAMoMY7/UIdnXvcUlzFQVDMOmNj9g0eDC/9hPt
         8Hbx5gIsR+tESx6F/oDE5h4KFm6r/26mHAOHOnLv3mLYaXx3byOzbokZE20oU/RQ6IIG
         S2+HrFT0MVjImsDRXFSGlSCR69MTe9q/0qE84+2xzC5bf8/T3ZYSMTRSeQU7/wcRIQ/N
         Pl/+4bvZfr1/tQMLTlGfVKKMzIABABoPPizN3mP09UG730HYj21orAkPJOdXlUnW5PB7
         SN5sTuhTiAyxZ7n5fWV5R2+y7T/EA8cmsOwBTRW2BMtG3KkE4VZLfo4ksGa9WNjZfrao
         TweA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773699172; x=1774303972; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=T73uDZ4Z5G09U44ABj0hvRpOVldLB+MMguafZX7PeHaOo8NY5NzSHv5slVkUrSrIE/
         Q5oYC3j+LxGOUitWyvhESWjG9x5Mh2yk/kY0MdbngytZ2+KpgS7V7q9kSo2UAYhZRJQO
         mMk+DreM6sDg1W/9fLiXBwv2CLuls8rGucIBe9djHyEJMvrqy2MQghwpPAmYrNsUawFl
         5OQxDSVyg2XdtVZ/1Idl2fEXrYT64StCI+C14OfT1Y1Jmc2FSDtEggSDEc/hJm8GoPLG
         rV+hMmXp4DGrOF3dFA7m591NoAISZhnrWDVzEziiuhtGu6ZsyaedyW/q1EFvS7JgRRQV
         h7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699172; x=1774303972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=DZNs9wrRzO82OG4Fh9vqaPoSOUgPAiDekCsJlwouaX5vu8nUfQLtqj5CBN1Cabouj4
         iwHs4J2nVAm15QZl6D8ToGYE8/P3zoEnjeS8ZWHedyOfZgpXlp3I8HEukpEC6tX3Qa39
         pOkzrYRjGV/kKFulR5aIUwt4T//D4HHXeDyYmv0RRGDJHJ7Yu/iYFJ7wS2TUUQRBYWXq
         GKTOTMGDM523IeaSjubxj9QAbEQ8UuZzaF5PWNSh4dzg+ooQazebaNzdLEPWVMY21Pir
         BiaQ/NUMmZoPxyCRxctgZ2OOsbmEKw37YjJEagkJ0Xdo1rvJRMWyxaHO3n53TAp52wM6
         nLaw==
X-Forwarded-Encrypted: i=1; AJvYcCWG7DCOx989PlYCYWWLpXyOptTBuC0E5sR3ZxLha9RjauNeLlb6ghRT+m5LL5w/Ll6wODj2YsHvPQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz48qghgfkjx9fP/G8kLrmhkZc79Tzsw+c2RStV//HPzUjHFRYT
	wWjzgY3ai4axKLh6TajIPAmuXpamVsuq1S0v+d1dhzR9a0M/1Ec8VvgUGe50BRpxHpIyqf85HtG
	IJnb4bEWbObUG48V10ml2rYgMzYFcT9g=
X-Gm-Gg: ATEYQzw67vhLyiwFKuwqKaY8V+mwsdlz4GjE4TNcuLCsvvPTZ95Rvixgu7TrNUS+SII
	Ygl7HbbIWFwPr06dEdAD9FTpRkALxmnhQ63jte1xki9lzsLLksxaV5hXV2RMRJNI2CfCES62skG
	fZsLVugS63cJO0uY3iGWdqRazJUxgxFAEKC7LIEzsm1ATV3FoYsYI5h+IbYZjjFcRNZRrZNIXTm
	LYnXQwYKzynM89+vQrZUl+XbpRo3EJYno8PWCScV4MWzWg7RbGdRC94PP35Qd9AEbtkNajF7YcF
	yXD8ULi7tioYeSbyiYv9HIiaCeRS1YRQ5XrqY7so
X-Received: by 2002:a17:907:1c0b:b0:b97:b515:31e with SMTP id
 a640c23a62f3a-b97b51509acmr346111966b.50.1773699172087; Mon, 16 Mar 2026
 15:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260311070416.972667-1-hch@lst.de> <20260311070416.972667-11-hch@lst.de>
In-Reply-To: <20260311070416.972667-11-hch@lst.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 16 Mar 2026 23:12:39 +0100
X-Gm-Features: AaiRm53MOL-S4iIRiZrnVZNNZCm-cfe6kMQGe2L4WL9TC_xpq_akeJ994p2lXMA
Message-ID: <CA+=Fv5QkJm8+ysx8W=ypr84oSR=rrikfk-iMMU6_xrtS1PsWvg@mail.gmail.com>
Subject: Re: [PATCH 10/27] alpha: move the XOR code to lib/raid/
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Li Nan <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_151254_931850_16403EE1 
X-CRM114-Status: GOOD (  15.50  )
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

On Wed, Mar 11, 2026 at 8:06=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Move the optimized XOR code out of line into lib/raid.
>
> Note that the giant inline assembly block might be better off as a
> separate assembly source file now, but I'll leave that to the alpha
> maintainers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/include/asm/xor.h | 853 +----------------------------------
>  lib/raid/xor/Makefile        |   2 +
>  lib/raid/xor/alpha/xor.c     | 849 ++++++++++++++++++++++++++++++++++
>  3 files changed, 855 insertions(+), 849 deletions(-)
>  create mode 100644 lib/raid/xor/alpha/xor.c
>

Hi,

I applied this patch and ran it on my UP2000+

The kernel builds and boots, and I verified the new lib/raid/xor/alpha
implementation using the XOR KUnit test, the test passed, see below:

[   25.705064]     KTAP version 1
[   25.705064]     # Subtest: xor
[   25.705064]     # module: xor_kunit
[   25.705064]     1..1
[   28.957992]     # xor_test: Test should be marked slow (runtime:
3.253413330s)
[   28.958969]     ok 1 xor_test

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

