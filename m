Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXNEG-0000kz-Aj
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 08:11:52 -0800
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXNEF-0002lz-VT
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 08:11:52 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031219161144.GB18100@alcor.net>
References: <20031219143655.GA7944@pari.math.u-bordeaux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219143655.GA7944@pari.math.u-bordeaux.fr>
Subject: [uml-devel] Re: Bug#224502: FATAL: cannot determine library version
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
Date: Fri, 19 Dec 2003 08:11:44 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bill Allombert <ballombe@debian.org>, 224502-forwarded@bugs.debian.org

On Fri, Dec 19, 2003 at 03:36:55PM +0100, Bill Allombert wrote:

> I have upgraded from 2.4.22-5um-1 to 2.4.22-7um-1 and now 
> user-mode-linux fail to start with 
> 
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> FATAL: cannot determine library version

Strange.  I think this error message comes from ld.so.

> Kernel panic: Attempted to kill init!
> 
> The host kernel is 2.4.22+Debian patch+SKAS Debian patch
> The machine is a bi-processor athlon.
> The command line is
> linux ubd0=uml root=/dev/ubd0
> 
> 2.4.22-5um-1 work fine.
> 
> On another host without the skas patch, rootstrap lead to
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (hostfs filesystem) readonly.
> Mounted devfs on /dev
> 
> and then it hang.

2.4.22-7um-1 works fine for me in skas mode.  There is a problem in tt mode
which has already been reported (#224431).

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
