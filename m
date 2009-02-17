Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <webmaster@villagersonline.com>) id 1LZU5f-00068N-J0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Feb 2009 17:50:39 +0000
Received: from fed1rmmtao102.cox.net ([68.230.241.44])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LZU5W-0007zR-JY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Feb 2009 17:50:39 +0000
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao102.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP id
	<20090217175029.YKWQ21647.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Feb 2009 12:50:29 -0500
Message-ID: <499AAC60.2050504@villagersonline.com>
Date: Tue, 17 Feb 2009 05:24:00 -0700
From: Russell Lewis <webmaster@villagersonline.com>
MIME-Version: 1.0
Subject: [uml-devel] Nesting, and other Qs
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Welcome, all.  I played with UML a few years back (before it was in the 
mainline), and now plan to use it again for some academic research.  I'm 
sure you guys will be hearing from me over the next couple of semesters. :)

3 early questions:

- Is nesting currently working?  Do we still need to set NESTING=x, or 
is it autodetected somehow?

(I tried to nest, and it doesn't segfault, but it terminates immediately 
with "Checking syscall emulation patch for ptrace...check_sysemu : 
expecting SIGTRAP, got status = 256"

- Is there a recommended "best" level to work from?  I am currently 
using linux-2.6.28, which seems to work except or the "sigprocmask" problem.

- Looks to me like the website is way out of date.  Is there a good, 
current page or wiki where I can look things up?  I've google'd a lot, 
but everything seems a couple of years old.

Thanks!

Russ Lewis

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

