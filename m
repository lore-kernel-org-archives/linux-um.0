Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bcmbk-0007wq-SF for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 07:50:44 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Bcmbk-0003Kp-Dq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 07:50:44 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Kernel panic: handle_trap - failed to wait at end of
	syscall, errno = 4, status = 1151
Message-ID: <20040622154320.GA28615@ccure.user-mode-linux.org>
References: <000f01c45593$35c20e00$0201a8c0@hawk>
	<20040619173952.GA7740@ccure.user-mode-linux.org>
	<40D831B2.8060108@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D831B2.8060108@nortelnetworks.com>
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
Date: Tue, 22 Jun 2004 11:43:20 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Jun 22, 2004 at 09:18:42AM -0400, Joe Marzot wrote:
> would this be something simple like
> 
> do {
>    err = waitpid(pid, &status, WUNTRACED);
> } while ((err < 0) && (errno == EINTR));
> 

Yup, it would be that simple.

				Jeff


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
