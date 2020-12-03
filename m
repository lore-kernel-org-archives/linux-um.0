Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkxI9-0006wa-EC
 for linux-um@lists.infradead.org; Thu, 03 Dec 2020 22:41:38 +0000
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] rtc: enable RTC framework on ARCH=um
Date: Thu,  3 Dec 2020 23:41:33 +0100
Message-Id: <160703528647.99810.8924384359041408113.b4-ty@bootlin.com>
In-Reply-To: <20201120211103.6895ac740d11.Ic19a9926e8e4c70c03329e55f9e5b1d45095b904@changeid>
References: <20201120211103.6895ac740d11.Ic19a9926e8e4c70c03329e55f9e5b1d45095b904@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-rtc@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>

On Fri, 20 Nov 2020 21:11:06 +0100, Johannes Berg wrote:
> There's no real reason it should be disabled, and at least we can
> use it for development & testing with the RTC test driver.
> 
> However, two devices are missing a HAS_IOMEM dependency, so add
> that to avoid build failures from e.g. allyesconfig.

Applied, thanks!

[1/1] rtc: enable RTC framework on ARCH=um
      commit: 9c7957991e56291c59803cf0412127ae7177beac

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

