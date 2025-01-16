Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA93EC0218B
	for <linux-um@archiver.kernel.org>; Tue, 21 Jan 2025 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQBvA11kyxIGOlMc4gw5ALfkgQqX/TyrIH9O3oAvLFA=; b=oEgpQFuzxjbsHGTKZJSDcAB45y
	IFJOjXLJZef2933e5rusaW0tMuqKhP9hPiBwv5ds54DGHa6essmWoD4QmjumOCDno0SYHGALtGcEm
	uR8Z4aElLEyvh6y3p+ffCl5uPT1SXqFaHZOhn/AnZm3A1vCYmkbVtQbgt58lh3495ValELsab4xQ5
	kj3xuKSjUdDDveARQInIDDJR+pJS9+1TYBwoJUzF+daBNjXbi/gOawK8i9Ky/IX0/pAJdg4khvMqG
	IC4ecVMC6WQewoSDd3+Wnjr1Njg4/qmC5QXKachS3hnTYLqk1DLQ/St3qVVptuFYwlt6INh9aWDFb
	wmA8pijA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taGn6-00000008JoV-25Fq;
	Tue, 21 Jan 2025 16:07:48 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYN8B-0000000EVWA-2Y5f;
	Thu, 16 Jan 2025 10:29:45 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3C7840E02BE;
	Thu, 16 Jan 2025 10:29:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MFOmT_gDX9aa; Thu, 16 Jan 2025 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737023375; bh=GQBvA11kyxIGOlMc4gw5ALfkgQqX/TyrIH9O3oAvLFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FM40lE/0clitssFsEKe5JK0a143dAnkAItQNq6yMfahZmpGeSTt09D5HGf0pFLbt8
	 ulpp29oYaFstDERke8ThqjtXoN04wo6eTBNIkCpJpYEXzS9U9b6shsRrnjlVJY+eKW
	 TBn1/+CZ9ngMH08pwT66FQz7AXQy6uCPmHYlis0QOsac6iB9mWKsXjQbzbnmjnFYRL
	 rZuO8syduQMjrFLSjkGi0HDUyE5i/fs8xiEFxdQfkwB7MgmrqT5n5XzifvkD8pCoqz
	 5X1jUm0gItWfUGbyRkcvKB+w0NCTaoWmvE8UGl8msx3A8F9pgsooW7AjKtjxpPd8Lg
	 Fb16TJfn+gMvgYR9ZsMlvBBT0VyKZ8xqAHFUwbZBUJJBetncTrqjjppvD9l7XGyf4m
	 juTTN1zpyhjrfd7TJsAviRyvUSFuCvbml3Dt2L9NGpEIVm/zwFrWYVYuT654H8gFk2
	 2Yj2R3th9hwTaGTH/t/mjjo+AyzreQe3eFBzv5ejybagmNkRrbkC3tIXtHARl+Igxz
	 KDg7YnAEPlNEP63WkcD8y4HxsuP37idpXVeYFeL/U5iPMx4eRF2w1AcbW6UgXuHjtO
	 b3RYhp+4K4Ia7A1PVcGG9NkyVI2JCvCFPMGn35tDMiM9QmJ3MEVxqzNgvDl6r7hKMW
	 MGq/1HBafOJLETwhOQ5EmCKY=
Received: from zn.tnic (p200300ea971f93c3329c23fFFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93c3:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F55140E028B;
	Thu, 16 Jan 2025 10:27:52 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:27:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mike Rapoport <rppt@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC v2 01/29] mm: asi: Make some utility functions
 noinstr compatible
Message-ID: <20250116102747.GAZ4jfI9HG3K-PW7nf@fat_crate.local>
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-1-8419288bc805@google.com>
 <20250116001858.GDZ4hQctZe_PFvJ0AJ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116001858.GDZ4hQctZe_PFvJ0AJ@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_022943_803656_928E4E09 
X-CRM114-Status: GOOD (  11.92  )
X-Mailman-Approved-At: Tue, 21 Jan 2025 08:07:46 -0800
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

On Thu, Jan 16, 2025 at 01:18:58AM +0100, Borislav Petkov wrote:
> Long story short, lemme try to poke around tomorrow to try to figure out what
> actually happens. It could be caused by the part of Rik's patches and this one
> inlining things. We'll see...

Looks transient... The very similar guest boots fine on another machine. Let's
watch this...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

