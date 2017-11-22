Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1eHSEr-00079I-Fd
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 10:26:41 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eHSEp-0003QW-Lc for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 10:26:41 +0000
References: <201711221745.R0byKNwn%fengguang.wu@intel.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <401951dc-b3ae-8036-fa4c-4fe8b3f82f7e@kot-begemot.co.uk>
Date: Wed, 22 Nov 2017 10:26:33 +0000
MIME-Version: 1.0
In-Reply-To: <201711221745.R0byKNwn%fengguang.wu@intel.com>
Content-Language: en-US
Subject: Re: [uml-devel] [uml:for-linus-4.15-rc1 5/6] ERROR:
 "free_irq_by_fd" [arch/um/drivers/random.ko] undefined!
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>

irq.c needs an EXPORT_SYMBOL(free_irq_by_fd);

Amended patch coming up shortly.

A.


On 11/22/17 09:33, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.15-rc1
> head:   ad1f62ab2bd43b962127af760d59a25ae1c93681
> commit: d4560bdc6d38f5c3bf5889fd95c954b6b5949fab [5/6] Epoll based IRQ controller
> config: um-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>          git checkout d4560bdc6d38f5c3bf5889fd95c954b6b5949fab
>          # save the attached .config to linux build tree
>          make ARCH=um
>
> All errors (new ones prefixed by >>):
>
>     ERROR: "devm_ioremap_resource" [drivers/auxdisplay/img-ascii-lcd.ko] undefined!
>>> ERROR: "free_irq_by_fd" [arch/um/drivers/random.ko] undefined!
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

