Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200401191940.i0JJeYVW024171@ccure.user-mode-linux.org>
Subject: Re: [uml-user] Re: [uml-devel] Dynamic remount with variable COW
	stacking/merging needed, support for snapshot repilication 
In-Reply-To: Your message of "Mon, 19 Jan 2004 12:26:17 CST."
	<Pine.LNX.4.44.0401191223310.1154-100000@gradall.private.brainfood.com>
References: <Pine.LNX.4.44.0401191223310.1154-100000@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 19 Jan 2004 14:40:34 -0500
To: Adam Heath <adam@doogie.org>
Cc: James W McMechan <mcmechanjw@juno.com>, sdw@lig.net, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

adam@doogie.org said:
> The problem is that you can't request multiple pages at once with
> mmap.  Only one page at a time(because the page you requested will
> fault, which will pause the process while the system pages it in). 

No, mmap itself doesn't fault.  It fiddles some data structures and returns
immediately.  The fault happens when the page is first touched.  That's why
the ubd IO thread touches the page after a request is satified my mmap - to
fault the page in in an asynchronous way.

I would love for there to be aio page fault notification.

> In fact, mmap can be slower in some cases than normal reading, if the
> kernel only pages in one block at a time(because of other reasons). 

In a lot of cases, actually.  The tlb operations associated with changing
mappings are expensive, and can outweigh a lot of copying.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
