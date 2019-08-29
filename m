Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3KcS-0003rz-I6
 for linux-um@lists.infradead.org; Thu, 29 Aug 2019 13:37:45 +0000
Message-ID: <696734afb27182d7a1a9218dd3cfa01f47a76093.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 29 Aug 2019 15:37:32 +0200
In-Reply-To: <20190828204609.02a7ff70@TheDarkness>
References: <20190828204609.02a7ff70@TheDarkness>
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
To: Alexander Neville <dark@volatile.bz>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 21:44 -0400, Alexander Neville wrote:
> The old driver had a bug that would cause it to outright stop working if
> the host's /dev/random were to block. Instead of trying to track down
> the cause of said bug, rewriting it from scratch turned out to be a much
> better option as it came with a few benefits:
> 
>  - The new driver properly registers itself as an hardware RNG.
> 
>  - The code is simpler and therefore easier to maintain.
> 
>  - It serves as a minimal example of writing a hardware RNG driver.
> 
> I also edited the Kconfig symbol to bring it up to more modern
> standards.

I realize that it's still easier to use, but theoretically you could
just use the virtio implementation, and use that driver with a suitable
small vhost device implementation. :-)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

