Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADci4-0000Q4-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 21:41:00 -0700
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ADch6-0001Sw-Iu
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 25 Oct 2003 21:40:00 -0700
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 5A9118B
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 00:39:59 -0400 (EDT)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1ADch5-00079X-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 26 Oct 2003 00:39:59 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] uml on iA-64
Message-ID: <20031026043958.GN6350@dijkstra.csh.rit.edu>
References: <OF941872B2.40FC99C5-ONC1256DCA.004792A7@mpsa.com> <200310251703.h9PH3Mkw002305@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310251703.h9PH3Mkw002305@ccure.karaya.com>
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
Date: Sun, 26 Oct 2003 00:39:58 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 25, 2003 at 01:03:22PM -0400, Jeff Dike wrote:

> pierre.gentile@mpsa.com said:
> > Has anyone tried to implement user-mode-linux (skas patch and um
> > architecture) on an Itanium IA-64 machine ? 
> 
> Not really.  I have an IA64 box sitting next to me, and starting a port to
> it is on my list once I acquire some free time.

I did some preliminary investigation into making ia64 UML-friendly as a host
(the changing syscall numbers bit), and after discovering why it won't work,
I sent pleas for help to some HP folks to find out if it would be easy to
fix.  I did get one interested response, but no reply to my followup as yet.

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
