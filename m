Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtTn8-0006Zu-0f for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Aug 2004 09:11:30 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BtTn7-0000Le-H1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Aug 2004 09:11:29 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Bug in hostfs
Message-ID: <20040807171133.GC7320@ccure.user-mode-linux.org>
References: <200408071859.12858.peter@dimtech.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408071859.12858.peter@dimtech.com.au>
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
Date: Sat, 7 Aug 2004 13:11:33 -0400
To: Peter Hartshorn <peter@dimtech.com.au>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Aug 07, 2004 at 06:59:12PM +1000, Peter Hartshorn wrote:
> original:
> static int access_file(char *file, int uid, int gid, int r, int w, int x,
> 
> modified:
> static in access_file(char *file, int r, int w, int x, int uid, int gid,
> 
> So, as you can see, the parameters for the function were in the wrong order.
> The order was also changed in the hostfs.h file.

Fixed, nice spotting..

				Jeff




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
