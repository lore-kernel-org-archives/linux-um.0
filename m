Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbNei-0006qt-3u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 11:00:00 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BbNeh-0004Dm-HR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jun 2004 10:59:59 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406181348.58968.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Uml PATCH for 2.6.7
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
Date: Fri, 18 Jun 2004 13:48:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

I'm going to upload it ASAP onto my page:

http://www.user-mode-linux.org/~blaisorblade.

I just took 2.6.6-1um (from Jeff Dike, not my older forward ports) and fixed 
some rejects (plus I checked the API changes done to arch/um and 
include/asm-um and extended them: the only one was this: 

-                       atomic_set(&page->count, 1);
+                       set_page_count(page, 1);

which I applied to other users in the UML patch).

It's ready (I've compiled and tested it). There where just 2 easy rejects. It 
has some innocous offsets (if it hasn't it will mean I later fixed them). No 
functional change in it.

Jeff, would you accept a such patch for the main UML site, if nobody complains 
in 2-3 days and we get some success reports?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
