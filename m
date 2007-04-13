Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HcQYt-0002hl-Lq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 11:31:55 -0700
Received: from mail.windriver.com ([147.11.1.11] helo=mail.wrs.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HcQYr-0008Fz-2A
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 11:31:55 -0700
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l3DIVOeT018235
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 13 Apr 2007 11:31:24 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 13 Apr 2007 11:31:23 -0700
Message-ID: <AF1602CB2550CE4381C0C75118A7856BE60A5F@ala-mail02.corp.ad.wrs.com>
From: "Stephens, Allan" <allan.stephens@windriver.com>
Subject: [uml-devel] Does UML Currently Emulate SMP?
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
To: user-mode-linux-devel@lists.sourceforge.net

What is the status of SMP support in UML?  (That is, can I start up a
UML session that uses separate processes on my uniprocessor host to
emulate a machine with multiple CPUs?)

Jeff Dike's "User Mode Linux" text indicates that this sort of support
was once available, but it seems to have died out.  (I can't find any
way of enabling it in a 2.6.20 kernel.)  Has this capability been
dropped due to lack of interest?  If so, what was the most recent kernel
that did suppport it?

Thanks,
Al

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
