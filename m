Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiBQf-0005p1-UZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 09:07:34 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IiBQf-0000uj-Bo
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 09:07:29 -0700
Date: Wed, 17 Oct 2007 12:07:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071017160718.GG9497@c2.user-mode-linux.org>
References: <BLU102-W37724FC51969103D82EFACA9A10@phx.gbl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BLU102-W37724FC51969103D82EFACA9A10@phx.gbl>
Subject: Re: [uml-devel] accessing host resources from inside the UML kernel
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
To: madiyaan@fastmail.fm
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 13, 2007 at 04:56:39AM +0000, Ahmad Sharif wrote:
> I know this might be counter-intuitive and completely in the
> opposite direction of what people use UML for, but I have a question
> regarding accessing host's files from within UML (from the UML kernel,
> not user). Having said that, this is what I want: 

I've long advocated taking a more flexible view about sharing
resources between UML and the host.

> I want to write a kernel module that I load from inside a running
> UML using insmod that will be able to call functions like mmap(),
> ftok() etc. Here is the important part: these functions should use
> the *host's* kernel, not the UML's. This is because I want to do
> some IPC with another regular process that is running on the
> host. Here is the summary of what I want to do: the host is running
> one regular process and UML, and from within the UML's kernel, I
> want to access the host's resources (like shared files and such). 

If you write a kernel module and stick it into UML, any system calls
that it makes will operate on the host, not UML.  This is the
difference between UML kernel mode and user mode - userspace has its
system calls intercepted and run inside UML, while kernelspace has its
system calls run on the host.

> If I compile a program from within UML and use the function mmap(),
> it will link to mmap() implementation that is virtualized by
> UML. Instead, I want the real mmap() function (the host's mmap()
> function). Obviously because of UML's design this shouldn't be
> possible from the user-space within UML... I am aware of that, which
> is why I said that my UML kernel module will have this functionality
> of doing IPC with another process running on the host. 

A module will automatically do what you want.

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
