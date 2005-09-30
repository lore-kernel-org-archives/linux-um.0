Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ELIwW-00010D-GX	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 04:20:44 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ELIwV-0006FN-TF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 04:20:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Error running UML
References: <229e70f205093003511a49c171@mail.gmail.com>
	<200509301306.08001.blaisorblade@yahoo.it>
	<229e70f2050930041251654370@mail.gmail.com>
In-Reply-To: <229e70f2050930041251654370@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509301320.18389.blaisorblade@yahoo.it>
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
Date: Fri, 30 Sep 2005 13:20:17 +0200
To: Etay Meiri <etay.meiri@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 30 September 2005 13:12, Etay Meiri wrote:
> Thanks for your response.
>
> I tried running it with a simple: ./vmlinux ubd0=root_fs.2005062201
> and now it says:
Well, the only option which *must* be dropped is root=/dev/ubd/0. The rest is 
harmless, and may help.

Note that if you use con=pty rather than con=xterm, you'll need to connect to 
the consoles manually and look for them. Plus /dev/pty* are deprecated, and 
some host kernel don't support them any more.

At least, using con=pts is more modern (it's supported on any recent kernel).
> [42949373.420000] Console initialized on /dev/tty0
> [42949373.420000] ubda: unknown partition table
> [42949373.420000] kjournald starting. Commit interval 5 seconds
> [42949373.420000] EXT3-fs: mounted filesystem with ordered data mode.
> [42949373.420000] VFS: Mounted root (ext3 filesystem) readonly.
> [42949373.420000] Warning: unable to open an initial console.
This warning, normally, is harmless.
> [42949373.420000] Kernel panic - not syncing: Attempted to kill init!

> Looks like it mounted the root file system but has a problem opening
> a console. Maybe I'm missing some console related option in the kernel
> config?
It's possible. I would first check also if init=/bin/sh makes it boot, to 
distinguish between fs problems and console problems. Also, remember to 
"mv /lib/tls /lib/tls.away" in the guest fs.

Due to a bug in kconfig, which wasn't fixed because the fix wasn't nice, if 
you do "make *config ARCH=um" on an empty tree it may pick as default values 
from /boot/config-`uname -r`. To avoid this, you need to move away 
your .config and do:

make defconfig ARCH=um
and only afterwards, depending on your taste for configuration tool,
make {menu,x,g}config ARCH=um
i.e. either make menuconfig ARCH=um or the other similar ones.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
