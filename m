Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wad@dataspill.org>) id 1SiWHs-0000sv-9J
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Jun 2012 19:46:28 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SiWHq-0002UW-QD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Jun 2012 19:46:28 +0000
Received: by lbol5 with SMTP id l5so5383222lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 23 Jun 2012 12:46:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABmXcB-UXYr+UiL7u-o3AvN_3x-O0Z-5Lpz7rL-YR+qcbCUXuA@mail.gmail.com>
References: <4F3C1B06.7080506@nagafix.co.uk>
	<loom.20120621T174831-991@post.gmane.org>
	<CAFLxGvzcA7RNyJ_Ax94kQxXhsLx5+g8bBAbz8rKkLr0JfU4xVA@mail.gmail.com>
	<loom.20120621T214420-7@post.gmane.org>
	<CAFLxGvwC6AWu2=Fuj1OJR1AyDqPTFg7grfnYEHZ-b2JyCMBV1A@mail.gmail.com>
	<CABmXcB-UXYr+UiL7u-o3AvN_3x-O0Z-5Lpz7rL-YR+qcbCUXuA@mail.gmail.com>
Date: Sat, 23 Jun 2012 14:46:20 -0500
Message-ID: <CABmXcB-zR965qrk12wX=ZDkN45E=90jXgzSDMzfKqWWYCMp==A@mail.gmail.com>
From: Will Drewry <wad@dataspill.org>
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
Subject: Re: [uml-devel] X11 vfb forward ported to 3.2
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jun 22, 2012 at 2:26 PM, Will Drewry <wad@dataspill.org> wrote:
> On Thu, Jun 21, 2012 at 3:07 PM, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
>> On Thu, Jun 21, 2012 at 9:45 PM, Will Drewry <wad@dataspill.org> wrote:
>>> Cool! I'll clean it up. =A0So far I also found a use-after-free bug whi=
ch broke
>>> list traversal (during screen redraw) and moved it from kthread to work=
queues.
>>> There are still a lot of pieces which don't make as much sense to me ye=
t, but
>>> once it seems not so crazy, I'll definitely post it for consideration. =
=A0I'd love
>>> to see it in!
>>
>> Do you have a git repo where your current work is visible?
>
> Not yet, but I'll push a branch (to github) and reply here with the
> link. =A0I'm still trying to prove out input (just realized why the irq
> registration failed, etc).

If anyone really wants to follow along, I've pushed up some commits
that boot to a working mouse, keyboard, and fb console using the DSL
image with CONFIG_VT, CONFIG_HW_CONSOLE, CONFIG_FRAMEBUFFER_CONSOLE
and the normal stdio stuff works iff CONFIG_VT is disabled (in case
you want the fb without it being a console). If not, the dummy console
will clobber.

  https://github.com/redpig/linux/commits/uml_x11_fb

The commits are not cleaned up or rationalized. I need to annotate
that the original work comes from vfb-*/Gerd's patches, as well as
keep cleaning up the code, and split out the commits so that they
aren't one patch-bomb.  I'd also like to get a basic virtual touch
input mode working too, but baby steps for now :)

cheers!
will

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

