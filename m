Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATUNA-00008Z-1h
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:01:00 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATUN9-0004Ys-EV
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:00:59 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: chroot option 
In-Reply-To: <200312082204.hB8M41Av029907@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312082326210.14902-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 9 Dec 2003 00:00:47 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: Steven Pritchard <steve@kspei.com>, Matthew Bloch <matthew-list@bytemark.co.uk>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 8 Dec 2003, Jeff Dike wrote:

> The first step is for things that can't be done later, like establishing the
> physical memory size.
> 
> The second is for everything else, and anything that can be done at this stage
> should be.

What is being discussed (having UML chroot itself and drop root privs)  
basically needs to be just between these two, while the uml is still 
just a plain process.

Chrooting and changing user to the intended is kind of part of
establishing the "physical" environment wherein the UML kernel runs, just
as establishing the physical memory. If anywhere this belongs in the
kernel "boot proces" before giving "real" control to the kernel.

This is precisely where the postsetup hook is with it's setupinfo
arguments, making it in my opinion a very good place for a function like 
this, but some care needs to be taken to get the ordering correct wrt 
initrd loading, pid files etc in order to get the desired functionality.

I see a value to UML if this is done after the memory has been set up and
any initrd has been loaded, but should not be done any later than this in
my opinion. And I also do not see any clean way of doing this any later 
without causing confusion about what is inside the chroot and what is 
outside or seriously risking leaks allowing easy breakout from the 
chroot.

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
