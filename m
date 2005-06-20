Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkUpw-0005GJ-He	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 15:33:48 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DkUpt-00047V-Qu	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 15:33:48 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 1/1] um: copy_from_user size fix in signal.c
References: <20050620215041.767887000@nd47.coderock.org>
In-Reply-To: <20050620215041.767887000@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506210038.23729.blaisorblade@yahoo.it>
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
Date: Tue, 21 Jun 2005 00:38:23 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: domen@coderock.org, jdike@karaya.com

On Monday 20 June 2005 23:50, domen@coderock.org wrote:
> From: Domen Puncer <domen@coderock.org>
>
>
> Size of pointer doesn't seem right, but maybe my solution isn't
> either (sig_size maybe?).
Your patch had already been submitted by Jeff a couple of hours before this 
mail. Thanks!
> Signed-off-by: Domen Puncer <domen@coderock.org>
>
> ---
>  signal.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: quilt/arch/um/sys-i386/signal.c
> ===================================================================
> --- quilt.orig/arch/um/sys-i386/signal.c
> +++ quilt/arch/um/sys-i386/signal.c
> @@ -312,7 +312,7 @@ long sys_sigreturn(struct pt_regs regs)
>  	unsigned long __user *extramask = frame->extramask;
>  	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
>
> -	if(copy_from_user(&set.sig[0], oldmask, sizeof(&set.sig[0])) ||
> +	if(copy_from_user(&set.sig[0], oldmask, sizeof(set.sig[0])) ||
>  	   copy_from_user(&set.sig[1], extramask, sig_size))
>  		goto segfault;
>
>
> --
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
