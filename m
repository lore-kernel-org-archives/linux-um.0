Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74435C0218E
	for <linux-um@archiver.kernel.org>; Tue, 21 Jan 2025 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ugKrbojVRwTBmPMKkHUcaS2aDcqRv9OqaSevzpXMYOg=; b=oY6+O69jTpByepqtc6bziL5iFl
	3cgpk+AaHN6wtzjKqbM/luEWxfbpmairervAahI4LSOGDMXGiij//jxjzURP4w602TR+ZB9Guxc3W
	3JlmRANzhCkVgeJEXWXjxaJPHJIJpMa8fNhWToRoWMKhh1sKzUjpWp/PB/uVJe717E9YXsKg+GXcD
	jaRb0hHuA85y/ps7ec0y6wQsq1h8kmz8aVQzT+4vurk99mEeqnDMlVz0G9FuuObqAca8fq6HfNyqG
	ukETi5mb3MIHYIc1Y2phX+EomnX3PFpik04LDsqRJGZRttvFrInijLuNQoy1/pdc1bdd/RTW/yyYT
	61PR1Duw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taGn7-00000008Joz-0co6;
	Tue, 21 Jan 2025 16:07:49 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYQUO-0000000F5ST-2mdn;
	Thu, 16 Jan 2025 14:04:54 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 64DEC40E0288;
	Thu, 16 Jan 2025 14:04:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2AjLmPaIv3rS; Thu, 16 Jan 2025 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1737036284; bh=ugKrbojVRwTBmPMKkHUcaS2aDcqRv9OqaSevzpXMYOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AoUcPN70r71GRskEbBjwKB5t2IpKoOvWroHj7Gj+yh3TXIQq4jAaeXsAtKetsP+we
	 7U42EJbMPBRZdphzKgKJnl1FaXd4+NOPdDL1SkgOkJuvHbUXMBGkSPz+3v8h7dNhmT
	 Hnpwxe9r0qX772w6Op3rP2iEyZS27E/nwn39RIAvFhrt8U3AgFlwZ1zghfPHzcZ8zO
	 c/4ymjaW+0fTU8jpLPb236iMCAWdJa4hZ/QKzL2ReUqqUBynyzdljxfL49TuGZKsUK
	 HuZUYY0mmrBW4uLQ4YxKMwtuKAzOBBOTZPyqnz4H81TmMZX9A3znFZ3JT09PpbLLCS
	 Ia6e5nKvzD4mq+MXsOmJ3+GXejTE4cvNoC5h043TIg2mzfveb9shxPPW6gBlFTA53E
	 7jgElnzIfinsMoQwVSg6i18FLDzY50+kqVz9+zbr5gpiPs5LeCwLYM/Aq1u2fGPpZ0
	 0Ls41+wYzo1pfh0OpM+GBydt5tkuWtf+9452THH3PFkEdzhwGbhRprrYvj75bnToTh
	 nRx4uZELom9gJdmd+ZcYZKN5oNcUaiz0Ijo4hBEtkfRieSbS8RUd1mN91KKgO2qVid
	 d+CXJjbRpPfJbO67fm64t8fRGqM3v/OqRo/Z09m5/2qMM0veqGpRWUhNKQ3qXXaJz4
	 pfAh9T0l+/f8chSy2nlAbhlU=
Received: from zn.tnic (p200300ea971f934f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:934f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B67F640E0286;
	Thu, 16 Jan 2025 14:03:01 +0000 (UTC)
Date: Thu, 16 Jan 2025 15:02:58 +0100
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
Message-ID: <20250116140258.GDZ4kRkvEGYovA_J5u@fat_crate.local>
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-1-8419288bc805@google.com>
 <20250116001858.GDZ4hQctZe_PFvJ0AJ@fat_crate.local>
 <20250116102747.GAZ4jfI9HG3K-PW7nf@fat_crate.local>
 <CA+i-1C1sXC1tbo9ytuex0eBD3gUbQwnNP8rvOhCv=JV+oSHo1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+i-1C1sXC1tbo9ytuex0eBD3gUbQwnNP8rvOhCv=JV+oSHo1g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_060452_850964_9424A3FC 
X-CRM114-Status: GOOD (  23.72  )
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

On Thu, Jan 16, 2025 at 02:22:42PM +0100, Brendan Jackman wrote:
> Sure. I'm actually not even sure that for a [PATCH]-quality thing this
> cross-cutting commit even makes sense - once we've decided on the
> general way to solve this problem, perhaps the changes should just be
> part of the commit that needs them?

Right, that sounds better.

> It feels messy to have a patch that "does multiple things", but on the
> other hand it might be annoying to review a patch that says "make a
> load of random changes across the kernel, which are needed at various
> points in various upcoming patches, trust me".
> 
> Do you have any opinion on that?

You're absolutely right - we do things when we need them and not before.
Otherwise, often times things get done preemptively and then forgotten only
for someone to notice way later and undo them again.

> (BTW, since a comment you made on another series (can't find it on
> Lore...), I've changed my writing style to avoid stuff like this in
> comments & commit messages in general, but this text all predates
> that. I'll do my best to sort all that stuff out before I send
> anything as a [PATCH].)

Thanks!

Btw, good and funny way to use "[PATCH]-quality" to mean non-RFC. :-P

> Oh, I didn't notice your update until now. But yeah I also couldn't
> reproduce it on a Sapphire Rapids machine and on QEMU with this patch
> applied on top of tip/master (37bc915c6ad0f).

Yeah, it feels like toolchain-related but I can't put my finger on it yet.
We'll see if and when this thing will re-surface its ugly head...

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

