Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNbLC-00082K-65 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 11:55:58 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FNbLA-0006q1-Qd
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 11:55:58 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Resend: how to debug module on UML kernel 2.6.15.6 +
	SKAS mode?
References: <442366BA.3080902@gmail.com>
	<200603241544.23878.blaisorblade@yahoo.it>
	<44256976.9010003@gmail.com>
In-Reply-To: <44256976.9010003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261952.44368.blaisorblade@yahoo.it>
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
Date: Sun, 26 Mar 2006 19:52:43 +0200
To: mikado4vn@gmail.com
Cc: "D.Bahi" <dbahi@enterasys.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Saturday 25 March 2006 17:01, Mikado wrote:
> Thank D. Bahi and Blaisorblade for your replies.

> Blaisorblade wrote:
> > On Friday 24 March 2006 04:25, Mikado wrote:

> > What happens? Maybe gdb is stepping there but the calls are inlined and
> > it's not apparent that it's looking at source code. However I've not
> > clear what you describe, anyway.

> Sometimes gdb can't access macros included in header files and it dumped
> "some_header.h: No such file or directory". Those macros can contain
> function calls so that I cannot trace that calls. Got any ideas?

I remember this happens, but I usually ignore it so I don't know which is the 
case.

If you post the header name I'll now better.

Anyway, I'm not sure, but maybe it happens for system headers, maybe it 
happens for headers located in strange place and in this case, you can likely 
modify the source-path (where gdb looks for files) and add more header 
folders, after finding where the header is in the source tree.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
