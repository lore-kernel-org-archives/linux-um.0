Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1mVh-0003pg-CL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 07:24:37 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1F1mVf-00028d-PG
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 07:24:37 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <84144f020601250133o1fd90c7vf05e8f17e1a51c2a@mail.gmail.com>
	<200601251557.26762.blaisorblade@yahoo.it>
	<Pine.LNX.4.58.0601251707230.8470@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0601251707230.8470@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601251624.13666.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PROBLEM] uml refuses to boot
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
Date: Wed, 25 Jan 2006 16:24:13 +0100
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 25 January 2006 16:09, Pekka J Enberg wrote:
> On Wed, 25 Jan 2006, Blaisorblade wrote:
> > So, first thing, you're still running in TT mode.

> > FYI, you should probably enable CONFIG_MODE_SKAS - it now (since 2.6.13)
> > works even on unpatched hosts, in SKAS0 mode (even if it's a bit slower
> > than SKAS3).

> > The only reason TT mode is still in is that its code is useful for
> > debugging and future extension (i.e. there's no SMP support in SKAS0/3
> > modes).

> Well, yeah, I know. I haven't been able to get the uml debug mode work
> with SKAS which is why I use TT.

With SKAS you simply do the normal "gdb ./vmlinux" rather than using the debug 
parameter - that was needed for TT only because of its weirdness (and it 
recently the ptrace proxy started being buggy too).

Make sure CONFIG_CMDLINE_ON_HOST is still disabled, because gdb seems unable 
to debug a program which ptraces itself.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
