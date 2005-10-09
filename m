Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOgnq-0002mT-2s	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:25:46 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EOgno-0002lM-Ne
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:25:48 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
In-Reply-To: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510092126.04881.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH] UML TT-mode-only compile fix.
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
Date: Sun, 9 Oct 2005 21:26:04 +0200
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sunday 09 October 2005 07:06, Junichi Uekawa wrote:
> Hi,
>
> In today's linus's git tree, uml doesn't compile when it's configured for
> only TT-mode.

> This regression caused by:
> 	8923648c125421b0fcb240cde607e2748d099ab8
> 	[PATCH] uml: clear SKAS0/3 flags when running in TT mode
>
> Signed-off-by: Junichi Uekawa <dancer@debian.org>
Thanks for the report and the patch, however I want to fix things a bit 
differently... the thing _should_ compile anyway.

The macro is declared anyway and the var should exist anyway.
The problem is just that they aren't declared, I think. Will fix.

> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -334,8 +334,10 @@ int linux_main(int argc, char **argv)
>  		add_arg(DEFAULT_COMMAND_LINE);
>
>  	os_early_checks();
> +#ifdef CONFIG_MODE_SKAS
>  	if (force_tt)
>  		clear_can_do_skas();
> +#endif
>  	mode_tt = force_tt ? 1 : !can_do_skas();
>  #ifndef CONFIG_MODE_TT
>  	if (mode_tt) {

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
