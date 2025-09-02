Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF399CA101C
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75QsosR73EP7Bhx5dXwnnBiSrQlTSAdKIHehZonw/2s=; b=mKFZOpdvwfM2m3ToZVrGbcf4lp
	6eU5OxUtjChrsVx5HJViQbxyoHLhTBZvAiegI25a0LIYsiShkT9de+tTQMgpJuF+6nZcZbl4dCLhl
	/Ym7CjfP7gStAG8UiZ4LcGv/pNZIxUnL30Q4CHkEwQYcc2PQh4cgj1a3icLbcuLjF3boNenNyNkGp
	lnJWWPaGO17CWcVQnHx/7fvnn5eUQeG44FIAWXPELpxkE9dE9OSQkrlfugR6WVsnZPTl1pr/dNLJJ
	WVIyi/OI36cEgkvo0whw3TNdRuhUJxCe5MD/t37ewE63Z40/uHh03MaNgvaOuoz0DWBumNJaG//zl
	vkVu8j2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYlu-00000002AIB-2RK6;
	Tue, 02 Sep 2025 21:42:34 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utLEc-0000000FhM1-3alT;
	Tue, 02 Sep 2025 07:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=75QsosR73EP7Bhx5dXwnnBiSrQlTSAdKIHehZonw/2s=; t=1756797318;
	x=1757402118; b=nVB+12/nFKT2wSz0MEK3OpJQI5VpKzHxqMhYEC6s+piOnCZc+zTc5oxCf4C3N
	hwGp+W4iySQK12hmLVmj7WEx9len4isI+qp/H/QONq94ZwMYlVjYth04dTi4iWklOMGTz/wuDOg7i
	EMk7EaRS8WUABc2rventFAbuVLpo6XgLppYzJ+iTacIzGKNaVb85oDwri5qRj6FSppc8X7mYxhg8R
	BM05Qpj401nm6d8kTc6wRFqh9k3q/2yAY/CMQROg0Dx3ceFUuE8Jkjfaa4mTBQF+endHpBIsGvN0j
	eGdAq7JLXk45XYJf4TYetCFHy+zEKG94BzXTPhIrLGJtnUpNMw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1utLEY-00000000Jm5-12co; Tue, 02 Sep 2025 09:15:14 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1utLEX-00000002jxi-2pMt; Tue, 02 Sep 2025 09:15:13 +0200
Message-ID: <11a4d0a953e3a9405177d67f287c69379a2b2f8f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>,
 schuster.simon@siemens-energy.com,  Dinh Nguyen <dinguyen@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes	 <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka	 <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan	 <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Ingo Molnar	 <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli	 <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>,  Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti	 <alex@ghiti.fr>, Guo
 Ren <guoren@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Jens Axboe
 <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=	 <mkoutny@suse.com>,
 Paul Moore <paul@paul-moore.com>, Serge Hallyn	 <sergeh@kernel.org>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn"	 <serge@hallyn.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mathieu
 Desnoyers	 <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin	
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers	 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, John
 Johansen	 <john.johansen@canonical.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>,  Ondrej Mosnacek <omosnace@redhat.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa	
 <penguin-kernel@I-love.SAKURA.ne.jp>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta	 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian
 Cain	 <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui	
 <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal
 Simek	 <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jonas Bonn	 <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>,  Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller	 <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger	
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Richard
 Weinberger	 <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  Chris Zankel <chris@zankel.net>, Max Filippov
 <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Date: Tue, 02 Sep 2025 09:15:08 +0200
In-Reply-To: <f2371539-cd4e-4d70-9576-4bb1c677104c@gaisler.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
	 <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
	 <f2371539-cd4e-4d70-9576-4bb1c677104c@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.52
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_001519_101512_51E58565 
X-CRM114-Status: GOOD (  20.52  )
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

Hi Andreas,

On Tue, 2025-09-02 at 09:02 +0200, Andreas Larsson wrote:
> On 2025-09-01 15:09, Simon Schuster via B4 Relay wrote:
> > From: Simon Schuster <schuster.simon@siemens-energy.com>
> >=20
> > With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> > clone3") the effective bit width of clone_flags on all architectures wa=
s
> > increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> > However, for most consumers of clone_flags the interface was not
> > changed from the previous type of unsigned long.
> >=20
> > While this works fine as long as none of the new 64-bit flag bits
> > (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is stil=
l
> > undesirable in terms of the principle of least surprise.
> >=20
> > Thus, this commit fixes all relevant interfaces of the copy_thread
> > function that is called from copy_process to consistently pass
> > clone_flags as u64, so that no truncation to 32-bit integers occurs on
> > 32-bit architectures.
> >=20
> > Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> > ---
>=20
> Thanks for this and for the whole series! Needed foundation for a
> sparc32 clone3 implementation as well.

Can you implement clone3 for sparc64 as well?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

