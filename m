Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bbj0S-0003q8-QK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:47:52 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Bbj0S-0000Ez-Aj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:47:52 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Kernel panic: handle_trap - failed to wait at end of
	syscall, errno = 4, status = 1151
Message-ID: <20040619173952.GA7740@ccure.user-mode-linux.org>
References: <000f01c45593$35c20e00$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c45593$35c20e00$0201a8c0@hawk>
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
Date: Sat, 19 Jun 2004 13:39:52 -0400
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Jun 18, 2004 at 07:19:57PM -0500, Christopher S. Aker wrote:
> Kernel panic: handle_trap - failed to wait at end of syscall, errno = 4, status =
> 1151
> 
>         err = waitpid(pid, &status, WUNTRACED);
>         if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
>                 panic("handle_trap - failed to wait at end of syscall, "
>                       "errno = %d, status = %d\n", errno, status);

Easy diagnosis - errno 4 is EINTR, this wasn't checking for that and redoing
the wait.

I've been adding EINTR safety in a bit at a time, just hadn't noticed this
yet.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
