Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D75CF07C4
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=; b=Y0VZunYb97d27wvHj3Xs7Cxtn0
	c3zoqxhQfyToK8T4gJXYQB4QFK0Ln/M4+ccg0nq9+sPscfvVlNJgKoc2HBdGT+tSQGIO9Hoj3Bz28
	GHBWcUT/4Xz+Pljbfq+OVEH87QTsbAP1iEmWJcDNvNNYiS0VSImk0tn4kYkRptjXeZxi52rhnlqIn
	AZ1ls4Uv7opoy+wtFjDsoLVsm/jK7MWcgMEvSOgz/65sVUef50SbB5sfW1zXnIJ/QnFTLAMUo+yoy
	LKDGg/J+XuQ0T5p8fyjHRzF1NXT/01wZ6mXh5FOB3yOVo9bgY+tolKAgllQSXc0Ge4SvKbwNkZBV9
	jqkJ2OPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syoak-0000000C1Y6-470k;
	Thu, 10 Oct 2024 08:32:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syoZS-0000000C0rK-1jvL
	for linux-um@bombadil.infradead.org;
	Thu, 10 Oct 2024 08:30:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=; b=KcCm8ZQFYlckSOSDO39Eo9/kbU
	qP9AoRMxNxnteKjgA4wRBODap9MXEYadlrvHYD4RKqWbYnIqZssMBWBeMtdJvpHUyexHug9odS1IX
	6iyNgkqOb6aQFxKbC4j8QyDlB05HvrL3VoCy833y86T5rNupxU2dP1YpLnIxRbEUI/kJnTX/4ckhr
	es9VyhEZVpJU+zjnHr3ZOTtolskLHe9EVSEAyUeZ7HHW+2dzpMJvBrIKRfluftDSFLcmC0LP0cRM/
	vyOpazvig2PthlpETs3Jy8ME7sC2co76U8z+YT5BtQDvnEYzg837gTL1yh/+QfVVSgPPjf8f7PD/8
	dd99Rudg==;
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syoZO-00000005FV8-337f
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 08:30:52 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2e2d73e6a9fso246232a91.2
        for <linux-um@lists.infradead.org>; Thu, 10 Oct 2024 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728549047; x=1729153847; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=;
        b=lWD5ZF4paS+CPNvk5I0Q3vgmZaGbjHo0e8O542C2/6vcDhO2sNFFKyncHpuzkNK2nL
         LvMyZaLh8yJLLf8yMcKKBKYNjMTRbHBy9aQxBVpfI3584oaLa/d9Ie1TVY8s1Ilhk3to
         X98/gHRANduq1YEJ5pSnV1S+jg0kaTf0ujZPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549047; x=1729153847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=;
        b=KfvhdcRg3r9DHS/ai8T2AgOdYOU2dYjrtXpODBo5696WjB7F3KvAJCUI6OzhNaMWp4
         f8cAJdCLGuibgsFrpWB8JiSJ1cVx+HwvOVZYmL+TcrT1lKmfDwFlaGV4uv3KNEnjoP7S
         CmjX0Z77Bm04DxX/ZoAWGwhNeU0yGhU5eJgyLU4dvx9dsTYmiZXFG4LMAJxSLfNzPAJt
         6XIFtX7XW63t16rLDE9Itz8t6paDoqw+DEuUNqC3dl3yo1bpiPl49VhUuYeDgDsE/uu3
         xFbzrwDzDbETKEetGs6mgxZ5RA5vg/duHHaPJuVCSghCIv3rANNa7V+Ys1bKMO/DA4Ad
         GRdw==
X-Forwarded-Encrypted: i=1; AJvYcCXwMy38DC42aV1KK5ju0rwJTCf73zmA1VfaUf4b11s5/HF2bx/cHsRQV4f4B9SE9/Z0vf7gqb2CXA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEcUTHlDY1A1aeo/uunAfUYmW1SVELYM4UxxC3TUsFF//mHbEh
	QPpfU1iuPWL9eMfx8vFk6NohDhhXI7hf+LFJjOvXc8aY7E5NVLb10on8euFwsg==
X-Google-Smtp-Source: AGHT+IGiHJLVn7EEJZoiHDg1IHJwEmo5BKI2W3X+EqMqHJDA19Xi8bq+M3epyy60EICvZVegJa7iQQ==
X-Received: by 2002:a17:90a:178e:b0:2e2:cc47:ce1a with SMTP id 98e67ed59e1d1-2e2cc47ce65mr2245610a91.1.1728549047177;
        Thu, 10 Oct 2024 01:30:47 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c13a:abb0:1c8:a3c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f0a424sm730808a91.28.2024.10.10.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:30:46 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:30:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Bisected: [PATCH v5 8/8] x86/module: enable ROX caches for module
 text
Message-ID: <20241010083033.GA1279924@google.com>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-9-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180816.83591-9-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_093051_162449_F8CB0FDE 
X-CRM114-Status: GOOD (  10.51  )
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

On (24/10/09 21:08), Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
> text allocations.
> 

With this modprobe disappoints kmemleak

[   12.700128] kmemleak: Found object by alias at 0xffffffffa000a000
[   12.702179] CPU: 5 UID: 0 PID: 410 Comm: modprobe Tainted: G                 N 6.12.0-rc2+ #760
[   12.704656] Tainted: [N]=TEST
[   12.705526] Call Trace:
[   12.706250]  <TASK>
[   12.706888]  dump_stack_lvl+0x3e/0xdb
[   12.707961]  __find_and_get_object+0x100/0x110
[   12.709256]  kmemleak_no_scan+0x2e/0xb0
[   12.710354]  kmemleak_load_module+0xad/0xe0
[   12.711557]  load_module+0x2391/0x45a0
[   12.712507]  __se_sys_finit_module+0x4e0/0x7a0
[   12.713599]  do_syscall_64+0x54/0xf0
[   12.714477]  ? irqentry_exit_to_user_mode+0x33/0x100
[   12.715696]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.716931] RIP: 0033:0x7fc7af51f059
[   12.717816] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.722324] RSP: 002b:00007ffc1d0b0c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.724173] RAX: ffffffffffffffda RBX: 00005618a9439b20 RCX: 00007fc7af51f059
[   12.725884] RDX: 0000000000000000 RSI: 000056187aea098b RDI: 0000000000000003
[   12.727617] RBP: 0000000000000000 R08: 0000000000000060 R09: 00005618a943af60
[   12.729361] R10: 0000000000000038 R11: 0000000000000246 R12: 000056187aea098b
[   12.731101] R13: 0000000000040000 R14: 00005618a9439ac0 R15: 0000000000000000
[   12.732814]  </TASK>
[   12.733362] kmemleak: Object 0xffffffffa0000000 (size 2097152):
[   12.734800] kmemleak:   comm "modprobe", pid 410, jiffies 4294880489
[   12.736334] kmemleak:   min_count = 2
[   12.737228] kmemleak:   count = 0
[   12.738043] kmemleak:   flags = 0x5
[   12.738917] kmemleak:   checksum = 0
[   12.739783] kmemleak:   backtrace:
[   12.740606]  kmemleak_vmalloc+0x29/0xc0
[   12.741532]  kasan_alloc_module_shadow+0xbe/0xe0
[   12.742649]  execmem_vmalloc+0x116/0x220
[   12.743596]  execmem_alloc+0xfb/0x3d0
[   12.744479]  load_module+0x1e84/0x45a0
[   12.745383]  __se_sys_finit_module+0x4e0/0x7a0
[   12.746452]  do_syscall_64+0x54/0xf0
[   12.747319]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.748772] kmemleak: Not scanning unknown object at 0xffffffffa000a000
[   12.750364] CPU: 5 UID: 0 PID: 410 Comm: modprobe Tainted: G                 N 6.12.0-rc2+ #760
[   12.752441] Tainted: [N]=TEST
[   12.753165] Call Trace:
[   12.753760]  <TASK>
[   12.754279]  dump_stack_lvl+0x3e/0xdb
[   12.755165]  kmemleak_load_module+0xad/0xe0
[   12.756165]  load_module+0x2391/0x45a0
[   12.757068]  __se_sys_finit_module+0x4e0/0x7a0
[   12.758135]  do_syscall_64+0x54/0xf0
[   12.759099]  ? irqentry_exit_to_user_mode+0x33/0x100
[   12.760292]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.761508] RIP: 0033:0x7fc7af51f059
[   12.762372] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.772361] RSP: 002b:00007ffc1d0b0c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.774957] RAX: ffffffffffffffda RBX: 00005618a9439b20 RCX: 00007fc7af51f059
[   12.776635] RDX: 0000000000000000 RSI: 000056187aea098b RDI: 0000000000000003
[   12.778283] RBP: 0000000000000000 R08: 0000000000000060 R09: 00005618a943af60
[   12.779949] R10: 0000000000000038 R11: 0000000000000246 R12: 000056187aea098b
[   12.781619] R13: 0000000000040000 R14: 00005618a9439ac0 R15: 0000000000000000
[   12.783319]  </TASK>

