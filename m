Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPrsH-0000VP-SS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 16:50:25 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPrsH-00039o-Bm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 16:50:25 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] 2.4.24-2 UML problems with hostfs ClearCase mounts
In-Reply-To: <40A8DC43.5060001@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com>
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
Date: Tue, 18 May 2004 01:50:12 +0200 (CEST)
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 17 May 2004, Joe Marzot wrote:

> A little more data on this one - the behaviour I see with these mounts 
> is that
> 
> mount -t hostfs none /mnt/mybob -o /view/myview/vob/myvob
> 
> succeeds but mounts the hosts / dir instead of the desired view extended 
> pathname of the ClearCase vob.

This is a known bug in 2.4.24-2. A patch can be found in the archives or 
from http://marasystems.com/download/uml/

If you need hostfs then you should probably stick to 2.4.24-1 for the time
being. Jeff is doing some heavy restructuring of the uml host file access
methods while adding the humfs and as a result of this the hostfs support
has become very unstable while the combined supporting framework for humfs
and hostfs is taking shape. Hopefully this will soon result in a much 
better hostfs than before, but at the moment things is a bit shaky..

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
