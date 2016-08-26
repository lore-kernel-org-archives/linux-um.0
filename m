Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rob@landley.net>) id 1bdNKC-0006oU-KR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 20:02:00 +0000
Received: from mail-oi0-f44.google.com ([209.85.218.44])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bdNKB-0008JF-8U
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2016 20:02:00 +0000
Received: by mail-oi0-f44.google.com with SMTP id 188so34662553oif.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Aug 2016 13:01:59 -0700 (PDT)
References: <20160713030256.GA26654@taihen.jp>
	<CAFLxGvyhO87SvLn5ofPMGobT6Y27vA-yzC7KxdVe_h6GPB+6Pg@mail.gmail.com>
	<20160714030836.GA1538@taihen.jp> <57874E5D.9030906@nod.at>
	<20160714150731.GB11969@taihen.jp> <20160714151709.GC11969@taihen.jp>
	<20160728143220.GA21216@taihen.jp>
	<a335d8cf-dc4a-09f6-cbf1-93657f6c9530@nod.at>
	<20160817170225.GA9261@parts.user-mode-linux.org>
From: Rob Landley <rob@landley.net>
Message-ID: <4fc897e7-bbc9-1594-faa8-f8cc0918ea2d@landley.net>
Date: Fri, 26 Aug 2016 14:35:55 -0500
MIME-Version: 1.0
In-Reply-To: <20160817170225.GA9261@parts.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Mattia Dongili <malattia@linux.it>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 08/17/2016 12:02 PM, Jeff Dike wrote:
> Hi Richard,
> 
>> But let's ask Jeff first.
>> Jeff, do you have a more recent SCM repo of uml-utilities?
> 
> No, I don't believe so.  Everything I have is out there somewhere.
> You might check with Matt Zimmerman - he might have been doing some
> maintenance on them.
> 
> 				Jeff

With this reminder, I added a quick and dirty tunctl to toybox (since I
used it in http://landley.net/lxc/02-networking.html with kvm a while
back). I see busybox already has one. I'm reading the kernel tuntap
documentation file to see how to add tap support.

Is there anything else in here of general applicability to perhaps
containers? (Maybe uml_switch?)

I've wandered away from using UML because last I checked it's still
x86-only, and x86 is no longer enough of the world to justify investing
time in an architecture-specific tool. But ubuntu still says to install
this package if I want tunctl...

Rob

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

