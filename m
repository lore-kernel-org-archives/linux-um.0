Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBXJv-0003eW-IL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 04:03:43 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BBXJv-0003uO-2w
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 04:03:43 -0700
Message-Id: <200404081141.i38BfaB6001902@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] A quick humfs HOWTO 
In-Reply-To: Your message of "Thu, 08 Apr 2004 10:54:32 BST."
	<20040408095432.GA10043@axis.demon.co.uk> 
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
	<20040408095432.GA10043@axis.demon.co.uk> 
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
Date: Thu, 08 Apr 2004 07:41:36 -0400
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

ncw1@axis.demon.co.uk said:
> Why not make each of the files in the metadata directory a symlink and
> store the metadata in the symlink itself?  I believe that there is
> room in the inode for short symlinks so you'll save inodes there.

Yeah, I'll keep that in mind for a future version.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
