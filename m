Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUXCg-0005Wl-OK	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:23:34 -0700
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUXCf-0008G1-6g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:23:34 -0700
From: Andi Kleen <ak@suse.de>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
	<20051025221253.21106.22572.stgit@zion.home.lan>
In-Reply-To: <20051025221253.21106.22572.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260024.17241.ak@suse.de>
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
Date: Wed, 26 Oct 2005 00:24:16 +0200
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


> No correctness issues, obviously. So this could even be merged for 2.6.14
> (I'm not a fan of this idea, though).

I don't think it's a good idea to mess with this for 2.6.14

In general the maxaligned stuff is imho bogus and should be removed. That is 
what CONFIG_X86_GENERIC is for. It doesn't make sense imho to separate
the variables in two aligned classes - either they should be aligned in 
all cases or they shouldn't.

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
