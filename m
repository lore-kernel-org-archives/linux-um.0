Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B98vL-0005ll-QE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 12:36:27 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B98vL-0008HY-64 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 12:36:27 -0800
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] RFC: lossless printk
In-Reply-To: <20040401152813.F28573@almesberger.net>
Message-ID: <Pine.LNX.4.44.0404012235500.9228-100000@filer.marasystems.com>
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
Date: Thu, 1 Apr 2004 22:36:21 +0200 (CEST)
To: Werner Almesberger <werner@almesberger.net>
Cc: Henrik Nordstrom <uml@henrik.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 1 Apr 2004, Werner Almesberger wrote:

> Hmm, I don't see what you mean. If there's a complete or partial
> write, I break to the outer loop, which adjusts "len" and "p" by
> the amount written, and repeats until we're done.

You are correct. It is just me being tired. Ignore that part of my message 
;-)

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
