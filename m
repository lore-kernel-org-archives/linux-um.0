Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBWF3-0000Cc-9j for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 02:54:37 -0700
Received: from userbb201.dsl.pipex.com ([62.190.241.201]
	helo=irishsea.home.craig-wood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBWF2-00063f-7E for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 02:54:36 -0700
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Subject: Re: [uml-devel] A quick humfs HOWTO
Message-ID: <20040408095432.GA10043@axis.demon.co.uk>
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
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
Date: Thu, 8 Apr 2004 10:54:32 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 07, 2004 at 10:07:52PM -0400, Jeff Dike wrote:
> As the readers of uml-devel are aware by now, there is a new virtual UML 
> filesystem called humfs.

Sounds like a good solution to lots of problems to me ;-)

Do you think it is easy / possible to make UML boot off a loop mounted
filesystem which is stored in humfs?  This would be an easy migration
path...

> The superblock file has the format
> 	"version <number>\nused <number>\ntotal <number>\n"
> 
> The version is currently 1.  used is set to the disk space consumed by 
> everything in the data directory.  total is set arbitrarily when you set
> up the filesystem.  It is the size of the filesystem as seen within
> UML.

Does uml actually obey this total in the superblock?  Ie does this
setting act as a quota?

And an idea...

Why not make each of the files in the metadata directory a symlink and
store the metadata in the symlink itself?  I believe that there is room in
the inode for short symlinks so you'll save inodes there.  Lots of
dangling symlinks might look a bit untidy, but its a technique thats
been used before (eg emacs session files).

See http://www.charmed.com/txt/ext2.txt and in particular

  Symbolic links are also filesystem objects with inodes.  They
  deserve special mention because the data for them is stored within
  the inode itself if the symlink is less than 60 bytes long.  It uses
  the fields which would normally be used to store the pointers to
  data blocks.  This is a worthwhile optimisation as it we avoid
  allocating a full block for the symlink, and most symlinks are less
  than 60 characters long.

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
