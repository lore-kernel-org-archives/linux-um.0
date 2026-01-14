Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F80D30CF5
	for <linux-um@archiver.kernel.org>; Wed, 14 Jan 2026 00:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gaWdSFFdOKkEXTHGFmdiT7EpMTfrWly43NlKkw7Tnic=; b=Ml3ePJD6/paD+f2zJeD9sVlqFh
	bHcJev5ER52wMeYSjfFktZ3sGBfcgkGwGbPUZ9jQ/Jo/u+1f6y03jbQrOQr0zxL6wibJsH+ltnZng
	3bFc+ISHspHJtjcQEBwKFKaaio1mKcoYWsYnOxydstk44g/JzT/zrFxAOKp3BUJYdDDmRpP6uUxqY
	0d12jiuu4S6j0+RNhdVeyeN6ZGtllCM5qWtTaC2hGFnyZ8rkYN8Xa/dSOFZAatrdmleO+2MK8Su0i
	Aq+PYSLHqRiyymzSTIiG6BejAOIf+QLfYeKEAQfDhsDPTr12OcvugUDKF6mkiVS/9Ac7XasEjIYYH
	CThZNFZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfoof-00000007uSM-1Kgu;
	Wed, 14 Jan 2026 00:32:53 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfooc-00000007uRC-32Rt
	for linux-um@lists.infradead.org;
	Wed, 14 Jan 2026 00:32:52 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-47ed987d51aso12094945e9.2
        for <linux-um@lists.infradead.org>; Tue, 13 Jan 2026 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768350768; x=1768955568; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gaWdSFFdOKkEXTHGFmdiT7EpMTfrWly43NlKkw7Tnic=;
        b=KUQmf8RHIEWRTQ6LPatPP6DEEqSC9h5n3JtnllYNhVGQ/hWireKp40v0saxttn+SEb
         cejlR1zBBTmfPLGN5W6Q5RWAyYjcNAMhrbsUNWItgGQyq+KBw8rCfv+T9Uif1wGJ8aHu
         iYR+XdfH56vboU0/HBaLIhPFjVnJF4YspmMnRmo2XZK+ij/Vyh4Tk3MGPM4CM+HoZ9QK
         aV2KYOofIt63veUyCOFQuauYEAw3QZ37lQGVzFRGLUyTobWjCXlngqrOlhoHV4kn9g0Y
         ISQ3W9xUYly4n8GyOhkWfg2PosTH/VWTYbgHYblRKnvsAkT3xTCKNIdIDeZ3iXmrsAhv
         QLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350768; x=1768955568;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaWdSFFdOKkEXTHGFmdiT7EpMTfrWly43NlKkw7Tnic=;
        b=wmBsLVVznmsleI7Dqyou+5HHXXHhKW1655gADQ1LUEwmTDFMhQXZ5A4qhvB8HzzgIT
         M34z4B3/dpES60yeu7Pg/W60E7YEnSF5FvZKIzbO3N7ekqDve0dIP+XK2dk7mCKLsQxZ
         NePKf+kGgI4XCeu1N2a0j2h7ni2nWZhM5PsYKVSUhX07TKhm8cPiARh22ySzOJ2EwW8l
         4ukoM3cZYpYU2NKfmPrpy/97k/lOsZmPH78EE9iv3PdxfUHXCUSaEpjcSw5wfxJWtzCF
         +t91rpuwAoDPKabXGU+gXSsm6wTRuOO4PzMIZEtmhrRrjWae0APtPfN6Cxyd+wLMYjow
         uPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAjX72FzGBEUaCwQfbAQX5TqzOeYugHaHRq7v4HvKRr7YmF/wUMmmoD4XWsNsDfIXYlsAJ5AJsLw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzimSnNYtUPUBZNDmu5o/D5gjaC1EYzkVcHLgCxnk7lybvenvl6
	qHY3uL/48pPvH6SRBaFbjmkX2I/56jkMyghFrXy/MtA+92DANn8s4X11cub0/VPxBq4=
X-Gm-Gg: AY/fxX6fhyhLplHv3aD2X1jZWdDrKmvAoehbUHR+wOmQshmmTck+HI+NaW/ptlSvNhY
	pJ1z+RrUuC5ZQitP04sUrZ8c74hn86C88FE3k1p8J2C3I7l8+wlW9UEyKunxedPQz02bJeLpXti
	QapPx//nrEsl61l71Um9NduaUL+8xP9JbYrqceTjCwdHy5qdErs1FAvjyZ2eDhNvQGA0gcdSVnB
	zT8GT7U4ZrbKsL+SVh+MezyMRSpHgHVtMNDKoZIkQREY1UrSOywyh5iGkjliIMcgi9AoiH0LtYy
	QYBd1EK5vrwb9SvS+LDHT0Sao2zWzK96PN/IhdnNu4w059OXyH0k5y3zX+4uP+Kz47UWZBu/81o
	u+LKQv3t+n6pazBSlIGBtvwVdkp2Nb1t99WRm0UWUMMTTiSssr6DdMGDPenJmUGHyXjskFNEhR2
	jNOeo3aPowLmxnoWJn67JYrtx8PQ3AeHh24x42KC/Ijw==
X-Received: by 2002:a05:600c:a101:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-47ee48b510fmr2972975e9.16.1768350767989;
        Tue, 13 Jan 2026 16:32:47 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9c5sm48257391f8f.22.2026.01.13.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 16:32:47 -0800 (PST)
Message-ID: <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson	 <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek	 <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness	 <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>,  Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-fsdevel@vger.kernel.org
Date: Tue, 13 Jan 2026 21:32:33 -0300
In-Reply-To: <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
		 <aVuz_hpbrk8oSCVC@aspen.lan> <aVvF2hivCm0vIlfE@aspen.lan>
	 <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_163250_814886_F4D3E8B6 
X-CRM114-Status: GOOD (  41.17  )
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

On Tue, 2026-01-13 at 09:41 -0300, Marcos Paulo de Souza wrote:
> On Mon, 2026-01-05 at 14:08 +0000, Daniel Thompson wrote:
> > On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> > > Hi Marcos
> > >=20
> > > On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza
> > > wrote:
> > > > The parts 1 and 2 can be found here [1] and here[2].
> > > >=20
> > > > The changes proposed in this part 3 are mostly to clarify the
> > > > usage of
> > > > the interfaces for NBCON, and use the printk helpers more
> > > > broadly.
> > > > Besides it, it also introduces a new way to register consoles
> > > > and drop thes the CON_ENABLED flag. It seems too much, but in
> > > > reality
> > > > the changes are not complex, and as the title says, it's
> > > > basically a
> > > > cleanup without changing the functional changes.
> > >=20
> > > I ran this patchset through the kgdb test suite and I'm afraid it
> > > is
> > > reporting functional changes.
> > >=20
> > > Specifically the earlycon support for kdb has regressed (FWIW the
> > > problem bisects down to the final patch in the series where
> > > CON_ENABLED
> > > is removed).
> > >=20
> > > Reproduction on x86-64 KVM outside of the test suite should be
> > > easy:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 make defconfig
> > > =C2=A0=C2=A0=C2=A0 scripts/config \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable DEBUG_INFO \
> > > 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> > > 	--enable DEBUG_FS \
> > > 	--enable KALLSYMS_ALL \
> > > 	--enable MAGIC_SYSRQ \
> > > 	--enable KGDB \
> > > 	--enable KGDB_TESTS \
> > > 	--enable KGDB_KDB \
> > > 	--enable KDB_KEYBOARD \
> > > 	--enable LKDTM \
> > > 	--enable SECURITY_LOCKDOWN_LSM
> > > =C2=A0=C2=A0=C2=A0 make olddefconfig
> > > =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> > > =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G -smp 2 -nographic \
> > > 	-kernel arch/x86/boot/bzImage \
> > > 	-append "console=3DttyS0,115200 kgdboc=3DttyS0
> > > earlycon=3Duart8250,io,0x3f8 kgdboc_earlycon kgdbwait"
> >=20
> > Actually I realized there was a simpler reproduction (hinted at by
> > the
> > missing "printk: legacy bootconsole [uart8250] enabled" in the
> > regressed
> > case). It looks like the earlycon simply doesn't work and that
> > means
> > the
> > reproduction doesn't require anything related to kgdb at all.
> > Simply:
> >=20
> > =C2=A0=C2=A0=C2=A0 make defconfig
> > =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> > =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel
> > arch/x86/boot/bzImage \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "earlycon=3Duart8250=
,io,0x3f8"
> >=20
> > With the part 3 patchset applied I get no output from the earlycon
> > (without the patch set I get the early boot messages which, as
> > expected,
> > stop when tty0 comes up).
>=20
> Hi Daniel, sorry for the late reply! Lots of things to check lately
> :)
>=20
> Ok, I reproduced here, thanks a lot for testing kgdboc, it's a quick
> way to check that the new register_console_force is not working. Let
> me
> take a look to find what's wrong. Thanks a lot for finding this
> issue!

Ok, I did a bisect and found out that the issue lies in the last
commit, where CON_ENABLED was removed. After it, I then checked what
was wrong, since everything was being plumbed correctly (tm), and then
I found that it was not:

On _register_console, the function try_enable_default_console is called
when there are not registered consoles, and then it sets CON_ENABLED
for the console. Later on, try_enable_preferred_console it checks if
the console was specified by the user, and at the same time it had
CON_ENABLED set.

It worked by chance, but now, we don't have this flag anymore, and then
we are not _marking_ the console on try_enable_default_console so
try_enable_preferred_console returns ENOENT.

I have added logs for both cases first the case with the patchset
applied but the last one patch, and it works:

$ vng --append "console=3DttyS0,115200 earlyprintk=3DttyS0,115200
kgdboc=3DttyS0 earlycon=3Duart8250,io,0x3f8 kgdboc_earlycon kgdbwait" --
verbose

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x000000000450d530).
XXX register_console earlyser
XXX try_enable_default_console earlyser enabled
XXX try_enable_preferred_console earlyser user_specified 1 returned -
ENOENT
XXX try_enable_preferred_console earlyser user_specified 0 returned 0
because flags was ENABLED

^^ here, returning 0 means that the console was accepted and will be
registered

XXX __register_console earlyser registered
XXX register_console uart
XXX try_enable_default_console uart enabled
XXX try_enable_preferred_console uart user_specified 1 returned -ENOENT
XXX try_enable_preferred_console uart user_specified 0 returned 0
because flags was ENABLED
XXX __register_console uart registered

^^^^ same here

Going to register kgdb with earlycon 'uart'
Entering kdb (current=3D0x0000000000000000, pid 0)=20


Now, the logs of the patchset with the last patch also applied:


Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x000000000450d530).
XXX register_console earlyser
XXX try_enable_default_console earlyser enabled
XXX try_enable_preferred_console earlyser user_specified 1 returned -
ENOENT
XXX try_enable_preferred_console earlyser user_specified 0 returned -
ENOENT
XXX register_console uart
XXX try_enable_default_console uart enabled
XXX try_enable_preferred_console uart user_specified 1 returned -ENOENT
XXX try_enable_preferred_console uart user_specified 0 returned -ENOENT

^^^^ here, it should have registered the console

XXX console_setup hvc0
XXX __add_preferred_console hvc added, idx 0 i 0
XXX console_setup ttyS0,115200
XXX __add_preferred_console ttyS added, idx 0 i 1
Poking KASLR using RDRAND RDTSC...
XXX register_console tty
XXX try_enable_preferred_console tty user_specified 1 returned -ENOENT
XXX try_enable_preferred_console tty user_specified 0 returned -ENOENT


^^^ again, it fails because we don't flag the console with CON_ENABLED
as before.

XXX register_console hvc
XXX register_console ttyS
XXX try_enable_preferred_console ttyS user_specified 1 returned 0 with
user specified
XXX __register_console ttyS registered
[    0.000000] Linux version 6.18.0+ (mpdesouza@daedalus) (clang
version 21.1.7, LLD 21.1.7) #374 SMP PREEMPT_RT Tue J
an 13 21:08:34 -03 2026 reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')     =20
[    0.000000] kgdboc: No suitable earlycon yet, will try later       =20


So, without any console kgdb is activated much later in the boot
process, as you found it.

I talked with Petr Mladek and it would need to rework the way that we
register a console, and he's already working on it. For now I believe
that we could take a look in all the patches besides the last one that
currently breaks the earlycon with kgdb and maybe other usecases.

Sorry for not catching this issue before. I'll use kgdb next time to
make sure that it keeps working :)

