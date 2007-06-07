Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwDvA-0000ND-4Q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 02:04:44 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HwDv8-0003mg-Fn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 02:04:44 -0700
Message-ID: <4667CA21.80506@nagafix.co.uk>
Date: Thu, 07 Jun 2007 10:04:33 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <7EDC24AB1ED682439657D3B7790609D39825E6@deepthought.Elpro.local>
In-Reply-To: <7EDC24AB1ED682439657D3B7790609D39825E6@deepthought.Elpro.local>
Subject: Re: [uml-devel] Building a UML uClinux(Busybox/uClibc) filesystem
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Sinclair <Andrew.Sinclair@elprotech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Andrew Sinclair wrote:
> Hello all,
> 
> I've been able to use the pre-built Busybox 1.5.0 filesystem at
> http://uml.nagafix.co.uk/ perfectly with the same UML kernel I am using.
> 
> 
> Unfortunately, when trying to generate my own filesystem, my kernel no
> longer works. It basically stops after mounting the filesystem. 
You may want to diff the config I used with yours:
http://uml.nagafix.co.uk/BusyBox-1.5.0/amd64.config
And see if anything major turns up.

> When I try and use gdb to debug I get stuck in
> arch/um/include/um_uaccess.h:50
> 
> static inline int copy_to_user(void __user *to, const void *from, int n)
> {
>         return(CHOOSE_MODE_PROC(copy_to_user_tt, copy_to_user_skas, to, 
>                                 from, n));
> }
> 
> If I put the kernel in tracing thread mode, to avoid this, it falls over
> even with the prebuilt nagafix filesystem.
> 
> I have been unable to build the automated Busybox root filesystem
> builder (based on buildroot) on
> http://user-mode-linux.sourceforge.net/contrib.html
> A number of the package download links in the makefile no longer exist,
> so I searched the web for the packages from other locations. Perhaps I
> have the wrong packages. I have got it to the point where it is looking
> for a uml-gcc that is not in the build folder.
> 
> I've noticed that the nagafix prebuilt filesystem has no lib folder. I
> guess this means that the pre-built filesystem was built with glibc?
> (Unlike the mine or the buildroot variant which use uClibc)
IIRC, that's because it was built with the static option.

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZ8ohGK2zHPGK1rsRCsvVAJ41jb7jbHZw43BDZOFcijTAcOdqiQCcCac2
sAL2R+IFI5FTd4IbGmrdRnA=
=ODDY
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
