Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bl5XW-0004I2-O7 for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jul 2004 05:40:42 -0700
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bl5XW-0007Ve-5h for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jul 2004 05:40:42 -0700
Received: from [192.168.23.2] (bgm-24-94-57-251.stny.rr.com [24.94.57.251])
	by ms-smtp-01.nyroc.rr.com (8.12.10/8.12.10) with ESMTP id
	i6FCeaZx013627 for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Jul 2004 08:40:37 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
Reply-To: uml@goodmis.org
Subject: Re: [uml-devel] mount_fs bug
In-Reply-To: <Pine.LNX.4.44.0407150508220.3644-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407150838230.4568-100000@localhost.localdomain>
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
Date: Thu, 15 Jul 2004 08:44:06 -0400 (EDT)
To: User Mode Linux Development <User-mode-linux-devel@lists.sourceforge.net>

Hi again,

I found why I cant mount hostfs.  In arch/um/fs/hostfs/externfs.c the 
function hostfs_read_super is calling get_inode with the need_fh set. And 
since this is really a directory, the get_inode fails.  I changed it to 0, 
and I'm back in business.

Again, I must apologize for not supplying a patch, but again it is quite
trivial, and I have a lot of junk code in my copy and little disk space.  
If I start working on this further, I'll make sure to start sending 
patches.

Thanks,

-- Steve



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
