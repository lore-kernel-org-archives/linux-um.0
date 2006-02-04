Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F5KTv-0008PV-FH for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Feb 2006 02:17:27 -0800
Received: from fmmailgate04.web.de ([217.72.192.242])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F5KTr-0001Xz-OW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Feb 2006 02:17:27 -0800
Message-Id: <979918309@web.de>
MIME-Version: 1.0
From: devzero@web.de
Subject: Re: [uml-devel] AoE with UML?   have a strange problem with AoE root
Content-Type: text/plain; charset=iso-8859-1
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
Date: Sat, 04 Feb 2006 11:17:13 +0100
To: JeffDike <jdike@addtoit.com>
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

hi jeff, 

thanks for the quick response.

Jeff Dike <jdike@addtoit.com> schrieb am 04.02.06 05:15:38:
> 
> On Sat, Feb 04, 2006 at 03:07:23AM +0100, roland wrote:
> > Checking that ptrace can change system call numbers...OK
> > Checking syscall emulation patch for ptrace...missing
> > Checking PROT_EXEC mmap in /tmp...OK
> > Checking for the skas3 patch in the host:
> >   - /proc/mm...found
> >   - PTRACE_FAULTINFO...found
> >   - PTRACE_LDT...found
> > UML running in SKAS3 mode
> > ---- hangs here forever. err - why that early ? -----
> 
> Ummm, strange...
> 
> Can you double-check that the config is the same, except for the new
> AoE stuff.

yes - the only difference is the AoE-root stuff.

diff .config .config_aeoroot
4c4
< # Sat Feb  4 10:56:08 2006
---
> # Sat Feb  4 02:40:14 2006
222c222,224
< # CONFIG_ATA_OVER_ETH_ROOT is not set
---
> CONFIG_ATA_OVER_ETH_ROOT=y
> CONFIG_ATA_OVER_ETH_ROOT_SHELF=1
> CONFIG_ATA_OVER_ETH_ROOT_SLOT=1



> Also, adding stderr=1 might give you some more output.

you mean adding this to the commandline? 
mhh - doesn`t seem to make a difference.


if somewone might want to try if it behaves the same on their system, i put the working and the broken binary to

www.my-vserver.de/stuff/uml/linux.aoe_ok.bz2
www.my-vserver.de/stuff/uml/linux.aoeroot_notok.bz2

for taking a look into the relevant source, i tarred drivers/block/aoe, too :

www.my-vserver.de/stuff/uml/aoe.tar.bz2

TIA

roland

______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
