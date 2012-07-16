Return-Path: <linux-mips-bounce@linux-mips.org>
From: Mark Salter <msalter@redhat.com>
Date: Mon, 16 Jul 2012 08:56:36 -0400
In-Reply-To: <14a91278564bb5a263c561a7f1bd10ea6386d90a.1342157022.git.joe@perches.com>
References: <1341968967.13724.23.camel@joe2Laptop>
         <14a91278564bb5a263c561a7f1bd10ea6386d90a.1342157022.git.joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <1342443401.2880.2.camel@deneb.redhat.com>
Mime-Version: 1.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
Subject: Re: [PATCH net-next 8/8] arch: Use eth_random_addr
To: Joe Perches <joe@perches.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Mike Frysinger <vapier@gentoo.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, uclinux-dist-devel@blackfin.uclinux.org, linux-c6x-dev@linux-c6x.org, linux-mips@linux-mips.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2012-07-12 at 22:33 -0700, Joe Perches wrote:
> Convert the existing uses of random_ether_addr to
> the new eth_random_addr.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/blackfin/mach-bf537/boards/stamp.c |    2 +-
>  arch/c6x/kernel/soc.c                   |    2 +-

Acked-by: Mark Salter <msalter@redhat.com>




