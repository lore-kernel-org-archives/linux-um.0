Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRw5X-0005LY-2K for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 09:44:39 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BRw5W-0007lG-C8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 09:44:38 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] CVS not updated?
In-Reply-To: <200405231337.30401.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0405231837160.23006-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 23 May 2004 18:44:27 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, Henrik Nordstrom <uml@hno.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, 23 May 2004, BlaisorBlade wrote:

> Not here:

This is because the CVS pserer currently being slightly 
reorganised for security... should work once Jeff 
gets the time to do the last few steps setting the permissions correctly.

> even when I try from inside ssh blaisorblade@www.user-mode-linux.org. However, 
> I used :ext: and my login name and it worked (though the site content is a 
> bit out-of-date).

ssh CVS access do work, but not pserver over ssh as this is no different 
from pserver remotely except for encryption..

> I would suggest to write, on the server, a script which checks out everything 
> from the CVS repository and rebuilds it; then you commit the new site, run 
> the script from the server and it should work perfectly + the site would 
> always be up-to-date.

???

> By the way, onto 
> http://user-mode-linux.sourceforge.net/compile.html
> there is still a link to the old repository. (I know I could fix it now, by 
> asking you to update then the site, but I've no time right now + you need to 
> do something anyway).

There is several updates wrt the pserver links once the CVS serber setup
is finished.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
