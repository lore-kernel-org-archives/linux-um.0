Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UXDyA-0001Gr-NB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Apr 2013 17:03:58 +0000
Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UXDy9-0004ip-U6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Apr 2013 17:03:58 +0000
Received: by mail-wg0-f49.google.com with SMTP id x12so669642wgg.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 30 Apr 2013 10:03:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+ve00QZq=tDAprLwZcthgqKk262RW_+Vq4YmHvWO5bECxzv=Q@mail.gmail.com>
References: <CA+ve00STDD3cud+U_f7=nJpgygE0_vjRoOjiDJBVAiHEzQgxRQ@mail.gmail.com>
	<311858522.18447.1367339268757.JavaMail.root@sigma-star.at>
	<CA+ve00QZq=tDAprLwZcthgqKk262RW_+Vq4YmHvWO5bECxzv=Q@mail.gmail.com>
Date: Tue, 30 Apr 2013 19:03:51 +0200
Message-ID: <CAFLxGvw9chpSiqCSdr8aY6+Onjd7YzQ2DfX+=GNrCcqmL-oFEA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] UML Hardware Virt Support
To: Earlence Fernandes <earlenceferns@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Apr 30, 2013 at 6:49 PM, Earlence Fernandes
<earlenceferns@gmail.com> wrote:
> But then there's a fundamental question of whether KVM has similar
> semantics.

KVM works completely different than UML does.

> UML was incredibly useful to my project since it ran a whole "kernel +
> processes" in user space.
> Now i'm confused as to whether I need to change my work so that it works
> with KVM (I'm trying to read thru KVM docs to understand the semantics).

You can still use UML, it is functional.

--
Thanks,
//richard

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

