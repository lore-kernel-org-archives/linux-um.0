Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UOslq-0005n3-HW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 16:48:46 +0000
Received: from mail-we0-f180.google.com ([74.125.82.180])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UOsll-0004eC-T4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 16:48:46 +0000
Received: by mail-we0-f180.google.com with SMTP id r5so3857045wey.25
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 07 Apr 2013 09:48:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51054.173.206.136.128.1365288799.squirrel@webmail3.pt.com>
References: <45722.173.206.176.149.1364962278.squirrel@webmail3.pt.com>
	<20130405092141.61f2f61c@spider.haslach.nod.at>
	<OFF553D1A8.B32C41CE-ON85257B44.004D6DD3-85257B44.004D81FA@pt.com>
	<20130405160739.68d74008@spider.haslach.nod.at>
	<OF04169121.A123E516-ON85257B44.004E1BE5-85257B44.004E21A8@pt.com>
	<20130405161541.6e4a2472@spider.haslach.nod.at>
	<39656.10.100.142.174.1365215174.squirrel@webmail3.pt.com>
	<515FE511.8060601@nod.at>
	<39111.173.206.136.128.1365266052.squirrel@webmail3.pt.com>
	<51604F00.10507@nod.at>
	<51054.173.206.136.128.1365288799.squirrel@webmail3.pt.com>
Date: Sun, 7 Apr 2013 18:48:35 +0200
Message-ID: <CAFLxGvzyd1gMs8cCrcC=9g=W4Qi3A=4qH1y4MR-o05z=tLd51w@mail.gmail.com>
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
Subject: Re: [uml-devel] BUG: failure at
	block/blk-core.c:2985/blk_flush_plug_list()
To: Peter Butler <pbutler@pt.com>
Cc: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Apr 7, 2013 at 12:53 AM, Peter Butler <pbutler@pt.com> wrote:
> OK setting SUBARCH did the trick.  Thanks for that.  :-)

Can you do a git bisect between 3.8 and 3.9-X to find the evil doer?
You'll get the credit. :-)

> Here's the output from a crash using the associated build.  Too several
> boots to trigger the crash - probably some sort of a race condition.  Note
> that I am doing nothing other than booting up the UML to trigger the crash
> (that is, I am not doing anything at the command line).  If no crash
> occurs I simply do a graceful shutdown and then start it up again (in
> order to trigger a crash).  In this particular case the crash actually
> occurred during the shutdown and triggered this bug:
>
> BUG: scheduling while atomic: systemd-logind/485/0x00000001
>
> Here's the full output:
>
> bash $ ./linux ubd0=Fedora18-AMD64-root_fs rw mem=4096M con0=fd:0,fd:1

What it your host kernel?
At least here on my Laptop (v3.7.x x86_64) I cannot reproduce this.
(Also fc18 also guest, same cmd line...)
I fear it has to do something with the host side. Toralf saw related crash.

Thanks,
//richard

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

