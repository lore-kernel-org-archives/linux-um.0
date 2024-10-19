Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096FDD3C930
	for <linux-um@archiver.kernel.org>; Sat, 19 Oct 2024 22:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6U/MXBANaCIhbBTgy1iP8gWqP4/mPXJe/ul6wCvAkuQ=; b=NjUmnDkKzuD4sduAYwGdE3VYON
	vUYgVlYJPVFodHYCR+dqzw+zuH1hB4N8b3y5RHMTS1sFYDFvPYTQIRp6uG9EmRNkICVknxw5CtrIC
	4jZaV1dp3wPmaoPdgncVwJUbj6SdxrERZ/eJ1pIRzfFznr4CJpqENOiAkJysXOtg3W9L8xwDhwQFI
	fIXdSbClaIsXsgfK0Y10P4vIB6LEmTuhodtLW3hAjcghDj3xNvxyb72pheByJJFWAsoP41vAe0URb
	S1DoypbRg37eDMYzW1zBda+lkE3OTIUS012q00uB6dz3EaNY6Cf78qlqv6vvUGmt8yH0a7hnlf1IV
	6MGK2QvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2I0F-0000000419q-1WkK;
	Sat, 19 Oct 2024 22:32:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2I0A-0000000417Y-2yPX;
	Sat, 19 Oct 2024 22:32:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F1013A403C4;
	Sat, 19 Oct 2024 22:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CB8C4CEC5;
	Sat, 19 Oct 2024 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729377168;
	bh=tXAHb3/33MongE4AilsDsGXF/gFBIt2F2QSYX1Ig+Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFrPQGZG5ks5EiB9Mnc/4AmJdwPhHC/bJiwRWWIfX818gCaPcWQh1XlbBHiE/H5xN
	 F0xn4R9NyrCX5rbT4E/r2bI3eWePDaxoGl02Glr8IDOcawqbsqwcHEy31pJkVKsHd1
	 R80j5rV7rbUbChGdgHidqCABQhZUdpYtq1OU/j70YJ0eKHQEKfqrNrOXLJ6Lhywvvk
	 lEeXyrtVkQ3cXx2b3vA47dSohi5i4ZoSOIVgfvjj1oOSBCAm7WZjXI5kAP0Q/IpH9F
	 aRnwWgNhVNQVUt/uiOOxM+3soGdJDEHOHKUHGach+M7x6L3jzPDjXMTepSfZKjSd31
	 DPfJEVpKd5tKQ==
Date: Sat, 19 Oct 2024 15:32:45 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
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
	Suren Baghdasaryan <surenb@google.com>,
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
	sparclinux@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 5/8] arch: introduce set_direct_map_valid_noflush()
Message-ID: <ZxQzjWVTi1lvOQnT@bombadil.infradead.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-6-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-6-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241019_153250_880142_3BBDD541 
X-CRM114-Status: GOOD (  13.06  )
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

On Wed, Oct 16, 2024 at 03:24:21PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Add an API that will allow updates of the direct/linear map for a set of
> physically contiguous pages.
> 
> It will be used in the following patches.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

