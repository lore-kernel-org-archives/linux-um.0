Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgPYc-0001Dv-Qe
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 09:51:53 +0000
Message-ID: <229d3b5d615c858345a8b84454099eefd64581ce.camel@sipsolutions.net>
Subject: Re: [PATCH] rtc: enable RTC framework on ARCH=um
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 21 Nov 2020 10:51:43 +0100
In-Reply-To: <20201120223914.GD348979@piout.net>
References: <20201120211103.6895ac740d11.Ic19a9926e8e4c70c03329e55f9e5b1d45095b904@changeid>
 <20201120223914.GD348979@piout.net>
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
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-um@lists.infradead.org

On Fri, 2020-11-20 at 23:39 +0100, Alexandre Belloni wrote:
> On 20/11/2020 21:11:06+0100, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > There's no real reason it should be disabled, and at least we can
> > use it for development & testing with the RTC test driver.
> > 
> > However, two devices are missing a HAS_IOMEM dependency, so add
> > that to avoid build failures from e.g. allyesconfig.
> > 
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> > ---
> > Would there be objection to taking this through the linux-um tree?
> > I have a couple of patches that depend on it as well, to add
> > suspend/resume support with a pseudo-RTC to wake up from it.
> 
> I'm fine with that.

Thanks. I think I spoke too quickly here though; I realize now that it's
probably better if you just merge it through whatever RTC tree you have.

Some of the code I was working on has "depends on RTC_CLASS", but then
it obviously doesn't matter what tree it goes through, it doesn't have
any conflicts, and things will just fall into place whenever all patches
are merged, regardless through which tree.

For my local experimentation etc. it doesn't matter, I can just carry
this.

I apologize for not thinking this through properly yesterday, but now
think it's better if it just goes through the normal route.

Thanks,
johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

