Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsJ9J-0007tN-Mu for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 06:23:25 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IsJ9F-00025f-Bm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 06:23:23 -0800
Date: Wed, 14 Nov 2007 09:22:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071114142247.GA5848@c2.user-mode-linux.org>
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>
	<20071114011002.GA11477@c2.user-mode-linux.org>
	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] uml doesn't work on 2.6.24-rc2
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: tglx@linutronix.de, mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 14, 2007 at 11:35:56AM +0100, Miklos Szeredi wrote:
> Note, this is 32bit UML on 64bit host, to complicate matters.  So I
> think it's not PTRACE_ARCH_PRCTL, but PTRACE_SET_THREAD_AREA.

Oh, that changes things.  In this case, I believe this problem is fixed
by fd181c72a3c202a3986bcee7551c0838265aec2a.

You'll also need f86f9e6d66027bdcdc9b40c06d431ee53ea0d509 for a
separate problem.

> Maybe this is a fallout from the x86 architecture merge?

No, the problems had been there from before the merge - years, in the
case of the second one.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
