Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQYxP-0001qX-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 30 Nov 2003 13:18:19 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AQYxO-0000mD-CD
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 30 Nov 2003 13:18:18 -0800
Message-ID: <05a201c3b788$12caed30$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0311280940300.3315-100000@filer.marasystems.com>
Subject: Re: [uml-devel] How to copy COW files to another machine across the network?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sun, 30 Nov 2003 22:22:34 +0100
To: Henrik Nordstrom <hno@marasystems.com>, Shao-Lin Joseph Chung <sc57@cs.waikato.ac.nz>
Cc: UML User list <user-mode-linux-user@lists.sourceforge.net>, UML Devel list <user-mode-linux-devel@lists.sourceforge.net>

hi!
> You can't move COW files around 
but i`d like to move around my uml`s!
hey - this is one of the uml benefits: you have a virtual machine which 
is independent from hardware and is _generally_ quite "relocateable".
if it would have swsusp - i could even relocate a running instance - like
i can do with vmware.
why was that relocateability being made difficult artificially by putting 
that "features" into COW? is this "problem" going to be adressed?
regards
roland


----- Original Message ----- 
From: "Henrik Nordstrom" <hno@marasystems.com>
To: "Shao-Lin Joseph Chung" <sc57@cs.waikato.ac.nz>
Cc: "UML User list" <user-mode-linux-user@lists.sourceforge.net>; "UML Devel list" <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, November 28, 2003 9:49 AM
Subject: Re: [uml-devel] How to copy COW files to another machine across the network?


> On Fri, 28 Nov 2003, Shao-Lin Joseph Chung wrote:
> 
> > As the subject says, I'm trying to copy the COW files across the network. 
> > But the size of those copies got expanded to the same size of the backing
> > file.
> 
> You can't move COW files around unless you make a tool to adjust the COW
> file header after the move. If not UML will disregard the COW file as
> invalid and revert to the backing file copy.. UML checks that the 
> following parameters match the backing file
>   * Full file name including path
>   * File size
>   * Modification timestamp
> 
> Regarding the size: You need to use a copying tool which accounts for 
> holes in the file. See for example the --sparse option to cp.
> 
> Regards
> Henrik
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
