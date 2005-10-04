Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMnQr-0001Je-1m	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 07:06:13 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMnQo-0006au-A7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 07:06:13 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by wumpus.mythic-beasts.com with esmtp (Exim 4.44)
	id 1EMnQh-0006mK-Li	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 15:06:03 +0100
From: Chris Lightfoot <chris@ex-parrot.com>
Message-ID: <p0zwERnRDXpq.XPXM1lKY1g1VZeW131q++g@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] comments in ubd_kern.c
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
Date: Tue, 4 Oct 2005 15:06:02 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Presently the code in ubd_kern.c carries the following
comments:

  - for ubd_handler,

    /* Called without ubd_io_lock held */

  - for do_ubd_request,

    /* Called with ubd_io_lock held */

ubd_handler locks ubd_io_lock before calling end_request,
but it then calls do_ubd_request, after releasing the
lock. But at the end of ubd_handler, it calls
do_ubd_request, and doesn't acquire the spinlock before
doing so. Am I missing something or is this an error?

-- 
Something must be done. This is something, so we must do it.
(characterising government-by-reaction)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
