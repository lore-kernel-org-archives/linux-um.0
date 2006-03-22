Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FM5SQ-0004f1-VW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 07:41:10 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FM5SQ-0001CM-Hk
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 07:41:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Cannot debug UML
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX>
	<44215B8F.6060400@gmail.com>
In-Reply-To: <44215B8F.6060400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221640.50362.blaisorblade@yahoo.it>
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
Date: Wed, 22 Mar 2006 16:40:49 +0100
To: user-mode-linux-devel@lists.sourceforge.net, mikado4vn@gmail.com
Cc: stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 15:13, Mikado wrote:
> Stefano Melchior wrote:
> > On Wed, Mar 22, 2006 at 08:32:48PM +0700, Mikado wrote:
> > Hi Mikado,

> Debugging UML requires running it under TT mode. Normally I run UML
> under SKAS mode, everything is OK. I cannot get into GDB under SKAS mode
> whenever I use 'debug' option.

debug is an ugly trick for TT-only.

For SKAS mode use the normal debug sequence:

$ gdb vmlinux
(gdb) <set breakpoints, do what you want>
(gdb) run <params>

More info at the "debugging UML" link, "SKAS" subsection on the main site.
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
