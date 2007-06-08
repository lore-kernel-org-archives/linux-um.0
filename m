Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwhcG-000810-Uj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jun 2007 09:47:13 -0700
Received: from agminet01.oracle.com ([141.146.126.228])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HwhcF-0004CN-Ae
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jun 2007 09:47:12 -0700
In-Reply-To: <20070608163302.GA9101@c2.user-mode-linux.org>
References: <20070531181923.GA9904@c2.user-mode-linux.org>
	<20070607232733.GM17082@mami.zabbo.net>
	<20070608161048.GA8147@c2.user-mode-linux.org>
	<CBFDCBBC-B5D8-4A91-9322-D63E107F38BF@oracle.com>
	<20070608163302.GA9101@c2.user-mode-linux.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <46AA734B-D157-4F9C-B238-E43031666C88@oracle.com>
From: Zach Brown <zach.brown@oracle.com>
Date: Fri, 8 Jun 2007 09:46:55 -0700
Subject: Re: [uml-devel] [PATCH] Syslets - Fix cachemiss_thread return value
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Mason <chris.mason@oracle.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> The latter - it fails the test that I posted.

OK, good.  That's easy enough to fix :)  I'll send out a tested version.

- z

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
