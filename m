Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ix58z-0006sX-9J for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Nov 2007 10:26:49 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ix58y-0006FA-E0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Nov 2007 10:26:49 -0800
In-reply-to: <E1Ix3Du-0002aL-Ac@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 27 Nov 2007 17:23:46 +0100)
References: <E1Ix3Du-0002aL-Ac@dorka.pomaz.szeredi.hu>
Message-Id: <E1Ix58o-0004J5-Mz@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 Nov 2007 19:26:38 +0100
Subject: Re: [uml-devel] leak in do_ubd_request
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> There seems to be no corruption though.  Looking at the code, I can't
> see how the requests could leak...

Didn't look close enough.

Index: linux/arch/um/drivers/ubd_kern.c
===================================================================
--- linux.orig/arch/um/drivers/ubd_kern.c	2007-11-27 19:23:37.000000000 +0100
+++ linux/arch/um/drivers/ubd_kern.c	2007-11-27 19:24:24.000000000 +0100
@@ -1132,6 +1132,7 @@ static void do_ubd_request(struct reques
 					       "errno = %d\n", -n);
 				else if(list_empty(&dev->restart))
 					list_add(&dev->restart, &restart);
+				kfree(io_req);
 				return;
 			}
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
