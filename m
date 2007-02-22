Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1j2-0006oH-Qg for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:22:20 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HK1iz-0000Ah-6y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:22:20 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 22 Feb 2007 01:22:06 +0100
References: <20070215170713.GB5641@ccure.user-mode-linux.org>
In-Reply-To: <20070215170713.GB5641@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702220122.07414.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - Fix 2.6.20 hang
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, uml@ligatura.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 15 February 2007 18:07, Jeff Dike wrote:
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
[...]
> @@ -331,10 +334,9 @@ void maybe_sigio_broken(int fd, int read
>
>  	sigio_lock();
>  	err = need_poll(&all_sigio_fds, all_sigio_fds.used + 1);
> -	if(err){
> -		printk("maybe_sigio_broken - failed to add pollfd\n");
> +	if(err)
>  		goto out;
> -	}
> +
>  	all_sigio_fds.poll[all_sigio_fds.used++] =
>  		((struct pollfd) { .fd  	= fd,
>  				   .events 	= read ? POLLIN : POLLOUT,
>
Was that removal wanted or it happened by mistake? That way, err is completely 
lost.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
