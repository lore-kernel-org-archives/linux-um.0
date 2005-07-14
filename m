Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt83L-0000MI-Pn	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 11:03:19 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1Dt839-0002nK-G6
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 11:03:19 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<42D6459B.6080702@fujitsu-siemens.com> <42D654F7.2080608@fujitsu-siemens.com>
In-Reply-To: <42D654F7.2080608@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507141302.57157.rob@landley.net>
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
Date: Thu, 14 Jul 2005 13:02:56 -0500
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Thursday 14 July 2005 07:05, Bodo Stroesser wrote:
> Bodo Stroesser wrote:
> > stub_segv_handler misses the "push ebp" at the beginning. As you
> > do the normally corresponding "pop eax" explicitly, I think stack
> > pointer is wrong on call of sigreturn.
> >
> > I have no idea, what makes happen this. Maybe it depends on compiler
> > version?
>
> I hope, the attached patch fixes the problem. The patch is tested in
> my 2.6.12-rc4 + skas0, where I didn't see the problem. It still works
> fine for me.
>
> Rob, could you please test whether the patch fixes the problem for you?
>
>  Bodo

I think it did.  Alas, it still dies:

VFS: Mounted root (hostfs filesystem).
cannot set up thread-local storage: cannot set up LDT for thread-local storage

But that's a failure I can understand.

Rob


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
