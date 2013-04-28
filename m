Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UWWwx-0008IK-JV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Apr 2013 19:07:51 +0000
Received: from mail-wi0-f169.google.com ([209.85.212.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UWWww-0003tb-Sg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Apr 2013 19:07:51 +0000
Received: by mail-wi0-f169.google.com with SMTP id h11so2290899wiv.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 28 Apr 2013 12:07:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+ve00RvAsBBqZ1TFt_q3fCxDTS54aUN5MpL7pK_+6u3O-=rwg@mail.gmail.com>
References: <CA+ve00RvAsBBqZ1TFt_q3fCxDTS54aUN5MpL7pK_+6u3O-=rwg@mail.gmail.com>
Date: Sun, 28 Apr 2013 21:07:44 +0200
Message-ID: <CAFLxGvxQz=wbzkFqp5wx33VyAEknhUQ6yEY81iDcNVk3CR2DaQ@mail.gmail.com>
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
Subject: Re: [uml-devel] Code for tracing thread
To: Earlence Fernandes <earlenceferns@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Apr 28, 2013 at 5:43 PM, Earlence Fernandes
<earlenceferns@gmail.com> wrote:
> I keep reading that there is a tracing thread that intercepts process
> syscalls and I've been grepping thru the kernel sources to find this.

UML intercepts all system calls in any mode.
Tracing thread mode (tt) was the very first operating mode it was
dropped years ago
in flavor to SKAS0 mode.

--
Thanks,
//richard

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

