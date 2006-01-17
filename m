Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eyg8c-0000AX-Df for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:59:58 -0800
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eyg8a-0002Bc-AO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:59:58 -0800
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] high-performance system calls using vsyscall
Message-ID: <HbcrwbrtvOUs.K4FEW1N24puC7st8KrlCFA@sphinx.mythic-beasts.com>
References: <3524bf1f0601120902v3812029l4d8ba5411b53f36f@mail.gmail.com>
	<20060112233848.GA945@ccure.user-mode-linux.org>
	<200601170104.22814.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170104.22814.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 01:59:40 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Young Koh <young.koh@gmail.com>

On Tue, Jan 17, 2006 at 01:04:21AM +0100, Blaisorblade wrote:
    [...]
> However, going through ptrace for interprocess comunication is far from 
> optimal - using something like, say, POSIX message queues (it's a wild guess) 
> would be probably faster. Something purely in userspace seems difficult. 
> However, as shown below, if it's not purely in userspace ptrace will 
> intercept it, so we stop any gain.

http://caesious.beasts.org/~chris/tmp/20060117/msgq-pipe-signal-costs.png

(measured on 2.6.12.6, on Intel Xeon, with sending and
receiving processes bound to the same CPU).

So message queues don't win you much over pipes, but do
(significantly!) over signals.

-- 
``Oh my god, I was wrong! It was Earth all along!
  You've finally made a monkey out of me.''
  (`Stop the Planet of the Apes! I want to get off', from `The Simpsons')


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
