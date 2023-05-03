Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C4CC7EE2C
	for <linux-um@archiver.kernel.org>; Wed,  3 May 2023 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=71I75fX/OevL09xUuZRjBdyn2l5R910S9sNjz9NRSc0=; b=nl86FnBS55OKDc
	WPie9ycupxI4vQksTtRWXckDPO0hJpc4Ep24jHS8dYWdmcZ2zKdkgSp15bVIkCTFE7IAxjcdwTFte
	UC72QNV0FFCKTG/d4Qkm5K7c8wUzo733nxEIyAfUJ/gk4S6rIilP5kIEWO3lRlh309mT9quBEIucQ
	mQk14Ey6gTd4JrPEVTDhtiZU1Zy66mKrn9UgDO9cNpPfPfSH995knEllBr6xU3Bc3YOs3PHqIRokL
	LU2UtlUVGdTZhskMz9R9XntOJTTN+tUXKvPp5ZMXLkvSVbjqr//u6/ah6PuMlByo3XnjRpAh/eps/
	7IySMeJNv2hPUnpwVcMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puAJw-004LlI-2v;
	Wed, 03 May 2023 11:06:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puAJt-004Ljs-2I;
	Wed, 03 May 2023 11:06:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 68C3562085;
	Wed,  3 May 2023 11:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319CAC433D2;
	Wed,  3 May 2023 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683112007;
	bh=1Z/abXjYScbaeQJORhJfZ1yaBTS2vU/U1cufhR2GD0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYeRD57ViS93rxSgHpAWB7YMqFMUVx8+EiMfSRn6yQEG7G9RSDQSNSSe1sxzZ3BLo
	 GvrB3gAjIST0ilFZUg8IMfwBDx8wfH+KA+j3pBm5lWI8UmkhRuaPcCrBRvajh/kKlf
	 sc97elHz9FlAP3leMT4UaefDRJMGkLzMHZE6FdoaOvmUUjuDHCL58u0eFmESKWCS4j
	 iTu0lEr+kmh/c3tzKSar0Ap1ePkXfG5K61exCSLbCF+9ApT/2au8DOYFlhGDOEhdXg
	 2pQvwMWVokBgoPnt+ruSQN7Puaw5HnfRo4DOOVEE3FkCyWkRa5+PjlZzOTI1BYYKE3
	 QatkVXcriRXBA==
Date: Wed, 3 May 2023 13:06:44 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Message-ID: <ZFJARBDqWPLSy7Ge@localhost.localdomain>
References: <20230429063348.125544-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230429063348.125544-1-npiggin@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_040649_812345_2C190D8B 
X-CRM114-Status: GOOD (  12.32  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Le Sat, Apr 29, 2023 at 04:33:48PM +1000, Nicholas Piggin a =E9crit :
> This option was created in commit 554b0004d0ec4 ("vtime: Add
> HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
> they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.
> =

> The cputime_t type has since been removed, so this doesn't have any
> meaning. Remove it.

Well, cputime_t has disappeared but not the u64 type used
for task/cpu time accounting.

But now we have the vtime seqcount. Though we already had it
when we introduced that Kconfig switch so I can't remember why
this was necessary :-(

It _looks_ OK but I might be missing something...

Thanks.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
