Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTPVD-0001Q7-Ac for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 11:21:15 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTPVC-000347-GP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 11:21:14 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] CVS not updated?
In-Reply-To: <200405241944.02966.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0405272019101.18839-100000@filer.marasystems.com>
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
Date: Thu, 27 May 2004 20:21:01 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 24 May 2004, BlaisorBlade wrote:

> Btw - don't know if this is needed or it's obvious for you- but the directory 
> for the checkout must be setgid to a group containing everyone who should 
> have write access to the website, and writable by the group; otherwise the 
> when someone else than Jeff run the update script, the script won't have the 
> needed permissions.

Yes, this is included in the instructions sent to Jeff earlier.

> This is about keeping even the web-site in CVS - to allow selected people to 
> contribute to it (I am for instance thinking about replacing the RPM, finally 
> - there are up-to-date RPM somewhere, I remember).

Makes perfect sense. This is also what I do on most the projects I
maintain and it works out really well when there is many contributors.

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
