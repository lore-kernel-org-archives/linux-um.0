Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AjjQw-00077P-58 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 10:20:02 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AjjQv-0003bP-If
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 10:20:01 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [patch] uml fixes, 2.6.1-mm5-A2
Message-ID: <20040122184236.GB3317@ccure.user-mode-linux.org>
References: <20040120191706.GA32711@elte.hu> <20040120194328.GA1518@elte.hu>
	<20040120200105.GA2289@elte.hu> <20040122162139.GA28167@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122162139.GA28167@elte.hu>
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
Date: Thu, 22 Jan 2004 13:42:36 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 22, 2004 at 05:21:39PM +0100, Ingo Molnar wrote:
> the patch below fixes a bug in UML that i've reproduced under 2.6.1-mm5. 
> 
> The bug hits in the following race scenario: if userspace() is just
> about to handle a SIGTRAP signal that it wants to relay_signal(), and
> SIGVTALRM hits the context before this happens but after is_user is set
> to 1 in userspace(), then we get a kernelspace-signal panic. Ought to be
> rare but definitely triggerable.

Applied, nice catch.

			Jeff


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
