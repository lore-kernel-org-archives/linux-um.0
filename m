Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4kbC-00081K-0H	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 12:26:18 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E4kb7-0004v4-Q7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 12:26:18 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [-mm PATCH 14/32] um: fix-up schedule_timeout() usage
Message-ID: <20050815185428.GA5542@ccure.user-mode-linux.org>
References: <20050815180514.GC2854@us.ibm.com>
	<20050815181626.GQ2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815181626.GQ2854@us.ibm.com>
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
Date: Mon, 15 Aug 2005 14:54:28 -0400
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Aug 15, 2005 at 11:16:26AM -0700, Nishanth Aravamudan wrote:
> Description: Use schedule_timeout_interruptible() instead of
> set_current_state()/schedule_timeout() to reduce kernel size.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Acked-by: Jeff Dike <jdike@addtoit.com>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
