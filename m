Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v2uO-0005wM-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 15:48:56 -0700
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19v2uN-0006XX-Iv
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 15:48:55 -0700
Message-ID: <3F57C169.3050303@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Creating virtual consoles on the fly
References: <10C160F5A03A0942A1A87B658784CA6A0976D2@gummo.domain.trailerparc.com>
In-Reply-To: <10C160F5A03A0942A1A87B658784CA6A0976D2@gummo.domain.trailerparc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 04 Sep 2003 23:49:13 +0100
To: Michael Talyansky <michaelt@doublewidesoft.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi!

Michael Talyansky wrote:
> This is the result of "openvt -l bash":
> 
> Couldnt get a file descriptor referring to the console
> Could not get a file descriptor referring to the console
> 
> If I run /sbin/mingetty with a new console tty (say, ttys/2), the
> virtual console xterm does come up, but then mingetty terminates, and no
> login process is run for the new console. Could someone tell me what am
> I doing wrong?


Maybe you didn't configure any "consoles" in the command line?

Read this:
http://user-mode-linux.sourceforge.net/input.html

Regards,
Nuno Silva



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
