Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPpkE-0005bH-II for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 14:33:58 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPpkD-0002dI-Tv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 14:33:58 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] 2.4.23(24?)-2 TT mode hangs on request_module
In-Reply-To: <Pine.LNX.4.44.0405171722530.17607-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405172331390.27355-100000@filer.marasystems.com>
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
Date: Mon, 17 May 2004 23:33:54 +0200 (CEST)
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, 17 May 2004, Henrik Nordstrom wrote:

> On all our boxes not having the SKAS patch recent UML 2.4 kernels has
> started hanging on the first request_module call from within the kernel.

Just rebuilt with uml-patch-2.4.26-1 and the problem remains, and in 
addition there is new problems.. now hostfs fails to mount manually 
specified directories again (root works, mount does not)

More info available tomorrow.

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
