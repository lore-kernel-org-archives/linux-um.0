Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 18 Apr 2007 07:47:19 -0700
Message-ID: <AF1602CB2550CE4381C0C75118A7856BE6151C@ala-mail02.corp.ad.wrs.com>
From: "Stephens, Allan" <allan.stephens@windriver.com>
Subject: [uml-devel] Does UML Currently Emulate SMP?
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

[Apologies if you've received this twice.  My earlier posting appears to
have been lost.]

What is the status of SMP support in UML?  (That is, can I start up a
UML session that uses separate processes on my uniprocessor host to
emulate a machine with multiple CPUs?)

Jeff Dike's "User Mode Linux" text indicates that this sort of support
was once available, but it seems to have died out.  (I can't find any
way of enabling it in a 2.6.20 kernel.)  Has this capability been
dropped due to lack of interest?  If so, what was the most recent kernel
that did suppport it?

Thanks,
Al

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
