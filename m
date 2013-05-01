Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UXbZN-0007IM-Fd
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 May 2013 18:15:57 +0000
Received: from mail-oa0-f43.google.com ([209.85.219.43])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UXbZM-0003lq-Re
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 May 2013 18:15:57 +0000
Received: by mail-oa0-f43.google.com with SMTP id k7so1672866oag.16
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 01 May 2013 11:15:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAER6Ckc5PpTBZNy93WtK1ZvJqCaoQkGgKDYcUtTmCfmhwYNmow@mail.gmail.com>
References: <CA+ve00STDD3cud+U_f7=nJpgygE0_vjRoOjiDJBVAiHEzQgxRQ@mail.gmail.com>
	<311858522.18447.1367339268757.JavaMail.root@sigma-star.at>
	<CAER6Ckc5PpTBZNy93WtK1ZvJqCaoQkGgKDYcUtTmCfmhwYNmow@mail.gmail.com>
Date: Wed, 1 May 2013 20:15:51 +0200
Message-ID: <CAFLxGvxCgsk5-c_173R718gM-mOOSmwWS-Hnxa0Nrv=vxtunKQ@mail.gmail.com>
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
To: Terry Hsu <terry.shoes@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Wed, May 1, 2013 at 7:54 PM, Terry Hsu <terry.shoes@gmail.com> wrote:
> Indeed, I am developing some functions for the virtual memory subsystem in
> the kernel.
> Qemu replaces UML in my case. I run qemu without kvm support because I don't
> seem to be able to run nested virtualization in virtualbox.
> Anyway now Qemu serves me well. :)
>
> Is Jeff Dike still developing UML?

Not really. Just use git to find out. :)

Currently I maintain UML in my very limited spare time.
Al Viro also often helps hunting bugs down.

So, don't expect much new features coming to UML.
But I try hard to keep it running.

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

