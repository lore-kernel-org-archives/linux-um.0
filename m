Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] How to copy COW files to another machine across the
 network?
In-Reply-To: <05a201c3b788$12caed30$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0311302233440.4256-100000@filer.marasystems.com>
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
Date: Sun, 30 Nov 2003 22:37:47 +0100 (CET)
To: roland <for_spam@gmx.de>
Cc: Shao-Lin Joseph Chung <sc57@cs.waikato.ac.nz>, UML User list <user-mode-linux-user@lists.sourceforge.net>, UML Devel list <user-mode-linux-devel@lists.sourceforge.net>

On Sun, 30 Nov 2003, roland wrote:

> but i`d like to move around my uml`s!

Then as I said you (or someone else) needs to write the tool required to 
adjust the COW header after the move.

> hey - this is one of the uml benefits: you have a virtual machine which 
> is independent from hardware and is _generally_ quite "relocateable".

It is, except for COW files..

> if it would have swsusp - i could even relocate a running instance - like
> i can do with vmware.

To my knowledge nobody has solved suspend with UML yet..

> why was that relocateability being made difficult artificially by putting 
> that "features" into COW? 

To make sure there is no mixup between COW and backing file, especially if 
you umlmoo the backing file with one COW file but there is multiple other 
UMLs also using the same backing file.

> is this "problem" going to be adressed?

It is simply one of many things which is not yet done. If a user who needs 
such functionality contributes a patch I am pretty sure it will get 
accepted, or at least commented on how it should be done.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
