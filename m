Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFVW8-0000wD-LF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 02:56:44 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BFVW7-00082E-T3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 02:56:44 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i3J9ugM17564
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Apr 2004 11:56:42 +0200
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] Thoughts on HUMFS and metadata
In-Reply-To: <Pine.LNX.4.44.0404191058380.16955-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0404191106340.17224-100000@filer.marasystems.com>
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
Date: Mon, 19 Apr 2004 11:56:42 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 19 Apr 2004, Henrik Nordstrom wrote:

> On Mon, 19 Apr 2004, Paul Wagland wrote:
> 
> > 2. When COW humfs "partitions" are made, will it be possible to  
> > separately copy metadata and data?
> 
> This makes me remember the Overlay Filesystem 
> <url:http://ovlfs.sourceforge.net>. 

Looked around a little and there is several of these..

ovlfs Overlay Filesystem
<url:http://ovlfs.sourceforge.net>

translucency lkm
<url:http://translucency.sourceforge.net/>

mini_fo Mini Fan-Out filesystems
<url:http://www.denx.de>
There is also a good technical paper on the subject.


Of these the mini_fo looks very promising.


A nice collection on information regarding overlay or template filesystems
can also be found at the TBVFS Virtual Gathering
<url:http://vserver.13thfloor.at/TBVFS/>

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
