Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATTGs-00044f-L6
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 13:50:26 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ATTGq-000132-Os
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 13:50:25 -0800
Message-Id: <200312082204.hB8M41Av029907@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: chroot option 
In-Reply-To: Your message of "Mon, 08 Dec 2003 19:57:41 +0100."
             <Pine.LNX.4.44.0312081932200.14902-100000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0312081932200.14902-100000@filer.marasystems.com> 
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
Date: Mon, 08 Dec 2003 17:04:01 -0500
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Steven Pritchard <steve@kspei.com>, Matthew Bloch <matthew-list@bytemark.co.uk>, user-mode-linux-devel@lists.sourceforge.net

hno@marasystems.com said:
> There is two parsing steps. One which is done by the "uml" before
> launching the kernel where "debug" and other options modifying how uml
> operates are parsed (registered by __uml_setup()), and then another
> where the kernel options are parsed. 

The first step is for things that can't be done later, like establishing the
physical memory size.

The second is for everything else, and anything that can be done at this stage
should be.

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
