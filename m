Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C0CA1014
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EkyOW6EUUTV+C/dNjMz2+XFswtE2xmJVWwojlRsa6wQ=; b=Bgi35D7mU5PEtORWFyyp4lSiix
	KpqS4uTRtR95jA2BT1lnHW4LvT3NamNakdnJdBkwq10JjuZz+90HDGMpybSD3/nh7hH3EMyeLtB5T
	eGgTPDp4iDGG5pf+tbnt/z4syZpvcKiYHFMTt/GfVqZhXy4tVYSnTEVah3YIwWn+XOW/B+It95R9l
	F9jw1XPJ34xKmQvCpd7WPU2jYuVvBY1xqFJpHu/YOtl05LClb77/PLGlOEQ+A1RRflQkOl5B89Slc
	xNHbABZLBPD3IojjsXapg+KKqkGe5HVF58R96h5Y20XC7q4mwmDdqbuDCTMa6k2Pmy/6j7FI0L9Gn
	m4i/T1FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYls-00000002AEE-1pnU;
	Tue, 02 Sep 2025 21:42:32 +0000
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut4hZ-0000000ChgV-2qBk;
	Mon, 01 Sep 2025 13:36:06 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 7D2251300C7D;
	Mon,  1 Sep 2025 09:36:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 01 Sep 2025 09:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756733763;
	 x=1756740963; bh=EkyOW6EUUTV+C/dNjMz2+XFswtE2xmJVWwojlRsa6wQ=; b=
	iqQoAqNvegrh6j4CIJgpRxtWPa4GfHGJHLJTeEiexLv/cC5adGMhR8mu9arcNl1O
	I+SViigwx5fkDtvAUK3JQvr9LUo9tSyD34ZzpwtKWl4oFpF9VVsko6G0wgKCFOrB
	Wgwk3+poGXpme23gg9tOI5NyS1XAjU0UtkVbuQdc6FHKDGjmCvobEZ9KxeWcp220
	ubS3J54j+pFRzIZl5cfhA3pOQm3sGNXHxwAVgi/uBnkXKL329bISvPyPgjUgQwA9
	8FW2trQiznoacWZhLt9i6H2QSMNg8TYnbJn1BTlhuZoxeGDnw5hk4Tdb29vm1nUY
	bZXVgQ/h5beUsffzWqRmug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756733763; x=
	1756740963; bh=EkyOW6EUUTV+C/dNjMz2+XFswtE2xmJVWwojlRsa6wQ=; b=Y
	ZdEcITLqgPB8jj8CHPxaiDUBffgGZ2F11HyGFeXL1aqJLq4I4uY3ERkYEVyLePpp
	o/psznaJhEHGBKJ1kQdFcm4CnwWSHMxVhZ1tegHG4+vQZnEWzWcfLawto2oOCNBm
	Q/nmgawaUaDpiYJcIgjle3tNvGPP7HrGRlkZTVjBSyx3SdL+Ubvbaw2NllbE0UKR
	5PpaPKDdUnQpnidtMabM7ViC4q/rsdCRkhJmrsQb7pfEcghJVlhRRIXKOl1ByAL6
	97jtMnFynzRNFQoG7yviaZDvoKIlFw/RFuOZzAvP0wULCLGRMZMgHnd0YvSE2EEr
	37ywaIwtBcs1nPsRIxnAw==
X-ME-Sender: <xms:QqG1aMBAb1qwptbTZfcieXRiGZJ-sUTLCT0kfm4oU2mfCmb2rLE59w>
    <xme:QqG1aOgtge6O1bXGieZrbSKSwHUnyy_Eoot2uP8L9kA1s2-ybgS8kAo4MwLH_ML4e
    xXpfwuSam7mVev1zuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvghhuphhtrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfi
    hilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    gurghlihgrsheslhhisggtrdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhgu
    vghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepvhhinhgtvghnthdrghhuih
    htthhotheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehl
    ihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigi
    druggv
X-ME-Proxy: <xmx:QqG1aJZQk38pWZPUfRtMdGUj4gUf32jREDDlB8cSddU8-Bte6a_BGA>
    <xmx:QqG1aI0LMalgb6WOOoOvBq_ZHFcA810ON4N6sxEckbEx2UH355DlHQ>
    <xmx:QqG1aBnD05OhcRlHKCFLP4CiLGcm0kJsZXFJNAUtGT5thazjIMDFJw>
    <xmx:QqG1aLuu7r7Df2HXyPIO-14-qQlreeIXRd5bgYb73qe7TD5XXuvCoQ>
    <xmx:Q6G1aKbfgfdq7WHr6K7GavWXAT9kKUqpMQgMvatETMxCn_gjK_opBczb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 72651700065; Mon,  1 Sep 2025 09:36:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AHNSoFB7hZ_J
Date: Mon, 01 Sep 2025 15:35:42 +0200
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
Message-Id: <35893d46-6caf-49ea-bbae-6e1cab6b2914@app.fastmail.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-4-53fcf5577d57@siemens-energy.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-4-53fcf5577d57@siemens-energy.com>
Subject: Re: [PATCH v2 4/4] nios2: implement architecture-specific portion of
 sys_clone3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_063605_786917_BE5CB208 
X-CRM114-Status: UNSURE (   9.34  )
X-CRM114-Notice: Please train this message.
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
> This commit adds the sys_clone3 entry point for nios2. An
> architecture-specific wrapper (__sys_clone3) is required to save and
> restore additional registers to the kernel stack via SAVE_SWITCH_STACK
> and RESTORE_SWITCH_STACK.
>
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

