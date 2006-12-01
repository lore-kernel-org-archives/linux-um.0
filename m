Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gq2dI-0004Jh-2Y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 23:16:28 -0800
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gq2dH-0005Wg-KM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 23:16:28 -0800
Received: by nf-out-0910.google.com with SMTP id c31so5476172nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 30 Nov 2006 23:16:26 -0800 (PST)
Message-ID: <22a33e9f0611302316l14e7eff9h75f0201a56a4a3f7@mail.gmail.com>
Date: Fri, 1 Dec 2006 07:16:26 +0000
From: "Matt Willsher" <matt@monki.org.uk>
In-Reply-To: <20061201002252.GF8331@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
	<200611210813.14745.blaisorblade@yahoo.it>
	<22a33e9f0611211123w3b57d6bdh5e599a87589816c9@mail.gmail.com>
	<200611220122.24515.blaisorblade@yahoo.it>
	<22a33e9f0611220004m46ce8d98nc7f21eff09febc89@mail.gmail.com>
	<20061122164446.GB5120@ccure.user-mode-linux.org>
	<22a33e9f0611232329g6c8a8614x3472a0da3416aba5@mail.gmail.com>
	<20061124202512.GD4745@ccure.user-mode-linux.org>
	<22a33e9f0611241310y42962e8exce5011f2d6b99435@mail.gmail.com>
	<20061201002252.GF8331@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Problem with newer (>2.6.14) UML kernels hanging
	under Xen DomU/Centos 4.4
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

The problem I'm having

On 12/1/06, Jeff Dike <jdike@addtoit.com> wrote:
> On Fri, Nov 24, 2006 at 09:10:50PM +0000, Matt Willsher wrote:
> > The very same image, uncopied. I have a directory tree set up and
> > scripts I use and all I did was to change the script to call the newer
> > kernel.
>
> And the exact same UML binary?  I'm grabbing at straws here, in case
> somehow the broken one is lacking binfmt support for /sbin/init.
>

Just to recap:

TT mode support under 2.6.12 works fine and I can boot a custom build
kernel with it. A downloaded, known good 2.6.12 also boots a know good
linux disk image.

2.6.18, either compiled by myself, or a downloaded known good doesn't
boot either my known good disk image as used with 2.6.12 or one
downloaded from the web.  The 2.6.18 that doesn't work on my machine
has been used successfully on someone elses environment boot my known
good image.

My guess is that this issue is related to SKAS0 support in the newer
kernels. I've been meaning to find the earliest kernel that ships with
SKAS0 and try both TT mode and SKAS0 mode to see what happens there.

http://user-mode-linux.sourceforge.net/new/problems.html#vdso seems to
be the problem I'm having but I'm running UML under Xen, and there is
not /proc/config.gz to check the kernel config, nor do I access to
Dom0. so I have no way to check CONFIG_COMPAT_VDSO or have it changed
on my host.

I'm willing to have a go at debugging using gdb etc. but I really
don't know what I'm looking for there.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
