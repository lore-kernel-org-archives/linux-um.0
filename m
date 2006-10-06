Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVe4s-0006ra-7z for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 18:00:38 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GVe4r-0000ye-UB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 18:00:38 -0700
Date: Thu, 5 Oct 2006 18:00:35 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20061005180035.90c6937e.akpm@osdl.org>
In-Reply-To: <20061005213846.17268.31893.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
	<20061005213846.17268.31893.stgit@memento.home.lan>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 04/14] uml: readd forgot prototype
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
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, 05 Oct 2006 23:38:46 +0200
"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:

> --- a/arch/um/include/os.h
> +++ b/arch/um/include/os.h
> @@ -201,6 +201,7 @@ extern int os_getpgrp(void);
>  
>  #ifdef UML_CONFIG_MODE_TT
>  extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
> +extern void stop(void);

You have a global function called "stop"?

Good luck with that...


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
