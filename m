Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvvLl-0007ib-9U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 06:14:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HvvLj-0006hf-Q7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 06:14:57 -0700
Date: Wed, 6 Jun 2007 09:06:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070606130627.GB5491@c2.user-mode-linux.org>
References: <dec0fd580706060422w255ea6e9l52d6f6784252814b@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dec0fd580706060422w255ea6e9l52d6f6784252814b@mail.gmail.com>
Subject: Re: [uml-devel] doubt regarding UML instlation please help me.
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
To: battipatisainagendra Bhavaniprasad <sainagendrabhavaniprasad@gmail.com>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Jun 06, 2007 at 04:52:25PM +0530, battipatisainagendra Bhavaniprasad wrote:
> next i went with the latest kernel i.e..linux-2.6.21.tar.bz2
> but when i run command i.e...make ARCH=um
> 
> it's going on exexuting the same sequence of things....

What same sequence of things?  The JB_* errors?  That's impossible,
since those are gone in 2.6.21.

> please suggest me which kernel mirror to use which has already uml
> patch built in....

Any mirror which carries 2.6.21.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
