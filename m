Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200312180115.hBI1FAkS007918@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Debug uml kernel won't boot (VFS: Unable to mount root fs) 
In-Reply-To: Your message of "Mon, 15 Dec 2003 09:04:37 PST."
             <20031215170437.73387.qmail@web10402.mail.yahoo.com> 
References: <20031215170437.73387.qmail@web10402.mail.yahoo.com> 
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
Date: Wed, 17 Dec 2003 20:15:10 -0500
To: Joydeep Sen Sarma <jsensarma@yahoo.com>, "James S. Johnson" <jjohnson@eclipse.ncsc.mil>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

jsensarma@yahoo.com said:
> The regular uml kernel worked fine till i turned on the debug option.
> Kernel version is 2.4.22 and I applied uml patch 2.4.22-6 to it.

jjohnson@eclipse.ncsc.mil said:
> When I try to run a UML kernel as root, using a real partition as the
> UML root  filesystem, it reports that the filesystem is corrupted and
> goes into single  user mode.
>
> The UML kernel is 2.4.22 with uml-patch-2.4.22-6 applied.

For grins, can you try 2.4.22-5 and see if it's any better?  Looking through
my mail I see a couple of complaints about things newly broken in -6 and
I'd like to see if these are some more.

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
