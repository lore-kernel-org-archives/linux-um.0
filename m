Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ix73t-0002sb-9j for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Nov 2007 12:29:41 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ix73r-0002Co-BS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Nov 2007 12:29:41 -0800
In-reply-to: <20071127201105.GA9332@c2.user-mode-linux.org> (message from Jeff
	Dike on Tue, 27 Nov 2007 15:11:05 -0500)
References: <E1Ix3Du-0002aL-Ac@dorka.pomaz.szeredi.hu>
	<E1Ix58o-0004J5-Mz@dorka.pomaz.szeredi.hu>
	<20071127201105.GA9332@c2.user-mode-linux.org>
Message-Id: <E1Ix73b-0004aI-Px@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 Nov 2007 21:29:23 +0100
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

> On Tue, Nov 27, 2007 at 07:26:38PM +0100, Miklos Szeredi wrote:
> > +				kfree(io_req);
> 
> Whoops, nice catch.
> 
> Can you sign that off for me?

Sure.  The patch works for me, but please check that it also makes
sense.

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
