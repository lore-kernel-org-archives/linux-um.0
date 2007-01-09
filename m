Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H4E20-0001X2-K8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 02:16:36 -0800
Received: from picard.linux.it ([213.254.12.146])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H4E20-0005ae-3O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 02:16:36 -0800
Message-ID: <35792.80.105.100.166.1168337791.squirrel@picard.linux.it>
In-Reply-To: <C1C8A68E.16BE8%pierre.laroche@sbcglobal.net>
References: <C1C8A68E.16BE8%pierre.laroche@sbcglobal.net>
Date: Tue, 9 Jan 2007 11:16:31 +0100 (CET)
From: "Mattia Dongili" <malattia@linux.it>
MIME-Version: 1.0
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
To: pierrelaroche <pierre.laroche@sbcglobal.net>
Cc: pkg-uml-devel@lists.alioth.debian.org, user-mode-linux-devel@lists.sourceforge.net

Hi,

first of all: do you really mean 2.6.8??

On Tue, January 9, 2007 10:55 am, pierrelaroche said:
> These programs, as found in the Debian unstable tree, don't install
> properly
> on my Debian system. Apt-get insists on first removing all my kernel
> images
> claiming a conflict.

hmmm, maybe apt gets some dependency wrong, can you share the output of
apt-get?

> The installation succeeds however if the .deb files are downloaded first
> before installation (the files are downloaded, and then installed using
> dpkg).
>
> Also, where can I find the source code and the instructions to recreate
> these binaries? I would like to generate a debug version. I need to know
> the
> system setup, and the uml patches used to create these binaries (2.6.8).

apt-get source user-mode-linux
and build it with
DEB_BUILD_OPTIONS=nostrip dpkg-buildpackage -uc -us -b -rfakeroot

-- 
mattia
:wq!



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
