Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYpRg-0008Px-Bp	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 11:08:32 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYpRe-0002bq-QW	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 11:08:32 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050519180155.GA7020@ccure.user-mode-linux.org>
References: <200505180420.j4I4K5CS017303@ccure.user-mode-linux.org>
	<20050518052940.GE29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518052940.GE29811@parcelfarce.linux.theplanet.co.uk>
Subject: [uml-devel] Re: [PATCH 1/9] UML - small fixes left over from rc4
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
Date: Thu, 19 May 2005 14:01:55 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, May 18, 2005 at 06:29:40AM +0100, Al Viro wrote:
> Wrong.  If you want it to work, you need 0x80000000 here (or changed START
> in x86_64 makefile.

Oops, missed that.  That'll be in the next set of patches.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
