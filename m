Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0LLV-00085X-Qa	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 08:39:53 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E0LLU-0006CR-Hx
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 08:39:53 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Host kernel requirements for UML
Message-ID: <20050803143957.GB4701@ccure.user-mode-linux.org>
References: <20050803094805.GA6090@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803094805.GA6090@in.ibm.com>
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
Date: Wed, 3 Aug 2005 10:39:57 -0400
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 03, 2005 at 03:18:05PM +0530, Srivatsa Vaddagiri wrote:
> Hi,
> 	I am trying to get a quick answer for a question I had on UML.
> As I understand, UML kernel makes use of host kernel's 
> system call interface for its functionality. The questions is, does the
> host kernel need to support *all* system calls or only a subset?

Only a small subset.

> Does UML rely on /proc or any other such filesystems on host?

It looks at /proc/cpuinfo for some information about cmov and xmm support
on the processor.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
