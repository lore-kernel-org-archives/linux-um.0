Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BONKa-0002ZH-9J for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 14:01:28 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BONKa-0004jx-4R for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 May 2004 14:01:28 -0700
Message-ID: <40A3E217.2080104@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml-patch-2.4.24-3
References: <200405122208.i4CM8cCe008920@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 13 May 2004 17:01:11 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> This patch contains a ton of hostfs/humfs work.  
> 
> The kernel infrastructure that was in hostfs_kern.c was made asynchronous, 
> cleaned up, and many bugs fixed.  It was also renamed to externfs.  The old
> hostfs_user.c is now host_fs.c.  Previously, there were a number of bugs
> conspiring to make hostfs completely synchronous, so you could read a file
> in, change it from the host, read it again, and see the new contents.  This
> is now very likely not to work. 

I wonder based on what you say here if two UMLs that hostfs mount the 
same directory and access the same file...one for reading, and the other 
for writing, if the first will see the updates written by the 
second....or maybe I am misinterpretting.

??

thanks, Giovanni






-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
