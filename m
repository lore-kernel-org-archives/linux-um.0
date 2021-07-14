Return-Path: <dmaengine-owner@vger.kernel.org>
Date: Wed, 14 Jul 2021 12:30:04 +0530
From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
Message-ID: <YO6LdCg2/4M47k7/@matsya>
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: dmaengine@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>
List-ID: <linux-um.lists.infradead.org>

On 25-06-21, 10:38, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.

Applied, thanks

-- 
~Vinod

