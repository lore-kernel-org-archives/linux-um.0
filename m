Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1EDCD042A
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 02:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3PneSlTXDqotjglO3Y2Knzidjrv0hwlCbWEle0lUDcE=; b=J3Jl5s/+XU5HRyQbiknXjy5kZv
	gSgkqsKgb2jX1hEOyy053A3Zsq6gRspXuo1Fs57wc6knF4//KhFcj1wlHLa8g4wWC0UnsKatOrsFr
	T9kMqHuVFDGq5k2+yglzpS0POjJmJEkbwpogV4z0sJKVCV9onUJ6HfdGscYe46SMkCL8X/x76c4DG
	wjn88+FFI+s3jSkScns7aGj7ew5xnYh5IbtMuO5AjIcIwPgPMGe7iHnT7ebkKzLcfxCGaEAiVy0vB
	oJJac/7efOsZVnmHT43zP0DHrrfSKxPYE+wOK2ZuJIIYba7jfo91XiuCZSqKlVgjEkUAEjSLhfeOL
	tYGySprQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcwtK-0000000CLvX-0WXk;
	Tue, 06 Jan 2026 02:33:50 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcwtG-0000000CLvB-2iJr
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 02:33:49 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-88a367a1db0so7046776d6.3
        for <linux-um@lists.infradead.org>; Mon, 05 Jan 2026 18:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767666825; x=1768271625; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PneSlTXDqotjglO3Y2Knzidjrv0hwlCbWEle0lUDcE=;
        b=jgHGuTbqBnUso4Lnfj3O9DRi0I4aUVyboTdfADVMYXOk/Npok1mca0AREDObhPyEoL
         JhgcTDQt9r7cOGLUMvtHHBd0YaIdqtdPoQ1UgYd84cwBNMjVZw2oQ0maZzSokPG+hf4c
         hhyVzPwgkvnfrG8pWtLAIeRp21ok8SQ4I6oGZKzVXN4aVQe1txDXVzJNl2JzoxdRhIBz
         nnvhQutZXpzWwKOyMscCMqBOPdM/uIZ64X/a6SBPwWS0H4v+i5UPAItCCCmTwsSm1m18
         ZE5XaRRjKe1J0r3KjfMNHhDY3qqt0FH+GeAF31HeV05YxbezXb5GG/iz95SzEhZobuwj
         owXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767666825; x=1768271625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PneSlTXDqotjglO3Y2Knzidjrv0hwlCbWEle0lUDcE=;
        b=UpXu6BmnVQ7uTo0VOVcxsz6hc6tp4qYsXo1uKX5YanEdY2ujHHaxkRUjT8/qOQTZ9C
         2DqGZFqJLp2mfItjZ88oB10Aq3m3/DGAG6RoxeOM0bKTj3rUndDrBmmQU3XxCoY3sdS9
         4DSMG3vHqx1ukS6EbhjZXI+Dl0YNYEVAi6V7Z8faJJhKoLkiVxALDRa/JYBBxpXoFuuI
         Yp3ZZbtAEunThQ6jdiRmvsruRd30a+YzJjucR9EP9W+MdunBx1Wa72+gDKjERLVovQ1J
         pCbitdhbOw5QTBXQS3Rh9sMkATxX3lTrgs+AeG2Xq9z/5HQpMT61GqGMptPs0WIjsP1k
         U3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUOpJE2t1qJcBRx+Nvlo5bvM9KiU1/F1+OSaRKVaQTPGIKq5sPhihEoowKYMzmCELNMAonNXyBahg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmoeKY/e4LbStNNfIu7TPF/JVugjOwAzBxb7acPZR5+3sdeuvN
	J/5+Y6ybSxRd1VrBNbUKdvX6IGlGq5HbZuJxlD2DbPrsJTaimuUZkrNF
X-Gm-Gg: AY/fxX6s9ZW9Ot4C4/Y9IzOm5v1l+5Ya6rjz/J/9YmRyTHK0iZM8hHkC7v1IsmE0qIU
	RIzKm/Ako1MVFvubhfizvGpIEKWXRSqd3vNoFjTA/UTeGrvvpWXGvk62/ilAI+H2a23XK7PFiq4
	NfPWDeDmOD86QCKsegQ/98AFzUZQH5meRyRRsxXhdevBj6k4JXf+oWn94VttsrzZxPh/yJ+1Ry5
	Sf9E/2TOdtAQqE58YPqwUT+rYmQjb2ioFw51izKsMlCK8qI7rZ2+6nm+/n2Wng2/UYe2Yhae+g6
	IpqSxnrJfcqzRaNyZWE1cJ5+fuCn5GyfHR5ztCbNH5Li2zyS+53g/7wxSJ7Um+vSGo2cGkpOmwg
	Pd8PURq0IqpBhu9g8V6TOHhcD1mdYgbaw7xFC7aTNhvty0bkOcBvATva1yyZcdC6upcY2EDy72t
	LctqFYfiDDZ4aM3kvCqAMMzy5sZOXHg0E8ueX+bKVV8Q+FLVVb3qZnzgjLjorYrMCPPx0zDHlG4
	XOWWNq9daOplNU=
X-Google-Smtp-Source: AGHT+IH/ZnViArMDusDnASin1cg4KvwlFUBMfsXmrGNUlYaoDSSPkbXVeTNfTyQwJuK1hW94jJnL2A==
X-Received: by 2002:a05:620a:1aa8:b0:8c3:55bf:735b with SMTP id af79cd13be357-8c37ec06899mr194116885a.81.1767660549347;
        Mon, 05 Jan 2026 16:49:09 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f540650sm62900285a.47.2026.01.05.16.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:49:08 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45B0CF4006A;
	Mon,  5 Jan 2026 19:49:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 19:49:08 -0500
X-ME-Sender: <xms:BFxcacLaYSZeaZHCInRCEKx1t7gio2sOan8nMWlaOAftxb6cMbzZig>
    <xme:BFxcaVi8cvoZQl5Yjxu0XkAdVD9WiLnvhLKqIGJ56Jkc-Uv-6oKEtDTmaK-O0_FI3
    skFnOJcgXWWFOPCRuNqRWaplgcZn0dYLpM2dMrks1atArfO6zbR6A>
X-ME-Received: <xmr:BFxcaVN_MHnqRgCLmuuW_xddB_5EgJOgN5rf_SgfuEUzcrr7m0ALSh6C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepfeffudehveduteeuffeutdetieeftdelfeelveffffevteeffedtteehteegkeeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepfhhujhhithgrrdht
    ohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehllhhvmheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpd
    hrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrihgughgvghhrvgihshdr
    tghomhdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhsohhluhhtihhonhhsrdhnvg
    htpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohep
    mhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:BFxcaY5Gx8Jp86sLaYoazAtB9DP7v3tKbfmtFZVR8YT1OUkyVSK-sw>
    <xmx:BFxcaUmk0QWQ3Edbq7ih6qmgSAky7Qhn95FtxRYszP2gv4lO5huQHQ>
    <xmx:BFxcaQJTqkKpqJuZCkQAsFeM0C0nkyz3vT60LAhR_03jL-g4nAaoAg>
    <xmx:BFxcaUTG5mSIvQgOY_GbRZ3D-7cZKEpzjwucqXIXpm73stWvyPiFpQ>
    <xmx:BFxcadtBWFQ5rj93VI_SYR0myk8PisqpeSvfhhy8BiyD_jiI67FztcYD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 19:49:07 -0500 (EST)
Date: Tue, 6 Jan 2026 08:49:05 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [boqun:rust-sync.20260105a 18/22] error[E0277]: the trait bound
 `i8: AtomicImpl` is not satisfied
Message-ID: <aVxcAZe6AEXEfx3G@tardis-2.local>
References: <202601060041.k0JkAkUD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202601060041.k0JkAkUD-lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_183346_710981_3BA7B172 
X-CRM114-Status: GOOD (  17.83  )
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

[Cc UML]

On Tue, Jan 06, 2026 at 12:25:24AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rust-sync.20260105a
> head:   243aa6a057d46d3a4de9297422e480d469eddaf7
> commit: 06ed7e7e7aa656f7054af7d3d3387a07244d85b1 [18/22] rust: sync: atomic: Add i8/i16 xchg and cmpxchg support
> config: um-randconfig-001-20260105 (https://download.01.org/0day-ci/archive/20260106/202601060041.k0JkAkUD-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260106/202601060041.k0JkAkUD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601060041.k0JkAkUD-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/sched/rq-offsets.c:5:
>    In file included from kernel/sched/sched.h:28:
>    In file included from include/linux/cgroup_api.h:1:
>    In file included from include/linux/cgroup.h:27:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:24:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>    |                                                   ~~~~~~~~~~ ^
>    1 warning generated.
>    llvm-nm: error: rust/helpers/helpers.o: No such file or directory
>    clang diag: include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    clang diag: include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>    clang diag: include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >> error[E0277]: the trait bound `i8: AtomicImpl` is not satisfied
>    --> rust/kernel/sync/atomic/internal.rs:265:7
>    |
>    265 |     [ i8 => atomic_i8, i16 => atomic_i16, i32 => atomic, i64 => atomic64 ]
>    |       ^^ the trait `AtomicImpl` is not implemented for `i8`
>    |
>    = help: the following other types implement trait `AtomicImpl`:
>    i32
>    i64

UML_X86 is using the atomics of x86 kernel (defined in
arch/x86/include/asm/atomic*), right? If so, I think we need this:

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index bdd7c8e39b01..44b12e45f9a0 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -9,6 +9,7 @@ endmenu
 config UML_X86
        def_bool y
        select ARCH_USE_QUEUED_RWLOCKS
+       select ARCH_SUPPORTS_ATOMIC_RMW
        select ARCH_USE_QUEUED_SPINLOCKS
        select DCACHE_WORD_ACCESS
        select HAVE_EFFICIENT_UNALIGNED_ACCESS

Regards,
Boqun

[...]

