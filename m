Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B96va-0008Pv-6j for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 10:28:34 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B96vZ-0004Wq-Vv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 10:28:34 -0800
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: [uml-devel] RFC: lossless printk
Message-ID: <20040401152813.F28573@almesberger.net>
References: <20040401123622.D28573@almesberger.net>
	<Pine.LNX.4.44.0404011940570.6165-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404011940570.6165-100000@filer.marasystems.com>;
	from uml@henrik.marasystems.com on Thu, Apr 01, 2004 at
	07:42:58PM +0200
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
Date: Thu, 1 Apr 2004 15:28:13 -0300
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Henrik Nordstrom wrote:
> Yes, but the problem was that you ignored the partial write as if it had
> not happened.. after a partial write you need to remember what you have
> wrote and not write these again. If not you get dublicated data.

Hmm, I don't see what you mean. If there's a complete or partial
write, I break to the outer loop, which adjusts "len" and "p" by
the amount written, and repeats until we're done.

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
