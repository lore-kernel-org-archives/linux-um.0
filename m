Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTOi7-0007Ur-BB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 10:30:31 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BTOi6-0000R0-Ly for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 10:30:30 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] CVS not updated?
References: <Pine.LNX.4.44.0405231837160.23006-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405231837160.23006-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405241944.02966.blaisorblade_spam@yahoo.it>
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
Date: Mon, 24 May 2004 19:44:02 +0200
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Alle 18:44, domenica 23 maggio 2004, Henrik Nordstrom ha scritto:
> On Sun, 23 May 2004, BlaisorBlade wrote:
> > Not here:
>
> This is because the CVS pserer currently being slightly
> reorganised for security... should work once Jeff
> gets the time to do the last few steps setting the permissions correctly.

Btw - don't know if this is needed or it's obvious for you- but the directory 
for the checkout must be setgid to a group containing everyone who should 
have write access to the website, and writable by the group; otherwise the 
when someone else than Jeff run the update script, the script won't have the 
needed permissions.

> > even when I try from inside ssh blaisorblade@www.user-mode-linux.org.
> > However, I used :ext: and my login name and it worked (though the site
> > content is a bit out-of-date).
>
> ssh CVS access do work, but not pserver over ssh as this is no different
> from pserver remotely except for encryption..
>
> > I would suggest to write, on the server, a script which checks out
> > everything from the CVS repository and rebuilds it; then you commit the
> > new site, run the script from the server and it should work perfectly +
> > the site would always be up-to-date.
>
> ???

This is about keeping even the web-site in CVS - to allow selected people to 
contribute to it (I am for instance thinking about replacing the RPM, finally 
- there are up-to-date RPM somewhere, I remember).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
