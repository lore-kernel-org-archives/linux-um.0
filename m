Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B96Da-0006K8-L7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 09:43:06 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B96DZ-0003nP-VX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 09:43:06 -0800
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] RFC: lossless printk
In-Reply-To: <20040401123622.D28573@almesberger.net>
Message-ID: <Pine.LNX.4.44.0404011940570.6165-100000@filer.marasystems.com>
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
Date: Thu, 1 Apr 2004 19:42:58 +0200 (CEST)
To: Werner Almesberger <werner@almesberger.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 1 Apr 2004, Werner Almesberger wrote:

> Henrik Nordstrom wrote:
> > This won't work properly. What you need is something like:
> 
> Hmm, if the destination is "stuck", you should get ENOSPC or EAGAIN
> in the next iteration after a partial write.

Yes, but the problem was that you ignored the partial write as if it had
not happened.. after a partial write you need to remember what you have
wrote and not write these again. If not you get dublicated data.

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
