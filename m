Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPnKe-0005ff-MH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 11:59:24 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPnKe-0001XW-6P for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 11:59:24 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i4HIxMj21007
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 17 May 2004 20:59:22 +0200
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] CVS not updated?
In-Reply-To: <Pine.LNX.4.44.0405171859530.18477-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405172036290.20517-100000@filer.marasystems.com>
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
Date: Mon, 17 May 2004 20:59:22 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 17 May 2004, Henrik Nordstrom wrote:

> The more I look at the CVS tree the more confused I get.. what is
> actaually in the CVS at the moment? Looks like something like the current
> patch but based on 2.4.23 instead of 2.4.26..

Digging.. and there is some conclusions

a) The CVS tree currently seems to be 2.4.24-2

b) The CVS tree contains many deleted files which for some reason has not
been deleted in the CVS, some of which are very old, and most even have
tag versions of the newer patches even if they are not included in the
patches.

Or bottom line, the CVS tree is pretty much not suitable as source when 
building kernels, just a version repository to look into what changed when 
and only for kernels up to 2.4.24-2, and even then quite confusing due 
to the duplicate files on rearrangements.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
