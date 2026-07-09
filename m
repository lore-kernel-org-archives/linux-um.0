Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12FEC44506
	for <linux-um@archiver.kernel.org>; Thu,  9 Jul 2026 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E3GKiVGCG/M7FltpcGzY43WO5HnNe5q++QmCFGBnpG0=; b=x7jvSqNXzTYtwHghZFckJeGkSX
	b0kIVAxI+3hGIlyWiwnCVUv9GzOYNonPaXmbPoIDQzFm15NqXhPMVO6XCtc/scTu7tYib1zruQTvI
	BdlXerhriTpheviSDUffrpKE5Y5MfJ4B6iJ0yPDjGZneqcc4iXTYZK9SaNGJJnkUZ2tA/CuW4JSY5
	qsYCgJvmKFPoTzaHAgnrfxB6fjCNqH1+A4JFDA6/tDeV3o675cK66eyV3ohlb4RW9ylsVW0MR5eel
	KaXgmD9cWyJCnMYme+IUuwL1KhWYkAEJln2nM+RZ6amXMbN86E5pKdrb9PoA0w6lqmyGu3TusVXzP
	JMDc23Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrVq-000000031cB-2dvq;
	Thu, 09 Jul 2026 16:22:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrVo-000000031ba-0NlY;
	Thu, 09 Jul 2026 16:22:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EECAA600C3;
	Thu,  9 Jul 2026 16:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FB1F000E9;
	Thu,  9 Jul 2026 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614126;
	bh=E3GKiVGCG/M7FltpcGzY43WO5HnNe5q++QmCFGBnpG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S/Uien6vGeymdukHshCIRbD/qQirZnmNv1fkPyrZGO6+K+ckkFdEYSDwlnKFpi2BF
	 tuyJKBhR0dyYdYiHulLx/LgusylN0RPtbaGzeJM/aCdOjZzg650pi7YEBbg+JGqSHR
	 64dXPeQbq2evJa22r52hBC05ICSGISNW2xikw530YpQ+nCbruCjZdneQ5mim5aCUCw
	 Xf0AYTbfJ+wFGM1bNULmUZblGmQ7iYYE8zwgMJIETdC1+LLXgejWycDXueD9QUnxdI
	 F83JV94XXQwp5V/iZ2sAm+8m4as7p5Y/PmHH5g0nCXnFS05/jmhxEmyZJZGFezfdfB
	 UQzRtgW6GQfPA==
Date: Thu, 9 Jul 2026 09:22:06 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
Message-ID: <202607090921.ABE4BB4A@keescook>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.230735780@kernel.org>
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

On Tue, Jul 07, 2026 at 09:06:40PM +0200, Thomas Gleixner wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> The return value of __secure_computing() currently uses 0 to indicate
> that a system call should be allowed, and -1 to indicate that it should
> be blocked/killed. This 0/-1 pattern is non-intuitive for a security
> check function and makes the control flow at the call sites less readable.

Conceptually, I'm good with this. Just make sure that the
tools/testing/selftests/seccomp/seccomp_bpf tests still passes. :)

-- 
Kees Cook

