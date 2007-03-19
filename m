Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTLsW-0006A9-4z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:42:40 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTLsV-0001EA-Lk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:42:40 -0700
Date: Mon, 19 Mar 2007 13:40:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070319174038.GB11790@c2.user-mode-linux.org>
References: <0A01463223B8164194908CAC85B66A1201AD3E57@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201AD3E57@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding context switching in UML.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Krishnappa Abhijith-A21204 <abhijith@motorola.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 19, 2007 at 11:01:40AM +0800, Krishnappa Abhijith-A21204 wrote:
>         Regarding Context switching in UML.
> Each process running in UML will have corresponding process in HOST.

In tt and skas0 mode, roughly yes.

> So when the context switching in HOST happens, UML has to switch the
> corresponding UML process by saving context etc...
> will this be done by tracing thread.... Also how does process running in
> HOST notifies UML to switch ?

It does so by calling the UML's schedule().

The actual context switching is done by the outgoing process sleeping
after waking up the incoming process.

In tt mode, this is done by using a pipe as a semphore.  A sleeping
process is sleeping in read on a pipe, and will be woken up when an
outgoing process writes a byte into the other end.

> Also I've read in one of the article that UML schedules its process by
> itself..? How this is done ?

It has its own scheduler.

The fact that you ask this question, and that you seem to think there
is some sort of special relationship between UML and the host kernel,
suggests that you have some basic misunderstandings.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
