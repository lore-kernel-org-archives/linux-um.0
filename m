Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200401080019.i080JOtd008375@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Wed, 07 Jan 2004 20:12:04 +0100."
	<200401072012.05007.blaisorblade_work@yahoo.it> 
References: <200312242019.23335.blaisorblade_work@yahoo.it>
	<200401062038.37402.blaisorblade_work@yahoo.it>
	<20040106202145.GA11953@mars.ravnborg.org>
	<200401072012.05007.blaisorblade_work@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [kbuild-devel] Needed help for UML kbuild.
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
Date: Wed, 07 Jan 2004 19:19:24 -0500
To: BlaisorBlade <blaisorblade_work@yahoo.it>
Cc: Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

blaisorblade_work@yahoo.it said:
> some modules(i.e. hostaudio) are built from a "userspace" (needing the
> special  treatment) file and a "kernel" (to be compiled as usual)
> file. How will  kbuild link them together?

> I have three workarounds:
> - split the module into 2 separate ones, with the kernel one requiring the 
> other. BUT a lot of EXPORT_SYMBOLS should be added (one for each function 
> inside the userspace file at least)
> - create a symlink from arch/um/drivers/hostaudio_user.c(old place) to 
> arch/um/os/drivers/hostaudio_user.c (new place) and pass the symlink to gcc.
> This must be done only when the file will be part of a module.
> Note that arch/um/os is a symlink to arch/um/os-{Linux, Win, any OS needed}.
> - (worst option) make kbuild link together objects from different folders 
> inside one module. But I don't like this and I guess this would never be 
> accepted (this is against a fundamental kbuild assumption, IIRC).

Option 2 would work, although I would try to avoid that.  I would rather
have everything under arch/um/os be userspace code, and none of it be kernel
code.

So, rather than have a module consisting of a userspace chunk and a kernel
chunk needing to be turned into a single .o, I would rather look at having
two modules, with the userspace piece plugging into an interface in the
kernel piece.  

This is what I've envisioned for hostfs for a long time.  You don't need to
stick host files underneath hostfs files - you can stick other host resources
under them, and the way to do that is to have multiple hostfs userspace modules
which plug into an interface in the hostfs kernel piece, each of which provides
access to a different sort of host resource.

So, I would look at the other problematic modules and see if they can be treated
in the same way.

So, I basically don't like the idea of making the CFLAGS munging part of kbuild
overall.  It's very UML-specific now, and in the future, it will become specific
to small pieces of UML.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
