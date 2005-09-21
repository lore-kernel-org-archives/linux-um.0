Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIA9I-00008y-3Q	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 12:20:56 -0700
Received: from prgy-npn1.prodigy.com ([207.115.54.37]
	helo=oddball.prodigy.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EIA9G-0000Jr-Kj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 12:20:56 -0700
Message-ID: <4331B231.1040405@tmr.com>
From: Bill Davidsen <davidsen@tmr.com>
MIME-Version: 1.0
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921172920.10219.29856.stgit@zion.home.lan>
In-Reply-To: <20050921172920.10219.29856.stgit@zion.home.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 08/10] uml: Fix GFP_ flags usage
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
Date: Wed, 21 Sep 2005 15:19:13 -0400
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> GFP_ATOMIC | GFP_KERNEL is meaningless and won't work. Actually it never worked,
> even in 2.4.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  arch/um/kernel/process_kern.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
> --- a/arch/um/kernel/process_kern.c
> +++ b/arch/um/kernel/process_kern.c
> @@ -82,7 +82,8 @@ unsigned long alloc_stack(int order, int
>  	unsigned long page;
>  	int flags = GFP_KERNEL;
>  
> -	if(atomic) flags |= GFP_ATOMIC;
> +	if (atomic)
> +		flags = GFP_ATOMIC;
>  	page = __get_free_pages(flags, order);
>  	if(page == 0)
>  		return(0);
> 

int flags = (atomic ? GFP_ATOMIC : GFP_KERNEL);

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
