Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AKKZF-0005lS-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 13 Nov 2003 08:43:37 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AKKZE-0008QM-Tn
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 13 Nov 2003 08:43:37 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 6AD38168
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 13 Nov 2003 11:43:31 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AKKZ9-0000Oa-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 13 Nov 2003 11:43:31 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] UML on 2.6.0-test9 host
Message-ID: <20031113164331.GS9377@dijkstra.csh.rit.edu>
References: <20031113015758.GS22490@blabluga.hell.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113015758.GS22490@blabluga.hell.pl>
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
Date: Thu, 13 Nov 2003 11:43:31 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 13, 2003 at 02:57:58AM +0100, Artur R. Czechowski wrote:

> I would like to exercise a benefits from user-mode-linux, so I installed it
> and... the saga begins.
> 
> I am using Debian unstable, kernel 2.6.0-test9 and debianized
> user-mode-linux, version 2.4.22-5um-1. It looks like running uml in this
> configuration is impossible. However it boots properly after some time it
> displays message:
> I'm tracing myself and I can't get out
> and it hangs up.
> Only I can do is ``killall linux''.

One other person has reported this now:

http://bugs.debian.org/220526

who is also using a 2.6.x kernel.  Perhaps this is a 2.6 problem?

-- 
 - mdz


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
