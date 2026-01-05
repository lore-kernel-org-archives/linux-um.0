Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BC9C79F8A
	for <linux-um@archiver.kernel.org>; Mon,  5 Jan 2026 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DIfhp3vJVBySXs5/naEXyaaROJC4kEOY5dOC0TJhcN0=; b=46dGRPKZj/2su7eLxlZy4ldn+l
	wwZqlKV2ZlBCe8G4Hui88ovmrFYZwZsPAGE9kv3AyxdZ1XZBRxuDcLtefGOvHwcn7gRFfwrDX38br
	MRIXloDAl/6RDvqerQgiPwUyAHINPdK9r1/QF+R2wvRBw12+D2fC0wgIzNaWV8e9Y+PSg0WtcFEHy
	5q7h99hZNgxqqP84fdSQih9oWFrqJ6NLBOkhKtNUIxKHgEdhoptwqo1Awo+IHxaAM7qCQsVXaPSDm
	A8oeHLNpQIM8wDlGuNBVMrXqOmQ2sHQOwzKq9stA0NMkTEZ64EqmxrYsAAXbayZNNy8bHKGQtT2Dl
	q3CykUTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vck4N-0000000BLcE-3qmZ;
	Mon, 05 Jan 2026 12:52:23 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vck4K-0000000BLaM-2Nvn
	for linux-um@lists.infradead.org;
	Mon, 05 Jan 2026 12:52:22 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so5733918f8f.3
        for <linux-um@lists.infradead.org>; Mon, 05 Jan 2026 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767617538; x=1768222338; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIfhp3vJVBySXs5/naEXyaaROJC4kEOY5dOC0TJhcN0=;
        b=a3XzevQzmxBmGXDbbG8lMnM8xdp8oyj8xKyux2iW8aZ7UHybILVFAIpT1AO6SGVk0s
         Gpbo0exRFnP5pSDQQd5bfFOQib491ckMd0aaT2sUOvBLZ0WpWkSXA3BCJvj38nOGyPBR
         pEMKpBZUEcdSKumHEaMUIrhz8iZrRuyZ7NTfqFnF8Zaju6HlexTzXs8NDgTwBO5HI6Fh
         onHCTFfp4SuQGDEGPARcBheGf8V0YwGuRivBcumxqI1C4rbsA3v3ZlzqAnHLLCV6/n75
         /1kph/COT0z9KaS5R+wfOSRghZy+xVDv26zWAklAYZnTMo/Ca0vFykb9VeIxVZr95i4K
         x3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617538; x=1768222338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIfhp3vJVBySXs5/naEXyaaROJC4kEOY5dOC0TJhcN0=;
        b=R2CZD9ACqgIjR98XA8cpu2GznlajmT7yQyxQccsv8V/yBhNqrOWCeZK+cfTrMkvqaE
         +zfCJkx9f/2vQWsiiO5VDjEPw2yvXFMC505edv1R1JnB6agayCQxge4Vit7aVRdEeUvN
         cCZB2m3JK1OGqsE7xPya5kHOXBbaReXQeh1GnJAwW2EZi/b0SDj3EAHqjmfMl0QYXoFi
         4rkMbsnR3X8eyiR8Mo57KzO547sCG3ic/X2jD5horBlycqTtwiysecHLl9cP7Fkv++t6
         nVRaoQJCs5Sxj1D/h3FfRBHhNlvESZuRz4JiCFpD8q/nEBpO0trhsavfyHJ7+HSxb4J8
         +DIg==
X-Forwarded-Encrypted: i=1; AJvYcCX/S5NdgVG2X3KnV/RaTV5MbZjKyyXACj+MKX0V40tLcLeohkj6louOv88M9DpDnWwuvPJ+PbFHJw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHzC2RcdLx7nxfQaZv85EY17PG4Ec3JqB8m27rXhkaRreUbiVE
	MGM93BKOZD1HKGKbuYpuIH7r7vHDD6+JvbFQJDbQEpXu2mv0SgQm7kAb/ttgCuXpqHY=
X-Gm-Gg: AY/fxX4ZnNA61DYFsZsnPTrjLEOBPQ30T3X/x+S4FQRuldcyQz0dMLUS43QUYPoWBQ1
	s+XWR8peowvUCSTFfoyxUjM7G8CFtzhf8NAS66hll8fIQj5wMpWAuUprUHE5XVmiqpkH/d4S+3X
	KTuy8IFbOXFeMuEMIfISWbos8ksLZiqD0jA9TwxIYmEG1hnd5f8d53gpEW4dLdj8YjzV2d272yN
	VjvViFgRBKFe+adAmFi+ytcCG4FH5UPw7YT6kIoTI7n0muLiNCHyyo7l3rqct6ML5vsnvyegSm2
	MJFi1l2S5YlYeA4iNJC66OqehwMatJvgL7CXIxjnwSpSXA09a+nTVvNRGp8/eXz2Gl2rj/5SZQf
	UVpMlKf+7moWKGqkb6JH0dGk8eCJ/SuX1ijboheItgL9HLzYOKPuyqsEEAL8+65eW/P39xmTUao
	paltRRlyxjxqgYqML7Y1HzOTJKu/oggn7oLAP5ntm96Q5PYgY2C+9P2sFfOGyF0o0Hc90hwmgSl
	razeOw6rLdmSeSwYwHHqfa5qSKXmPdrpl8isqiA82bHABYO2XQHUNREYzkw5edRbYv1Xz8Vpd4u
	zUniGbA=
X-Google-Smtp-Source: AGHT+IE4Mz004OZ0As7rWOFq5sPjHYJ4N8Pzam8+bOUXJdXGQOskOlJaecSDta7VRdPfx5XGGjwohQ==
X-Received: by 2002:a05:6000:1844:b0:432:8504:b8a9 with SMTP id ffacd0b85a97d-4328504b8e1mr37753933f8f.62.1767617537725;
        Mon, 05 Jan 2026 04:52:17 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm100029761f8f.5.2026.01.05.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:52:17 -0800 (PST)
Date: Mon, 5 Jan 2026 12:52:14 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aVuz_hpbrk8oSCVC@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_045220_883394_E8654FB7 
X-CRM114-Status: GOOD (  16.12  )
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

Hi Marcos

On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> The parts 1 and 2 can be found here [1] and here[2].
>
> The changes proposed in this part 3 are mostly to clarify the usage of
> the interfaces for NBCON, and use the printk helpers more broadly.
> Besides it, it also introduces a new way to register consoles
> and drop thes the CON_ENABLED flag. It seems too much, but in reality
> the changes are not complex, and as the title says, it's basically a
> cleanup without changing the functional changes.

I ran this patchset through the kgdb test suite and I'm afraid it is
reporting functional changes.

Specifically the earlycon support for kdb has regressed (FWIW the
problem bisects down to the final patch in the series where CON_ENABLED
is removed).

Reproduction on x86-64 KVM outside of the test suite should be easy:

    make defconfig
    scripts/config \
        --enable DEBUG_INFO \
	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
	--enable DEBUG_FS \
	--enable KALLSYMS_ALL \
	--enable MAGIC_SYSRQ \
	--enable KGDB \
	--enable KGDB_TESTS \
	--enable KGDB_KDB \
	--enable KDB_KEYBOARD \
	--enable LKDTM \
	--enable SECURITY_LOCKDOWN_LSM
    make olddefconfig
    make -j$(nproc)
    qemu-system-x86_64 \
        -m 1G -smp 2 -nographic \
	-kernel arch/x86/boot/bzImage \
	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

In a successful test the kdb prompt will appear after only a few lines
of output:
~~~
[    0.000000] Linux version 6.19.0-rc4-00020-g4b7f3b144021 (drt@wychelm) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #2 SMP PREEMPT_DYNAMIC Mon Jan 6
[    0.000000] Command line: console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')
[    0.000000] printk: legacy bootconsole [uart8250] enabled
[    0.000000] kgdboc: Going to register kgdb with earlycon 'uart'
[    0.000000] KGDB: Registered I/O driver kgdboc_earlycon
[    0.000000] KGDB: Waiting for connection from remote gdb...

Entering kdb (current=0x0000000000000000, pid 0) on processor 0 due to NonMaskable Interrupt @ 0xffffffff9101491f
[0]kdb>
~~~

After this patchset is applied the earlycon triggers do not work
correctly and we get:
~~~
[    0.000000] Linux version 6.19.0-rc4-00019-g882df99205ba (drt@wychelm) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #3 SMP PREEMPT_DYNAMIC Mon Jan 6
[    0.000000] Command line: console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')
[    0.000000] kgdboc: No suitable earlycon yet, will try later
...
~~~


Daniel.

