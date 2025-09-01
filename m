Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D47CA1013
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnVy+GFpTqM3XIwnfxspH9w/hhNpLd3QoIWawv7MRX0=; b=MIBpWM1Nl3P1Z3ghK8nzltR+ob
	GLjW97OQzrDRlM8islSx7Epp2QFkJkYUZqcBRH2+DVEh95ei6uMvdhoFUNsz1P0W+HPdgwWLMlkjB
	iwGWhhtwuG4oLwiBYFwzsKPN8l14ctijdPCO2YjvJKWxYbp9uGv2jJd2wHkFVEoB+rmePzwCfPcqg
	Sl92MWjkZwyRQLyVPtZ3Id1HMHe0VduONYjtTa7iPCiViDjXGxW+ngKm5Xqb8KCO/+W698kGMdlOY
	ruMpAUl3f0Ll09U8vYPpUQ33ZTjuvY+03AIs3PfI74oga5uczQ+gZbnya26QKW2m9my3aJDrEsK8A
	se1qpGiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYls-00000002ADT-0SIT;
	Tue, 02 Sep 2025 21:42:32 +0000
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut4h2-0000000ChTa-1uGf;
	Mon, 01 Sep 2025 13:35:33 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 72DA61300C7D;
	Mon,  1 Sep 2025 09:35:30 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 01 Sep 2025 09:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756733730;
	 x=1756740930; bh=AnVy+GFpTqM3XIwnfxspH9w/hhNpLd3QoIWawv7MRX0=; b=
	qOIcHpD4d/ZwPxo1YAsCo06kvto8t7fcl/eyXQIg6cyMQZbfFLNJfqA2efdp4Xsl
	SIxwT8NGSQEC1RYPKlI0w/9nHoTAjYhQnSNteytsGnnBue+kcc/ExwpMSrzbmjfu
	+oboS1XJQ4PeLkgo/1t43q1StwLR6V2MDXQTVGUDUXS1g42rUqUbMAM5+WH8VnSH
	kaWZ18CwqCxP7TO5BT4ZAGk7Pn1Z/8/XDfGh4tAITg3Z8HdEgvBouVWrHd0xoAiO
	qv4oRiSq3Mhf0KE3i7RjlwcZNN7oiL5/3iv0waT1HbgOZ3HCFVNC+vRq22I7Wz7v
	QiBDfGjrNaidFxuWoPXK+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756733730; x=
	1756740930; bh=AnVy+GFpTqM3XIwnfxspH9w/hhNpLd3QoIWawv7MRX0=; b=T
	rZ7WmYWNKyTbBY0kpjsY07s3bpDNclAvZsAXI08SlFwVW+Ue69i4oCFAyqUpoKm1
	CcQIQxv7Hmp4aVz7nEpjk5GdPWcO1haigrmDuMzTGRMruHZiN4qTX5WBBR4KJm4v
	JJY6GqEOxeOtjDk/rKAh5vtg/2MK/YVpyOLcJNiv/dDj8BBkVSeVfTw7bG3uAS+N
	1QuVYU4DQW5tNXY+Kq5F9HRYmIFo8Dlw5ydb2ovHcxqPGgzlBclh0D3/UtBOQfYF
	MzrQ9r9iIoMLPbV2gpH4YsjASp8H3D4jOs6RAJSARnhDv+kSET/nwrfgFY9tzqLE
	oFX2UPss9JLXwxUKU76TA==
X-ME-Sender: <xms:IKG1aDr3Hqrb31TbMjN78ZTLVNY4RM96ZCFBcQVyAuY4LgHcbrnlEQ>
    <xme:IKG1aNp7u77IIkCCX9bjV4qZW5wWqe7OkAxvJPCwwbE91dmYpG4mpCOLTMXsp-Jm3
    nn8tlWvYObQvbyKOTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvghhuphhtrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfi
    hilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    gurghlihgrsheslhhisggtrdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhgu
    vghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepvhhinhgtvghnthdrghhuih
    htthhotheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehl
    ihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigi
    druggv
X-ME-Proxy: <xmx:IKG1aLMz2TINr0c9twI8YvaS3Bl-TSQE5dUZWyhg-L_0znn_f0dfPQ>
    <xmx:IKG1aE38YbHUEz7fNiAfpCQE3WrOAZZWG3HU_NyUya0Hi5uZ6Hpw_g>
    <xmx:IKG1aKom2NHpTpyZT_0AwJSkDC2sC6eK75faHFKKsNdr-FTPcJGMHA>
    <xmx:IKG1aEs7wsdixga8FnPAoUQDIFaRRBPGSqTVbhgfbhKfgrnZLF3VgQ>
    <xmx:IqG1aPF5JqcLstqMCk-eCuy-NBIHh4w5lGboHTQV22jCAUfuu3AJWcNC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 33FF5700065; Mon,  1 Sep 2025 09:35:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AWRA786TDMiJ
Date: Mon, 01 Sep 2025 15:35:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>, "Dinh Nguyen" <dinguyen@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@redhat.com>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "Kees Cook" <kees@kernel.org>, "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, guoren <guoren@kernel.org>, "Oleg Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Tejun Heo" <tj@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, "Paul Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Anna-Maria Gleixner" <anna-maria@linutronix.de>, "Frederic Weisbecker" <frederic@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Masami Hiramatsu" <mhiramat@kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "John Johansen" <john.johansen@canonical.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>, "Kentaro Takeda" <takedakn@nttdata.co.jp>, "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>, "Richard Henderson" <richard.henderson@linaro.org>, "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>, "Russell King" <linux@armlinux.org.uk>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Brian Cain" <bcain@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Michal Simek" <monstr@monstr.eu>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Jonas Bonn" <jonas@southpole.se>, "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>, "Stafford Horne" <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Helge Deller" <deller@gmx.de>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Andreas Larsson" <andreas@gaisler.com>, "Richard Weinberger" <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg" <johannes@sipsolutions.net>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Message-Id: <ebe9be04-274b-4791-b883-198320cab886@app.fastmail.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-2-53fcf5577d57@siemens-energy.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-2-53fcf5577d57@siemens-energy.com>
Subject: Re: [PATCH v2 2/4] copy_process: pass clone_flags as u64 across calltree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_063532_629724_3A14A8FC 
X-CRM114-Status: GOOD (  12.56  )
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:45:36 -0700
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

On Mon, Sep 1, 2025, at 15:09, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
>
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> However, for most consumers of clone_flags the interface was not
> changed from the previous type of unsigned long.
>
> While this works fine as long as none of the new 64-bit flag bits
> (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is still
> undesirable in terms of the principle of least surprise.
>
> Thus, this commit fixes all relevant interfaces of callees to
> sys_clone3/copy_process (excluding the architecture-specific
> copy_thread) to consistently pass clone_flags as u64, so that
> no truncation to 32-bit integers occurs on 32-bit architectures.
>
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

