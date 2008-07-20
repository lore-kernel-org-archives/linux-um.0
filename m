Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKb5U-0003bc-Jn for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 08:44:40 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KKb5T-0003vK-5Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 08:44:40 -0700
Date: Sun, 20 Jul 2008 11:44:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080720154420.GA6244@c2.user-mode-linux.org>
References: <20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
	<20080710170210.GB18429@c2.user-mode-linux.org>
	<5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
	<20080714144612.GA5751@c2.user-mode-linux.org>
	<5df78e1d0807160252j1b610c41la1a2f5092ae04be7@mail.gmail.com>
	<5df78e1d0807162155t594936c9qe5bc1616fae97f77@mail.gmail.com>
	<20080718205342.GE13572@c2.user-mode-linux.org>
	<20080720152022.GE1520@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080720152022.GE1520@inferi.kami.home>
Subject: Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down() on	a
	semaphore with zero counter
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Mattia Dongili <malattia@linux.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jiaying Zhang <jiayingz@google.com>

On Mon, Jul 21, 2008 at 12:20:22AM +0900, Mattia Dongili wrote:
> it's not entirely clear to me why, but that patch fixes a segfault that
> I experience when booting uml 2.6.25 built with gcc-4.3 on a 2.6.25
> host (I also applied your ICE workaround patch).

Hmmm, get a stack trace from it and let's see what's going on.

Presumably, you're not doing kernel development, just building a stock UML?

	    	       	     Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
