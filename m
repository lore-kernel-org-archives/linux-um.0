Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5qji-0006AA-I6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 12:07:11 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C5qjG-00024u-Cm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 12:06:48 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch 1/1] uml-update-2.6.8-finish
References: <20040908173855.68F518D0B@zion.localdomain>
In-Reply-To: <20040908173855.68F518D0B@zion.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409102059.58454.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 10 Sep 2004 20:59:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 19:38, blaisorblade_spam@yahoo.it wrote:
> Add some updates for API changes in 2.6.8 which were not included in the
> original UML patch; these fixes were detected by some warnings, so I
> probably missed some more ones.
Well, Andrew, this one should go in, please. No review should be needed, I 
hope.
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
>
>  uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h |    2 ++
>  1 files changed, 2 insertions(+)
>
> diff -puN include/asm-um/dma-mapping.h~uml-update-2.6.8-finish
> include/asm-um/dma-mapping.h ---
> uml-linux-2.6.8.1/include/asm-um/dma-mapping.h~uml-update-2.6.8-finish	2004
>-09-07 15:17:57.593456048 +0200 +++
> uml-linux-2.6.8.1-paolo/include/asm-um/dma-mapping.h	2004-09-07
> 15:17:57.595455744 +0200 @@ -1,6 +1,8 @@
>  #ifndef _ASM_DMA_MAPPING_H
>  #define _ASM_DMA_MAPPING_H
>
> +#include <asm/scatterlist.h>
> +
>  static inline int
>  dma_supported(struct device *dev, u64 mask)
>  {
> _
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
