Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cnu5I-0001cY-Lf for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 23:35:28 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cnu5H-00075w-TA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 23:35:28 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<200501091706.58778.rob@landley.net>
	<Pine.LNX.4.61.0501100141480.14613@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0501100141480.14613@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501100134.05591.rob@landley.net>
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
Date: Mon, 10 Jan 2005 01:34:05 -0500
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Frank Sorenson <frank@tuxrocks.com>, user-mode-linux-devel@lists.sourceforge.net

On Sunday 09 January 2005 08:53 pm, Henrik Nordstrom wrote:
> On Sun, 9 Jan 2005, Rob Landley wrote:
> > I wonder if that old hack (deleting the file signalling there's no rush
> > about writing stuff back to the disk anymore, although it's still your
> > backing store) still works?
>
> Probably not.

Might be worth a shot, though.  (If I delete the file from userspace after 
launching UML, will it screw up anything?)

> > I'm more interested in correctness than performance at the moment.  As
> > long as it WORKS, they can leave it running overnight for now...
>
> Just to give you alternatives, an alternative to UML is to use a emulator
> such as qemu. Personally I prefer UML, but using an emulator eleminates
> the need of the user to even have Linux to start with as the same image
> also works on Windows.

Yeah, I thought about that.  Higher memory requirements, higher disk usage 
(need to feed it a partition or loopback file or something, not a shared 
directory like hostfs -- my high water mark of disk usage during the build is 
just under 370 megabytes, but I really don't want to have to depend on 
knowing that), dog slow, I'd need to build the kernel twice anyway (once on 
the parent system to have something for the emulator to run and once with the 
final system), more source code in the tarball, harder to integrate into the 
existing build process (with UML I can fire up a child that runs a script 
that can shutdown at the end so the parent script continues)...

It's an option.  I'd much rather figure out how to get UML to work...

> Regards
> Henrik

Rob


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
