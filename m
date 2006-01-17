Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EygkO-0002LC-51 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:39:00 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EygkM-0008U5-QA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:39:00 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] high-performance system calls using vsyscall
Message-ID: <20060117033055.GA17171@ccure.user-mode-linux.org>
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
Date: Mon, 16 Jan 2006 22:30:55 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Tue, Jan 17, 2006 at 01:04:21AM +0100, Blaisorblade wrote:
> No, wrong - on x86 it's used for everything, depending on userspace (it's 
> replacing int 0x80 with sysenter). For some reason, on x86-64 it was that 
> way, but it switched to what you say (implementing only a few syscalls 
> directly in userspace).

Yeah, I was remembering Andrea's original proposal to implement a few system
calls entirely in userspace.

> > In a tt-style UML, where the UML kernel is in the same address space
> > as the process, this could be used for all system calls, where you
> > would just jump from there into the UML kernel.
> 
> 1st, TT mode is kept there only until SKAS0 will be damn stable (it seems 
> we're probably reaching that, no foreseen problems, except maybe my new TLS 
> code doesn't work for SKAS0 yet IMHO), and because it's the only SMP 
> supporting mode.

It has worked fine for me since I fixed that one bug.

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
