Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt45p-0003vJ-Sg	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 06:49:37 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Dt45o-0004JI-0J	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 06:49:38 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
Message-ID: <20050714134327.GB26655@ccure.user-mode-linux.org>
References: <200507122346.40320.rob@landley.net>
	<42D504D8.1010606@fujitsu-siemens.com> <200507131647.53822.rob@landley.net>
	<42D6459B.6080702@fujitsu-siemens.com> <42D654F7.2080608@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D654F7.2080608@fujitsu-siemens.com>
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
Date: Thu, 14 Jul 2005 09:43:27 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Thu, Jul 14, 2005 at 02:05:11PM +0200, Bodo Stroesser wrote:
> I hope, the attached patch fixes the problem. The patch is tested in
> my 2.6.12-rc4 + skas0, where I didn't see the problem. It still works
> fine for me.

You're too quick for me sometimes :-)  I was just about to write up
something essentially the same...

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
