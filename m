Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBV8Y-0007VK-AY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 01:43:50 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BBV8X-0003mk-JU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 01:43:49 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] A quick humfs HOWTO
In-Reply-To: <4074F052.20603@vgertech.com>
Message-ID: <Pine.LNX.4.44.0404081039320.7910-100000@filer.marasystems.com>
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
Date: Thu, 8 Apr 2004 10:43:47 +0200 (CEST)
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 8 Apr 2004, Nuno Silva wrote:

> In the meanwhile I'm thinking about this system and it seems that this
> will eat lots of inodes because every file will be present twice in the
> [host] filesystem with the metadata version using only a few bytes.

Indeed, so the host better use a filesystem which can handle this 
efficiently such as reiserfs if you plan on very large filesystems.

> Also every "ls -la" (if it's not cached) in UML will generate a read in
> the file's metafile file (say this 3 times quickly! eheheh). With 1000
> files in a directory thats lot's of fopen()s.

Indeed.

> Wouldn't it be better to add support for a simple DB, like sleepycat or
> CMU cyrus' project skiplist or even something lighter? This way we can
> have only 2 files in the humfs "root", the superblock and the metadataDB.

Sounds like a cool idea.

> The downsides:
> - - another linker requirement at build time;
> - - can't inspect and/or easily modify permissions with emacs. :-)

Doesn't there exists a emacs .el file for editing DB files? Exists for 
pretty much anything else so why not DB files.. should also be quite 
trivial to add a vim filter for the same. Just db4 tools required as long 
as keys & data are all ascii compatible.

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
