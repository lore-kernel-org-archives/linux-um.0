Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vKv2-00087Q-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 11:02:48 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vKv2-0000MT-DM
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 11:02:48 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19vKv1-0003n6-00
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 14:02:47 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19vKv1-0000Gg-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 14:02:47 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] hostfs as root
Message-ID: <20030905180247.GU11825@alcor.net>
References: <20030905161301.GT11825@alcor.net> <28005.1062783473@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28005.1062783473@marajade.sandelman.ottawa.on.ca>
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
Date: Fri, 5 Sep 2003 14:02:47 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 05, 2003 at 01:37:53PM -0400, Michael Richardson wrote:

>   If you have a simple /sbin/mount that you can recommend that solves my
> problem, I will consider using it.

The fact that you said it broke _potato_'s mount, specifically, led me to
believe that newer versions did not do this (they do).

However, the fix to mount is trivial, so you can easily create an
/sbin/mount which should work.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
