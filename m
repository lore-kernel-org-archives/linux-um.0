Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200312060004.hB604pAv008208@ccure.user-mode-linux.org>
Subject: Re: [uml-user] Re: [uml-devel] How to copy COW files to another machine across the network? 
In-Reply-To: Your message of "Sun, 30 Nov 2003 22:22:34 +0100."
             <05a201c3b788$12caed30$2000000a@schlepptopp> 
References: <Pine.LNX.4.44.0311280940300.3315-100000@filer.marasystems.com>  <05a201c3b788$12caed30$2000000a@schlepptopp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 05 Dec 2003 19:04:51 -0500
To: roland <for_spam@gmx.de>
Cc: Henrik Nordstrom <hno@marasystems.com>, Shao-Lin Joseph Chung <sc57@cs.waikato.ac.nz>, UML User list <user-mode-linux-user@lists.sourceforge.net>, UML Devel list <user-mode-linux-devel@lists.sourceforge.net>

for_spam@gmx.de said:
> why was that relocateability being made difficult artificially by
> putting  that "features" into COW? is this "problem" going to be
> adressed? 

To prevent people from mangling filesystems by providing the wrong backing
file to UML.

> is this "problem" going to be adressed?

It's not a problem.

If you really move a backing file, there is a perfectly good way of telling
UML to update the COW file.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
