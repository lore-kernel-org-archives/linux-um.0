Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F7LLV-0003BR-Kq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Feb 2006 15:37:05 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F7LLU-0005Lw-6z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Feb 2006 15:37:05 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
Message-ID: <20060209233811.GA11003@ccure.user-mode-linux.org>
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200501282010.50020.blaisorblade@yahoo.it>
	<3524bf1f0602091408j6d9fe7b4tbae6dddf46919e14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f0602091408j6d9fe7b4tbae6dddf46919e14@mail.gmail.com>
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
Date: Thu, 9 Feb 2006 18:38:11 -0500
To: Young Koh <young.koh@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 09, 2006 at 05:08:59PM -0500, Young Koh wrote:
> I have a question about system call implementation in tt mode. it
> seems that an invoked system call will be executed in tracee's
> context. (the tracer sends SIGUSR2 to the tracee and tracee executes
> the system call in usr2_handler) however, 'current' macro, which is
> used to find the current task structure, would only work in Kernel
> mode stack (which i assume is the tracer's stack), cause the current
> task structure is at the bottom of the kernel stack. then, how the
> system calls can be executed in tracee's context?

The SIGUSR2 on the process kernel stack, in the UML kernel, due to the
kernel stack being registered as the signal stack for SIGUSR2.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
