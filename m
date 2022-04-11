Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndy9X-009xyg-Uy
 for linux-um@lists.infradead.org; Mon, 11 Apr 2022 17:48:41 +0000
Date: Mon, 11 Apr 2022 10:48:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
Message-ID: <YlRp9KR1mp3/4Txo@thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
 <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Zhen Lei <thunder.leizhen@huawei.com>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, regressions@lists.linux.dev

Hi Richard,

On Sun, Apr 10, 2022 at 11:33:33AM +0200, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Thorsten Leemhuis" <regressions@leemhuis.info>
> > Hi, this is your Linux kernel regression tracker. Top-posting for once,
> > to make this easily accessible to everyone.
> > =

> > Zhen Lei, Richard, what's up here? Below regression report is more than
> > two weeks old now and afaics didn't even get a single reply.
> =

> Sorry, but UML is leisure pursuit, so I can only work on it when my
> schedule permits it.

No worries, it is easy enough to work around for our use case.

> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > =

> > P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> > reports on my table. I can only look briefly into most of them and lack
> > knowledge about most of the areas they concern. I thus unfortunately
> > will sometimes get things wrong or miss something important. I hope
> > that's not the case here; if you think it is, don't hesitate to tell me
> > in a public reply, it's in everyone's interest to set the public record
> > straight.
> > =

> > =

> > =

> > On 23.03.22 20:41, Nathan Chancellor wrote:
> =

> [...]
> =

> >> in case it helps. I am happy to provide more information or test patch=
es
> >> as necessary.
> =

> Nathan, can you provide me the error code from os_set_fd_block()?
> My best guess is that setting the fd is optional here and UML does
> not expect failure here.

I attempted to print out the error code but it seems like there is no
output in the console after "reboot: System halted". If I add an
unconditional print right before the call to os_set_fd_block(), I see it
during start up but I do not see it during shutdown. Is there some way
to see that console output during shutdown?

Cheers,
Nathan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

