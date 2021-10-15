Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbCz3-0053sF-Fi
 for linux-um@lists.infradead.org; Fri, 15 Oct 2021 02:30:13 +0000
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: fealnx: fix build for UML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163426500848.31820.18368368881396978501.git-patchwork-notify@kernel.org>
Date: Fri, 15 Oct 2021 02:30:08 +0000
References: <20211014050500.5620-1-rdunlap@infradead.org>
In-Reply-To: <20211014050500.5620-1-rdunlap@infradead.org>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Oct 2021 22:05:00 -0700 you wrote:
> On i386, when builtin (not a loadable module), the fealnx driver
> inspects boot_cpu_data to see what CPU family it is running on, and
> then acts on that data. The "family" struct member (x86) does not exist
> when running on UML, so prevent that test and do the default action.
> 
> Prevents this build error on UML + i386:
> 
> [...]

Here is the summary with links:
  - [net-next] net: fealnx: fix build for UML
    https://git.kernel.org/netdev/net-next/c/cd2621d07d51

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

