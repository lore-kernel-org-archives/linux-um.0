Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATQZr-0001DA-4w
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 10:57:51 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ATQZq-00041W-FT
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 10:57:50 -0800
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <20031208180250.GA7787@osiris.silug.org>
Message-ID: <Pine.LNX.4.44.0312081932200.14902-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: chroot option
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
Date: Mon, 8 Dec 2003 19:57:41 +0100 (CET)
To: Steven Pritchard <steve@kspei.com>
Cc: Matthew Bloch <matthew-list@bytemark.co.uk>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 8 Dec 2003, Steven Pritchard wrote:

> I once worked on a patch to add chroot() support, but, well, that
> didn't go too well.  :-)  (Actually, it worked fine, but by the time
> the kernel options were being parsed, there were already several
> threads, meaning only the thread doing option parsing was chroot()'d.
> Not quite what I intended...)

There is two parsing steps. One which is done by the "uml" before
launching the kernel where "debug" and other options modifying how uml
operates are parsed (registered by __uml_setup()), and then another where
the kernel options are parsed.

When using the first the kernel should still be in user mode with no other
threads running. To do this have a __uml_setup() for each of the command
line options, then a __uml_postsetup() executing the chroot (note: link
order important, these are executed in the linked order).

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
