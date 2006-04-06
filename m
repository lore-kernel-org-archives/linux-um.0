Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRciI-0004GB-GC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 15:12:26 -0700
Received: from omx2-ext.sgi.com ([192.48.171.19] helo=omx2.sgi.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FRciH-000893-3r
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 15:12:26 -0700
From: Nathan Scott <nathans@sgi.com>
Message-ID: <20060407081148.J1110920@wobbly.melbourne.sgi.com>
References: <200604061655.k36GtMvc005146@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604061655.k36GtMvc005146@ccure.user-mode-linux.org>;
	from jdike@addtoit.com on Thu, Apr 06, 2006 at 12:55:22PM -0400
Subject: [uml-devel] Re: [PATCH 1/2] Add GFP_NOWAIT
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
Date: Fri, 7 Apr 2006 08:11:48 +1000
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-xfs@oss.sgi.com, Daniel Phillips <phillips@google.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 06, 2006 at 12:55:22PM -0400, Jeff Dike wrote:
> Introduce GFP_NOWAIT, as an alias for GFP_ATOMIC & ~__GFP_HIGH.
> 
> This also changes XFS, which is the only in-tree user of this idiom that I 
> could find.  The XFS piece is compile-tested only.

Looks fine, thanks Jeff.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
Acked-by: Nathan Scott <nathans@sgi.com>

cheers.

-- 
Nathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
