Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D99D1CA0C
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 23:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2NDL0EIuphmCCwbl0Vy6MrgKt/ZIc9Yf0NK3jfYrbk=; b=V4HbJFCQY8d+2VWAsTG8LJv8cO
	GvWe0jNLiNIGPzA5rvdercEATrm/ELMACjsnNaaVyY/7Rl8LhbjITWTj2kn1xRubfTwyvPpndmo0b
	UUCbr7eEaUzGbrFZ2ZqAob9VHv8z60EJq+8j04ZGdVBF+tEfg4NqBOdRBIIm3BTDmfyn/bQju/Pcv
	YJI1d70M/coiZ/p055dwwD2EBq8/+wFrGS0g9CZvH7NQCwFAqpVHOSrR/6P0tVA2WpRDWGPIhDYcP
	d2EmG39SL10Cr6rN4lCQ6IzO4KswaajmZWa68eL0o58i+disGiNEKJ2qSlQDLpfva0Ya6w6y6IZ4p
	F36SbscA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t86UC-0000000FNzp-0GJO;
	Mon, 04 Nov 2024 23:27:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t86U8-0000000FNxg-1763;
	Mon, 04 Nov 2024 23:27:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8521EA41B3D;
	Mon,  4 Nov 2024 23:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A7C4CECE;
	Mon,  4 Nov 2024 23:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730762866;
	bh=G7tF/ZaqXBtDJLMTb97Oc+SktZk//Kx3oRVjwm2Gkec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD6aQVKZ8xYi+PTTwYupZ6PGdQoZjGxor3CJ6T/KZlWjFxurKitUGg4OsLqeVl22R
	 oTMAQXmWqXP0EO6JaBIYZ9VEqoL35XGUitRTwgi+bJtDhjSL6UuAIcLW7XMfz2tbvE
	 x3MFVpG1yHfJRXfsS6NaRprs6A1rIqEf/OZ8jX2sy+DwUFdsMetTULRZ3iOQoxlOsn
	 5JoGBx6K0BrtfF9Z0+hxFGtNMWymLR+Dppngi0NxeJnTpYgOWeDN7FHowhaRXk3khA
	 u6nha7LupF4lzkb6ryYEoHDIxLmpv0DY+XiF9diWn7xWUzJjMMZ/7hbbF3UF0ISQXS
	 B++nhrf0RE3MQ==
Date: Mon, 4 Nov 2024 16:27:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
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
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v7 6/8] x86/module: prepare module loading for ROX
 allocations of text
Message-ID: <20241104232741.GA3843610@thelio-3990X>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-7-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023162711.2579610-7-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_152748_440233_6613DAE2 
X-CRM114-Status: GOOD (  22.72  )
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

Hi Mike,

On Wed, Oct 23, 2024 at 07:27:09PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When module text memory will be allocated with ROX permissions, the
> memory at the actual address where the module will live will contain
> invalid instructions and there will be a writable copy that contains the
> actual module code.
> 
> Update relocations and alternatives patching to deal with it.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Tested-by: kdevops <kdevops@lists.linux.dev>

Hopefully the last time you have to hear from me, as I am only
experiencing issues with only one of my test machines at this point and
it is my only machine that supports IBT, so it seems to point to
something specific with the IBT part of the FineIBT support. I notice
either a boot hang or an almost immediate reboot (triple fault?). I
guess this is how I missed reporting this earlier, as my machine was
falling back to the default distribution kernel after the restart and I
did not notice I was not actually testing a -next kernel.

Checking out the version of this change that is in next-20241104, commit
7ca6ed09db62 ("x86/module: prepare module loading for ROX allocations of
text"), it boots with either 'cfi=off' or 'cfi=kcfi' but it exhibits the
issues noted above with 'cfi=fineibt'. At the immediate parent, commit
b575d981092f ("arch: introduce set_direct_map_valid_noflush()"), all
three combinations boot fine.

  $ uname -r; tr ' ' '\n' </proc/cmdline | grep cfi=

  6.12.0-rc5-debug-00214-g7ca6ed09db62
  cfi=kcfi

  6.12.0-rc5-debug-00214-g7ca6ed09db62
  cfi=off

  6.12.0-rc5-debug-00213-gb575d981092f
  cfi=fineibt

  6.12.0-rc5-debug-00213-gb575d981092f
  cfi=kcfi

  6.12.0-rc5-debug-00213-gb575d981092f
  cfi=off

I do not think this machine has an accessible serial port and I do not
think IBT virtualization is supported via either KVM or TCG in QEMU, so
I am not sure how to get more information about what is going on here. I
wanted to try reverting these changes on top of next-20241104 but there
was a non-trivial conflict in mm/execmem.c due to some changes on top,
so I just tested in the mm history.

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

