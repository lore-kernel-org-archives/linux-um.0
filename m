Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcFjd-00071G-Of for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jun 2004 20:44:41 -0700
Received: from click.bur.st ([203.34.17.217])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcFjc-0004Vu-UF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jun 2004 20:44:41 -0700
Received: from thump.bur.st (thud.bur.st [10.1.1.1])
	by click.bur.st (Postfix) with ESMTP id D673D8A5AA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 21 Jun 2004 11:44:38 +0800 (WST)
From: Trent Lloyd <lathiat@bur.st>
Message-ID: <20040621034434.GC2735@thump.bur.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] hostfs / current->fsuid
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
Date: Mon, 21 Jun 2004 11:44:35 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Hi Guys,

I was looking into trying to modify hostfs so if UML ran as root it
would keep the same permissions

And to start, I am aware of humfs, i guess my next question could be,
would humfs work with two UMLs accessing the filesystem, if yes, the
rest of this is redundant.

I was looking at making hostfs set the right owner at create time,
however current->fsuid seems just to be root, and not the person who
called the process (this is in hostfs_kern.c)

Sorry if I'm off the mark here and this is wrong, could someone tell me
if either I've buggered up somewhere and it should be right, or if I'm
using the wrong thing completely and how I could get the uid of the user
who requested the file operation.

Cheers,
Trent
Bur.st

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
