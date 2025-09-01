Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBF1CA1005
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mw8Cn4/OCWn4lPhhW5QgwqsK4SmxabwHi0TRYO6VF1s=; b=rVU/lIh4ufng73WpIY4wDViiYu
	wuJegeXKT/2SKbVi11qdMtkJqJNyVspA5oabET2kw1h26KOaFdcbKVViO5Rfll2Hual8f1sP/OVEw
	TpzXv/VrU2fOcmjOhP2d2GLdaTtIqspF4a+LQr1s1F3cKc8BrRsErMuAV4yHcH6MDglMfcEr/MiZD
	KYMQTxWFwzClNT9rRnwpcXL6H66bSnvwnC1bF2sSI/XELn2NAMlpifuPmRd/CUGQh/sh2hXYmGOVw
	BDXSrs5rL+u0/CDZJZbjp5wobOhjk1GPpAk0TGDHu3eJqSrqoe1G7Z8n2n7MDrVBZCks0pASR+6gg
	/kcaoNMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYlr-00000002ACa-1xbf;
	Tue, 02 Sep 2025 21:42:31 +0000
Received: from flow-b2-smtp.messagingengine.com ([202.12.124.137])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut4S1-0000000CfHz-21A9;
	Mon, 01 Sep 2025 13:20:02 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id A6FC21300863;
	Mon,  1 Sep 2025 09:19:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 01 Sep 2025 09:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756732796;
	 x=1756739996; bh=Mw8Cn4/OCWn4lPhhW5QgwqsK4SmxabwHi0TRYO6VF1s=; b=
	tLTVNY7szoigfD1bdhldSITh7Kox+Ycn17T1yGQFuN7jiGG9Sp2E3OoIEgt4BlYR
	rNhkEYaaTwW9AY8m/x59u8SKCEV8qlVaBwXQvzGnzQoPzBL4TjVy5CdpcL+u+JqB
	KmJ3jHWtf+GNS20ntReqncPg5QMylzMw0aOyUz8qs6cq7e90TqtTjq8VaJiUu84j
	0Hbrt3spucncVfrk667VYr7pw5WfvWM/7x1uij9C9tbA0VlIJi04Xfi/PwUtHZjH
	tp2QLWr1i5c0AXIenHSE0ClgWTuzdKOBvYNRbC8MWhIAWUeC6kCgPRh8m9F4uMyi
	KzWTcNLbW1JaPQ2Aw11NKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756732796; x=
	1756739996; bh=Mw8Cn4/OCWn4lPhhW5QgwqsK4SmxabwHi0TRYO6VF1s=; b=I
	zqfGdUJTZYsd9+VQGEkI1q4f285SfJOyQUijCL8E0cG2BY7oScLcaHaB4U4dSd6C
	amMI/0oCv9Bb0UfFnGfGYioT9dMJyeughesxg0Wy1rdEh8SQOGdyCUffECW6u3Ik
	7Yt199ahGI90eOSQbbYW4SeXGJc3EXxwFehYo9jcgKLtOkWvo9SKPtZekLd+KcYs
	Z/Fffj6kergS+JKtkBMxaKu8MQZtZradNzWqlU+a2WBOqFRrht0dAWPgSu3etycz
	k7O/f+D6scJuUcbaLBYenYfBxURlHHBUlfglvq526uItPCjL8pAUcIHJOR7e07hM
	zb1rPxkwOSlF3dLiDllTQ==
X-ME-Sender: <xms:d521aOf13Zr5ThFIjcbvwdTTV2pPmE198UZ83DSiYsB0vWHFjqexWQ>
    <xme:d521aINZWaZx6d4hdtzCY3ReTpNDHMXU4y76p-zL9tbADaAIKToEoWjoFLEFK0nJN
    uZjL5twG3OOu4Cx9a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvvdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:d521aFWUjfBNEEbfvfRsOXSgs_xr9RfZnAPjyB2Gss4aiPQVe79b8A>
    <xmx:d521aOB9sbKqEptN3OSwQ4xRQk_xYmG1ZydhuFGxz43PvXYNa2Ks1g>
    <xmx:d521aHACv2QrtY793xhqmmRyjqkD5ZVdMHOozOYGDyCY3vyLPOZbWQ>
    <xmx:d521aMbQNOQ3kj5F7xBftwDq3uTM_HtOBAYus1Iszp-XmI0rzGHioA>
    <xmx:fJ21aLW9J1hdKeVm-quvjTtf5v_yEVzzCp7GK-rbIpJMpKdzZjrbFv0P>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76793700065; Mon,  1 Sep 2025 09:19:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AngmsHLdt4H3
Date: Mon, 01 Sep 2025 15:19:31 +0200
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
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 stable@vger.kernel.org
Message-Id: <13f8ca46-92f0-47bb-a046-165402122a44@app.fastmail.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-1-53fcf5577d57@siemens-energy.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-1-53fcf5577d57@siemens-energy.com>
Subject: Re: [PATCH v2 1/4] copy_sighand: Handle architectures where sizeof(unsigned
 long) < sizeof(u64)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_062001_663254_1D441ADC 
X-CRM114-Status: UNSURE (   8.17  )
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

> This commit fixes the bug by always passing clone_flags to copy_sighand
> via their declared u64 type, invariant of architecture-dependent integer
> sizes.
>
> Fixes: b612e5df4587 ("clone3: add CLONE_CLEAR_SIGHAND")
> Cc: stable@vger.kernel.org # linux-5.5+
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

