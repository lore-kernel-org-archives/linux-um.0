Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BB7Yv-0004Pa-1B for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 00:33:29 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BB7Yu-0004Vs-E9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 00:33:28 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] DDD 3.3.1 + UML_2.4.24 - can't debug
In-Reply-To: <E1BB1ZH-0004xn-Ff@sc8-sf-mx1.sourceforge.net>
Message-ID: <Pine.LNX.4.44.0404070931130.22817-100000@filer.marasystems.com>
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
Date: Wed, 7 Apr 2004 09:32:54 +0200 (CEST)
To: Pedro Estrela <pedro.estrela@tagus.ist.utl.pt>
Cc: user-mode-linux-devel@lists.sourceforge.net, pedro.estrela@inesc.pt

On Wed, 7 Apr 2004, Pedro Estrela wrote:

> 1 - started "ddd linux" on the host
> 2 - i've noted the gdb pid that ddd swapned
> 3 - started program with arguments: "root=<my-root-fs> debug=parent gdb-pid=<pid>"

Try with just

  root=<rootfs> debug gdb-pid=<pid>

Also try the same on a stand-alone GDB.

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
