Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3CD31A22
	for <linux-um@archiver.kernel.org>; Wed, 14 Jan 2026 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kOjWICKElajAktcnLTxDO0a0hjOrXuTPJG+TIiIDMlE=; b=Tx5SMpEvoYNa6+ssD8KMP0C1qz
	exGm/E489QGxI3ZgvcNbFH4vM312R+xGYJpJtx55BgB76/jjkojDHCKLyyfK42FIeEowzGOQgNga7
	9e/elqLTTJ9sab6EnUdCXQZUM7JMndlhrB3KwHrHca+l8bN5JGjkOHlmf3MX5/eU4ehbw9SX3gQW5
	deu75nP/z8Kw8kum3kZzDkxGawbl1W/i6SQskvT8iZdQGc50fbzIO93vEnL+SEsLomA+/H8FWVat2
	C8U7deFFo0GLxZ84pNMG7vFKWlrHdusw5rHxPkFDEu0FQiJnzWPRiqQFdjWeoiwh/O0sIVSt9nFua
	/+SozUVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfw7B-00000008JIV-1Utn;
	Wed, 14 Jan 2026 08:20:29 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfw78-00000008JH8-0hNx
	for linux-um@lists.infradead.org;
	Wed, 14 Jan 2026 08:20:27 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-4327555464cso5005560f8f.1
        for <linux-um@lists.infradead.org>; Wed, 14 Jan 2026 00:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768378824; x=1768983624; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOjWICKElajAktcnLTxDO0a0hjOrXuTPJG+TIiIDMlE=;
        b=JWCjoqMUuIlb9/NRh8Y6ACNHoI5mYnD0bb+ar5yqcyHl/wwxloIywo2WSPlCJnz8kj
         C9eknrL9IeqvDqxVWSr46UgDmbdggZu/3FE5GKIeMS5m3xh4mXH5ywTvZ8s3nqCsjYGa
         3qs9EOEOjyN+NCG3LGZoZ56gmLk0jREwp/bVFHm5NRG5cenFEvUyJal+R1r2PmUhKyl1
         ckJambW6+tblIOOG4jvi7/ON/D05jHodaUaDB0FEec/9cO7zUNTg4HpJfdMmmhIRSMef
         5uym+h+HqziPil0zXxcru4T4R2R1DIl+qbAswmyjI3uSQMLN3mBpUs3f2LqqiWPMLdWf
         cp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378824; x=1768983624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOjWICKElajAktcnLTxDO0a0hjOrXuTPJG+TIiIDMlE=;
        b=lrzjnpRE1GLZ5R2LVZcyiOmdIAkUKmxKYi7/uVBbH3ZnmEmg/O+31f0lEhpZEGm9wK
         Na/SmToIcbrNvpXtNN8XdV4c/sVuZyouhewmA4d9/i70RwtL9nJSs+biHO6Mc1Kp7R7+
         xhEU4ebpPtUKa+Mpd18a3W6G0tT0gS7Eflux0/T5LBxe/d1SA/BJaFJ4F1Ysj3NF4VG8
         GcEA1R4o1Gpa/i2USRqvbTxf0GxEU08f9E3lu4KZILvnA3003JZ/0O6ARvnbtRxAGQRe
         KerLHnHtEWCqoUUDm/o09jEiM2J/q+wIgv28iAWQ7x521bEfTGtcVvvtcQM859y+rOHF
         0YVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcd8TwFP8MhJlRlElTgd/5cVf7ZwXhk0oVPeyEYFOBjBsnyiwec+tQsB5zbsub66ArUA1Qdrazjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YylmrVb7Jd1G0iGTyCCvLfqnQ1qYG+mcORAq1ZpuS+SvV0UFgYS
	DwefsNM5TUhWDWbaWo5AYcGbk1DRM/JLAgar4EL2yeIPTrIJ/ga1pdXZnyfKiYDapMU=
X-Gm-Gg: AY/fxX7dg2qMAyH2/3vnfQLrMwmF7BeXe2kTsFznjpd+4RzbIoSmU8+sUaSegEFzKba
	E2d0ZiBFeXN4LJ7bber39dRlfRg7EQXwDjgLtIUmyjs7NpungUNmKyRiIQKN5X40cKMPnhNb9fk
	GRYMzj78esFwTxquOQdNXco9HVROnXrlH4fGSBqHBt3Qs7aEmeUqzQmoqg68oGsWW6X6k/uvW0L
	CqJRuaADsk39YaCjIci9ttex/nhhQV3A9p7qPg494JWLS8MQz6Y+KhsW4CUS3brVu3wze15uK8F
	DukuRviEPVHstzzit+sLU59ZAAkTOwAonQVEjBI2ksRpv8TqN7o9SNorV56He/V2nMUcaz3odoN
	rpn0LHtOpi9nJu+UMa/LQ8TMba+4bAhqni1mh/TQMPx07/gRKsDiUiL3WkumxOihzczAVaRO6xS
	jIhTTchlcRgWjYlw==
X-Received: by 2002:a05:6000:40e1:b0:432:5b81:498 with SMTP id ffacd0b85a97d-4342c4f4a32mr1782744f8f.23.1768378823922;
        Wed, 14 Jan 2026 00:20:23 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm49346913f8f.8.2026.01.14.00.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:20:23 -0800 (PST)
Date: Wed, 14 Jan 2026 09:20:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Daniel Thompson <daniel@riscstar.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
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
Message-ID: <aWdRxBbJOEIZ-KjE@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
 <aVvF2hivCm0vIlfE@aspen.lan>
 <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
 <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_002026_250776_C93890A1 
X-CRM114-Status: GOOD (  48.14  )
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

On Tue 2026-01-13 21:32:33, Marcos Paulo de Souza wrote:
> On Tue, 2026-01-13 at 09:41 -0300, Marcos Paulo de Souza wrote:
> > On Mon, 2026-01-05 at 14:08 +0000, Daniel Thompson wrote:
> > > On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> > > > Hi Marcos
> > > > 
> > > > On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza
> > > > wrote:
> > > > > The parts 1 and 2 can be found here [1] and here[2].
> > > > > 
> > > > > The changes proposed in this part 3 are mostly to clarify the
> > > > > usage of
> > > > > the interfaces for NBCON, and use the printk helpers more
> > > > > broadly.
> > > > > Besides it, it also introduces a new way to register consoles
> > > > > and drop thes the CON_ENABLED flag. It seems too much, but in
> > > > > reality
> > > > > the changes are not complex, and as the title says, it's
> > > > > basically a
> > > > > cleanup without changing the functional changes.
> > > > 
> > > > I ran this patchset through the kgdb test suite and I'm afraid it
> > > > is
> > > > reporting functional changes.
> > > > 
> > > > Specifically the earlycon support for kdb has regressed (FWIW the
> > > > problem bisects down to the final patch in the series where
> > > > CON_ENABLED
> > > > is removed).
> > > > 
> > > > Reproduction on x86-64 KVM outside of the test suite should be
> > > > easy:
> > > > 
> > > >     make defconfig
> > > >     scripts/config \
> > > >         --enable DEBUG_INFO \
> > > > 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> > > > 	--enable DEBUG_FS \
> > > > 	--enable KALLSYMS_ALL \
> > > > 	--enable MAGIC_SYSRQ \
> > > > 	--enable KGDB \
> > > > 	--enable KGDB_TESTS \
> > > > 	--enable KGDB_KDB \
> > > > 	--enable KDB_KEYBOARD \
> > > > 	--enable LKDTM \
> > > > 	--enable SECURITY_LOCKDOWN_LSM
> > > >     make olddefconfig
> > > >     make -j$(nproc)
> > > >     qemu-system-x86_64 \
> > > >         -m 1G -smp 2 -nographic \
> > > > 	-kernel arch/x86/boot/bzImage \
> > > > 	-append "console=ttyS0,115200 kgdboc=ttyS0
> > > > earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"
> > > 
> > > Actually I realized there was a simpler reproduction (hinted at by
> > > the
> > > missing "printk: legacy bootconsole [uart8250] enabled" in the
> > > regressed
> > > case). It looks like the earlycon simply doesn't work and that
> > > means
> > > the
> > > reproduction doesn't require anything related to kgdb at all.
> > > Simply:
> > > 
> > >     make defconfig
> > >     make -j$(nproc)
> > >     qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel
> > > arch/x86/boot/bzImage \
> > >         -append "earlycon=uart8250,io,0x3f8"
> > > 
> > > With the part 3 patchset applied I get no output from the earlycon
> > > (without the patch set I get the early boot messages which, as
> > > expected,
> > > stop when tty0 comes up).
> > 
> > Hi Daniel, sorry for the late reply! Lots of things to check lately
> > :)
> > 
> > Ok, I reproduced here, thanks a lot for testing kgdboc, it's a quick
> > way to check that the new register_console_force is not working. Let
> > me
> > take a look to find what's wrong. Thanks a lot for finding this
> > issue!
> 
> Ok, I did a bisect and found out that the issue lies in the last
> commit, where CON_ENABLED was removed. After it, I then checked what
> was wrong, since everything was being plumbed correctly (tm), and then
> I found that it was not:
> 
> On _register_console, the function try_enable_default_console is called
> when there are not registered consoles, and then it sets CON_ENABLED
> for the console. Later on, try_enable_preferred_console it checks if
> the console was specified by the user, and at the same time it had
> CON_ENABLED set.
> 
> It worked by chance, but now, we don't have this flag anymore, and then
> we are not _marking_ the console on try_enable_default_console so
> try_enable_preferred_console returns ENOENT.

Great catch! Yeah, it worked just by chance.

> So, without any console kgdb is activated much later in the boot
> process, as you found it.
> 
> I talked with Petr Mladek and it would need to rework the way that we
> register a console, and he's already working on it.

Yes, I have some patches in early stages of developnent of another
feature which would help here.

> For now I believe
> that we could take a look in all the patches besides the last one that
> currently breaks the earlycon with kgdb and maybe other usecases.

I agree. I am going to review this patchset first. Then I'll try to
clean up the patches which remove the ugly side effect from
try_enable_preferred_console(). Then we could discuss how
to move forward. It might make sense to push this patchset
first without the last patch...

> Sorry for not catching this issue before. I'll use kgdb next time to
> make sure that it keeps working :)

Do not worry at all. It was a well hidden catch. It is great that
Daniel found the regression in time...

Best Regards,
Petr

