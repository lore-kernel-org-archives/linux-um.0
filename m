Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HU3Am-0002hQ-8N for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 08:56:34 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HU3Aj-0002rW-Ff
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 08:56:24 -0700
Date: Wed, 21 Mar 2007 11:54:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070321155409.GB6962@c2.user-mode-linux.org>
References: <20070321135510.GC5398@c2.user-mode-linux.org>
	<0A01463223B8164194908CAC85B66A1201B0F107@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201B0F107@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding Process creation in UML tracing thread mode
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

On Wed, Mar 21, 2007 at 10:11:48PM +0800, Krishnappa Abhijith-A21204 wrote:
> Also from your below response it means that: UML just have a
> task_structure maintained....
> Also I never saw the UML specific schedule() code in .../arch/um does
> UML uses the host schedule itself ?

UML, like any other port, uses the schedule() in kernel/sched.c.  The
UML-specific context switching indirectly uses the host's scheduler
when it switches from one host process to another.  TT mode has the
outgoing process sleeping in a read() on a pipe after waking up the
incoming process from its read by writing a byte down its pipe.

But the host makes no scheduling decisions between UML processes - the
UML scheduler makes the decisions and the host scheduler just decides
when the process chosen by the UML scheduler actually gets some CPU
time.

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
