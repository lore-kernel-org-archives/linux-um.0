Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwlPk-0000IV-0G for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 13:22:48 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IwlPi-0004bA-Ar
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 13:22:47 -0800
In-reply-to: <20071126205242.GA11444@c2.user-mode-linux.org> (message from
	Jeff Dike on Mon, 26 Nov 2007 15:52:42 -0500)
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>
	<20071114011002.GA11477@c2.user-mode-linux.org>
	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
	<20071114142247.GA5848@c2.user-mode-linux.org>
	<E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>
	<20071126205242.GA11444@c2.user-mode-linux.org>
Message-Id: <E1IwlPY-0000Q7-0r@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Nov 2007 22:22:36 +0100
Subject: Re: [uml-devel] uml doesn't work on 2.6.24-rc2
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: tglx@linutronix.de, mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> On Wed, Nov 14, 2007 at 04:26:11PM +0100, Miklos Szeredi wrote:
> > This one fixed the EINVAL messages, and now UML boots, but consumes
> > 100% CPU constantly.
> 
> Can you disable NO_HZ and try the patch below, which WorksForMe (TM)?

Yes, it fixes the busy looping for me as well.  Thanks!

There's still something strange, as top shows 50% time spent in I/O
wait when UML is running.  But ps doesn't show any process in "D"
state.

Can't remember seeing this earlier.

Miklos

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
