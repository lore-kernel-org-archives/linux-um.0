Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBWRn-0001wT-5y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 03:07:47 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBWRm-000156-FS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 03:07:46 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] A quick humfs HOWTO
In-Reply-To: <20040408095432.GA10043@axis.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0404081201120.8462-100000@filer.marasystems.com>
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
Date: Thu, 8 Apr 2004 12:07:38 +0200 (CEST)
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 8 Apr 2004, Nick Craig-Wood wrote:

> Do you think it is easy / possible to make UML boot off a loop mounted
> filesystem which is stored in humfs?  This would be an easy migration
> path...

Eh? Why a loop mounted filesystem for humfs? The whole point of humfs is
to be able to emulate full UNIX semantics including ownership,
permissions, filesystem size etc ontop of a plain file tree without
requiring root on the host..

If you want performance then ubd devices is the path to go.

Please elaborate on what you envision being able to do. Probably I just
misunderstood something.

> Why not make each of the files in the metadata directory a symlink and
> store the metadata in the symlink itself?  I believe that there is room in
> the inode for short symlinks so you'll save inodes there.  Lots of
> dangling symlinks might look a bit untidy, but its a technique thats
> been used before (eg emacs session files).

Good idea for optimization on ext2/ext3 host filesystems.

For host filesystems such as reiserfs there is no difference as the same
kind of optimisation is done on small files as well there (provided the
notail option is not used)

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
