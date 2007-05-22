Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HqYp6-0008Vf-5o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 May 2007 11:11:04 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HqYp2-0000KC-P7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 May 2007 11:11:02 -0700
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HqYo6-0004HE-OR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 May 2007 20:10:03 +0200
Received: from web01-l1d01-bc01.isus.emc.com ([128.221.197.21])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 May 2007 20:10:02 +0200
Received: from angilly by web01-l1d01-bc01.isus.emc.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 May 2007 20:10:02 +0200
From: Ryan Angilly <angilly@gmail.com>
Date: Tue, 22 May 2007 18:04:22 +0000 (UTC)
Message-ID: <loom.20070522T200258-554@post.gmane.org>
References: <7EDC24AB1ED682439657D3B7790609D395B358@deepthought.Elpro.local>
	<464D9713.3090904@nagafix.co.uk>
Mime-Version: 1.0
Subject: Re: [uml-devel] 2.6.18 UML machine on FC6 host
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

Do you know why exactly the kernel needs to be upgraded?  Just curious.

Antoine Martin <antoine <at> nagafix.co.uk> writes:
> > I've been trying to run UML on FC6 (kernel 2.6.20-1.2933.fc6) and appear
> > to have encountered the same issue as described in the following
> > threads:
> You need to upgrade your host kernel.
> Try 2.6.21 or >= 2.6.20.8
> 
> Antoine


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
