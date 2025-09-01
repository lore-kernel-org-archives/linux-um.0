Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03699CA1015
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmDip3pK7R1bCI3jhASK9yPIU2OeMFz+fVnQvMU5RZM=; b=dXV0fuUWFOyje64Nqiu8/94uGp
	g8IQmwDs1C6fQJAle2Vm1C4zlKGtTrRcmYPjmdILfixDZSrX2Fl+iqMFvR+bLsssKaSB1mlyLY0tc
	UROnDEOTiFXF8mg01kzxIxqFA8nl1zvlQK0ql0arLQxDvuxI3E116duwZPA3XgKwJ9retbHTgkZ62
	2X1nV19wXhLLghWzsY/pr0kuSohK3rOlhO8lJX3Z4h8mcKH9wMyHCSJp6sms59I6YNoGDxdvcWl50
	gAOT/7Q0wq5GKstNXA9ytKh8Jfg1U953LhrXI5mFwBZOM1FHKo12IiT3qJ1C5pdi2+6SqneqHQPfE
	WW3Z7R1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYlt-00000002AHM-3AtG;
	Tue, 02 Sep 2025 21:42:33 +0000
Received: from mail-oo1-f50.google.com ([209.85.161.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut53p-0000000Cn5q-45YF;
	Mon, 01 Sep 2025 13:59:07 +0000
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61ddbc4264cso2330937eaf.0;
        Mon, 01 Sep 2025 06:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735145; x=1757339945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmDip3pK7R1bCI3jhASK9yPIU2OeMFz+fVnQvMU5RZM=;
        b=f3bc9G3/lnLzzLRIdMwRlSIwCgHOfJTb+vv/i99fBL93RzwUi8woQvidNAMjxzpxjw
         lgSuwEImYLaH50DLm2W5ku1soNLX5ohDXBjbft39OF8xTsoh4xYw5GYZO5dLeRRS2HZk
         Sq3deV64GsA3ATMXHT4lxkFf7MwCB+9wR6j5aSzIl6j4IEy5AjzJknQENtNpLbE8W97u
         pZCaH4qI9km5V6s3x66zZVl/ssjEgwD+YWcgzeBoZrCUpvmTAQkHIxSGEurnfCbyCyZB
         WZ8iIjP0DMInOs3G6ouxvsY/gQULhNTBMGIOOf/yTz/9azoS7ZjF0KURxd+TSK4CeEAP
         sd8A==
X-Forwarded-Encrypted: i=1; AJvYcCVdGPK2JhbThWK5eOqqaHt00DkWUCYYlt4ncWTRyN5jaRnIHGSWn2kCygX+TU9woBtM2cMJbyL04To=@lists.infradead.org, AJvYcCXoiLGZqt99UyuQhc3L6D86yAg/2t3XRi32kQoK5XPQhBpPhSRtmtW8i/gD23N6v7qLWFqjIH4I5xMkWbM=@lists.infradead.org, AJvYcCXuDDitZSI2ZE7gEHfm10Pat9lAFLTfM96DNADA0AhOnKXqYMiqaO9AD7fJu9ldSCAkK/hznNEGMe3LAswtQrM=@lists.infradead.org, AJvYcCXzJB9hdVrR5jYQctbiq3f0lYYsRrG0lP+cthsKpTwaUyGgGlR7G9HQmWBx2fBZ7Bn+g91woXbTpDgAOIeneoEq@lists.infradead.org
X-Gm-Message-State: AOJu0Yzg0FeAKczYGRxN7TZD1eJXydAYpWeN0kioBPFMYqSFY6DtMMy3
	+4g7c44YKmmUlMjUXKCrIwGBLl/I7ggJxw6MZeuvCyQt9Yh22ER29gdGHMyGcTEopzM=
X-Gm-Gg: ASbGncubK++qrRdjBE9ZLpgZsZvhw1NGzuSKJIpoB0HZ5IBazwQ/fNe8kF0En6kU136
	90V2tAzeoXHrytSfILsNEKmkKFUTyUoxKYG/1Oev96JFKvcfxG3YFdMWkx64VrX5W5MI3oo1Ges
	QXnadcyr5Q7gKvOQJFsKUn/xjkurj2xIDe46i4O6S5vQ71Vx4/1OvWoP/nc8dq5nZGRMYgZ9Od9
	0vZixzPL8MokPVZ5m+EEbGGMc2gCHlWH0KgoYaLgil6f3bTMjtRwzNNm82QpcSqPTGDAKuCbtjK
	yLWUA7SGFwgCjUFEg4ko+wVrthvkDWPcOHU09HgLzs+a/ZAvM75A7bEFvC/jf8lJ6fmh/gNQu8+
	Dlo+F2sCYHAxFvzkq/B1gciJjhRehaV3Cflgcfj01YrlH4dZyhTnyjwGJK6sH
X-Google-Smtp-Source: AGHT+IER3l46WWZFn65CQWnnpQYyjo+l31xDBrCdDEWIoKcPXunWef7a035sf4J8aRkAFJe9NmsKEQ==
X-Received: by 2002:a05:6820:1ca8:b0:61e:1d70:766e with SMTP id 006d021491bc7-61e3383fde3mr5496885eaf.6.1756735144642;
        Mon, 01 Sep 2025 06:59:04 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61e3206c527sm665564eaf.14.2025.09.01.06.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:59:04 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3197f534179so1244664fac.2;
        Mon, 01 Sep 2025 06:59:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVIc4Ch4Mp+FRMz53TreFHBqIhwgSTDIkX5VnJaSsnSZQUgEZRGDcGHESdp6HweFfRYwHT6gt5g7lIg1M=@lists.infradead.org, AJvYcCVI5m8M3TznCKeSXhx/B6F81xrX/0rYXhLQss4nBPuVguYp6pPMcFYZkcvQxu8RO4QLAaopDtL0Ztk=@lists.infradead.org, AJvYcCWr2v1wT8gM+AhiXbAAlVQAKzSPfJP9INKAiUI4Bwbk/GVhrRjjY7XkUtZ5A6o6nc+uvJQ/z7hKuyu/0cZPW2YO@lists.infradead.org, AJvYcCX1Jz5LvhgRIB6UKenYXz/dsfxjiV+2Jl6QDPqf3QI5O1J9C3DsP93TnKELWaV6vw9uRekjk2Jdccddr33/Q2o=@lists.infradead.org
X-Received: by 2002:a05:6102:3053:b0:52a:c340:11db with SMTP id
 ada2fe7eead31-52b1bb24afcmr2206016137.27.1756734711158; Mon, 01 Sep 2025
 06:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 15:51:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyCbOgs6XyW=8PG2pVw1-zhWP_VtsXsGz1HeFrZ6kjdA@mail.gmail.com>
X-Gm-Features: Ac12FXxyJUafI_d6iF6chcUi31LuXt_e8cojxsF4wFcxCNHCg2s17r6RQqbjdms
Message-ID: <CAMuHMdWyCbOgs6XyW=8PG2pVw1-zhWP_VtsXsGz1HeFrZ6kjdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
To: schuster.simon@siemens-energy.com
Cc: Dinh Nguyen <dinguyen@kernel.org>, Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_065906_015927_9E2E98E4 
X-CRM114-Status: GOOD (  26.22  )
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:45:36 -0700
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

On Mon, 1 Sept 2025 at 15:10, Simon Schuster via B4 Relay
<devnull+schuster.simon.siemens-energy.com@kernel.org> wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
>
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> However, for most consumers of clone_flags the interface was not
> changed from the previous type of unsigned long.
>
> While this works fine as long as none of the new 64-bit flag bits
> (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is still
> undesirable in terms of the principle of least surprise.
>
> Thus, this commit fixes all relevant interfaces of the copy_thread
> function that is called from copy_process to consistently pass
> clone_flags as u64, so that no truncation to 32-bit integers occurs on
> 32-bit architectures.
>
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>

Fixes: c5febea0956fd387 ("fork: Pass struct kernel_clone_args into copy_thread")

>  arch/m68k/kernel/process.c       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

