Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H4VxT-0006me-18 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 21:25:07 -0800
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H4VxS-00080R-Hq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 21:25:06 -0800
Date: Tue, 09 Jan 2007 21:24:56 -0800
From: pierrelaroche <pierre.laroche@sbcglobal.net>
Message-ID: <C1C9B8A8.16C08%pierre.laroche@sbcglobal.net>
In-Reply-To: <35792.80.105.100.166.1168337791.squirrel@picard.linux.it>
Mime-version: 1.0
Subject: Re: [uml-devel] Debian user mode linux 2.6.8 and supporting utils
	don't install
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
To: Mattia Dongili <malattia@linux.it>
Cc: pkg-uml-devel@lists.alioth.debian.org, user-mode-linux-devel@lists.sourceforge.net

Hello,

First, thanks for the very prompt response.

Also thanks for the build instructions. I now have a uml kernel debug
environment.

I was incorrect in stating the uml version. I am installing uml
2.6.18-1um-2, not 2.6.8.

Here is the apt-get log showing the problem I mentioned,

debian:/etc/apt# apt-get install user-mode-linux
Reading Package Lists... Done
Building Dependency Tree... Done
The following extra packages will be installed:
  busybox fontconfig fontconfig-config klibc-utils libc6 libc6-dev libcairo2
libdbus-1-3 libdbus-glib-1-2 libfontconfig1 libfreetype6 libglib2.0-0
libhal-storage1 libhal1 libklibc libncurses5 libpango1.0-0
  libpango1.0-common libreadline5 libselinux1 libsepol1 libusb-0.1-4
libvolume-id0 locales lsb-base makedev module-init-tools readline-common
tzdata uml-utilities
Suggested packages:
  glibc-doc libfreetype6-dev ttf-kochi-gothic ttf-kochi-mincho
ttf-thryomanes ttf-baekmuk ttf-arphic-gbsn00lp ttf-arphic-bsmi00lp
ttf-arphic-gkai00mp ttf-arphic-bkai00mp rootstrap slirp linux-patch-skas
Recommended packages:
  dbus libglib2.0-data x-ttcidfont-conf
The following packages will be REMOVED:
  base-config initrd-tools kernel-image-2.4.27-3-386 kernel-image-2.6-686
kernel-image-2.6.8-3-686
The following NEW packages will be installed:
  busybox fontconfig-config klibc-utils libcairo2 libdbus-1-3
libdbus-glib-1-2 libhal-storage1 libhal1 libklibc libvolume-id0
readline-common tzdata uml-utilities user-mode-linux
The following packages will be upgraded:
  fontconfig libc6 libc6-dev libfontconfig1 libfreetype6 libglib2.0-0
libncurses5 libpango1.0-0 libpango1.0-common libreadline5 libselinux1
libsepol1 libusb-0.1-4 locales lsb-base makedev module-init-tools
17 upgraded, 14 newly installed, 5 to remove and 746 not upgraded.
Need to get 41.7MB of archives.
After unpacking 4974kB disk space will be freed.
Do you want to continue? [Y/n]


note: my sources are pointing to the unstable tree

- Pierre


On 1/9/07 2:16 AM, "Mattia Dongili" <malattia@linux.it> wrote:

> Hi,
> 
> first of all: do you really mean 2.6.8??
> 
> On Tue, January 9, 2007 10:55 am, pierrelaroche said:
>> These programs, as found in the Debian unstable tree, don't install
>> properly
>> on my Debian system. Apt-get insists on first removing all my kernel
>> images
>> claiming a conflict.
> 
> hmmm, maybe apt gets some dependency wrong, can you share the output of
> apt-get?
> 
>> The installation succeeds however if the .deb files are downloaded first
>> before installation (the files are downloaded, and then installed using
>> dpkg).
>> 
>> Also, where can I find the source code and the instructions to recreate
>> these binaries? I would like to generate a debug version. I need to know
>> the
>> system setup, and the uml patches used to create these binaries (2.6.8).
> 
> apt-get source user-mode-linux
> and build it with
> DEB_BUILD_OPTIONS=nostrip dpkg-buildpackage -uc -us -b -rfakeroot



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
