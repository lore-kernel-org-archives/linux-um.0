Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEtsh-0006NG-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 09:13:15 -0800
Received: from smtp2.wanadoo.fr ([193.252.22.29] helo=mwinf0202.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEtsh-0001pr-C4
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 29 Oct 2003 09:13:15 -0800
Received: from doggy.fute.lan (AMontsouris-108-1-18-216.w80-15.abo.wanadoo.fr [80.15.147.216])
	by mwinf0202.wanadoo.fr (SMTP Server) with ESMTP id 36066A400248
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 18:13:09 +0100 (CET)
Received: from snide by doggy.fute.lan with local (Exim 3.35 #1 (Debian))
	id 1AEtsa-0001Qq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 18:13:08 +0100
From: Steve Schnepp <snide@free.fr>
Subject: Re: [uml-devel] About COW & filesystems
Message-ID: <20031029171307.GB2182@fute.lan>
References: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com> <200310281723.h9SHNLLJ002565@ccure.karaya.com> <BAY10-DAV26Yvm7kLig00008a71@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY10-DAV26Yvm7kLig00008a71@hotmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 29 Oct 2003 18:13:08 +0100
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, Oct 29, 2003 at 06:16:18AM -0800, James McMechan wrote:
> [Plenty interesting stuff about the future of COW]

I did a kernel module to support user space loop devices. [ actually 
any userspace block device ]

The idea is that you open a /dev/ulb[a-z] and the kernel module connects
it to /dev/ulc[0-26] (major/minor are assigned automatically by the
kernel)

Then a user-space helper reads /dev/ulc0 for commands & data, and
reads/writes somewhere (usually in a file), and then writes back the
result to /dev/ulc0. For now it's heavily 2.4.x oriented...

The code isn't in a really good shape (lots of hardcoded values)
But, since i don't have much spare time i decided to publish it here in
case of someone wants to have a look at it. The code should be almost
self-explaining.

I should be able to resume working on it soon, but anyway... your
feedback is very welcome. ( i'm not a good C hacker, and i *do* like to
improve myself )

URL: http://snide.free.fr/uldd/

	Steve

-- 
GPG public key available from http://snide.free.fr/gpg/snide.free.fr.asc
   Or by email to "snide at free.fr" with "send key pub" as subject
   Fingerprint: 19D7 12ED 5A37 4F29 8FDA  19B0 6DFD 3A54 A753 EA6F 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
