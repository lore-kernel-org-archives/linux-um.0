Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUYHF-0000Is-79	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 16:32:21 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUYHD-00079D-OY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 16:32:21 -0700
From: Andi Kleen <ak@suse.de>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
	<200510260024.17241.ak@suse.de> <200510260044.26138.blaisorblade@yahoo.it>
In-Reply-To: <200510260044.26138.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260133.03425.ak@suse.de>
Subject: [uml-devel] Re: [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for Intel
	EM64T [for 2.6.14?]
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
Date: Wed, 26 Oct 2005 01:33:03 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 26 October 2005 00:44, Blaisorblade wrote:

> For what I see, that's based on the tradeoff between space and contention -
> for instance there are few zones only, so there's no big waste.

If space is precious it shouldn't be padded at all.

> In  practice, interpreting !X86_GENERIC as "I will run this kernel on _this_
> processor" could also be done.

That is what it always meant yes.

> However, in case you didn't note, max_align is never enough on EM64T
> currently, right?

I will prepare patches for .15 to remove it completely, that should fix that 
problem.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
