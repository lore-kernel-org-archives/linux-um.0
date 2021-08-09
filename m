Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD1UM-00Haya-Tq
 for linux-um@lists.infradead.org; Mon, 09 Aug 2021 09:22:32 +0000
Message-ID: <09b654a819dc2985ee18419931a710572bf2b8f9.camel@sipsolutions.net>
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 09 Aug 2021 11:21:53 +0200
In-Reply-To: <YO6LdCg2/4M47k7/@matsya>
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
 <YO6LdCg2/4M47k7/@matsya>
MIME-Version: 1.0
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
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, linux-um@lists.infradead.org, kernel test robot <lkp@intel.com>

On Wed, 2021-07-14 at 12:30 +0530, Vinod Koul wrote:
> On 25-06-21, 10:38, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Now that UML has PCI support, this driver must depend also on
> > !UML since it pokes at X86_64 architecture internals that don't
> > exist on ARCH=um.
> 
> Applied, thanks

Thanks.

Any reason this hasn't landed in Linus's tree yet? I keep getting build
failure reports from there.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

