Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj2Js-0001pb-JU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 12:17:52 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Aj2Js-0005Td-2R
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 12:17:52 -0800
Message-Id: <200401202040.i0KKeCDG004061@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.4.23-2 
In-Reply-To: Your message of "Tue, 20 Jan 2004 17:35:35 GMT."
	<20040120173534.GA15399@axis.demon.co.uk> 
References: <200401171547.i0HFlPtk009266@uml.user-mode-linux.org>
	<20040120092050.GA31994@axis.demon.co.uk>
	<200401201500.i0KF09DG002355@ccure.user-mode-linux.org>
	<20040120173534.GA15399@axis.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 20 Jan 2004 15:40:11 -0500
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

ncw1@axis.demon.co.uk said:
> I diffed the hex dump to see what sort of corruptions they were.
> Nothing obvious springs to mind, other than that the corruptions start
> on a page boundary, but don't extend for a whole page.  Maybe the page
> is being re-used before writeout has finished?

Interesting, but I'm not sure what it means.  I had a 100% reproducable
test last night, thanks to Chris Aker, but it became somewhat iffy today.

BTW, what filesystem is this?  I'm seeing corruption with ext3, but nothing
with ext2.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
