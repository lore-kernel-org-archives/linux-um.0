Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns4yd-00DMEH-AK
 for linux-um@lists.infradead.org; Fri, 20 May 2022 15:55:44 +0000
Date: Fri, 20 May 2022 08:55:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
Message-ID: <Yoe5/HwL9DXhaw7Z@dev-arch.thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
 <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
 <YlRp9KR1mp3/4Txo@thelio-3990X>
 <1287561645.244713.1649702724736.JavaMail.zimbra@nod.at>
 <e9597cbc-cabb-facf-deb6-662d40cf16a3@leemhuis.info>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9597cbc-cabb-facf-deb6-662d40cf16a3@leemhuis.info>
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
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Richard Weinberger <richard@nod.at>, Zhen Lei <thunder.leizhen@huawei.com>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, regressions <regressions@lists.linux.dev>

On Fri, May 20, 2022 at 08:08:01AM +0200, Thorsten Leemhuis wrote:
> On 11.04.22 20:45, Richard Weinberger wrote:
> > ----- Urspr=FCngliche Mail -----
> >> Von: "Nathan Chancellor" <nathan@kernel.org>
> >> I attempted to print out the error code but it seems like there is no
> >> output in the console after "reboot: System halted". If I add an
> >> unconditional print right before the call to os_set_fd_block(), I see =
it
> >> during start up but I do not see it during shutdown. Is there some way
> >> to see that console output during shutdown?
> > =

> > I think in this case the easiest way is attaching gdb with a breakpoint.
> =

> I noticed this in my list of open regressions. It seems there wasn't any
> progress to get this regression fixed (please let me know in case I
> missed something), but I guess nobody considered it urgent which is
> likely not that much of a problem in this case.

Yes, sorry, I tried to get gdb to reveal something but I couldn't get it
to work then I had to move onto other work. We have worked around this
for the time being but it would still be nice to figure out what is
going on here; I am just not sure when I am going to have time to
participate in that process.

Cheers,
Nathan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

