Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] A quick humfs HOWTO
In-Reply-To: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0404081027360.7910-100000@filer.marasystems.com>
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
Date: Thu, 8 Apr 2004 10:35:48 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Wed, 7 Apr 2004, Jeff Dike wrote:

> The root contains two directories :
> 	data - which contains the files
> 	metadata - which shadows "data" and whose files contain ownership 
> 		information
> and one file
> 	superblock - which contains information about the filesystem as a 
> 		whole


Can data be a symlink on the host?

I would suggest adding an option to optionally allow specifying the path
to data, this to allow humfs permission shadows to easily be created of
existing trees. If data can be a symlink this option can be managed in
humfsify.


Also, what happens if there is a mismatches between metadata and data
content?

> The superblock file has the format
> 	"version <number>\nused <number>\ntotal <number>\n"
> 
> The version is currently 1.  used is set to the disk space consumed by 
> everything in the data directory.  total is set arbitrarily when you set
> up the filesystem.  It is the size of the filesystem as seen within UML.

Great!

I wouldsuggest adding a read-only flag, preventing UML from mounting the 
directory read-write.

> user and group are the uid and gid that UML will be running as, respectively.

How is this information used by humfsify? Can these be made optional (then 
use current uid/gid, or don't care)

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
