Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBWkX-0005pp-HP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 03:27:09 -0700
Received: from [212.62.253.247] (helo=nepa.nlc.no ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BBWkW-0000iV-Ox for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 03:27:09 -0700
Message-ID: <64241.82.148.164.122.1081420011.squirrel@nepa.nlc.no>
In-Reply-To: <20040408095432.GA10043@axis.demon.co.uk>
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org> 
	<20040408095432.GA10043@axis.demon.co.uk>
Subject: Re: [uml-devel] A quick humfs HOWTO
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Thu, 8 Apr 2004 12:26:51 +0200 (CEST)
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> And an idea...
>
> Why not make each of the files in the metadata directory a symlink and
> store the metadata in the symlink itself?  I believe that there is room in
> the inode for short symlinks so you'll save inodes there.  Lots of
> dangling symlinks might look a bit untidy, but its a technique thats
> been used before (eg emacs session files).
>
> See http://www.charmed.com/txt/ext2.txt and in particular
>
>   Symbolic links are also filesystem objects with inodes.  They
>   deserve special mention because the data for them is stored within
>   the inode itself if the symlink is less than 60 bytes long.  It uses
>   the fields which would normally be used to store the pointers to
>   data blocks.  This is a worthwhile optimisation as it we avoid
>   allocating a full block for the symlink, and most symlinks are less
>   than 60 characters long.

What if the place you store all you data does not support symlinks (yes,
most filesystems supports symlinks, but there are a few that don't).

Stan


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
