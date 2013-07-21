Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1V0id3-0005Da-PI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jul 2013 01:40:05 +0000
Received: from li9-11.members.linode.com ([67.18.176.11] helo=imap.thunk.org)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps
	(TLSv1:AES128-SHA:128) (Exim 4.76) id 1V0id2-0002B3-0H
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jul 2013 01:40:05 +0000
Date: Sat, 20 Jul 2013 21:03:52 -0400
From: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20130721010352.GB21484@thunk.org>
References: <51EAA7A7.4000104@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51EAA7A7.4000104@gmx.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] fuzzying a user mode linux image often core dumps
	with
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-ext4@vger.kernel.org, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Jul 20, 2013 at 05:07:19PM +0200, Toralf F=F6rster wrote:
> I do run the fuzzer trinity within a 32 bit user mode linux.
> With latest git tree I do often get a core dump like the one attached.
> =

> Although it is the nature of trinity to corrupt the kernel /me wonders wh=
y it happens nearly alway
> at the same place. That's why I decided to just report it here.

Thanks, this is a known problem for which the fix is can be found here:

	http://patchwork.ozlabs.org/patch/260250/

I hope to get this fixed before -rc2 is released; the only question at
the moment is whether the fix is going to go to Linus via the ext4
tree or the VFS tree....

					- Ted

---------------------------------------------------------------------------=
---
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=3D48808831&iu=3D/4140/ostg.cl=
ktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

