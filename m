Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOcbB-0000ON-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 25 Nov 2003 04:47:21 -0800
Received: from thor.65535.net ([216.17.104.19])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AOcbB-0000Tv-6s
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 25 Nov 2003 04:47:21 -0800
From: Rus Foster <rghf@fsck.me.uk>
Subject: Re: [uml-devel] Uml_tools compile error
In-Reply-To: <3507.1069763498@www12.gmx.net>
Message-ID: <Pine.LNX.4.58.0311251248060.32099@bitch.localdomain>
References: <20031124.190229.-373069.0.mcmechanjw@juno.com>
 <3507.1069763498@www12.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 25 Nov 2003 12:48:16 +0000 (GMT)
To: Thonix@gmx.net
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 25 Nov 2003 Thonix@gmx.net wrote:

> Can sombody sel me what this message mean?
>
> test:~/uml/test/tools# make
> set -e ; for dir in jail jailtest mconsole moo port-helper tunctl uml_net
> uml_router watchdog; do make -C $dir all; done
> make[1]: Entering directory `/root/uml/test/tools/jail'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/root/uml/test/tools/jail'
> make[1]: Entering directory `/root/uml/test/tools/jailtest'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/root/uml/test/tools/jailtest'
> make[1]: Entering directory `/root/uml/test/tools/mconsole'
> cc -g -Wall   -c -o uml_mconsole.o uml_mconsole.c
> uml_mconsole.c:17: readline/readline.h: No such file or directory
> uml_mconsole.c:18: readline/history.h: No such file or directory

readline-devel actually

soz

Rus
-- 
w: http://www.jvds.com  | JVDS Tech Channel:
e: rghf@jvds.com        | http://tech.jvds.com
t: +44 7919 373537	| Talk about Tech
t: 1-888-327-6330 	| email: sales@jvds.com




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
