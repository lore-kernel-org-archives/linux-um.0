Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DcfCQ-0007xf-1q	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 01:00:38 -0700
Received: from gprs189-60.eurotel.cz
	([160.218.189.60] helo=amd.ucw.cz ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DcfCJ-00071f-Gd	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 01:00:37 -0700
From: Pavel Machek <pavel@ucw.cz>
Message-ID: <20050530075931.GA13119@elf.ucw.cz>
References: <200505262230.j4QMUGVh014671@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505262230.j4QMUGVh014671@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [PATCH 1/7] UML - set_tsk_need_resched
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
Date: Mon, 30 May 2005 09:59:32 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hi!

> This is the UML resched patch.  Please stick it in with the other arch resched
> fixes.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.11/arch/um/kernel/process_kern.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/process_kern.c	2005-05-26 14:01:28.000000000 -0400
> +++ linux-2.6.11/arch/um/kernel/process_kern.c	2005-05-26 14:31:46.000000000 -0400
> @@ -188,6 +188,8 @@ void default_idle(void)
>  	current->mm = &init_mm;
>  	current->active_mm = &init_mm;
>  
> +        set_tsk_need_resched(current);
> +
>  	while(1){
>  		/* endless idle loop with no priority at all */
>  		SET_PRI(current);

Seems to me you are have some tabs-vs-spaces problems. Plus it would
be nice to write

	while (1) {
instead of
	while(1){
								Pavel


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
