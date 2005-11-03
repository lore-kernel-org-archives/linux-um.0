Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20051103052649.GA16508@ccure.user-mode-linux.org>
References: <1130917338.14475.133.camel@localhost>
	<20051102172729.9E7C.Y-GOTO@jp.fujitsu.com>
	<43687C3D.7060706@yahoo.com.au>
	<200511021728.36745.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511021728.36745.rob@landley.net>
Subject: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
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
Date: Thu, 3 Nov 2005 00:26:49 -0500
To: Rob Landley <rob@landley.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, user-mode-linux-devel@lists.sourceforge.net, Yasunori Goto <y-goto@jp.fujitsu.com>, Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lhms <lhms-devel@lists.sourceforge.net>

On Wed, Nov 02, 2005 at 05:28:35PM -0600, Rob Landley wrote:
> With fragmentation reduction and prezeroing, UML suddenly gains the option of 
> calling madvise(DONT_NEED) on sufficiently large blocks as A) a fast way of 
> prezeroing, B) a way of giving memory back to the host OS when it's not in 
> use.

DONT_NEED is insufficient.  It doesn't discard the data in dirty
file-backed pages.

Badari Pulavarty has a test patch (google for madvise(MADV_REMOVE))
which does do the trick, and I have a UML patch which adds memory
hotplug.  This combination does free memory back to the host.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
