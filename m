Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35503C7EE32
	for <linux-um@archiver.kernel.org>; Sat, 28 Jun 2025 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WW5Xm1iyi3UCGUGi1nrA70AfDCSuOC/overmp2OZ2oI=; b=kBqUtyWScj6o+9tuVoM4sMyGsk
	/zkUJ22gL6gl9+QeYNQK3inFbt2H7vAwUEJVIpXA6wOMuNscs7ntKnsIVuZWHJb/UeCgevT2Qr3zK
	IavGp8gpPIksmPvv7d3jY/O3XsZxyoaIMah8xOAFI4Nt/ADzI7+gtKYeea654eT3cfVvWdRoeMbF/
	clwhGIwU0fyaZ+aoLTXwWvY3yrc/tfxFk/ii7nwQ7cIZEAjbiecztbH4trmie+t/Yb6cUawoqYFE+
	Ng62P0ZVG0o84k2vhXL4O4jnl74bVt6x2v4keCxMzjELgT+rkmM7zJrj7g87TrnDdf9bE+esxrCi2
	6z5wwjzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVTF3-0000000Ghoo-2S9u;
	Sat, 28 Jun 2025 10:57:05 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVTEz-0000000GhnU-3EHm;
	Sat, 28 Jun 2025 10:57:03 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-453643020bdso26032495e9.1;
        Sat, 28 Jun 2025 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751108219; x=1751713019; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW5Xm1iyi3UCGUGi1nrA70AfDCSuOC/overmp2OZ2oI=;
        b=D3L/+lknpaeeenqGwyJpshsQ8s7osMdbK6MB6jcAqHGVJty8XEuOzq8ds65be36ke9
         G/zqB1ztm/PGWgd524RAm3UXkbSvi5Z9xLNWDm7ii4+64JyCuY5cxS42oEaRwVMWPlI6
         WV3VBA6Bj0P674DZQe09CLsM6doquQBZ2gUxSXjcW+yQtT8wft0JrjLXl8glvP685Rei
         kyVkcBJJdbvrzOx+dFHCB1uqxnuoi7oZyd9MjyHeerb8wpfnLFmzdSr6fLXm9k3LLnJM
         JnmFoVBmytduoqXaKKuINS0NpWi3r1l6AbR+DFO6gF84ld3bEWVQf3oshVxo+jOhRaep
         zLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751108219; x=1751713019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW5Xm1iyi3UCGUGi1nrA70AfDCSuOC/overmp2OZ2oI=;
        b=AedaF0xyW3JAJiH2RWZIUuyco9VQzHgGw2I1yYp1hcBxuO0g5H2cS5idrGa0WurgO6
         d7TE60IGn4IdX+TsO5aNS5RopBHO2Rpvx0AGHB0h4aUNdT64Dm1XM5TJSLd3ddymW/9n
         ZOjSzoMXNfLFuxRSc+Mhh1PWwvKGpMubADynJhaQGvWY6cu1bOZvw2hEU2cAGUqABZiu
         sU6vqsG+KEA4hu5MtPqYEXaF2fjHDoOglxyeD4dwK+m2h0Yg7YJCBKCUFibM+ELnjrVD
         nRrajJo9T+fO/FJV5Tue7whzmtg1LG6bDcHwUX+hhzf4Hvh6fEpbH89nE6329A5OFIYJ
         I7zw==
X-Forwarded-Encrypted: i=1; AJvYcCVN/R80CvkPxmSxyy0K2N8bTXd+KNZ5+VCD7TnlHE5MJtnYZPoMxyw4zZNT5rXCpt94cb7s+6KG5FnHQXm4lnmK@lists.infradead.org, AJvYcCVSY06vNJtJrHPr85Avc4EO6His7ICr2KiMVxj13xGNRMtBapjyL8FoirmRpM4V7+9ffqQxnA1rLhA=@lists.infradead.org, AJvYcCWtNN5yr9cFo2mATS67ez8Y3060jbWhbUP2M2hfR1e3JpIEnUkRAULipaQZF7IMfmbfrWapgZVv/ndc/sE=@lists.infradead.org
X-Gm-Message-State: AOJu0YxnEFVEMbhH09LlddbhqoglFAByspLSBqXnvHwHnDgMyjCL2WPO
	/tdxrns/9EFzHOsuefwP1bD2zt6wRG7Akreo8Zada6E0JLqqHnk9ewbr54NX5ICCyeK5PPzz5De
	xnSX8pXFkcrvzpT4aRWsh37/LbcCIYAg=
X-Gm-Gg: ASbGnctvLrlcCkhwvyBuAXOv8M111DvzTPxV3+KC2tpOsfOHBj71r3yV5yQ1B9XNu/Z
	YZEUaVmNB3gfwDJU6FIET5+eGC/yVHZ8SzZGVFlHjHVny42flW9t1m2VmxPhfCKObcWYm0tu+qH
	0UEPAamHp0+AHpS/UtMEuu/cl66i765K46C+IenXT3yQ8chapMTtjE1ONj
X-Google-Smtp-Source: AGHT+IGAGkRhQdbRpH6HhS1J+gxMpfj97HGV7cZaVPURx7gE9Aj/9LEPZdgznOP2vFFz/ZEWLwEewnTNwxfxlbsYcE0=
X-Received: by 2002:adf:a1cb:0:b0:3a5:3b14:1ba3 with SMTP id
 ffacd0b85a97d-3a90b8c99bdmr4338216f8f.49.1751108219175; Sat, 28 Jun 2025
 03:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250626153147.145312-1-snovitoll@gmail.com>
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 28 Jun 2025 12:56:46 +0200
X-Gm-Features: Ac12FXzas27xdNkixqmlGojlaGpK_Gh1QoVs4xiB8K_jsjOjMmn0UG8i3tUlU1Q
Message-ID: <CA+fCnZfAtKWx=+to=XQBREhou=Snb0Yms4D8GNGaxE+BQUYm4A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] kasan: unify kasan_arch_is_ready with kasan_enabled
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	akpm@linux-foundation.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, arnd@arndb.de, rppt@kernel.org, 
	geert@linux-m68k.org, mcgrof@kernel.org, guoweikang.kernel@gmail.com, 
	tiwei.btw@antgroup.com, kevin.brodsky@arm.com, benjamin.berg@intel.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250628_035701_811773_3349B252 
X-CRM114-Status: GOOD (  19.81  )
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

On Thu, Jun 26, 2025 at 5:32=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> This patch series unifies the kasan_arch_is_ready() and kasan_enabled()
> interfaces by extending the existing kasan_enabled() infrastructure to
> work consistently across all KASAN modes (Generic, SW_TAGS, HW_TAGS).
>
> Currently, kasan_enabled() only works for HW_TAGS mode using a static key=
,
> while other modes either return IS_ENABLED(CONFIG_KASAN) (compile-time
> constant) or rely on architecture-specific kasan_arch_is_ready()
> implementations with custom static keys and global variables.
>
> This leads to:
> - Code duplication across architectures
> - Inconsistent runtime behavior between KASAN modes
> - Architecture-specific readiness tracking
>
> After this series:
> - All KASAN modes use the same kasan_flag_enabled static key
> - Consistent runtime enable/disable behavior across modes
> - Simplified architecture code with unified kasan_init_generic() calls
> - Elimination of arch specific kasan_arch_is_ready() implementations
> - Unified vmalloc integration using kasan_enabled() checks
>
> This addresses the bugzilla issue [1] about making
> kasan_flag_enabled and kasan_enabled() work for Generic mode,
> and extends it to provide true unification across all modes.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217049

Hi Sabyrzhan,

Thank you for working on this!

One aspect that is missing from the patches is moving the
kasan_arch_is_ready() calls into the include/linux/kasan.h (this is
not explicitly mentioned in the issue, but this is what the "adding
__wrappers" part is about).

Another thing that needs careful consideration is whether it's
possible to combine kasan_arch_is_ready() and kasan_enabled() into the
same check logically at all. There's one issue mentioned in [1]:

> In kasan_cache_create() we unconditionally allocate a metadata buffer,
> but the kasan_init_slab_obj() call to initialise it is guarded by
> kasan_enabled(). But later parts of the code only check the presence of
> the buffer before using it, so bad things happen if kasan_enabled()
> later turns on (I was getting some error about invalid lock state).

And there might be other callbacks that should be executed even before
kasan_init_...() completes. But then for the HW_TAGS mode, if
kasan_enabled() is off, then we don't want to execute any callbacks.

So maybe we do actually need a separate static key for
kasan_arch_is_ready(). But even if so, it still makes sense to move
kasan_arch_is_ready() into the __wrappers for the affected callbacks.

Thanks!

[1] https://lore.kernel.org/linux-mm/CA+fCnZf7JqTH46C7oG2Wk9NnLU7hgiVDEK0EA=
8RAtyr-KgkHdg@mail.gmail.com/

