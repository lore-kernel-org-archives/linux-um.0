Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE840CEE350
	for <linux-um@archiver.kernel.org>; Wed,  9 Oct 2024 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TCS0zSQTCadVqk2Y39+SINdQAA9/OIUqCm5jqJA+o4E=; b=32cjUDfiFn5M3zZ4sFiT9/HemX
	7O+RNA8oCoIqWjPvqKrj7qpo1H3aHQNcMHMPPN42OOc1skcP+g8JS1dJmuUsOdkP02JvT/YvSgyBO
	P0usQf0TtUulzS+8I2NpUGpOOMdVpIBpaKPpt182lsJPC0PT5xwAgWF5AwSFohkAQCLAIwsGqrUI0
	UJ/dn0KhnSS84MTWTFxfIVO5RTUfhL7GhRJ2VRCt/hn92U74kAp12n/e6oKh3YinkV79H2DCzMNqO
	RtM40PCpMg+CcExuXrPvAc/HprlZy7XRMzKu6ixBwLZJIF9SIkpJ7bHuM4lEByNtCVdZEvr627klQ
	1D3ImMuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syeGn-0000000An7c-0kq6;
	Wed, 09 Oct 2024 21:30:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sydEX-0000000Ad0m-2ddW;
	Wed, 09 Oct 2024 20:24:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6D42C5C58B1;
	Wed,  9 Oct 2024 20:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D537EC4CECC;
	Wed,  9 Oct 2024 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728505469;
	bh=Eajpzm9cUrzs//zMnCTfeMFhUIL/3eN5uDlR9BWdmqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2qzkbhuAMgino0DZ1hZZqBEMfexCBWtSiEWzzjILyq+cbaAjGfaWTcyToRrfMFDWm
	 Pjg8qjtjvKxkLVmq5KcKfEzMazZd7B9b+cvi3EOmzQaV9Z6xen8oKafvJ4u9r6ZkXt
	 owPHlRmA15/hxoqOKllm//ythdYQC4jZ89tWfNZw=
Date: Wed, 9 Oct 2024 13:24:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski
 <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christoph
 Hellwig <hch@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller
 <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Song Liu <song@kernel.org>, Stafford Horne <shorne@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Will
 Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
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
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX
 pages
Message-Id: <20241009132427.5c94fb5942bae3832446bca5@linux-foundation.org>
In-Reply-To: <20241009180816.83591-8-rppt@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
	<20241009180816.83591-8-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_132433_790805_F8A1650F 
X-CRM114-Status: GOOD (  10.79  )
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

On Wed,  9 Oct 2024 21:08:15 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Using large pages to map text areas reduces iTLB pressure and improves
> performance.

Are there any measurable performance improvements?

What are the effects of this series upon overall memory consumption?

The lack of acks is a bit surprising for a v5 patch, but I'll add all
this to mm.git for some testing, thanks.


