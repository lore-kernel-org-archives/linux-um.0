Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADX5o-000106-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 15:41:08 -0700
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ADWzi-0007bH-8x
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 25 Oct 2003 15:34:50 -0700
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id B313E206
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 18:34:47 -0400 (EDT)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1ADWzf-0006QF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 18:34:47 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] uml_switch
Message-ID: <20031025223447.GJ1538@dijkstra.csh.rit.edu>
References: <20031023181144.GU1538@dijkstra.csh.rit.edu> <Pine.LNX.4.21.0310251039390.21477-100000@ucontrol.mobiledns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0310251039390.21477-100000@ucontrol.mobiledns.com>
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
Date: Sat, 25 Oct 2003 18:34:47 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 25, 2003 at 10:42:23AM -0400, steven james wrote:

> Of course, UML itself 'just happens' to use the configured IP address
> (mildly mangled) as the MAC address for IP traffic.

...as a default if it isn't specified.

> However, it would be best to add functionality to parse the packet
> headers. Definatly NOT wanted for normal use due to efficiency issues.
> Perhaps a config option? compile time?

I think it's probably not necessary for the purpose he mentioned; matching
the MAC address is just as good (if not better).  Of course, it would be
even easier to use a tap device instead of uml_switch, and use iptables to
do the matching, which will be much more flexible.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
