Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFgfP-0002CC-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 13:18:47 -0800
Received: from [217.73.128.98] (helo=linuxhacker.ru ident=[0huqSDrnYUIPAUkLlo/96IdnrrgJ/H7t])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AFgfN-000064-QY
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 31 Oct 2003 13:18:46 -0800
Message-Id: <200310312118.h9VLINgN006672@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] Possible to run RH Install?
References: <3FA2BB1D.7060402@deming-os.org>
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
Date: Fri, 31 Oct 2003 23:18:23 +0200
To: spamhole-gnu@deming-os.org, user-mode-linux-devel@lists.sourceforge.net

"Russ Lewis" <spamhole-gnu@deming-os.org> wrote:
RL> I played around with trying to run RedHat's net install process under
RL> uml.  I get a little way into the initial download and then it fails,
RL> but I can't figure out why.  I'm looking to see if anybody else has done
RL> this and might know what I'm up against.

You might want to take a look at my howto at
http://linuxhacker.ru/uml
with newer 2.4.22-5um UMLs, it is probably even unneded to create
a modified stage2.img, so you theoretically should be able
to install of redhat's ftp server.

Bye,
    Oleg


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
