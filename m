Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B94FS-0003hA-Eb for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 07:36:54 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B94FS-0001UP-8s for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 07:36:54 -0800
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: [uml-devel] RFC: lossless printk
Message-ID: <20040401123622.D28573@almesberger.net>
References: <20040401042512.Y28573@almesberger.net>
	<Pine.LNX.4.44.0404011252320.1814-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404011252320.1814-100000@filer.marasystems.com>;
	from hno@marasystems.com on Thu, Apr 01, 2004 at 12:58:01PM +0200
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
Date: Thu, 1 Apr 2004 12:36:22 -0300
To: Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Henrik Nordstrom wrote:
> This won't work properly. What you need is something like:

Hmm, if the destination is "stuck", you should get ENOSPC or EAGAIN
in the next iteration after a partial write. Someone may make us work
particularly hard by only allowing only a few bytes at a time, but
I'm not sure printk should worry about this.

> Not sure about this.. should probably just drop the writes then and return
> an error. The console may have been hung up by various reasons, and I do
> not think this should kill the kernel.

Yes, that might be nicer.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
