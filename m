Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AANbd-0001oD-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 22:56:57 -0700
Received: from tsv.sws.net.au ([61.95.69.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AANaK-0003wA-N0
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 16 Oct 2003 22:55:36 -0700
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Re: [uml-devel] Hardening hostfs
References: <3F8F7C06.7080306@easyco.com>
In-Reply-To: <3F8F7C06.7080306@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171552.29026.russell@coker.com.au>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 17 Oct 2003 15:52:29 +1000
To: Doug Dumitru <doug@easyco.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 17 Oct 2003 15:20, Doug Dumitru wrote:
> o Run UML in a chroot jail.

There are a variety of other security systems which UML can be run under.  My 
SE Linux policy for UML greatly restricts which files it can access on the 
host (and could be made far more restrictive if you wanted to remove the 
xterm option).

Systrace, RSBAC, or GRSEC could also be used in a similar manner.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
