Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHTd-0004aI-Vv
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:15:29 -0800
Received: from i164-068.nv.iinet.net.au ([203.59.164.68] helo=cp.yi.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYHTc-0005et-Su
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 20:15:29 -0800
Received: from erdos.home ([10.0.1.2] helo=erdos)
	by cp.yi.org with esmtp (Exim 3.36 #1 (Debian))
	id 1AYHTZ-0008FE-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 22 Dec 2003 12:15:25 +0800
Received: from cameron by erdos with local (Exim 3.36 #1 (Debian))
	id 1AYHTX-0000og-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 22 Dec 2003 12:15:23 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] UML on Alpha
Message-ID: <20031222041523.GA1023@erdos.home>
References: <20031220052032.GC1152@erdos.home> <200312211644.39563.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312211644.39563.blaisorblade_spam@yahoo.it>
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
Date: Mon, 22 Dec 2003 12:15:23 +0800
To: user-mode-linux-devel@lists.sourceforge.net

On Sun, Dec 21, 2003 at 04:44:38PM +0100, BlaisorBlade wrote:

| Are you working on 2.4 or 2.6? I'd suggest the second choice, since otherwise 
| you'll have to duplicate part of the work(recheck patches...). It is true 
| than 2.6 still waits for some patches applied to 2.4, so you may get some 
| more troubles(module loading still doesn't work in the vanilla tree, but 
| search in the archives a few days ago for an up-to-date patch I posted and 
| disable MODVERSIONS). But by the time you finish the porting, I think(or 
| hope) that development will have moved to 2.6.

I've been working on 2.4 so far.  I'm not running 2.6 on any machine at
all ATM, and from the sounds of this mailing list, you can't run a 2.6
UML on a 2.4 host?  Also, the Alpha is running Debian woody at the
moment, and I'm not sure how well that copes with a 2.6 kernel.

But thanks for the advice, and I will look at porting 2.6 since it would
probably be less painful in the long run.

Cameron.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
