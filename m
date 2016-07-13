Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1bNRR1-0005yz-Dk
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2016 21:11:11 +0000
Received: from mail-oi0-f66.google.com ([209.85.218.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bNRQz-00029e-Ke
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2016 21:11:11 +0000
Received: by mail-oi0-f66.google.com with SMTP id c199so5335812oig.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Jul 2016 14:11:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160713030256.GA26654@taihen.jp>
References: <20160713030256.GA26654@taihen.jp>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 13 Jul 2016 23:11:03 +0200
Message-ID: <CAFLxGvyhO87SvLn5ofPMGobT6Y27vA-yzC7KxdVe_h6GPB+6Pg@mail.gmail.com>
Subject: Re: [uml-devel] UML tools anywhere?
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
To: Mattia Dongili <malattia@linux.it>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hi!

On Wed, Jul 13, 2016 at 5:02 AM, Mattia Dongili <malattia@linux.it> wrote:
> Hi,
>
> Does anybody knows if there is any newer version of the tools package
> (the one with tunctl, uml_mount and friends)?
>
> I'm maintaining[1] the package in Debian and I was wondering whether the
> original code is hosted somewhere.

http://user-mode-linux.sourceforge.net/old/dl-sf.html

There is no newer version.
Do you have a list of issues in the current utilities?

Maybe I should take this as chance to convert them to git and make
a new release.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

