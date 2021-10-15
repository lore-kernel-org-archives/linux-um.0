Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbCz3-0053sA-Do
 for linux-um@lists.infradead.org; Fri, 15 Oct 2021 02:30:12 +0000
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: intel: igc_ptp: fix build for UML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163426500834.31820.14758482906938638216.git-patchwork-notify@kernel.org>
Date: Fri, 15 Oct 2021 02:30:08 +0000
References: <20211014050516.6846-1-rdunlap@infradead.org>
In-Reply-To: <20211014050516.6846-1-rdunlap@infradead.org>
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
Cc: netdev@vger.kernel.org, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, davem@davemloft.net, kuba@kernel.org, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Oct 2021 22:05:16 -0700 you wrote:
> On a UML build, the igc_ptp driver uses CONFIG_X86_TSC for timestamp
> conversion. The function that is used is not available on UML builds,
> so have the function use the default system_counterval_t timestamp
> instead for UML builds.
> 
> Prevents this build error on UML:
> 
> [...]

Here is the summary with links:
  - [net-next] net: intel: igc_ptp: fix build for UML
    https://git.kernel.org/netdev/net-next/c/523994ba3ad1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

