Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <segooon@gmail.com>) id 1Qovub-0005n4-9k
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2011 11:16:25 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Qovua-0006GH-Bg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2011 11:16:25 +0000
Received: by fxg11 with SMTP id 11so1025336fxg.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 04 Aug 2011 04:16:18 -0700 (PDT)
Date: Thu, 4 Aug 2011 15:16:13 +0400
From: Vasiliy Kulikov <segoon@openwall.com>
Message-ID: <20110804111613.GA2375@albatros>
References: <201108011541.59640.richard@nod.at>
	<08cf4697685ecd9bcb7e4eefe516f2ee@localhost>
	<20110801172452.GA26190@albatros>
	<201108041304.41135.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201108041304.41135.toralf.foerster@gmx.de>
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
Subject: Re: [uml-devel] shm updates broke UML
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: serge.hallyn@canonical.com, user-mode-linux-devel@lists.sourceforge.net, Marc Zyngier <marc.zyngier@arm.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Thu, Aug 04, 2011 at 13:04 +0200, Toralf F=F6rster wrote:
> issue solved for the UML, tested linux-v3.0-7347-g288d5ab whcih works fin=
e.
> =

> BTW is there a special commit id dealing with this bug or was it solved a=
s a =

> side effect of another commit ?

The oops is fixed by 298507d4d2cff2248e84afcf646b697301294442 (shm:
optimize exit_shm()), but the dependency problem (tasks spawned by the
kernel are started with uninitialized namespaces) is not solved yet,
AFAICS.

Thanks,

-- =

Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments

---------------------------------------------------------------------------=
---
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
The must-attend event for mobile developers. Connect with experts. =

Get tools for creating Super Apps. See the latest technologies.
Sessions, hands-on labs, demos & much more. Register early & save!
http://p.sf.net/sfu/rim-blackberry-1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

