Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZwgY-0007MX-2d
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 10:27:42 -0800
Received: from i164-069.nv.iinet.net.au ([203.59.164.69] helo=cp.yi.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AZwgX-0004xk-Bj
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 10:27:41 -0800
Received: from erdos.home ([10.0.1.2] helo=erdos)
	by cp.yi.org with esmtp (Exim 3.36 #1 (Debian))
	id 1AZwgU-0007p3-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Dec 2003 02:27:38 +0800
Received: from cameron by erdos with local (Exim 3.36 #1 (Debian))
	id 1AZwgT-0003fq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 27 Dec 2003 02:27:37 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] UML patches against vanilla 2.6.0
Message-ID: <20031226182737.GK2378@erdos.home>
References: <200312261905.48277.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312261905.48277.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 27 Dec 2003 02:27:37 +0800
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Dec 26, 2003 at 07:05:48PM +0100, BlaisorBlade wrote:

| Go here:
| 
| http://web.tiscali.it/no-redirect-tiscali/blaisorblade/index.html

Which says:

	The only problematic patch is A-04-MM-compile-fix.patch, but
	maybe i386 can live even with it (I don't remember if I got a
	successful compilation with it applied). However, I think it's
	not at all safe even if it compiles. 

and in the README:
	
	but I think you'd better avoid doing this or do a complete
	backup, since you'll need it...).

Eeek!  I just upgraded my home desktop to a 2.6.0 kernel with that patch
applied (actually as part of Jeff's 2.6.0-test9 patch) and so far it
seems to be working.  Looking at the patch, it seems innocuous enough -
why should it be unsafe on an i386 kernel?

Cameron.

(Who doesn't have a complete system backup and hopes he won't regret not
making one soon...)



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
