Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTmey-0001jG-2o for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 12:04:52 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BTmex-0007XO-ME for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 May 2004 12:04:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] CVS not updated?
References: <20040518180259.GC29114@ccure.user-mode-linux.org>
	<200405231337.30401.blaisorblade_spam@yahoo.it>
	<20040523214437.GC25780@ccure.user-mode-linux.org>
In-Reply-To: <20040523214437.GC25780@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405282109.18920.blaisorblade_spam@yahoo.it>
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
Date: Fri, 28 May 2004 21:09:18 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > I would suggest to write, on the server, a script which checks out
> > everything from the CVS repository and rebuilds it; then you commit the
> > new site, run the script from the server and it should work perfectly +
> > the site would always be up-to-date.
>
> That would require leaving my private key on the UML, which doesn't sound
> like such a hot idea.  Although I could make a "uml-dev" key pair, which I
> use instead.  Plus, I could put it anywhere uml-dev privs are needed, and
> you could use it as well.

Why do you need a private key anywhere? The checkout should be done with 
pserver (i.e. anonymous CVS); checkout + rebuild should be done on the 
web-server. The private key is needed only by who writes something in the 
repo, i.e. you and who you want; obviously public key must be stored in 
authorized_keys but that is NOT a problem.

Bye
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
