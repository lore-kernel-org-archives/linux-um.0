Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRf1W-0007EJ-Jp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 18:49:30 -0800
Received: from qb-out-0506.google.com ([72.14.204.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JRf1V-0005aq-Sy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 18:49:30 -0800
Received: by qb-out-0506.google.com with SMTP id c8so2365937qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 19 Feb 2008 18:49:28 -0800 (PST)
Date: Wed, 20 Feb 2008 10:44:44 +0800 (CST)
Message-Id: <20080220.104444.124086115.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <47BB4EED.7020109@gmail.com>
References: <47BB4EED.7020109@gmail.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] uml: use DIV_ROUND_UP
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: olsajiri@gmail.com
Cc: jdike@addtoit.com, kernel-janitors@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH] uml: use DIV_ROUND_UP
Date: Tue, 19 Feb 2008 22:49:33 +0100
Message-ID: <47BB4EED.7020109@gmail.com>

> Hi,
> 
> I just saw similar patches in the janitor kernel's list,
> and spotted place it fits.
> 
> Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
> ---
>  arch/um/drivers/ubd_kern.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index b1a77b1..1e579e4 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1020,8 +1020,7 @@ static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow_mask,
>  	 * by one word.  Thanks to Lynn Kerby for the fix and James McMechan
>  	 * for the original diagnosis.
>  	 */
> -	if(*cow_offset == ((bitmap_len + sizeof(unsigned long) - 1) /
> -			   sizeof(unsigned long) - 1))
> +	if(*cow_offset == (DIV_ROUND_UP(bitmap_len, sizeof(unsigned long)) - 1))

Looks good for me. ACK.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
