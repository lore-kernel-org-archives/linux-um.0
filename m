Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F63C79F8C
	for <linux-um@archiver.kernel.org>; Mon,  5 Jan 2026 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=; b=seXfCd+v4HhEXtKthMdfAAR2Px
	0k92bSgF+9tnCiq1NJijEkafBON8xTCoVEo4HNeo2EHxwdaiVcb0A+rnhSLEhYL3XpAXsuv6FuHZe
	OXuii1qj60apVxTHoGncLhid9EDAIqOv8drUdoO2R3Iu9X0bZa8pjgDjBuSuGDguATAuWaUOGufoq
	uUbJ8iAeN6bM3XwbB5+VpgDb33i8PDd/tQP4cjvkbzcmCX/smO22U9I71/Au7c5P+FpvgW3rr9pes
	lZsd7KkzsasmzdcAErwI5hYWUqhfHBw2p4SQEnZWMlWFeFhnivdC1+jPUaKsWS2j8txsxwBg8xFR8
	I4cJqm5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vclG6-0000000BWGz-0QdK;
	Mon, 05 Jan 2026 14:08:34 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vclG3-0000000BWG0-2EFA
	for linux-um@lists.infradead.org;
	Mon, 05 Jan 2026 14:08:33 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-42fed090e5fso6465347f8f.1
        for <linux-um@lists.infradead.org>; Mon, 05 Jan 2026 06:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767622109; x=1768226909; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=KPUb5IsaQ8282Sb8PMBhanrGDYeohZgKKDWIHuqhkaXkA5OouNAVtswqhuJNBaX05m
         Npn8X7/I3xXX6qvXgwePUGBnel2HBRzX5WlpvmzwpV4mSqW2ZHcUnMmp04aZWd669WwM
         ZAJEYlXMjWbSqivr50E5ML5cUoaayHCGbRsJM//aEtoAP1sQu6sciTfThgqpzvjlOzuE
         Kn0DLYLx2NlYLu5WA+yb20RHI21uyDT7Dhvmay7F2DvwaYj4aXys56bwfr432nDAmZlt
         QCBspc5Hy5jVvmqUkEtsC0THmEyNMs8N+nq5qwJ75rB+u5JcCwu4Occ7N62ZK52TLN0Y
         36Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622109; x=1768226909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=STGz6FVjik0OZoN337ZSP7r8EJRWolkoi4oChITkBISf/9buADv5lvNcgX1QcoP4jP
         kLZBJPPKE6frGYMFpfo3lJQu/Quu75MWoyk8Ub5xeZmqb6l0VOPuzKOr4u8ulN/FeeGi
         EY2H5z/g4lqs0xmBDbVsrgpyQboPDtINNxo0Y1rw7XdNAWty/XH1z5gsVIqR8/IDB9ZO
         ZZkXTmb1GCm86S8cUdVcZxNqKnyPdKRKVEv3nu6sR9Z0fFOixI4HArgA8RN8EITsP+W/
         8Go3VKAPM4E5WwRQKsmJ1vXyiXdf9WGMsBEy9hXzcd6ebjSNtwq7im30sGMHICjGRQ3W
         zQNA==
X-Forwarded-Encrypted: i=1; AJvYcCWXwJ7N5eJi2TQIgr9m7i9VtQYnFLGpl1zIwuCQXWAsIHM1SbhO1qQt0663UtMgWDsQgFnthFYj2w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzmh1cUFmXiP/gcti4lDv0lK+TzvE3j8qBxm6I6Y13k8kaZROeQ
	vHwe5ayxkqhe0nnUrwNXM2EihnuXMTjXjlgJ6aHbDbGMS/isPFRraemFa4zikC2KlEI=
X-Gm-Gg: AY/fxX77mGuzdgjwEP8WxUMes1OMeLTCNewvVD8On8jLVa090Y/Awv1eKwmLZMi7Hj5
	0HbK8KJE+Q60anP1mh56KDizpS0cRQEVxhilc4SMJuqT0cwIJb3hTHlbRcYO/O7F6LKJqj27moN
	3w5zX65q+iuCkI/d+5ze+zR6kKUh9kgLThjfg6VaDjtKHKoSw2uzrBpCXy4dvFSfSadXKlRv0o/
	VNmG/GdF5T136UYha9f5n3itqFdSUTnjB7G780nnt1uNzheUE4eQDxpk+4ABWSqT23ek/tmTMy5
	oVxlZ37gitRXAkIAqbn6NyLJSeyvk7zxtJw/kicwqhtqttVxsBY1C/tZ3JWfK/zv9E8xSyqHJgz
	Hrrk7EFTum7/RrVTEFUUsiDOY8LsEpOSAqxoBdUbwMsmj0gvEXcZwfdNmT1dTdBG+ddLA1VZGdB
	n/F0bKkmH+DNwjs+UJvuXlG+7M5JlbZAI3g83usn4ltyRgpy5WavO6unjyEngqtwLamahts3f+b
	agty9L63b0h6QBbmwGc8FCjqEPli5ZwxBfP/gdGKskr4J7dA2VA0PqrOMBfW3dFUBsmJLEu
X-Google-Smtp-Source: AGHT+IFtm/KgnS/DHXZ241C9Tii09D9IuHplpok3aN88rFmOsLWOymloQBuensoLNVO5jV8TaARwoQ==
X-Received: by 2002:a5d:4842:0:b0:432:84ee:186d with SMTP id ffacd0b85a97d-43284ee2de1mr31846134f8f.62.1767622109438;
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm100250524f8f.3.2026.01.05.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Date: Mon, 5 Jan 2026 14:08:26 +0000
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
Message-ID: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVuz_hpbrk8oSCVC@aspen.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_060831_734181_DBDF580B 
X-CRM114-Status: GOOD (  23.49  )
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

On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> Hi Marcos
>
> On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >
> > The changes proposed in this part 3 are mostly to clarify the usage of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in reality
> > the changes are not complex, and as the title says, it's basically a
> > cleanup without changing the functional changes.
>
> I ran this patchset through the kgdb test suite and I'm afraid it is
> reporting functional changes.
>
> Specifically the earlycon support for kdb has regressed (FWIW the
> problem bisects down to the final patch in the series where CON_ENABLED
> is removed).
>
> Reproduction on x86-64 KVM outside of the test suite should be easy:
>
>     make defconfig
>     scripts/config \
>         --enable DEBUG_INFO \
> 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 	--enable DEBUG_FS \
> 	--enable KALLSYMS_ALL \
> 	--enable MAGIC_SYSRQ \
> 	--enable KGDB \
> 	--enable KGDB_TESTS \
> 	--enable KGDB_KDB \
> 	--enable KDB_KEYBOARD \
> 	--enable LKDTM \
> 	--enable SECURITY_LOCKDOWN_LSM
>     make olddefconfig
>     make -j$(nproc)
>     qemu-system-x86_64 \
>         -m 1G -smp 2 -nographic \
> 	-kernel arch/x86/boot/bzImage \
> 	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

Actually I realized there was a simpler reproduction (hinted at by the
missing "printk: legacy bootconsole [uart8250] enabled" in the regressed
case). It looks like the earlycon simply doesn't work and that means the
reproduction doesn't require anything related to kgdb at all. Simply:

    make defconfig
    make -j$(nproc)
    qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel arch/x86/boot/bzImage \
        -append "earlycon=uart8250,io,0x3f8"

With the part 3 patchset applied I get no output from the earlycon
(without the patch set I get the early boot messages which, as expected,
stop when tty0 comes up).


Daniel.

