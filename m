Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IsK8M-00063s-43 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 07:26:30 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IsK8K-0002aE-Jw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Nov 2007 07:26:30 -0800
In-reply-to: <20071114142247.GA5848@c2.user-mode-linux.org> (message from Jeff
	Dike on Wed, 14 Nov 2007 09:22:47 -0500)
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>
	<20071114011002.GA11477@c2.user-mode-linux.org>
	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
	<20071114142247.GA5848@c2.user-mode-linux.org>
Message-Id: <E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 14 Nov 2007 16:26:11 +0100
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: tglx@linutronix.de, mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> > Note, this is 32bit UML on 64bit host, to complicate matters.  So I
> > think it's not PTRACE_ARCH_PRCTL, but PTRACE_SET_THREAD_AREA.
> 
> Oh, that changes things.  In this case, I believe this problem is fixed
> by fd181c72a3c202a3986bcee7551c0838265aec2a.

This one fixed the EINVAL messages, and now UML boots, but consumes
100% CPU constantly.

> You'll also need f86f9e6d66027bdcdc9b40c06d431ee53ea0d509 for a
> separate problem.

I can't find this in -linus.  Which tree is it?

> > Maybe this is a fallout from the x86 architecture merge?
> 
> No, the problems had been there from before the merge - years, in the
> case of the second one.

Never seen anything like this until 2.6.24.  Strange...

Miklos

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
