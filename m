Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJdny-00Cghr-Qk
 for linux-um@lists.infradead.org; Fri, 27 Aug 2021 15:30:08 +0000
MIME-Version: 1.0
Subject: Re: [PATCH net-next] um: vector: adjust to coalesce API changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163007820547.21913.18376633815628407296.git-patchwork-notify@kernel.org>
Date: Fri, 27 Aug 2021 15:30:05 +0000
References: <20210827094759.f3ab06684bd0.I985181cc00fe017cfe6413d9e1bb720cbe852e6d@changeid>
In-Reply-To: <20210827094759.f3ab06684bd0.I985181cc00fe017cfe6413d9e1bb720cbe852e6d@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-um@lists.infradead.org, moyufeng@huawei.com, tanhuazhong@huawei.com, kuba@kernel.org, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 27 Aug 2021 09:48:04 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The API changes were propagated to most drivers, but clearly
> arch/um/drivers/ was missed, perhaps due to looking only at
> the drivers/ folder. Fix that.
> 
> Fixes: f3ccfda19319 ("ethtool: extend coalesce setting uAPI with CQE mode")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] um: vector: adjust to coalesce API changes
    https://git.kernel.org/netdev/net-next/c/4baf0e0b3298

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

