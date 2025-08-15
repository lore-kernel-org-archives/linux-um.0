Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F038CA0EE6
	for <linux-um@archiver.kernel.org>; Fri, 15 Aug 2025 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Message-ID:To:From:CC:In-Reply-To:Subject:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=EHLPRMwsFUXklJ+HOrV/DsMAdiggx2WSG2UfKCJiulY=; b=v8Kww2W1+xarjKzDFVcMbhuuVh
	/inIexq9E8Ei1uiKdwlAAmoxiJDC5qcOI8+2GKoAdiOqwjnAXqnPh0RizijQnVSCYL9zeFI2Hx4JO
	uMclggCCVwiJvbM/EhLxO++/sK8o1J36GM2tXgp+pA1icWJ9Nb9oUKjMIkqeS1bgET6zDlpe0iHC/
	nX446dia+GnXZ60Is6a+zhtIOxl/2gwBVYZGrDsyZGXMY5KAnIGl6uwlL/0yVXjSWB7s4uPjkZNaE
	vnMS1kZvxgXO39+8xPZd++Su8b753tASAtVf11OLTy5aEAPuMSMxqLB2zfCsN1ilAkmaa8sBKzi2c
	uZwTDWNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umxo8-00000003481-3D5M;
	Fri, 15 Aug 2025 17:01:36 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umw1l-00000002o4z-19Sk
	for linux-um@lists.infradead.org;
	Fri, 15 Aug 2025 15:07:35 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so2103557b3a.3
        for <linux-um@lists.infradead.org>; Fri, 15 Aug 2025 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1755270452; x=1755875252; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHLPRMwsFUXklJ+HOrV/DsMAdiggx2WSG2UfKCJiulY=;
        b=kuUsGxz/9rMdj1ukrsG45ngj/qTldeLG4g+kLJOJTigUJjHzu8Ciasmjp7sduz+5MC
         FgQ6OvKEcbuZFTu7//2cleiWXIe0OHvagjo8EwcrV/D4OuAbuNA064aJJ5XU13Y1fglm
         N5Jn0ZTwm25S/B/VvR0xUv9SnQGRz2c+p0Pq99Kd13/XAPfNpqL6vbBzVVYNOMcQIwQj
         Tgdmi+VcHA0l6mXT2xGg0enXpZhO71Ht+Xo7u1hgRUamj3aoIYa3CYHZOdMN4v+7btQ7
         nBIESUUHx9oEhaQWI+NTfm+cWP+6toujh+k7d2VaT5u6RG+ekOc0ItdzARt7oWUQP86V
         NxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270452; x=1755875252;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHLPRMwsFUXklJ+HOrV/DsMAdiggx2WSG2UfKCJiulY=;
        b=YxBk22bx8Mx8BT+sACmKarpk51jKhQwymDqWZwTg4RiVWWWU8RnFkSUJTX/vibyT/b
         m6LhC4FJw0D3p9w0Fc6QoW3IdJI80MSGNpCv3v/TCP4syVRSGTeC+WOEwC4mZFlVUWUG
         /VVLXLoxzEQ0aGNEzf0olLi5mdbm8VOsg2GJj/dFw3bgbb0zPuf+hbudawjgHjzUsYfn
         8e2pQByMY9vx0fZKaUFTwrJuIs3HCJ6bdkIywTIkj9E4aa7XtUyLymA193OUElo0rSDt
         +QWRKXyr2HDrh3x5VqJYItnic5wRgCNkD5fDntrk7GGpzcgf4Qww92GiaBcBLit5k6el
         c99g==
X-Forwarded-Encrypted: i=1; AJvYcCUU4DwOjPto5rjaSJMYW91XQwz5Aj/53P7KbfBr8HEq90tberbYZgK6yppUBuTws5DMKOu0nn73Yg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyA0om5j6KwgnOi5UN5uQ81V0V3a/xmlGRGyefQxX5lMnTcGgZ5
	JxwBngBgymRsb2OYFEjROEe/d27RzSg6Nfhl2sssTNPzf/8lPf/FMTdpJk9CH+Mup+s=
X-Gm-Gg: ASbGncsy1gmOcGCzBUtct72PExc1lAFmSNuV5+iUpQAmj9rntIbBT5hg1UsxMapFnHd
	Ow2Mo/1DqZ1KjpgR2JdagLD1J8NFBgi8Fy7eZB0Xobh8StRsccwFbygqR0jUYg7RM+D5lTo55tM
	JSHp99UegitKCXjgDuBDu9C11BSVWPdhAMV2LqHUzzebL19SDyAmj7LRK33s6ckANO7QviqILQt
	BbnTXdYbvUt+1vNk2QVrokcaE5exLbgFlcgd2rT8hm/Mw4eKpNoV4YQrGVR/QHWk8CJlq7Kae5K
	9ZpcyMQuGA6Qax1RWKcykrOLMKLBjk/60Pz3QFBISs6tZv9+qYbEtS6qjWarVdqZXjJiBVTwTwv
	8nvBm3Pz8eZB/GZhbcYRTyv1z3wr8+veq4gM=
X-Google-Smtp-Source: AGHT+IHmxnV+YR9cR/LeaPBJErhvHjNkppxMDemXEcOX3MCe4Sp9OWex1hLOxvkMk2wkz7dST8S4eg==
X-Received: by 2002:a05:6a00:4f96:b0:769:a6a2:fe1e with SMTP id d2e1a72fcca58-76e447e3389mr3104455b3a.11.1755270452302;
        Fri, 15 Aug 2025 08:07:32 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e4558bf19sm1309791b3a.99.2025.08.15.08.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:07:31 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:07:31 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Aug 2025 08:06:56 PDT (-0700)
Subject: Re: [PATCH v4 17/24] riscv: vdso: Deduplicate CFLAGS_REMOVE_* variables
In-Reply-To: <20250812-vdso-absolute-reloc-v4-17-61a8b615e5ec@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  Alexandre Ghiti <alex@ghiti.fr>, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
  justinstitt@google.com, luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
  kees@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
  hpa@zytor.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
  linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
  maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
  chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, gor@linux.ibm.com,
  agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, tsbogend@alpha.franken.de,
  ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
  bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
  tmgross@umich.edu, dakr@kernel.org, nicolas.schier@linux.dev, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
  linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
  linux-kbuild@vger.kernel.org, jstancek@redhat.com, acme@redhat.com, alexghiti@rivosinc.com,
  thomas.weissschuh@linutronix.de
From: Palmer Dabbelt <palmer@dabbelt.com>
To: thomas.weissschuh@linutronix.de
Message-ID: <mhng-540E0EE0-A9CF-4EE3-9E71-969B40D29C50@Palmers-Mini.rwc.dabbelt.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_080733_311288_69B6C47F 
X-CRM114-Status: GOOD (  15.65  )
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

On Mon, 11 Aug 2025 22:44:30 PDT (-0700), thomas.weissschuh@linutronix.de wrote:
> All vDSO objects need the same treatment.
> To make changes to both the list of objects and the list of removed flags
> easier, introduce a helper variable.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Jan Stancek <jstancek@redhat.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 9ebb5e590f93a3228c451dca58e6d5cfbbc03ff7..c19c3c76f7c9f6b2f7523a59269de3b683656323 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -49,9 +49,10 @@ CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
>  endif
>
>  # Disable -pg to prevent insert call site
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> -CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> -CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> +CFLAGS_REMOVE_VDSO = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> +CFLAGS_REMOVE_vgettimeofday.o = $(CFLAGS_REMOVE_VDSO)
> +CFLAGS_REMOVE_getrandom.o = $(CFLAGS_REMOVE_VDSO)
> +CFLAGS_REMOVE_hwprobe.o = $(CFLAGS_REMOVE_VDSO)
>
>  # Force dependency
>  $(obj)/vdso.o: $(obj)/vdso.so

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

Also assuming you want to take this with the others.

