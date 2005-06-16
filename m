Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DiyXr-0001w9-Mh	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 10:52:51 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DiyXq-0004BO-6V	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 10:52:51 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Recent patches of note
Message-ID: <20050616174735.GB7532@ccure.user-mode-linux.org>
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<42B1B8B9.7070006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B1B8B9.7070006@fujitsu-siemens.com>
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
Date: Thu, 16 Jun 2005 13:47:35 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 16, 2005 at 07:36:57PM +0200, Bodo Stroesser wrote:
> Reading the patches
> only the one that makes me worry is "dont-save-fpregs".
> To not save fpregs on every syscall or interrupt is O.K.
> But you also have to modify signal-handling, that currently relies on
> fpregs being saved. And you have to save and restore fpregs in switch_to
> for SKAS3 and also for SKAS0, if processes share the same mm.
> Then, I think special handling is needed for the fpregs in copy_thread
> and probably in execve also.

Good points, I'll fix things accordingly.

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
