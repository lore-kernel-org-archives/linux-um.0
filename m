Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BS02X-0003DO-HB for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 13:57:49 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BS02W-0008QY-Vz
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 13:57:49 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] CVS not updated?
Message-ID: <20040523214437.GC25780@ccure.user-mode-linux.org>
References: <20040518180259.GC29114@ccure.user-mode-linux.org>
	<Pine.LNX.4.44.0405182131440.10300-100000@filer.marasystems.com>
	<20040518220017.GA29646@ccure.user-mode-linux.org>
	<200405231337.30401.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405231337.30401.blaisorblade_spam@yahoo.it>
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
Date: Sun, 23 May 2004 17:44:37 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net

On Sun, May 23, 2004 at 01:37:30PM +0200, BlaisorBlade wrote:
> cvs -d :pserver:anonymous@www.user-mode-linux.org:/cvsroot/user-mode-linux 
> checkout doc/web/cl
> answers:
> 
> /cvsroot/user-mode-linux: no such repository

It did work when I sent that mail out.  It broke again after following Henrik's
recipe for chrooting it.  I haven't gotten around to figuring out what's wrong.

> even when I try from inside ssh blaisorblade@www.user-mode-linux.org. However, 
> I used :ext: and my login name and it worked (though the site content is a 
> bit out-of-date).
> 
> I would suggest to write, on the server, a script which checks out everything 
> from the CVS repository and rebuilds it; then you commit the new site, run 
> the script from the server and it should work perfectly + the site would 
> always be up-to-date.

That would require leaving my private key on the UML, which doesn't sound
like such a hot idea.  Although I could make a "uml-dev" key pair, which I
use instead.  Plus, I could put it anywhere uml-dev privs are needed, and you
could use it as well.

> By the way, onto 
> http://user-mode-linux.sourceforge.net/compile.html
> there is still a link to the old repository. (I know I could fix it now, by 
> asking you to update then the site, but I've no time right now + you need to 
> do something anyway).

Yeah, I'll fix that.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
