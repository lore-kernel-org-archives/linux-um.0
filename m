Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Dan Shearer <dan@shearer.org>
Message-ID: <20040207145149.GK4203@erizo.shearer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [uml-devel] ANSWER: Basics of compiling and running UML 2.6.[1,2]
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
Date: Sun, 8 Feb 2004 01:21:49 +1030
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

There's been a few questions on and off-list about this, hopefully this
will help until there's some tidying up done. The short version is that
UML on 2.6.[1,2] works quite well, even before Jeff's done a stable
release. I've probably missed things, please let me know.

These instructions are for those new to UML, not new to kernels and
distributions. The following might make your system unusable if you
don't know what you're doingi to a basic level. But enough detail is
given that if you *are* new to all this you aren't excluded from
destroying your system in the process of learning.

First, make sure you can compile a standard 2.6.x kernel without any UML
at all. You may need to upgrade your binutils. gcc 3.2.3 and 3.3.0 is
known to work.

You can get assorted patch sets for UML 2.6.[1,2] from
http://user-mode-linux.sourceforge.net/dl-uml-org.html and some a bit
more recent from http://web.tiscali.it/blaisorblade/index.html. These
don't quite compile for most people, but with the following twiddles it
should work:

1. The default config for um isn't set up correctly. Do 'make menuconfig
ARCH=um' and uncheck the following, all of which will prevent
compilation or linking:

	a) SCSI support / SCSI support

	b) UML-specific options / Highmem support

	c) Loadable modules support / Enable loadable module support

	d) Security options / Enable different security models

and add the following, without which UML is useless to most people:

	d) Block devices / virtual block device

There's some other slightly surprising omissions in the default as well,
so look carefully to see what you need. The Management Console is a good
idea to help with testing your new 2.6 UML kernel for example.

2. make linux ARCH=um should now work and give you a ~3Mb binary called
'linux' in the top-level directory. Don't get worried if it is massively
larger (debugging symbols, see the HOWTO) but that should not happen
with a normal 2.6 build system for UML used as described.

3. If you are running a 2.6.x host kernel and your new 2.6.x UML kernel
appears to hang just after initialising the console driver (eg by all
measures including commands such as 'uml_mconsole config con0' hanging
it seems to have stopped) then check to see if you have a NPTL-enabled
glibc. On RedHat or Debian systems running the 2.6 kernel you probably
have, and if this is the case UML will not work under any circumstances
(UML does not use the Native Posix Threading Library but glibc thinks
it should... see the archives for a sparse description of the problem.)

But never fear! Just recompile your own glibc without NPTL. Under Debian
this is done by:

-a) installing gcc 3.3 if you don't have it already

a) mkdir something; cd something; apt-get source glibc; cd
something/glibc-2.3.2.ds1/

b) export LINUX_SOURCE="/usr/src/tree-corresponding-to-2.6-host-kernel"
It might be nice if this kernel tree didn't vanish in the future too.

c) edit the file something/glibc-2.3.2.ds1/debian/sysdeps

	remove ntpl from the line "i686_add-ons"
	remove "__threads" from the line "i686_extra_config_options"

d) in the something directory type "dpkg-buildpackage" and wait for an
hour or two. Install the resulting .deb with "dpkg -i". No need to
remove /lib/tls as some have suggested, as far as I know.

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
