Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbOWE-0003aJ-6h for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 11:55:18 -0700
Received: from ns.theshore.net ([216.156.129.65] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbOWD-0007i2-Hp for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 11:55:17 -0700
Message-ID: <001f01c45566$1d8ad740$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <200406182049.59129.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] SYSEMU for 2.6.7
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Fri, 18 Jun 2004 13:57:31 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>, roland <for_spam@gmx.de>

> I'm attaching the host patch, adapted a bit for 2.6.7. I'm sure it needs this
> change (it's just a case change to entry.S) but I didn't compile it yet... I
> checked the other file but there is no relevant change in 2.6.7.

That's the same change I made yesterday (and a while ago with 2.6.4), along with
your 2.6.7-skas patch.  I'm now running this on six production boxes with no
problems.

Thanks!
-Chris



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
