Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-user] Re: [uml-devel] Dynamic remount with variable COW
	stacking/merging needed, support  for snapshot repilication
In-Reply-To: <20040119041049.GA21670@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0401191223310.1154-100000@gradall.private.brainfood.com>
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
Date: Mon, 19 Jan 2004 12:26:17 -0600 (CST)
To: Jeff Dike <jdike@addtoit.com>
Cc: James W McMechan <mcmechanjw@juno.com>, sdw@lig.net, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sun, 18 Jan 2004, Jeff Dike wrote:

> > A to set AIO mode
>
> I think this should be auto-detected and used.  Maybe there should be a no-AIO
> for debugging.  In any case, AIO is a lot less useful with ubd-mmap, unless
> there is an AIO way to wait to a page to be faulted in.

The problem is that you can't request multiple pages at once with mmap.  Only
one page at a time(because the page you requested will fault, which will pause
the process while the system pages it in).

With AIO, you can request multiple pages at once, and they will return in
random(or efficient) order.  AIO can actually be faster than mmap in this
case.

In fact, mmap can be slower in some cases than normal reading, if the kernel
only pages in one block at a time(because of other reasons).



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
