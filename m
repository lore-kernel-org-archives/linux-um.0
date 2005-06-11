Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DhAXL-0000rk-Du	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Jun 2005 11:16:51 -0700
Received: from cobalt.cs.wisc.edu ([128.105.121.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DhAXJ-00058R-EC	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Jun 2005 11:16:51 -0700
Received: from cobalt.cs.wisc.edu (localhost [127.0.0.1])
	by cobalt.cs.wisc.edu (8.13.1/8.13.1) with ESMTP id j5BIFHFi032550
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 Jun 2005 13:15:17 -0500
Received: (from epaulson@localhost)
	by cobalt.cs.wisc.edu (8.13.1/8.13.1/Submit) id j5BIFH2B032549
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Jun 2005 13:15:17 -0500
From: Erik Paulson <epaulson@cs.wisc.edu>
Message-ID: <20050611181516.GA32532@cobalt.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] UML on Win32
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 11 Jun 2005 13:15:17 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I dusted off the UMLWin32 port a little while ago, and got it to build
with the current release of Cygwin. It's really no different than the
last version, except that this one builds, so the credit for it remains
with Chandan and the other previous authors. 

It's still based on an ancient version of UML (2.4.18-um20) and it panics
on bootup (which is better than the binaries on the umlwin32 sourceforge
page, which just do nothing for me), but it's at least a start. My plan was 
to get something that built again with 2.4, and then move on to a modern 2.6 
release and use the 2.4 patch as a reference for a starting point. 

I stuck my version of the diff here.

http://www.cs.wisc.edu/~epaulson/umlwin32/

-Erik


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
