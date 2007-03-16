Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HS2Iv-0002X5-3k for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 19:36:29 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HS2Iu-0002ab-KB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 19:36:29 -0700
Date: Thu, 15 Mar 2007 22:35:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070316023512.GB8635@c2.user-mode-linux.org>
References: <0A01463223B8164194908CAC85B66A1201A974B0@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201A974B0@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding UML system call implementation
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

On Thu, Mar 15, 2007 at 09:10:05PM +0800, Krishnappa Abhijith-A21204 wrote:
> In order to execute the system call in user space, the process is made
> to execute the system call switch on its kernel stack 
> Why this is done... ?

Because all kernel code has to run on a kernel stack.

> Also UML queues a signal ( SIGUSR ) to the process in order to make it
> run on its kernel stack... is this the only reason why UML queue system
> call ?

It appears that you are looking at the tt mode code, which is
obsolete.  If you're interested in this for it's own sake, that's
fine, but the skas side of things is much more sane.

If you're referring to system call handling, you are correct.  The
signal is solely to get the process on its kernel stack.

skas mode, until somewhat recently, did something similar to get a new
process running on its kernel stack for the first time.  Now, it just
constructs the appropriate jmpbuf by hand and longjmps to it when it
needs to run.

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
