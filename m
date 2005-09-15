Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EG1vm-0004eD-5C	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 15:10:10 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EG1vk-0000iu-O5
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 15:10:10 -0700
Subject: Re: [uml-devel] 2.6.14-rc1 x86 on 2.6.13.1 amd64 host: guest
	segfaults
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <1126820388.1391.4.camel@localhost>
References: <1126803951.5268.39.camel@localhost.localdomain>
	 <20050915190633.GB8106@ccure.user-mode-linux.org>
	 <1126820388.1391.4.camel@localhost>
Content-Type: text/plain
Message-Id: <1126823701.1391.7.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 15 Sep 2005 23:35:01 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Here is another problem that may be of interest:
host is 2.6.13.1 amd64
guest is 2.6.14-rc1

after issuing a uml_mconsole N reboot, I got (from stdout):
" * Starting local...  [ ok ]
deactivate_all_fds failed, errno = 9

I/O possible"

And the guest just stopped there. Not sure why.

Antoine



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
